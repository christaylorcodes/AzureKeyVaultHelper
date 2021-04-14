---
external help file: AzureKeyVaultHelper-help.xml
Module Name: AzureKeyVaultHelper
online version:
schema: 2.0.0
---

# Connect-AzKeyVault

## SYNOPSIS
This will import needed modules and connect to Azure.

## SYNTAX

```
Connect-AzKeyVault [-TenantId] <String> [-ApplicationId] <String> [-VaultName] <String> [-Thumbprint] <String>
 [<CommonParameters>]
```

## DESCRIPTION
This will install, update and import relevant modules, then connect to Azure using certificate authentication. The VaultName will be cached and used for subsequent calls if not specified.

## EXAMPLES

### EXAMPLE 1
```
Connect-KeyVault -TenantId 123 -ApplicationId 123 -VaultName 'Vault' -Thumbprint 123
```

## PARAMETERS

### -TenantId
The tenant ID of the KeyVault.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicationId
The ID of the application that you are authenticating as.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VaultName
The Vault name given will be cached for use with subsequent commands.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Thumbprint
The thumbprint of the certificate used with authentication.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
General notes

## RELATED LINKS
