
### Create
$arr = $()
$arr = $(
    "Apple"
    "Orange"
)
$arr = "Apple", "Orange"
$arr = "Apple,Orange" -split ","

### Add
$arr += "Banana"

### Access
$arr[0]

### Loop
foreach ($fruit in $arr) {
    Write-Host $fruit
}

### Splatting
$ArrayArguments = "test.txt", "test2.txt"
Copy-Item @ArrayArguments -WhatIf
# equivalent
Copy-Item "test.txt" "test2.txt" -WhatIf