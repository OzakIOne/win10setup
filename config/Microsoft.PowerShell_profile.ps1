New-Alias -Name "ydl" -Value youtube-dl
function ydln([string]$url)
{
    youtube-dl --ignore-config "$url"
}
New-Alias -Name "s" -Value scoop
function sxsa()
{
    Dism.exe /Online /Cleanup-Image /AnalyzeComponentStore
}
function sxsc()
{
    Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
}
function jjar([string]$file)
{
    java -jar "$file"
}
Invoke-Expression (&scoop-search --hook)
