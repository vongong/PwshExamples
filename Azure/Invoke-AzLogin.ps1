

### Powershell
# Login
Connect-AzAccount

# Get Subscription
Get-AzSubscription
$SubscriptionID = (Get-AzSubscription | where-object name -match "Dev").id

# Switch Subscription
$SubscriptionID = '11111111-1111-1111-1111-111111111111'
Set-AzContext -SubscriptionID $SubscriptionID

##################

### Az Cli
# Login
az login
Write-Output 0 | az login # bypass interactive dialog

# Get Subscription
az account list --out json
$SubscriptionID = (az account list --out json | ConvertFrom-Json | where-object name -match "Dev").id

# Switch Subscription
$SubscriptionID = '11111111-1111-1111-1111-111111111111'
az account set --subscription $SubscriptionID