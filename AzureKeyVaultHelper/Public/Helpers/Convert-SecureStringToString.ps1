function Convert-SecureStringToString {
    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, Mandatory=$true)]
        [securestring]$Secure
    )
    $ssPtr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Secure)
    try {
        [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($ssPtr)
    }
    finally {
        [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ssPtr)
    }
}