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
Invoke-Expression (&starship init powershell)

# Set-PoshPrompt -Theme stelbent.minimal
# Set-PoshPrompt -Theme craver
# Set-PoshPrompt -Theme material
# Set-PoshPrompt -Theme patriksvensson

### phelp // outputs your profiles aliases and functions
function phelp() {
    Get-Content $PROFILE | Select-String -Pattern "New-Alias|###" | Select-String -Pattern "Get-Content" -NotMatch
}
### eee // open explorer.exe in current directory
function eee {
    param(
        [string]$dir = (Get-Location).Path
    )
    if (!$dir) {
        explorer.exe $dir
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
function ydpn {
    param([string]$url)
    yt-dlp --ignore-config "$url"
}
### ydpa // download only the audio of a video and then plays it to mpc-be
function ydpa {
    param([string]$url)
    yt-dlp -x -P "%TMP%/" --sponsorblock-remove all --embed-metadata --restrict-filenames -o "%(title)s.%(ext)s" "$url" --exec mpc-be.exe
}
### ydpmpc // download the video and then plays it to mpc-be
function ydpmpc {
    param([string]$url)
    yt-dlp -P "%TMP%/" --no-sponsorblock --embed-metadata --restrict-filenames -o "%(title)s.%(ext)s" "$url" --exec mpc-be.exe
}
function ydln {
    param([string]$url)
    youtube-dl --ignore-config "$url"
}
### ydpm // download the video to meme folder
function ydpm([string]$url, [string]$name) {
    yt-dlp --format-sort "codec:avc1:mp4a" -o "$name.%(ext)s" -P "D:\Documents\ytdl\" --no-sponsorblock --embed-metadata --restrict-filenames "$url" 
}
### scd // will change your directory with environment variables (it's a shortcut of cd $env:dev => scd dev)
function scd {
    param([string]$dir)
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
    sudo Dism.exe /Online /Cleanup-Image /AnalyzeComponentStore
}
### sxsc // clean your WinSXS directory
function sxsc() {
    sudo Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
}
### jjar // executes a jar file
function jjar {
    param([string]$file)
    if (!$file) {
        Write-Host "Usage: jjar <file.jar>"
    }
    else {
        java -jar "$file"
    }
}
### ydpr // rename downloaded video while keeping extension
function ydpr {
    param(
        [string]$name,
        [string]$url
    )
    if (!$name -or !$url) {
        Write-Host "Usage: ydpr [name] [url]"        
    }
    else {
        yt-dlp -o "$name.%(ext)s" "$url"
    }
}
### fileserv // create a python web file server in the directory you want
function fileserv {
    param(
        [string]$dir,
        [int]$port = 8000
    )
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
function myip {
    param([string]$copy)
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
function pubip {
    param([string]$copy)
    if ($copy.ToLower() -eq 'copy') {
        curl.exe -s icanhazip.com | clip
    }
    curl.exe -s icanhazip.com
}
### upfile // upload a file to 0x0.st
function upfile {
    param([string]$file)
    if (!$file) {
        Write-Host "Usage: upfile <file>"
    }
    else {
        curl.exe -F "file=@$file" https://0x0.st
    }
}
### ffaudio // record audio from choosen mic
function ffaudio {
    $c = -1
    [System.Collections.ArrayList]$micList = @()
    Get-PnpDevice | foreach-object {
        if ($_.Class -eq "AudioEndpoint" -and $_.Status -eq "OK") {
            ++$c
            Write-Host $c $_.FriendlyName
            $micList.Add($_.FriendlyName) > $null
        }
    }
    do {
        [int]$choice = Read-Host "Choose a mic (0 - $c)"
    } while ($choice -gt $c -or $choice -lt 0)
    $mic = $micList[$choice]
    $time = (Get-Date).ToString("yyyy_MM_dd_HH_mm_ss")
    $fileName = "\audio_$time.m4a"
    $filePath = $env:TEMP + $fileName
    ffmpeg -y -f dshow -i audio=$mic $filePath
    Start-Process -FilePath C:\Windows\explorer.exe -ArgumentList "/select, ""$filePath"""
}
### uto // shorten url with u.to
function uto {
    param([string]$url)
    if (!$url) {
        Write-Host "Usage: uto <url>"
    }
    else {
        $ProgressPreference = 'SilentlyContinue'
        (Invoke-WebRequest -UseBasicParsing -Uri "https://u.to/" -Method "POST" -Body "url=${url}&from=&a=add").Content -Match "https.+?(?=<)" > $null
        Write-Host $Matches[0]
        $Matches[0] | clip.exe
    }
}