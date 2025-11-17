#### Create new Virtual Switch
# Get NetAdapters
Get-NetAdapter
# Create Switch with NetAdapter
New-VMSwitch -Name "SwitchTeam" -NetAdapterName "Integrated NIC 1 Port 1-1","SLOT 1 Port 1" -AllowManagementOS $true
# Configures a virtual switch team - Specifies the load balancing algorithm that this switch team uses
Set-VMSwitchTeam -Name "SwitchTeam" -LoadBalancingAlgorithm HyperVPort
# Note: Set IP for vEthernet(SwitchTeam) && Enable RDP Access

#### Adds a virtual network adapter to the management operating system and Configures the virtual LAN settings for the traffic though the vnet adapter
$VlanName = "LiveMigration"
$VlanID = 84
Add-VMNetworkAdapter -ManagementOS -Name "$VlanName-$VlanID" -SwitchName "SwitchTeam"
Get-VMNetworkAdapter -name "$VlanName-$VlanID" -ManagementOS | Set-VMNetworkAdapterVlan -Access -VlanId $VlanID
# Note: Set IP for Vswitch Vlan

