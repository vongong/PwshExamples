
#### Read File
# basic
$v = Get-Content -Path "path\to\file.txt"
# convert to json
$v = $v | ConvertFrom-Json -Depth 5 # n levels deep
$v = $v | ConvertFrom-Json -AsHashtable # convert to Hashtable instead of custom class

#### Access
$v[0]       # Access first row of data
$v.Count    # Number of Rows in File

#### Write File
Set-Content -Path "path\to\file.txt" -Value $v
$v | ConvertTo-Json | Set-Content -Path "path\to\file.json"

#### Test Exists
# Test if Folder Exists
Test-Path -Path "path\to\folder"
# Test if Files Exists
Test-Path -Path "path\to\file.txt" -PathType Leaf