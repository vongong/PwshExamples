throw "do no run"

### Resource ID
# Azure ARM
$ApiResourceId = "https://management.azure.com/"
# Azure DevOps
$ApiResourceId = "499b84ac-1321-427f-aa17-267ca6975798"

### Other Vars for Service Principal
$TenantId = "" # Azure Tenant ID
$ClientId = "" # Service Principal Id
$KeyId = "" # Service Principal Secret

### API via Service Principal
$headers = @{
    "Content-Type" = "application/x-www-form-urlencoded"
}
$body = "grant_type=client_credentials&resource=$ApiResourceId&client_id=$ClientId&client_secret=$KeyId"
$response = Invoke-RestMethod "https://login.microsoftonline.com/$TenantId/oauth2/token" -Method 'POST' -Headers $headers -Body $body
Write-Output "jwt: $($response.access_token)"

### Azure Cli
$accessToken = az account get-access-token --resource $ApiResourceId --query "accessToken" --output tsv
Write-Output "jwt: $accessToken"

### Azure Powershell Az Module
# Note: The Token property of the output type will be changed from String to SecureString. Add the [-AsSecureString] switch to avoid the impact of this upcoming breaking change.
$accessToken = Get-AzAccessToken -ResourceUrl $ApiResourceId -AsSecureString
Write-Output "jwt: $(ConvertFrom-SecureString $accessToken.Token -AsPlainText)"