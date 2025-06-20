# Install Active Directory Module

## Windows 11
Install RSAT Tools via Settings
- Start Button Settings
- Navigate System | Optional Features
- Add optional Feature | View Features
- Search RSAT: Active Directory Domain Services and Lightweight Directory Service Tools
- Install

## Alt: Powershell
- cmd: 
```powershell
# Install Feature
Install-WindowsFeature -Name "RSAT-AD-PowerShell" -IncludeAllSubFeature

# List Module
Get-Module -Name ActiveDirectory -ListAvailable

# Import Module
Import-Module -Name ActiveDirectory
```