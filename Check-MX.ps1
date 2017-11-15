<#
.NOTES
	Name: Check-MX.ps1
	Original Author: Stanislav Buldakov
    contributor: Stanislav Buldakov
	Requires: PowerShell 4.0 and .Net Framework 4.5
	Version History:
	15/11/2017 - Initial Public Release.
.SYNOPSIS
	Finds mx-records for entered domain. Then finds all ns-records for each finded mx-record.
.DESCRIPTION
	Finds mx-records for entered domain. Then finds all ns-records for each finded mx-record.
.PARAMETER acceptedDomain
	This optional parameter allows point out domain. Default value is "google.com".
.PARAMETER DNSServer
	This optional parameter allows specify DNS-server. Default value is 8.8.8.8.
.EXAMPLE
	.\Check-MX.ps1 -acceptedDomain "o365lab.pro"
	Finds mx-records for domain o365lab.pro.
.LINK
    https://www.buldakov.ru
#>
param (
	[string] $acceptedDomain = "google.com",
	[string] $DNSServer = "8.8.8.8"
)

$MXs = @{}
$NSs = @{}

function Get-MXRecord ($Domain)
{
	return $((Resolve-DnsName $acceptedDomain -Type mx -Server $DNSServer).NameExchange)
}

function Get-NSRecord ($Domain)
{
	return $((Resolve-DnsName $Domain -Type ns -Server $DNSServer).NameHost)
}

function Write-Result
{
	Write-Host "Checking domain $acceptedDomain for MX-records..." -ForegroundColor Yellow
	Write-Host "Found the next MX-records:" -ForegroundColor Yellow 
	$MXs =  Get-MXRecord ($acceptedDomain)
	$MXs
	if ($MXs -ne $null)
	{
		Write-Host "Retreiving NS-records for each MX-record domain..." -ForegroundColor Yellow
		ForEach ($MX in $MXs)
		{
			$MXDomain = $MX.Replace($MX.Split('.')[0]+".", "")
			Write-Host "MX-record: $MX, domain: $MXDomain, found the next NS-records:" -ForegroundColor Yellow
			Get-NSRecord ($MXDomain)
		}
	}
}

Write-Result