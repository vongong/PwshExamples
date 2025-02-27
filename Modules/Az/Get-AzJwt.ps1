
$KvName = "Example-KeyVault-Dev"
$AppName = "Example"

$TenantId = Get-AzKeyVaultSecret -VaultName $KvName -Name "TenantId" -AsPlainText
$ClientId = Get-AzKeyVaultSecret -VaultName $KvName -Name "$AppName-AppId" -AsPlainText
$KeyId = Get-AzKeyVaultSecret -VaultName $KvName -Name "$AppName-Key" -AsPlainText
$ApiResourceId = "https://management.azure.com/"

$headers = @{
    "Content-Type" = "application/x-www-form-urlencoded"
}
$body = "grant_type=client_credentials&resource=$([uri]::EscapeDataString($ApiResourceId))&client_id=$ClientId&client_secret=$KeyId"
$response = Invoke-RestMethod "https://login.microsoftonline.com/$TenantId/oauth2/token" -Method 'POST' -Headers $headers -Body $body

Write-Output "jwt: $($response.access_token)"