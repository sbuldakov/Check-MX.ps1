# Check-MX.ps1

Script finds mx-records for entered domain. Then finds all ns-records for each finded mx-record.

# Parameters

-acceptedDomain

	This optional parameter allows point out domain. Default value is "google.com".
	
-DNSServer

	This optional parameter allows specify DNS-server. Default value is 8.8.8.8.
	
# Examples

## Example1

.\Check-MX.ps1 -acceptedDomain "o365lab.pro"
	
	Finds mx-records for domain o365lab.pro.