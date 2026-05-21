# Secret Management in Powershell
- [article-1](https://www.learningkoala.com/powershell-secret-management.html)
- [yt PowerShell Secrets Management - Mike Kanakos](https://www.youtube.com/watch?v=vEniQPooUSs&pp=ygVCZ2V0dGluZyBzdGFydGVkIHdpdGggc2VjcmV0cyBtYW5hZ21lbnQgZm9yIHBvd2Vyc2hlbGwgbWlrZSBrYW5ha29z)

## Modules
- Microsoft.PowerShell.SecretManagement - modules to store and retrieve secrets
  - https://github.com/powershell/SecretManagement
- Microsoft.PowerShell.SecretStore - extension for SecretManagement module
  - https://github.com/powershell/SecretStore

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

# Set up the Vault
## Default secret store path: $env:USERPROFILE\AppData\Local\Microsoft\PowerShell\secretmanagement\localstore
Register-SecretVault -Name PersonalVault -ModuleName Microsoft.PowerShell.SecretStore
Get-SecretVault

# Config Vault
Get-SecretStoreConfiguration
Set-SecretStoreConfiguration -PasswordTimeout 30

# Use Secret - Text
Set-Secret -Name "FirstEntry" -Secret "This is my secret"
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
