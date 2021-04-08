New-Alias -Name "ydl" -Value youtube-dl
function ydln([string]$url)
{
    youtube-dl --ignore-config "$url"
}
New-Alias -Name "s" -Value scoop
Invoke-Expression (&scoop-search --hook)
