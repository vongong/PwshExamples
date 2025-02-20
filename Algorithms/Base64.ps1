
param (	
	[Parameter(ValueFromPipeline=$true)]
    [string] $SitePath = ''
	,[switch] $d
)

$outStr = ""
if ($d) {    
    $bytes = [System.Convert]::FromBase64String($SitePath)
    $outStr = [System.Text.Encoding]::ASCII.GetString($bytes)
} else {    
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($SitePath)
    $outStr = [System.Convert]::ToBase64String($bytes)
}
Write-Output $outStr