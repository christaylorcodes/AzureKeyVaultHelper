function _CheckForCreds {
    [cmdletbinding()]
    param(
        [string]$VaultName = $Script:KeyVault.VaultName,
        [string]$SecretName,
        $SecretValue
    )
    if (!$Collection) { $Collection = @() }
    if ($SecretValue.GetType().Name -eq 'Hashtable') {
        foreach($item in $SecretValue.Clone().GetEnumerator()){
            if ($item.Value.GetType().Name -eq 'PSCredential'){
                $NestedSecret = _NewNestedCred -VaultName $VaultName -SecretName $SecretName -SecretValue $item.Value
                $SecretValue[$item.Name] = $NestedSecret
                $Collection += $NestedSecret
            }
            if ($item.Value.GetType().Name -eq 'PSCustomObject' -or $item.Value.GetType().Name -eq 'Hashtable'){
                $Collection += _CheckForCreds -VaultName $VaultName -SecretName "$($SecretName)-$($item.Name)" -SecretValue $item.Value
            }
        }
    }
    if ($SecretValue.GetType().Name -eq 'PSCustomObject') {
        foreach($item in $SecretValue.PSObject.Properties){
            if ($item.Value.GetType().Name -eq 'PSCredential'){
                $NestedSecret = _NewNestedCred -VaultName $VaultName -SecretName $SecretName -SecretValue $item.Value
                $SecretValue.$($item.Name) = $NestedSecret
                $Collection += $NestedSecret
            }
            if ($item.Value.GetType().Name -eq 'PSCustomObject' -or $item.Value.GetType().Name -eq 'Hashtable'){
                _CheckForCreds -VaultName $VaultName -SecretName "$($SecretName)-$($item.Name)" -SecretValue $item.Value
            }
        }
    }
    return $Collection
}
