New-Alias -Name "ydl" -Value youtube-dl
New-Alias -Name "ydp" -Value yt-dlp
New-Alias -Name "s" -Value scoop
New-Alias -Name "spicetify apply" -Value spicetify-apply
New-Alias -Name "spicetify enable devtool" -Value spicetify-enable-devtool
New-Alias -Name "spicetify disable devtool" -Value spicetify-disable-devtool

if (($host.Name -eq 'ConsoleHost')) {
    Import-Module PSReadLine
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadlineKeyHandler -Key UpArrow   -Function HistorySearchBackward
    Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
    # Set-PSReadLineKeyHandler -Key Tab -Function Complete
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
    Set-PSReadLineOption -Colors @{ InlinePrediction = '#F6546A' }
    if (($host.Version.Major -eq 7)) {
        Set-PSReadLineOption -PredictionViewStyle ListView
        Set-PSReadLineOption -EditMode Windows
    }
}

Import-Module -Name Terminal-Icons

Invoke-Expression (&scoop-search --hook)
Set-PoshPrompt -Theme stelbent.minimal
#Set-PoshPrompt -Theme craver
#Set-PoshPrompt -Theme material
# Set-PoshPrompt -Theme patriksvensson

### phelp // outputs your profiles aliases and functions
function phelp() {
    Get-Content $PROFILE | Select-String -Pattern "New-Alias|###" | Select-String -Pattern "Get-Content" -NotMatch
}
### eee // open explorer.exe in current directory
function eee([string]$dir) {
    if (!$dir) {
        explorer.exe (Get-Location).Path
    }
    else {
        explorer.exe $dir
    }
}
### ydpce // edit the yt-dlp config file
function ydpce() {
    code C:\Users\ozaki\AppData\Roaming\yt-dlp\config
}
### ydpn // ignores the config and so will download the video in the current directory
function ydpn([string]$url) {
    yt-dlp --ignore-config "$url"
}
### ydpa // download only the audio of a video and then plays it to mpc-be
function ydpa([string]$url) {
    yt-dlp -x -P "%TMP%/" --sponsorblock-remove all --embed-metadata --restrict-filenames -o "%(title)s.%(ext)s" "$url" --exec mpc-be.exe
}
### ydpmpc // download the video and then plays it to mpc-be
function ydpmpc([string]$url) {
    yt-dlp -P "%TMP%/" --no-sponsorblock --embed-metadata --restrict-filenames -o "%(title)s.%(ext)s" "$url" --exec mpc-be.exe
}
function ydln([string]$url) {
    youtube-dl --ignore-config "$url"
}
### scd // will change your directory with environment variables (it's a shortcut of cd $env:dev => scd dev)
function scd([string]$dir) {
    if (!$dir) {
        Write-Host "Usage: scd [dev|apps|temp]"
    }
    elseif ($dir.ToLower() -eq "list") {
        (Get-ChildItem Env:) | ForEach-Object {
            if (Test-Path -Path $($_.value) -PathType Container) {
                Write-Host -NoNewline -f red "$($_.name)" ; Write-Host -f blue " $($_.value)"
            }
        }
    }
    else {
        Set-Location Env:\
        Set-Location (Get-ChildItem -Path $dir).value
    }
}
### sxsa // analyze your WinSXS directory
function sxsa() {
    Dism.exe /Online /Cleanup-Image /AnalyzeComponentStore
}
### sxsc // clean your WinSXS directory
function sxsc() {
    Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
}
### jjar // executes a jar file
function jjar([string]$file) {
    if (!$file) {
        Write-Host "Usage: jjar <file.jar>"
    }
    else {
        java -jar "$file"
    }
}
### ydpr // rename downloaded video while keeping extension
function ydpr([string]$name, [string]$url) {
    if (!$name -or !$url) {
        Write-Host "Usage: ydpr [name] [url]"        
    }
    else {
        yt-dlp -o "$name.%(ext)s" "$url"
    }
}
### fileserv // create a python web file server in the directory you want
function fileserv([string]$dir, [int]$port = 8000) {
    if (!$dir) {
        Write-Host "Usage: fileserv [dir]"
        return
    }
    if ($port -lt 1 -or $port -gt 65535) {
        Write-Host 'Port must be between 1 and 65535'
        return
    }
    else {
        $localip = myip
        $publicip = pubip
        Write-Host "${localip}:${port}" ; Write-Host "${publicip}:${port}" ; python3 -m http.server --directory "${dir}" "${port}"
    }
}
### myip // print curent network ip and copied if "copy" arg
function myip([string]$copy) {
    if ($copy.ToLower() -eq 'copy') {
        (Get-NetIPConfiguration | Where-Object {
            $null -ne $_.IPv4DefaultGateway -and
            $_.NetAdapter.Status -ne "Disconnected"
        }).IPv4Address.IPAddress | clip
    }
    (Get-NetIPConfiguration |
    Where-Object {
        $null -ne $_.IPv4DefaultGateway -and
        $_.NetAdapter.Status -ne "Disconnected"
    }).IPv4Address.IPAddress
}
### pubip // print public network ip and copied if "copy" arg
function pubip([string]$copy) {
    if ($copy.ToLower() -eq 'copy') {
        curl.exe -s icanhazip.com | clip
    }
    curl.exe -s icanhazip.com
}
### upfile // upload a file to 0x0.st
function upfile([string]$file) {
    if (!$file) {
        Write-Host "Usage: upfile <file>"
    }
    else {
        curl.exe -F "file=@$file" https://0x0.st
    }
}
