throw "do not run"

# troubleshoot install modules

### check module exists
Get-Module -ListAvailable

### Install
Install-Module -Name $moduleName -Scope CurrentUser


### verify run as tls 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

### check PSRepository
Get-PSRepository

### Check Package Provider
Get-PackageProvider -ListAvailable

# Install PowerShellGet and Nuget
Install-PackageProvider -Name PowerShellGet -Force
Install-PackageProvider -Name NuGet -Force
