---
external help file: AzureKeyVaultHelper-help.xml
Module Name: AzureKeyVaultHelper
online version:
schema: 2.0.0
---

# Convert-SecureStringToString

## SYNOPSIS
Converts a secure string to a plain text string.

## SYNTAX

```
Convert-SecureStringToString [-Secure] <SecureString> [<CommonParameters>]
```

## DESCRIPTION
Converts a secure string to a plain text string.

## EXAMPLES

### Example 1
```powershell
PS C:\> ConvertTo-SecureString 'test' -AsPlainText -Force | Convert-SecureStringToString
```

Converts the secure string to a plain text string.

## PARAMETERS

### -Secure
The secure string you want to convert.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Security.SecureString

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
