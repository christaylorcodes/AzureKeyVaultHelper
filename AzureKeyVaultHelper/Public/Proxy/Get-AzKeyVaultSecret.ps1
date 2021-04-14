function Get-AzKeyVaultSecret {
    <#
    .PARAMETER Auto
    Will retrieve the secret and form back info the object that was set.

    .PARAMETER Expand
    Will return just the retrieved secret.

    .EXAMPLE
    Get-AzKeyVaultSecret -Auto -Name 'Secret'

    .NOTES
    General notes
    #>

    <#
    .PARAMETER Auto
    Will retrieve the secret and form back info the object that was set.

    .PARAMETER Expand
    Will return just the retrieved secret.

    .ForwardHelpTargetName Az.Keyvault\Get-AzKeyVaultSecret
    .ForwardHelpCategory Cmdlet
    #>

    [CmdletBinding(DefaultParameterSetName='ByVaultName')]
    param(
        [Parameter(ParameterSetName='BySecretName', Position=0, HelpMessage='Vault name. Cmdlet constructs the FQDN of a vault based on the name and currently selected environment.')]
        [Parameter(ParameterSetName='ByVaultName', Position=0, HelpMessage='Vault name. Cmdlet constructs the FQDN of a vault based on the name and currently selected environment.')]
        [Parameter(ParameterSetName='BySecretVersions', Position=0, HelpMessage='Vault name. Cmdlet constructs the FQDN of a vault based on the name and currently selected environment.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${VaultName},

        [Parameter(ParameterSetName='ByInputObjectVaultName', Mandatory=$true, Position=0, ValueFromPipeline=$true, HelpMessage='KeyVault Object.')]
        [Parameter(ParameterSetName='ByInputObjectSecretName', Mandatory=$true, Position=0, ValueFromPipeline=$true, HelpMessage='KeyVault Object.')]
        [Parameter(ParameterSetName='ByInputObjectSecretVersions', Mandatory=$true, Position=0, ValueFromPipeline=$true, HelpMessage='KeyVault Object.')]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Azure.Commands.KeyVault.Models.PSKeyVault]
        ${InputObject},

        [Parameter(ParameterSetName='ByResourceIdVaultName', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true, HelpMessage='KeyVault Resource Id.')]
        [Parameter(ParameterSetName='ByResourceIdSecretName', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true, HelpMessage='KeyVault Resource Id.')]
        [Parameter(ParameterSetName='ByResourceIdSecretVersions', Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true, HelpMessage='KeyVault Resource Id.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${ResourceId},

        [Parameter(ParameterSetName='ByVaultName', Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByInputObjectVaultName', Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByResourceIdVaultName', Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='BySecretName', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByInputObjectSecretName', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByResourceIdSecretName', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='BySecretVersions', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByInputObjectSecretVersions', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByResourceIdSecretVersions', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Alias('SecretName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(ParameterSetName='BySecretName', Mandatory=$true, Position=2, HelpMessage='Secret version. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment, secret name and secret version.')]
        [Parameter(ParameterSetName='ByInputObjectSecretName', Mandatory=$true, Position=2, HelpMessage='Secret version. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment, secret name and secret version.')]
        [Parameter(ParameterSetName='ByResourceIdSecretName', Mandatory=$true, Position=2, HelpMessage='Secret version. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment, secret name and secret version.')]
        [Alias('SecretVersion')]
        [string]
        ${Version},

        [Parameter(ParameterSetName='BySecretVersions', Mandatory=$true, HelpMessage='Specifies whether to include the versions of the secret in the output.')]
        [Parameter(ParameterSetName='ByInputObjectSecretVersions', Mandatory=$true, HelpMessage='Specifies whether to include the versions of the secret in the output.')]
        [Parameter(ParameterSetName='ByResourceIdSecretVersions', Mandatory=$true, HelpMessage='Specifies whether to include the versions of the secret in the output.')]
        [switch]
        ${IncludeVersions},

        [Parameter(ParameterSetName='ByVaultName', HelpMessage='Specifies whether to show the previously deleted secrets in the output.')]
        [Parameter(ParameterSetName='ByInputObjectVaultName', HelpMessage='Specifies whether to show the previously deleted secrets in the output.')]
        [Parameter(ParameterSetName='ByResourceIdVaultName', HelpMessage='Specifies whether to show the previously deleted secrets in the output.')]
        [switch]
        ${InRemovedState},

        [Parameter(HelpMessage='The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext','AzureRmContext','AzureCredential')]
        [Microsoft.Azure.Commands.Common.Authentication.Abstractions.Core.IAzureContextContainer]
        ${DefaultProfile},

        [Parameter(ParameterSetName='ByVaultName', Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByInputObjectVaultName', Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByResourceIdVaultName', Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='BySecretName', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByInputObjectSecretName', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByResourceIdSecretName', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='BySecretVersions', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByInputObjectSecretVersions', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByResourceIdSecretVersions', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [switch]
        ${Auto},

        [Parameter(ParameterSetName='ByVaultName', Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByInputObjectVaultName', Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByResourceIdVaultName', Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='BySecretName', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByInputObjectSecretName', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByResourceIdSecretName', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='BySecretVersions', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByInputObjectSecretVersions', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Parameter(ParameterSetName='ByResourceIdSecretVersions', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [switch]
        ${Expand}
    )

    begin
    {
        try {
            $outBuffer = $null
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
            {
                $PSBoundParameters['OutBuffer'] = 1
            }
            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Keyvault\Get-AzKeyVaultSecret', [System.Management.Automation.CommandTypes]::Cmdlet)

            if($PSBoundParameters['Auto']) {
                $null = $PSBoundParameters.Remove('Auto')

                $Expand = $false
                if ($PSBoundParameters['Expand']) {
                    $Expand = $true
                    $null = $PSBoundParameters.Remove('Expand')
                }

                if (!$PSBoundParameters.VaultName) { $PSBoundParameters.VaultName = $Script:KeyVault.VaultName }

                $scriptCmd = {
                    & $wrappedCmd @PSBoundParameters | ForEach-Object {
                        if ($_.ContentType -eq 'PSCredential') {
                            $UserName = $_.Tags['UserName']
                            $_ | Add-Member -NotePropertyName 'Auto' -NotePropertyValue $(New-Object System.Management.Automation.PSCredential ($UserName, $_.SecretValue))
                            if ($Expand) {
                                return New-Object System.Management.Automation.PSCredential ($UserName, $_.SecretValue)
                            }
                        }
                        elseif ($_.ContentType -eq 'JSON') {
                            $SecretValue = $_.SecretValue | Convert-SecureStringToString
                            $SecretObject = $SecretValue | ConvertFrom-Json

                            if ($_.Tags) {
                                foreach($Tag in $_.Tags.GetEnumerator()) {
                                    if ($Tag.Value -eq 'PSCred') {
                                        _ReplaceWithPSCred -SecretName $Tag.Name -SecretObject $SecretObject -VaultName $VaultName
                                    }
                                }
                            }
                            $_ | Add-Member -NotePropertyName 'Auto' -NotePropertyValue $SecretObject
                            if ($Expand) {
                                return $SecretObject
                            }
                        }
                        elseif ($_.ContentType -eq 'String') {
                            $_ | Add-Member -NotePropertyName 'Auto' -NotePropertyValue $_.SecretValue
                            if ($Expand) {
                                return $_.SecretValue
                            }
                        }
                        elseif ($Expand) {
                            return $_.SecretValue
                        }
                        $_
                    }
                }
            } else {
                $scriptCmd = {& $wrappedCmd @PSBoundParameters }
            }
            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($PSCmdlet)

        } catch {
            throw
        }
    }

    process
    {
        try {
            $steppablePipeline.Process($_)
        } catch {
            throw
        }
    }

    end
    {
        try {
            $steppablePipeline.End()
        } catch {
            throw
        }
    }
}