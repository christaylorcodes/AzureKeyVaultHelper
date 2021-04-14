function _NewNestedCred {
    [cmdletbinding()]
    param(
        [string]$VaultName = $Script:KeyVault.VaultName,
        [string]$SecretName,
        $SecretValue
    )
    $SecretName = "$($SecretName)-$($Secret.UserName)"
    $null = Set-AzKeyVaultSecret -VaultName $VaultName -SecretName $SecretName -SecretValue $SecretValue -Auto
    return $SecretName
}