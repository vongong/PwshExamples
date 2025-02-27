throw "do not run"

### Sas token for Storage Account
# Retrieved Storage Account Key
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $storageAccountRG -AccountName $storageAccountName).Value[0]
# Retrieved Storage Context
$destinationContext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey
# Generate SAS URI
$containerSASURI = New-AzStorageContainerSASToken -Context $destinationContext -ExpiryTime(get-date).AddSeconds(3600) -FullUri -Name $storageContainerName -Permission rw
# Uploading  file
azcopy copy "path\to\file.txt" $containerSASURI

### Find Azure VM Image
$locName="NorthCentralUS"
Get-AzVMImagePublisher -Location $locName | Select-Object PublisherName
$pubName="Canonical"
Get-AzVMImageOffer -Location $locName -PublisherName $pubName | Select-Object Offer
$offerName="0001-com-ubuntu-server-jammy"
Get-AzVMImageSku -Location $locName -PublisherName $pubName -Offer $offerName | Select-Object Skus
$skuName="22_04-lts"
Get-AzVMImage -Location $locName -PublisherName $pubName -Offer $offerName -Sku $skuName | Select-Object Version

