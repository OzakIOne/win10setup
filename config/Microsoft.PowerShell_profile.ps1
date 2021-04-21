New-Alias -Name "ydl" -Value youtube-dl
New-Alias -Name "s" -Value scoop
Invoke-Expression (&scoop-search --hook)
Set-PoshPrompt -Theme stelbent.minimal
function ydln([string]$url)
{
    youtube-dl --ignore-config "$url"
}
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
