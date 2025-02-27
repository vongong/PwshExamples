
# Az Module

## Install
```powershell
Install-Module -Name Az -Repository PSGallery
```

## Update
```powershell
Update-Module -Name Az
```

## Uninstall

### Get All Az Modules
```powershell
Get-InstalledModule -Name Az -AllVersions -OutVariable AzVersions
```

### Get All Previous Az Modules
```powershell
$latestVer = (Get-InstalledModule -Name Az).Version
$AzVersions = Get-InstalledModule -Name Az -AllVersions | Where-Object {$_.Version -ne $latestVer}

# Find Dependencies
($AzVersions |
  ForEach-Object {
      Import-Clixml -Path (Join-Path -Path $_.InstalledLocation -ChildPath PSGetModuleInfo.xml)
  }).Dependencies.Name | Sort-Object -Descending -Unique -OutVariable AzModules

# Remove Az Modules
$AzModules |
  ForEach-Object {
    Remove-Module -Name $_ -ErrorAction SilentlyContinue
    Write-Output "Attempting to uninstall module: $_"
    Uninstall-Module -Name $_ -AllVersions
  }
```
