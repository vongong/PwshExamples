
### Create
$map = @{}
$map = @{
    "OH" = "Ohio"
}

### Add
$map.Add("GA", "Georgia")
$map.Add("WI", "Wisconsin")
$map.Add("WI", "Wisconsin") # Err if exists

### Set Value
$map.Set_Item("NY", "New York")
$map.Set_Item("NY", "New York") # No Err

### Remove Value
$map.Remove("GA")

### Access
$map["GA"]
$map."GA"

### Splatting
$HashArguments = @{
    Path = "test.txt"
    Destination = "test2.txt"
    WhatIf = $true
  }
Copy-Item @HashArguments
# equivalent
Copy-Item -Path "test.txt" -Destination "test2.txt" -WhatIf

### Clone
$map1 = @{
  id = 0
  name = "Fruit"
  value = "Banana"
}
$map1.Clone() # success

$map2 = [ordered]@{
  id = 0
  name = "Fruit"
  value = "Banana"
}
$map2.Clone() # Failed

$ClonedMap = [ordered]@{}
foreach ($key in $map2.Keys) {
  $ClonedMap.Add($key, $map2[$key])
}

### Other
$map.Keys
$map.ContainsKey('NY')
$map.ContainsValue('Wisconsin')
$map.GetEnumerator()

