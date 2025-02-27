
### General Vars
$TenantId = "" # Azure Tenant ID
$ClientId = "" # Service Principal Id
$KeyId = "" # Service Principal Secret

### Powershell
# Login Interactive
Connect-AzAccount
# Login Service Prinipal
$SecurePassword = ConvertTo-SecureString -String $KeyId -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $ClientId, $SecurePassword
Connect-AzAccount -ServicePrincipal -TenantId $TenantId -Credential $Credential

# Get Subscription
Get-AzSubscription
$SubscriptionID = (Get-AzSubscription | where-object name -match "Dev").id

# Switch Subscription
$SubscriptionID = '11111111-1111-1111-1111-111111111111'
Set-AzContext -SubscriptionID $SubscriptionID

##################

### Az Cli
# Login Interactive
az login
# Login bypass interactive dialog
Write-Output 0 | az login 
# Login Service Prinipal
az login --service-principal -u $ClientId -p $KeyId --tenant $TenantId

# Get Subscription
az account list --out json
$SubscriptionID = (az account list --out json | ConvertFrom-Json | where-object name -match "Dev").id

# Switch Subscription
$SubscriptionID = '11111111-1111-1111-1111-111111111111'
az account set --subscription $SubscriptionID