## Az cli
$AdoResourceID = "499b84ac-1321-427f-aa17-267ca6975798"
$accessToken = az account get-access-token --resource $AdoResourceID --query "accessToken" --output tsv
Write-output "jwt: $accessToken"

## Api
$KvName = "Example-KeyVault-Dev"
$AppName = "Example"
$TenantId = Get-AzKeyVaultSecret -VaultName $KvName -Name "TenantId" -AsPlainText
$ClientId = Get-AzKeyVaultSecret -VaultName $KvName -Name "$AppName-AppId" -AsPlainText
$KeyId = Get-AzKeyVaultSecret -VaultName $KvName -Name "$AppName-Key" -AsPlainText
$AdoResourceID = "499b84ac-1321-427f-aa17-267ca6975798"

$headers = @{
    "Content-Type" = "application/x-www-form-urlencoded"
}
$body = "grant_type=client_credentials&resource=$AdoResourceID&client_id=$ClientId&client_secret=$KeyId"

$response = Invoke-RestMethod "https://login.microsoftonline.com/$TenantId/oauth2/token" -Method 'POST' -Headers $headers -Body $body

Write-Output "jwt: $($response.access_token)"