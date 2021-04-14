function Set-AzKeyVaultSecret {
    <#
    .PARAMETER Auto
    This will allow you to save other object types as a secret. ('PSCredential', 'String', 'Hashtable', 'PSCustomObject', 'SecureString')

    .EXAMPLE
    Set-AzKeyVaultSecret -Auto -Name 'Secret' -SecretValue @{ server = 'server.domain.com'; credentials = $Credentials }

    .NOTES
    General notes
    #>
    <#

    .ForwardHelpTargetName Az.Keyvault\Set-AzKeyVaultSecret
    .ForwardHelpCategory Cmdlet

    #>
    [CmdletBinding(DefaultParameterSetName='Default', SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    param(
        [Parameter(ParameterSetName='Default', Position=0, HelpMessage='Vault name. Cmdlet constructs the FQDN of a vault based on the name and currently selected environment.')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${VaultName},

        [Parameter(ParameterSetName='Default', Mandatory=$true, Position=1, HelpMessage='Secret name. Cmdlet constructs the FQDN of a secret from vault name, currently selected environment and secret name.')]
        [Alias('SecretName')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Name},

        [Parameter(Mandatory=$true, Position=2, HelpMessage='Secret value')]
        ${SecretValue},

        [Parameter(HelpMessage='A hashtable representing secret tags.')]
        [Alias('Tags')]
        [hashtable]
        ${Tag},

        [Parameter(HelpMessage='Secret''s content type.')]
        [string]
        ${ContentType},

        [Parameter(ParameterSetName='InputObject', Mandatory=$true, Position=0, ValueFromPipeline=$true, HelpMessage='Secret object')]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Azure.Commands.KeyVault.Models.PSKeyVaultSecretIdentityItem]
        ${InputObject},

        [Parameter(HelpMessage='Set secret in disabled state if present. If not specified, the secret is enabled.')]
        [switch]
        ${Disable},

        [Parameter(HelpMessage='The expiration time of a secret in UTC time. If not specified, the secret will not expire.')]
        [System.Nullable[datetime]]
        ${Expires},

        [Parameter(HelpMessage='The UTC time before which secret can''t be used. If not specified, there is no limitation.')]
        [System.Nullable[datetime]]
        ${NotBefore},

        [Parameter(HelpMessage='The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzContext','AzureRmContext','AzureCredential')]
        [Microsoft.Azure.Commands.Common.Authentication.Abstractions.Core.IAzureContextContainer]
        ${DefaultProfile},

        [Parameter(HelpMessage='Used to allows the saving of more then string data.')]
        [switch]
        ${Auto}
    )

    begin
    {
        try {
            $outBuffer = $null
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
            {
                $PSBoundParameters['OutBuffer'] = 1
            }
            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Az.Keyvault\Set-AzKeyVaultSecret', [System.Management.Automation.CommandTypes]::Cmdlet)

            if($PSBoundParameters['Auto']) {
                $null = $PSBoundParameters.Remove('Auto')

                if (!$PSBoundParameters.VaultName) { $PSBoundParameters.VaultName = $Script:KeyVault.VaultName }

                $SupportedTypes = @('PSCredential', 'String', 'Hashtable', 'PSCustomObject', 'SecureString')
                if ($SupportedTypes -notcontains $PSBoundParameters.SecretValue.getType().Name) {
                    $Message = @()
                    $Message += "$($PSBoundParameters.SecretValue.getType().Name), is not a supported object type."
                    $Message += "Supported types: $($SupportedTypes -join ', ')"
                    return Write-Error $($Message | Out-String)
                }

                if (!$PSBoundParameters.Tag) { $PSBoundParameters.Tag = @{} }
                if ($PSBoundParameters.SecretValue.getType().Name -eq 'SecureString'){}
                elseif ($PSBoundParameters.SecretValue.getType().Name -eq 'PSCredential') {
                    $PSBoundParameters.ContentType = 'PSCredential'
                    $PSBoundParameters.Tag['UserName'] = $PSBoundParameters.SecretValue.UserName
                    $PSBoundParameters.SecretValue = $PSBoundParameters.SecretValue.Password
                }
                elseif ($PSBoundParameters.SecretValue.getType().Name -eq 'String') {
                    $PSBoundParameters.ContentType = 'String'
                    $PSBoundParameters.SecretValue = ConvertTo-SecureString $SecretValue -AsPlainText -Force
                }
                else {
                    $PSBoundParameters.ContentType = 'JSON'

                    $PSBoundParameters.SecretValue = _CloneObject $PSBoundParameters.SecretValue

                    # replace PSCreds with nested secrets
                    $Replaced = _CheckForCreds -VaultName $PSBoundParameters.VaultName -SecretName $PSBoundParameters.Name -SecretValue $PSBoundParameters.SecretValue
                    if ($Replaced) {
                        foreach($Key in $Replaced){
                            $PSBoundParameters.Tag[$Key] = 'PSCred'
                        }
                    }

                    $PSBoundParameters.SecretValue = $PSBoundParameters.SecretValue | ConvertTo-Json
                    $PSBoundParameters.SecretValue = ConvertTo-SecureString $PSBoundParameters.SecretValue -AsPlainText -Force
                }
            }

            $scriptCmd = { & $wrappedCmd @PSBoundParameters }
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