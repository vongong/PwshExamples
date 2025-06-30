# Install Hyper V Powershell

## Windows Server
- Name:
  - Hyper-V = Hyper-V Role
  - Hyper-V-Powershell = Powershell Commandlets
  - Hyper-V-Tools = GUI Tools
  - RSAT-Hyper-V-Tools = PS + GUI Tools
- IncludeManagementTools: Install Managment tools. dont use for manage remotely
- cmd
```powershell
Install-WindowsFeature -Name Hyper-V -ComputerName <computer_name> -IncludeManagementTools -Restart
```

## Windows
```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

## Get Commands
```powershell
Get-Command -Module hyper-v | Out-GridView

Get-Help Get-VM
```
