
param (	
	[Parameter(ValueFromPipeline=$true)]
    [string] $SitePath = ''
	,[switch] $d
)

$outStr = ""
if ($d) {
    $outStr =  [System.Net.WebUtility]::UrlDecode($SitePath)
} else {
    $outStr =  [System.Net.WebUtility]::UrlEncode($SitePath)   
}
Write-Output $outStr