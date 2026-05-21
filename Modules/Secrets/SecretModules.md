# Secret Management in Powershell
- [article-1](https://www.learningkoala.com/powershell-secret-management.html)
- [article-2](https://devblogs.microsoft.com/powershell/secretmanagement-and-secretstore-are-generally-available/)
- [yt PowerShell Secrets Management - Mike Kanakos](https://www.youtube.com/watch?v=vEniQPooUSs&pp=ygVCZ2V0dGluZyBzdGFydGVkIHdpdGggc2VjcmV0cyBtYW5hZ21lbnQgZm9yIHBvd2Vyc2hlbGwgbWlrZSBrYW5ha29z)

## Modules / Notes
- Microsoft.PowerShell.SecretManagement - modules to store and retrieve secrets
  - https://github.com/powershell/SecretManagement
- Microsoft.PowerShell.SecretStore - extension for SecretManagement module; allows local store of secrets
  - https://github.com/powershell/SecretStore
  - Default secret store path: `$env:USERPROFILE\AppData\Local\Microsoft\PowerShell\secretmanagement\localstore`
- Other Ecosystem that works with SecretManagement
  - KeePass
  - LastPass
  - Hashicorp Vault
  - KeyChain
  - CredMan
  - Azure KeyVault
- Can Work with multiple vault types at the same time
- Secret Supported
  - String
  - SecureString
  - PSCredentials
  - Hashtable
  - Byte

## cmds
```powershell
# Install Modules
Install-Module -Name Microsoft.PowerShell.SecretManagement -Repository PSGallery
Install-Module -Name Microsoft.PowerShell.SecretStore -Repository PSGallery

# Verify Installed Modules 
Get-InstalledModule -Name *Secret* | Format-Table -AutoSize -Wrap

# Analyze the commands available
Get-Command -Module Microsoft.PowerShell.SecretManagement
Get-Command -Module Microsoft.PowerShell.SecretStore

# Set up the Vault for SecretStore
## Could set blank password - not advised
Register-SecretVault -Name "PersonalVault" -ModuleName "Microsoft.PowerShell.SecretStore"

# Set up the Vault for Azure
Register-SecretVault -Name "MyAzureVault" -ModuleName "Az.KeyVault" -VaultParameters @{ AZKVaultName = "YourVaultName"; SubscriptionId = "YourSubID" }

# List/Get Secret Vaults
Get-SecretVault
Get-SecretVault -Name "PersonalVault" | Format-List -Property *

# Set Default Vault
Set-SecretVaultDefault -Name "PersonalVault"

# Clear Default Vault (no defaults)
Set-SecretVaultDefault -ClearDefault

# Config Vault
Get-SecretStoreConfiguration
Set-SecretStoreConfiguration -PasswordTimeout 30

# Use Secret - Text
Set-Secret -Name "FirstEntry" -Secret "This is my secret" #assume default
Set-Secret -Name "FirstEntry" -Secret "This is my secret" -Vault "PersonalVault"
Get-SecretInfo
## same as Get-Secret FirstEntry -AsPlainText
$mySecret = Get-Secret YourEntry
ConvertFrom-SecureString $mySecret -AsPlainText

# Use Secret - PSCred
## Interactive
$myCred = Get-Credential
## Non-Interactive
$username = "YourUsername"
$password = "YourPassword" | ConvertTo-SecureString -AsPlainText -Force
$myCred = New-Object System.Management.Automation.PSCredential($username, $password)

Set-Secret -Name "MyServiceAccount" -Secret $myCred
Enter-PSSession -ComputerName ana-client1 -Authentication Default -Credential (Get-Secret -Name "MyServiceAccount") -UseSSL
```
