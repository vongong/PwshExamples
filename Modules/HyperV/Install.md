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

#### Vars
$vmName = "YourVMName"

#### Get-VM
Get-VM
Get-VM -Name $vmName
Get-VM | Where-Object {$_.State -eq "Running"}

#### VM Nic
Get-VMNetworkAdapter -VMName $vmName
Get-VMNetworkAdapterVlan -VMName $vmName
Set-VMNetworkAdapterVlan -VMName $vmName -VMNetworkAdapterName "YourVMNetworkAdapterName" -Access -VlanId 11

#### VM Intrg Services
Get-VMIntegrationService -VMName $vmName
Get-VMIntegrationService -VMName $vmName -Name "Guest Service Interface"
Enable-VMIntegrationService -VMName $vmName -Name "YourIntegrationService"

#### VM Processor Compat
Get-VMProcessor -VMName $vmName
Set-VMProcessor -VMName $vmName -CompatibilityForMigrationEnabled $true
```


