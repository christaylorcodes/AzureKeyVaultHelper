---
external help file: AzureKeyVaultHelper-help.xml
Module Name: AzureKeyVaultHelper
online version: https://docs.microsoft.com/en-us/powershell/module/az.keyvault/set-azkeyvaultsecret
schema: 2.0.0
---

# Set-AzKeyVaultSecret

## SYNOPSIS
Creates or updates a secret in a key vault.

## SYNTAX

### Default (Default)
```
Set-AzKeyVaultSecret [[-VaultName] <String>] [-Name] <String> [-SecretValue] <Object> [-Tag <Hashtable>]
 [-ContentType <String>] [-Disable] [-Expires <DateTime>] [-NotBefore <DateTime>]
 [-DefaultProfile <IAzureContextContainer>] [-Auto] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InputObject
```
Set-AzKeyVaultSecret [-SecretValue] <Object> [-Tag <Hashtable>] [-ContentType <String>]
 [-InputObject] <PSKeyVaultSecretIdentityItem> [-Disable] [-Expires <DateTime>] [-NotBefore <DateTime>]
 [-DefaultProfile <IAzureContextContainer>] [-Auto] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Set-AzKeyVaultSecret cmdlet creates or updates a secret in a key vault in Azure Key Vault.
If the secret does not exist, this cmdlet creates it.
If the secret already exists, this cmdlet creates a new version of that secret.

## EXAMPLES

### Example 1: Modify the value of a secret using default attributes
```
PS C:\> $Secret = ConvertTo-SecureString -String 'Password' -AsPlainText -Force
PS C:\> Set-AzKeyVaultSecret -VaultName 'Contoso' -Name 'ITSecret' -SecretValue $Secret

Vault Name   : Contoso
Name         : ITSecret
Version      : 8b5c0cb0326e4350bd78200fac932b51
Id           : https://contoso.vault.azure.net:443/secrets/ITSecret/8b5c0cb0326e4350bd78200fac932b51
Enabled      : True
Expires      :
Not Before   :
Created      : 5/25/2018 6:39:30 PM
Updated      : 5/25/2018 6:39:30 PM
Content Type :
Tags         :
```

The first command converts a string into a secure string by using the ConvertTo-SecureString cmdlet, and then stores that string in the $Secret variable.
For more information, type \`Get-Help ConvertTo-SecureString\`.
The second command modifies value of the secret named ITSecret in the key vault named Contoso.
The secret value becomes the value stored in $Secret.

### Example 2: Modify the value of a secret using custom attributes
```
PS C:\> $Secret = ConvertTo-SecureString -String 'Password' -AsPlainText -Force
PS C:\> $Expires = (Get-Date).AddYears(2).ToUniversalTime()
PS C:\> $NBF =(Get-Date).ToUniversalTime()
PS C:\> $Tags = @{ 'Severity' = 'medium'; 'IT' = 'true'}
PS C:\> $ContentType = 'txt'
PS C:\> Set-AzKeyVaultSecret -VaultName 'Contoso' -Name 'ITSecret' -SecretValue $Secret -Expires $Expires -NotBefore $NBF -ContentType $ContentType -Disable -Tags $Tags

Vault Name   : Contoso
Name         : ITSecret
Version      : a2c150be3ea24dd6b8286986e6364851
Id           : https://contoso.vault.azure.net:443/secrets/ITSecret/a2c150be3ea24dd6b8286986e6364851
Enabled      : False
Expires      : 5/25/2020 6:40:00 PM
Not Before   : 5/25/2018 6:40:05 PM
Created      : 5/25/2018 6:41:22 PM
Updated      : 5/25/2018 6:41:22 PM
Content Type : txt
Tags         : Name      Value
               Severity  medium
               IT        true
```

The first command converts a string into a secure string by using the ConvertTo-SecureString cmdlet, and then stores that string in the $Secret variable.
For more information, type \`Get-Help ConvertTo-SecureString\`.
The next commands define custom attributes for the expiry date, tags, and context type, and store the attributes in variables.
The final command modifies values of the secret named ITSecret in the key vault named Contoso, by using the values specified previously as variables.

## PARAMETERS

### -ContentType
Specifies the content type of a secret.
To delete the existing content type, specify an empty string.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultProfile
The credentials, account, tenant, and subscription used for communication with azure

```yaml
Type: IAzureContextContainer
Parameter Sets: (All)
Aliases: AzContext, AzureRmContext, AzureCredential

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Disable
Indicates that this cmdlet disables a secret.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Expires
Specifies the expiration time, as a DateTime object, for the secret that this cmdlet updates.
This parameter uses Coordinated Universal Time (UTC).
To obtain a DateTime object, use the Get-Date cmdlet.
For more information, type \`Get-Help Get-Date\`.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Secret object

```yaml
Type: PSKeyVaultSecretIdentityItem
Parameter Sets: InputObject
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the name of a secret to modify.
This cmdlet constructs the fully qualified domain name (FQDN) of a secret based on the name that this parameter specifies, the name of the key vault, and your current environment.

```yaml
Type: String
Parameter Sets: Default
Aliases: SecretName

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotBefore
Specifies the time, as a DateTime object, before which the secret cannot be used.
This parameter uses UTC.
To obtain a DateTime object, use the Get-Date cmdlet.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecretValue
Specifies the value for the secret as a SecureString object.
To obtain a SecureString object, use the ConvertTo-SecureString cmdlet.
For more information, type \`Get-Help ConvertTo-SecureString\`.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tag
Key-value pairs in the form of a hash table.
For example: @{key0="value0";key1=$null;key2="value2"}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: Tags

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VaultName
Specifies the name of the key vault to which this secret belongs.
This cmdlet constructs the FQDN of a key vault based on the name that this parameter specifies and your current environment.

```yaml
Type: String
Parameter Sets: Default
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Auto
Automatic conversion of input objects to secure strings.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Microsoft.Azure.Commands.KeyVault.Models.PSKeyVaultSecretIdentityItem
## OUTPUTS

### Microsoft.Azure.Commands.KeyVault.Models.PSKeyVaultSecret
## NOTES
## RELATED LINKS

[Get-AzKeyVaultSecret]()

[Remove-AzKeyVaultSecret]()

[Online Version:](https://docs.microsoft.com/en-us/powershell/module/az.keyvault/set-azkeyvaultsecret)

[Get-AzKeyVaultSecret]()

[Remove-AzKeyVaultSecret]()

