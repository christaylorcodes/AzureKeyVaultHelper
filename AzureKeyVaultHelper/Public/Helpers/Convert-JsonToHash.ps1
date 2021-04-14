function Convert-JsonToHash {
    <#
    .SYNOPSIS
    Converts a PSCustomObject converted from a JSON object to a hashtable.

    .PARAMETER Root
    The object to be converted.

    .EXAMPLE
    $Object | Convert-JsonToHash

    .NOTES
    https://stackoverflow.com/questions/22002748/hashtables-from-convertfrom-json-have-different-type-from-powershells-built-in-h
    #>

    [cmdletbinding()]
    param(
        [parameter(ValueFromPipeline, Mandatory=$true)]
        $root
    )
    $hash = @{}

    $keys = $root | Get-Member -MemberType NoteProperty | Select-Object -exp Name

    $keys | ForEach-Object{
        $key=$_
        $obj=$root.$($_)
        if($obj -match "@{") {
            $nesthash=ConvertJSONToHash $obj
            $hash.add($key,$nesthash)
        }
        else {
           $hash.add($key,$obj)
        }

    }
    return $hash
}