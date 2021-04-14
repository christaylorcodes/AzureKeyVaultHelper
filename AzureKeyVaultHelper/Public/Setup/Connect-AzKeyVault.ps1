function Connect-AzKeyVault {
    <#
    .SYNOPSIS
    This will import needed modules and connect to Azure.

    .DESCRIPTION
    This will install, update and import relevant modules, then connect to Azure using certificate authentication.

    .PARAMETER TenantId
    The tenant ID of the KeyVault.

    .PARAMETER ApplicationId
    The ID of the application that you are authenticating as.

    .PARAMETER VaultName
    The Vault name given will be cached for use with subsequent commands.

    .PARAMETER Thumbprint
    The thumbprint of the certificate used with authentication.

    .EXAMPLE
    Connect-KeyVault -TenantId 123 -ApplicationId 123 -VaultName 'Vault' -Thumbprint 123

    .NOTES
    General notes
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory=$true)]
        [string]$TenantId,
        [parameter(Mandatory=$true)]
        [string]$ApplicationId,
        [parameter(Mandatory=$true)]
        [string]$VaultName,
        [parameter(Mandatory=$true)]
        [string]$Thumbprint
    )

    $NeededModules = @('Az.Accounts', 'Az.Keyvault')
    foreach($Module in $NeededModules){
        $Installed = Get-Module $Module -ListAvailable
        if(!$Installed){
            $OriginalStatus = Get-PSRepository -Name 'PSGallery' -ErrorAction SilentlyContinue
            if (!$OriginalStatus){ Register-PSRepository -Default }
            if ($OriginalStatus.InstallPolicy -ne 'Trusted'){ Set-PSRepository -Name PSGallery -InstallationPolicy Trusted }
            Install-Module $Module -AllowClobber -Force -Confirm:$false
            if ($OriginalStatus.InstallPolicy -ne 'Trusted'){ Set-PSRepository -Name PSGallery -InstallationPolicy Untrusted }
        }
        Update-Module $Module
        Import-Module $Module
    }

    $Connect = @{
        ServicePrincipal = $True
        CertificateThumbprint = $Thumbprint
        ApplicationId = $ApplicationId
        TenantId = $TenantId
    }
    Connect-AzAccount @Connect -ErrorAction Stop

    $Script:KeyVault = @{
        VaultName = $VaultName
    }
}