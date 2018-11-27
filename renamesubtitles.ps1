# This piece of code renames all subtitle files in the executing directory to match the file name of corresponding mkv file.
# Almost all the smart TVs refuse to open the subtitle file unless the base video file name is exactly the same.
# This powershell script is better than renaming all the files yourself, one by one.
#
# Before:
# X.S02E01.x264.mkv
# subtitle02e01.srt
#
# After:
# X.S02E01.x264.mkv
# X.S02E01.x264.srt

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
