---
external help file: AzureKeyVaultHelper-help.xml
Module Name: AzureKeyVaultHelper
online version:
schema: 2.0.0
---

# Convert-JsonToHash

## SYNOPSIS
Converts a PSCustomObject converted from a JSON object to a hashtable.

## SYNTAX

```
Convert-JsonToHash [-root] <Object> [<CommonParameters>]
```

## DESCRIPTION
Converts a PSCustomObject converted from a JSON object to a hashtable.

## EXAMPLES

### EXAMPLE 1
```
$Object | Convert-JsonToHash
```

## PARAMETERS

### -root
The object to be converted.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
https://stackoverflow.com/questions/22002748/hashtables-from-convertfrom-json-have-different-type-from-powershells-built-in-h

## RELATED LINKS
