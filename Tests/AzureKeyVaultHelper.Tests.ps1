$ModuleName = 'AzureKeyVaultHelper'

# Connection param
$VaultSettings = @{
    TenantId = $env:TENANTID
    ApplicationId = $env:APPLICATIONID
    VaultName = $env:VAULTNAME
    Thumbprint = $env:THUMBPRINT
}

# Test objects
$String = 'Test string'

$PlainTextPassword = 'MySuperSecurePassword'
$SecStringPassword = ConvertTo-SecureString $PlainTextPassword -AsPlainText -Force
$CredObject = New-Object System.Management.Automation.PSCredential ('MyUserName', $SecStringPassword)

$Hashtable = @{
    string = $String
    credentials = $CredObject
}

$NestedHashtable = @{
    string = $String
    credentials = $CredObject
    nested = @{
        string = $String
        credentials = $CredObject
    }
}

$PSObject = [PSCustomObject]@{
    string = $String
    credentials = $CredObject
}

$NestedPSObject = [PSCustomObject]@{
    string = $String
    credentials = $CredObject
    nested = [PSCustomObject]@{
        string = $String
        credentials = $CredObject
    }
}

$Verbose = @{}
if($env:APPVEYOR_REPO_BRANCH -and $env:APPVEYOR_REPO_BRANCH -notlike "master") {
    $Verbose.add("Verbose",$True)
}

$PSVersion = $PSVersionTable.PSVersion.Major
Import-Module $PSScriptRoot\..\$ModuleName\$($ModuleName).psm1 -Force

Describe "Convert-SecureStringToString PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest

        It 'Converts' {
            try {
                $SecStringPassword | Convert-SecureStringToString | Should -be $PlainTextPassword
            }
            catch {
                $_ | Should -Be $null
            }
        }
    }
}

Describe "Connect-AzKeyVault PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest
        It 'Authentication: Certificate' {
            try {
                $Result = Connect-AzKeyVault @VaultSettings
            }
            catch {
                $Result = $_
            }
            $Result | Should -Be Microsoft.Azure.Commands.Profile.Models.Core.PSAzureContext
        }
    }
}

# Connect for subsequent tests
$null = Connect-AzKeyVault @VaultSettings

Describe "Set-AzKeyVaultSecret PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest

        It 'String' {
            try {
                $Result = Set-AzKeyVaultSecret -SecretName 'Test-String' -SecretValue $String -Auto
                $Result | Should -be Microsoft.Azure.Commands.KeyVault.Models.PSKeyVaultSecret
            }
            catch {
                $_ | Should -Be $null
            }
        }

        It 'PSCredential' {
            try {
                $Result = Set-AzKeyVaultSecret -SecretName 'Test-Credential' -SecretValue $CredObject -Auto
                $Result | Should -be Microsoft.Azure.Commands.KeyVault.Models.PSKeyVaultSecret
            }
            catch {
                $_ | Should -Be $null
            }
        }

        It 'HashTable' {
            try {
                $Result = Set-AzKeyVaultSecret -SecretName 'Test-Hashtable' -SecretValue $Hashtable -Auto
                $Result | Should -be Microsoft.Azure.Commands.KeyVault.Models.PSKeyVaultSecret
            }
            catch {
                $_ | Should -Be $null
            }
        }

        It 'Nested HashTable' {
            try {
                $Result = Set-AzKeyVaultSecret -SecretName 'Test-NestedHashtable' -SecretValue $NestedHashtable -Auto
                $Result | Should -be Microsoft.Azure.Commands.KeyVault.Models.PSKeyVaultSecret
            }
            catch {
                $_ | Should -Be $null
            }
        }

        It 'PSObject' {
            try {
                $Result = Set-AzKeyVaultSecret -SecretName 'Test-PSObject' -SecretValue $PSObject -Auto
                $Result | Should -be Microsoft.Azure.Commands.KeyVault.Models.PSKeyVaultSecret
            }
            catch {
                $_ | Should -Be $null
            }
        }

        It 'Nested PSObject' {
            try {
                $Result = Set-AzKeyVaultSecret -SecretName 'Test-NestedPSObject' -SecretValue $NestedPSObject -Auto
                $Result | Should -be Microsoft.Azure.Commands.KeyVault.Models.PSKeyVaultSecret
            }
            catch {
                $_ | Should -Be $null
            }
        }

    }
}

Describe "Get-AzKeyVaultSecret PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest

        It 'String' {
            try {
                $Result = Get-AzKeyVaultSecret -SecretName 'Test-String' -Auto -Expand
                $Result | Should -be System.Security.SecureString
                $Result | Convert-SecureStringToString | Should -be $String
            }
            catch {
                $_ | Should -Be $null
            }
        }

        It 'PSCredential' {
            try {
                $Result = Get-AzKeyVaultSecret -SecretName 'Test-Credential' -Auto -Expand
                $Result | Should -be System.Management.Automation.PSCredential
                $Result.UserName | Should -Be $CredObject.UserName
                $Result.GetNetworkCredential().Password | Should -Be $CredObject.GetNetworkCredential().Password

            }
            catch {
                $_ | Should -Be $null
            }
        }

        It 'HashTable' {
            try {
                $Result = Get-AzKeyVaultSecret -SecretName 'Test-Hashtable' -Auto -Expand
                $Result.PSObject.TypeNames | Should -Contain System.Management.Automation.PSCustomObject
                $Result.string | Should -Be $Hashtable.string
                $Result.credentials | Should -Be System.Management.Automation.PSCredential
                $Result.credentials.UserName | Should -Be $Hashtable.credentials.UserName
                $Result.credentials.GetNetworkCredential().Password | Should -Be $Hashtable.credentials.GetNetworkCredential().Password
            }
            catch {
                $_ | Should -Be $null
            }
        }

        It 'Nested HashTable' {
            try {
                $Result = Get-AzKeyVaultSecret -SecretName 'Test-NestedHashtable' -Auto -Expand
                $Result.PSObject.TypeNames | Should -Contain System.Management.Automation.PSCustomObject
                $Result.string | Should -Be $NestedHashtable.string
                $Result.credentials | Should -Be System.Management.Automation.PSCredential
                $Result.credentials.UserName | Should -Be $NestedHashtable.credentials.UserName
                $Result.credentials.GetNetworkCredential().Password | Should -Be $NestedHashtable.credentials.GetNetworkCredential().Password
                $Result.nested.string | Should -Be $NestedHashtable.nested.string
                $Result.nested.credentials | Should -Be System.Management.Automation.PSCredential
                $Result.nested.credentials.UserName | Should -Be $NestedHashtable.nested.credentials.UserName
                $Result.nested.credentials.GetNetworkCredential().Password | Should -Be $NestedHashtable.nested.credentials.GetNetworkCredential().Password
            }
            catch {
                $_ | Should -Be $null
            }
        }

        It 'PSObject' {
            try {
                $Result = Get-AzKeyVaultSecret -SecretName 'Test-PSObject' -Auto -Expand
                $Result.PSObject.TypeNames | Should -Contain System.Management.Automation.PSCustomObject
                $Result.string | Should -Be $PSObject.string
                $Result.credentials | Should -Be System.Management.Automation.PSCredential
                $Result.credentials.UserName | Should -Be $PSObject.credentials.UserName
                $Result.credentials.GetNetworkCredential().Password | Should -Be $PSObject.credentials.GetNetworkCredential().Password
            }
            catch {
                $_ | Should -Be $null
            }
        }

        It 'Nested PSObject' {
            try {
                $Result = Get-AzKeyVaultSecret -SecretName 'Test-NestedPSObject' -Auto -Expand
                $Result.PSObject.TypeNames | Should -Contain System.Management.Automation.PSCustomObject
                $Result.string | Should -Be $NestedPSObject.string
                $Result.credentials | Should -Be System.Management.Automation.PSCredential
                $Result.credentials.UserName | Should -Be $NestedPSObject.credentials.UserName
                $Result.credentials.GetNetworkCredential().Password | Should -Be $NestedPSObject.credentials.GetNetworkCredential().Password
                $Result.nested.string | Should -Be $NestedPSObject.nested.string
                $Result.nested.credentials | Should -Be System.Management.Automation.PSCredential
                $Result.nested.credentials.UserName | Should -Be $NestedPSObject.nested.credentials.UserName
                $Result.nested.credentials.GetNetworkCredential().Password | Should -Be $NestedPSObject.nested.credentials.GetNetworkCredential().Password
            }
            catch {
                $_ | Should -Be $null
            }
        }

    }
}

Describe "Convert-JsonToHash PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest

        It 'Converts' {
            try {
                $Result = Get-AzKeyVaultSecret -SecretName 'Test-Hashtable' -Auto -Expand
                $Result | Convert-JsonToHash | Should -be System.Collections.Hashtable
            }
            catch {
                $_ | Should -Be $null
            }
        }
    }
}