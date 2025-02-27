throw "do not run"

### Load SQL Module
$ModuleValidation = $false
if ((Get-Module -ListAvailable -Name "SqlServer")) {
    Import-Module -Name SqlServer
    $ModuleValidation = $true
}

if (!$ModuleValidation -and (Get-Module -ListAvailable -Name "SQLPS")) {
    Import-Module -Name SQLPS
    $ModuleValidation = $true
}
if (!$ModuleValidation) {
    throw "SQL Module Validation Failed"
}


### Invoke Query
try {
    Invoke-Sqlcmd -Query $Query -ConnectionString $ConnectionString -ErrorAction Stop -QueryTimeout $QryTimeout
}
catch {
    $message = $_
    Write-Output "nName error: $message"
    Write-Output "nName query: $Query"
    Throw "encountered error"
}