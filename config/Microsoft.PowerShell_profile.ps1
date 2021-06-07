New-Alias -Name "ydl" -Value youtube-dl
New-Alias -Name "s" -Value scoop
New-Alias -Name "spicetify apply" -Value spicetify-apply
New-Alias -Name "spicetify enable devtool" -Value spicetify-enable-devtool
New-Alias -Name "spicetify disable devtool" -Value spicetify-disable-devtool

Invoke-Expression (&scoop-search --hook)
Set-PoshPrompt -Theme stelbent.minimal
function ydln([string]$url)
{
    youtube-dl --ignore-config "$url"
}
function scd([string]$dir)
{
    Set-Location Env:\
    Set-Location (Get-ChildItem -Path $dir).value
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
