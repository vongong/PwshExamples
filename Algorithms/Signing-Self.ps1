# self-signed Script (https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_signing?view=powershell-7.4)

#####
## Create a self-signed certificate
$params = @{
    Subject = 'CN=PowerShell Code Signing Cert'
    Type = 'CodeSigningCert'
    CertStoreLocation = 'Cert:\CurrentUser\My'
    HashAlgorithm = 'sha256'
}
$cert = New-SelfSignedCertificate @params
$cert

# Verify 
Get-ChildItem Cert:\CurrentUser\my -CodeSigningCert

#####
## Sign a script
$cert = Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert | Select-Object -First 1

$File = "C:\path\to\your\script.ps1"
Set-AuthenticodeSignature -FilePath $File -Certificate $cert