
function Format-IntMB([int64]$inInt) {
    $mbValue = $inInt / 1MB
    return "$mbValue MB"
}


Write-Output "Get VMs"
$vms = Get-VM
$vmArr = @()

foreach ($vm in $vms){
    # $vm = $vms[0]
    Write-Output "Get Info for $($vm.Name)"    
    # $vlan = Get-VMNetworkAdapterVlan -VMName $vm.Name
    $vmIntgSrv = $vm.VMIntegrationService | Where-Object {$_.Name -eq "Guest Service Interface"} 
    $vmPcr = Get-VMProcessor -VMName $vm.Name
    $VlanId = $vm.NetworkAdapters[0].VlanSetting.AccessVlanId
    $item = @{
        Name = $vm.Name
        State = $vm.State
        CompatForMigrate = $vmPcr.CompatibilityForMigrationEnabled
        GuestService = $vmIntgSrv.Enabled
        VlanId = $VlanId        
        DynamicMemoryEnabled = $vm.DynamicMemoryEnabled
        MemoryStartup = Format-IntMB $vm.MemoryStartup
        MemoryMin = Format-IntMB $vm.MemoryMinimum
        MemoryMax = Format-IntMB $vm.MemoryMaximum        
    }
    $vmArr += [pscustomobject] $item
}

Write-Output "Display Info"

$vmArr | Select-Object Name, State, CompatForMigrate, GuestService, VlanId, DynamicMemoryEnabled, MemoryStartup, MemoryMin, MemoryMax | Out-GridView -Title "VM Details"
