New-Alias -Name "ydl" -Value youtube-dl
New-Alias -Name "s" -Value scoop
New-Alias -Name "spicetify apply" -Value spicetify-apply
New-Alias -Name "spicetify enable devtool" -Value spicetify-enable-devtool
New-Alias -Name "spicetify disable devtool" -Value spicetify-disable-devtool

Invoke-Expression (&scoop-search --hook)
Set-PoshPrompt -Theme stelbent.minimal
### phelp outputs your profiles aliases and functions
function phelp()
{
    Get-Content $PROFILE | Select-String -Pattern "New-Alias|###" | Select-String -Pattern "Get-Content" -NotMatch
}
### ydln ignores the config and so will download the video in the current directory
function ydln([string]$url)
{
    youtube-dl --ignore-config "$url"
}
### scd will change your directory with environment variables (it's a shortcut of cd $env:dev => scd dev)
function scd([string]$dir)
{
    Set-Location Env:\
    Set-Location (Get-ChildItem -Path $dir).value
}
### sxsa analyze your WinSXS directory
function sxsa()
{
    Dism.exe /Online /Cleanup-Image /AnalyzeComponentStore
}
### sxsc clean your WinSXS directory
function sxsc()
{
    Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
}
### jjar executes a jar file
function jjar([string]$file)
{
    java -jar "$file"
}
