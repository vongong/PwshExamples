
# Declare
$Random = "This is a string"

# Formatting
$StoreId = 'BP'
$StoreId = $StoreId + "215"
$n = 215
$StoreId = 'BP{0:d3}' -f $n

# String Length
$Random.Length

# Split
$Random -split " "

# Join
$ConnArr = ("Server=myServerName", "Database=master", "Trusted_Connection=True")
$ConnArr -join ";"

