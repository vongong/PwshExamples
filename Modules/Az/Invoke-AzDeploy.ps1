
### Vars
$rg = "InfraPoc-Dev-Rg"
$templateFile = ".\Template.json"
$parmFile = ".\ParametersDev.json"

### Powershell Deploy
New-AzResourceGroupDeployment -ResourceGroupName $rg -TemplateFile $templateFile -TemplateParameterFile $parmFile -whatIf
# HashTable Splatting
$parms = @{
    ResourceGroupName = $rg
    TemplateFile = $templateFile
    TemplateParameterFile = $parmFile
}
New-AzResourceGroupDeployment @parms -whatIf

### Azcli Deploy
az deployment group create --resource-group $rg --template-file $templateFile --parameter $parmFile --what-if
# Array Splatting
$parms = @(
    "--resource-group", $rg
    "--template-file", $templateFile
    "--parameter", $parmFile
)
az deployment group create @parms --what-if