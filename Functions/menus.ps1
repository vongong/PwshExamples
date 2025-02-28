$options = @()
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Az', 'Azure Cli'
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Pwsh', 'PowerShell (default)'
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Both', 'Both'
$title = 'Azure Method'
$message = 'Login Protocol?'
$resultLogin = $host.ui.PromptForChoice($title, $message, $options, 1)
$Method = 'pwsh'
switch ($resultLogin) {
    0 { $Method = 'azcli' }
    1 { $Method = 'pwsh' }
    2 { $Method = 'both' }
}
Write-Output "Selected: $Method"

$options = @()
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Dev', 'Dev-Test (Default)'
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Prod', 'Production'
$title = 'Azure Subscription'
$message = 'Subscription?'
$resultSub = $host.ui.PromptForChoice($title, $message, $options, 0)

$Subscription = '11111111-1111-1111-1111-111111111111'
if ($resultSub -eq 1) {        
    $Subscription = '22222222-2222-2222-2222-222222222222'    
}
Write-Output "Selected: $Subscription"

$options = @()
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Interact', 'Interact (Default)'
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&CodeFr', 'Code Freeze'
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Vsts', 'VSTS'
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Zabbix', 'Zabbix'
$title = 'Azure User'
$message = 'User?'
$resultUser = $host.ui.PromptForChoice($title, $message, $options, 0)
$KvSecret = 'interact'
switch ($resultUser) {
    0 { $KvSecret = 'interact' }
    1 { $KvSecret = 'adocodefr' }
    2 { $KvSecret = 'vsts' }
    3 { $KvSecret = 'zabbix' }
}

Write-Output "Selected: $KvSecret"