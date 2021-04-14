function _ReplaceWithPSCred {
    [cmdletbinding()]
    param(
        [string]$SecretName,
        $SecretObject,
        [string]$VaultName = $Script:KeyVault.VaultName
    )
    $Properties = $SecretObject.PSObject.Properties | Where-Object {$_.IsSettable -and $_.Value -eq $SecretName}
    if (!$Properties) {
        $NestedProperties = $SecretObject.PSObject.Properties | Where-Object {$_.TypeNameOfValue -eq 'System.Management.Automation.PSCustomObject'}
        if (!$NestedProperties) {
            Write-Error "Unable to find property with value, $($SecretName)"
        }
        foreach($NestedProperty in $NestedProperties){
            _ReplaceWithPSCred -SecretName $SecretName -SecretObject $NestedProperty.Value -VaultName $VaultName
        }
    }
    foreach($Property in $Properties){
        $Property.Value = Get-AzKeyVaultSecret -SecretName $SecretName -Auto -Expand
    }
}