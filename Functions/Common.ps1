## WIP
throw "Do not run"

# Debug Message
$DebugMsgLevel = 1
function Write-DebugMsgLevel {
    param (
        [string] $Message = ''
        ,[int] $MsgLevel = 1
    )
    if ($MsgLevel -lt 0) {
        $MsgLevel = 1
    }
    if ($MsgLevel -gt 9) {
        $MsgLevel = 9
    }
    if ($DebugMsgLevel -ge $MsgLevel) {
        Write-Host $Message
    }
}

# Debug Message
$debugMsg = $true
function Write-DebugMsg {
    param (
        [string] $Message = ''
    )
    if ($debugMsg) {
        Write-Host $Message
    }
}

# Logout
$CurrDate = Get-Date -Format "yyyy-MM-dd"
$logFile = "C:\Gong\tmp\$logName-$currDate.log"
function Write-Logger {
    param (
        [string] $Message = ''
    )
    $CurrDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$CurrDate $Message" | Tee-Object -FilePath $logFile -Append
}

## if inString has a comma, wrap with quotes
function Get-csvStr {
    param (
        [string] $instr
    )

    if (-not $instr.Contains(',')) {
        return $instr
    }
    return "`"$instr`""
}
function Get-Envir {
    param (
        [string] $appName
    )
    $envirArr = @("Dev","Test","Prod")
    foreach ($envir in $envirArr) {
        $matchValue = "-$envir-"
        if ($appName -match $matchValue) {
            return $envir
        }
    }
    return "??"
}
## return title case
function Get-TitleCase {
    param (
        [string] $inStr
    )
    return (Get-Culture).TextInfo.ToTitleCase($inStr)

}

function Select-ResourceId {
    param (
        [string] $resourceID
    )
    $array = $resourceID.Split('/')
    $SubscriptionIndex = 0..($array.Length -1) | Where-Object {$array[$_] -eq 'subscriptions'}
    $rgIndex = 0..($array.Length -1) | Where-Object {$array[$_] -eq 'resourcegroups'}
    $providerIndex = 0..($array.Length -1) | Where-Object {$array[$_] -eq 'providers'}
    $Providers = $array[($providerIndex+1)..($providerIndex+2)] | Join-String -Separator "/"
    $Name = $array[$array.Length-1]
    if ($providerIndex+4 -lt $array.Length) {
        $SubNameIndex = $providerIndex+3
        $Name = $array[$SubNameIndex] + '/' + $name
        $Providers = $Providers + '/' + $array[$SubNameIndex+1]
    }
    return [PSCustomObject]@{
        Subscription = $array[$SubscriptionIndex+1]
        ResourceGroup = $array[$rgIndex+1]    
        Providers = $Providers
        Name = $Name
    }
}

$fgErr = "Red"
$fgGood = "Green"
function Test-Value {
    param (
        [string] $matchValue
        , [string] $actualValue
        , [switch] $isRegEx
    )
    if ([string]::IsNullOrWhiteSpace($matchValue)) {
        Write-Host "Expected Match is blank " -ForegroundColor $fgErr
        return
    }
    $matchReg = $matchValue
    if (-not $isRegEx) {
        $matchReg = "^$matchValue$"
        $matchReg = $matchReg.Replace('\','\\')
        $matchReg = $matchReg.Replace('.','\.')
        $matchReg = $matchReg.Replace('*','\*')
    }
    if ($actualValue -match $matchReg) {
        Write-Host $actualValue -ForegroundColor $fgGood
    }
    else {
        Write-Host "Actual: $actualValue Expected Match: $matchValue " -ForegroundColor $fgErr
    }
}

function Test-HashKey {
    param (
        [string] $actualKey
        ,[hashtable] $actualHash
        ,[string] $matchValue
        , [switch] $isRegEx
    )
    if (-not ($actualHash.ContainsKey($actualKey))) {
        Write-Host "Missing Key $actualKey" -ForegroundColor $fgErr
    }
    Test-Value -matchValue $matchValue -actualValue $actualHash[$actualKey] -isRegEx:$isRegEx
}

$fgBold = "White"
function Write-Item {
    param (
        [string] $title = ''
        ,[string] $message = ''
    )
    
    Write-Host $title -ForegroundColor $fgBold -NoNewline
    Write-Host $message
}
