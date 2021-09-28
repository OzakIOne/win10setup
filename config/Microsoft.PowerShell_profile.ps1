New-Alias -Name "ydl" -Value youtube-dl
New-Alias -Name "ydp" -Value yt-dlp
New-Alias -Name "s" -Value scoop
New-Alias -Name "spicetify apply" -Value spicetify-apply
New-Alias -Name "spicetify enable devtool" -Value spicetify-enable-devtool
New-Alias -Name "spicetify disable devtool" -Value spicetify-disable-devtool

if (($host.Name -eq 'ConsoleHost'))
#  -and (Get-InstalledModule | where-object {$_.name -eq "PSReadLine"})
{
    Import-Module PSReadLine
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadlineKeyHandler -Key UpArrow   -Function HistorySearchBackward
    Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
    Set-PSReadLineKeyHandler -Key Tab -Function Complete
}

Invoke-Expression (&scoop-search --hook)
Set-PoshPrompt -Theme stelbent.minimal
### phelp // outputs your profiles aliases and functions
function phelp()
{
    Get-Content $PROFILE | Select-String -Pattern "New-Alias|###" | Select-String -Pattern "Get-Content" -NotMatch
}
### ydln/ydpn // ignores the config and so will download the video in the current directory
function ydpn([string]$url)
{
    yt-dlp --ignore-config "$url"
}
function ydln([string]$url)
{
    youtube-dl --ignore-config "$url"
}
### scd // will change your directory with environment variables (it's a shortcut of cd $env:dev => scd dev)
function scd([string]$dir)
{
    Set-Location Env:\
    Set-Location (Get-ChildItem -Path $dir).value
}
### sxsa // analyze your WinSXS directory
function sxsa()
{
    Dism.exe /Online /Cleanup-Image /AnalyzeComponentStore
}
### sxsc // clean your WinSXS directory
function sxsc()
{
    Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
}
### jjar // executes a jar file
function jjar([string]$file)
{
    java -jar "$file"
}
### ydpr // rename downloaded video while keeping extension
function ydpr([string]$name, [string]$url)
{
    yt-dlp -o "$name.%(ext)s" "$url"
}
### fileserv // create a python web file server in the directory you want
function fileserv([string]$dir)
{
    myip ; Set-Location $dir ; python3 -m http.server
}
### myip // print curent network ip and copied if "copy" arg
function myip([string]$copy)
{
    if($copy -eq 'copy')
    {
        (Test-Connection -ComputerName (hostname) -Count 1).IPV4Address.IPAddressToString | clip
    }

    (Test-Connection -ComputerName (hostname) -Count 1).IPV4Address.IPAddressToString
}
