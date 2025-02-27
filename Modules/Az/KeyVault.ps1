throw "Do not run"

## Get Secret Object
$kvName = "keyvault-dev"
$kvSecretName = "devwildcard00000000-0000-0000-0000-000000000000"
$kvSecret = Get-AzKeyVaultSecret -VaultName $kvName -Name $kvSecretName

## Get Secret Value as PlainText
$pfxSecret = ConvertFrom-SecureString $kvSecret.SecretValue -asPlainText
# $pfxSecret = Get-AzKeyVaultSecret -VaultName $kvName -Name $kvSecretName -AsPlainText

## Base64 Decode
$secretByte = [Convert]::FromBase64String($pfxSecret)

## Import to PFX
$x509Cert = New-Object Security.Cryptography.X509Certificates.X509Certificate2Collection
$x509Cert.Import($secretByte, $null, [Security.Cryptography.X509Certificates.X509KeyStorageFlags]::Exportable)

# Write to a file
$pfxFileByte = $x509Cert.Export([Security.Cryptography.X509Certificates.X509ContentType]::Pkcs12)
[IO.File]::WriteAllBytes("KeyVaultcertificate.pfx", $pfxFileByte)


#################

## Get Cert Object
$kvName = "keyvault-dev"
$kvCertName = "DevWildcard-cert"
$kvCert = Get-AzKeyVaultCertificate -VaultName $kvName -Name $kvCertName
$kvCert.Certificate
$kvCert.Thumbprint
