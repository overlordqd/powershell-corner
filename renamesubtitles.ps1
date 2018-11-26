dir | ?{$_.Name.EndsWith('.mkv')} | %{ 
    $episodeSignature = (Select-String -InputObject $_.BaseName -Pattern 'S\d{1,2}E\d{1,2}' -AllMatches).Matches[0].Value
    $matchingSubtitle = (dir | ?{ $_.Name.EndsWith('.srt') -and $_.Name -match $episodeSignature })

    if($matchingSubtitle -eq $null)
    {
        'cant find the subtitle for ' + $episodeSignature
    }
    else
    {
        ren $matchingSubtitle[0].Name ($_.BaseName + $matchingSubtitle[0].Extension)
        'renamed ' + $episodeSignature
    }
}
