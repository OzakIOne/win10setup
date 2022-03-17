$TERMINAL_CONFIG_PATH="$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$PS_PROFILE_PATH="$env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

function Backup-File {
  param (
    [string]$File
  )
  [string]$backupPath = "$env:USERPROFILE\Downloads\win10setup\Backup"
  if (!(Test-Path $backupPath)) {
    New-Directory($backupPath)
  }
  $currentDate = Get-Date -Format "yyyy-MM-dd-HH-mm"
  Copy-Item -Path "${File}__${currentDate}.bak" -Destination $env:USERPROFILE\Downloads\win10setup\Backup
  if ($?) {
    Remove-Item -Path $File
  }
  else {
    Write-Error "There was an error while backuping $File"
  }
}

function New-Directory {
  param (
    [string]$Path
  )
  if (!(Test-Path $Path)) {
    New-Item -ItemType Directory -Force -Path $path
  }
}

function Close-Process {
  param (
    [string]$ProcessName
  )
  $process = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue
  if ($process) {
    $process.CloseMainWindow()
    Start-Sleep 3
    if (!$process.HasExited) {
      $process | Stop-Process -Force
    }
    Write-Host "Closed windows terminal"
  }
  else {
    Write-Error "Process $ProcessName not found"
  }
}
function installOhMyPosh {
  Write-Host "Installing oh my posh"
  Install-PackageProvider NuGet -Force
  Install-Module -Name oh-my-posh -Scope CurrentUser -Force
  pwsh.exe -Command Install-Module -Name oh-my-posh -Scope CurrentUser -Force
}

function installPSReadLine {
  Write-Host "Installing PSReadLine"
  Install-Module -Name PowerShellGet -Force
  Install-Module PSReadLine -AllowPrerelease -Force
  pwsh.exe -Command Install-Module -Name PowerShellGet -Force
  pwsh.exe -Command Install-Module PSReadLine -AllowPrerelease -Force
}

function installTerminalIcons {
  Write-Host "Installing Terminal Icons"
  Install-Module -Name Terminal-Icons -Repository PSGallery
  pwsh.exe -Command Install-Module -Name Terminal-Icons -Repository PSGallery
}

function installCascadiaNF {
  Write-Host "Installing nerdfont"
  scoop install CascadiaCode-NF-Mono
}

function monitorAndMouseOptions {
  Write-Host "Monitor HZ options and disable mouse acceleration"
  C:\Windows\system32\rundll32.exe display.dll,ShowAdapterSettings 0
  C:\Windows\System32\rundll32.exe C:\Windows\System32\shell32.dll,Control_RunDLL C:\Windows\System32\main.cpl
  pause
}

function wslFeatures {
  Write-Host "Enabling features for WSL"
  wsl --install -d debian
}

function installWindowsTerminal {
  Write-Host "Install Windows Terminal"
  Start-Sleep 3
  Invoke-Expression "cmd.exe /C start ms-windows-store://pdp?productId=9N0DX20HK701"
  pause
}

function installPowershellProfile {
  Write-Host "Copying PowerShell Profile"
  New-Item -ItemType Directory -Force -Path $env:USERPROFILE\Documents\WindowsPowerShell
  if (Test-Path -Path $PS_PROFILE_PATH -PathType Leaf) {
    Backup-File($PS_PROFILE_PATH)
    Backup-File($PS_PROFILE_PATH_2)
  }
  else {
    New-Item -ItemType SymbolicLink -Target $env:USERPROFILE\Downloads\win10setup\config\Microsoft.PowerShell_profile.ps1 -Path $PS_PROFILE_PATH
    New-Item -ItemType SymbolicLink -Target $env:USERPROFILE\Downloads\win10setup\config\Microsoft.PowerShell_profile.ps1 -Path $PS_PROFILE_PATH_2
  }
}

function uninstallPowershellProfile {
  Write-Host "Removing PowerShell Profile"
  if (Test-Path -Path $PS_PROFILE_PATH -PathType Leaf) {
    Backup-File($PS_PROFILE_PATH)
    Backup-File($PS_PROFILE_PATH_2)
  }
  else {
    Remove-Item -Path $PS_PROFILE_PATH
    Remove-Item -Path $PS_PROFILE_PATH_2
  }
}

function installTerminalConfigFile {
  Write-Host "Copying Windows Terminal settings"
  Close-Process("WindowsTerminal")
  if (Test-Path -Path $TERMINAL_CONFIG_PATH -PathType Leaf) {
    Backup-File($TERMINAL_CONFIG_PATH)
  }
  else {
    New-Item -ItemType SymbolicLink -Target $env:USERPROFILE\Downloads\win10setup\config\settings.json -Path $TERMINAL_CONFIG_PATH
  }
}

function uninstallTerminalConfigFile {
  Write-Host "Removing Windows Terminal settings"
  Close-Process("WindowsTerminal")
  if (Test-Path -Path $TERMINAL_CONFIG_PATH -PathType Leaf) {
    Backup-File($TERMINAL_CONFIG_PATH)
  }
  else {
    Remove-Item -Path $TERMINAL_CONFIG_PATH
  }
}

function addEnvUserVar {
  Write-Host "Adding dev & apps env user variable"
  [System.Environment]::SetEnvironmentVariable('dev', 'C:\dev', [System.EnvironmentVariableTarget]::User)
  [System.Environment]::SetEnvironmentVariable('apps', "$env:USERPROFILE\scoop\apps", [System.EnvironmentVariableTarget]::User)
}

function windowsDebloat {
  Write-Host "Debloating windows press enter to start"
  .\Win10-Initial-Setup-Script-master\DefaultOzak.cmd
}

function installSpotify {
  Write-Host "Installing spotify"
  scoop bucket add spotify https://github.com/TheRandomLabs/Scoop-Spotify.git
  scoop install spotify-latest
}

function blockSpotifyAds {
  Write-Host "Installing blockthespot"
  scoop install blockthespot
}

function installSpotifyTheme {
  Write-Host "Installing spotify themes"
  scoop install spicetify-cli
  Set-Location $env:HOMEPATH\.spicetify\
  git clone --branch v2 https://github.com/morpheusthewhite/spicetify-themes/ Themes\
  spicetify config current_theme Sleek
  spicetify-apply
}

function installGeniusSpotify {
  Write-Host "Installing lyrics-plus for spotify"
  spicetify config custom_apps lyrics-plus
  spicetify-apply
  # Write-Host "Change your musixmatch token : https://github.com/khanhas/genius-spicetify#musicxmatch"
  # Invoke-Expression "cmd.exe /C start $env:USERPROFILE\.spicetify\CustomApps\genius\manifest.json"
}

function installProgramAssociation {
  Write-Host "Installing file program association"
  sudo dism /online /Import-DefaultAppAssociations:".\win10setup\config\FileAssociations.xml"
}

function installUsefullApps {
  Write-Host "Installing usefull apps"
  scoop install mpc-be obs-studio youtube-dl yt-dlp ffmpeg anydesk authy discord everything ffsend keepass naps2 nomacs notepadplusplus python qbittorrent rclone sharex tightvnc wumgr
}

function installOtherApps {
  Write-Host "Installing other apps"
  scoop bucket add java
  scoop bucket add nirsoft-alternative https://github.com/MCOfficer/scoop-nirsoft.git
  scoop bucket add Sysinternals 'https://github.com/Ash258/Scoop-Sysinternals.git'
  scoop install adb gcc hwinfo speedtest-cli waifu2x-caffe winaero-tweaker bulk-rename-utility audacity autohotkey autologon autoruns bat clockres cmake crystaldiskinfo dark ddu diffmerge dismplusplus driverstoreexplorer firefox gifski gitextensions hyperfine innounp insomnia lessmsi losslesscut mediainfo nodejs deno nuclear p4merge picotorrent processmonitor putty qaac rufus sdelete spek sumatrapdf tcpview telegram ventoy vlc webtorrent winmerge wiztree xca z zoomit
}

function installGpo {
  Write-Host "Installing GPO"
  Copy-Item .\win10setup\config\GroupPolicy -Destination "C:\Windows\System32\" -Recurse -Force
  gpupdate.exe /force
}

function installVcppaio {
  Write-Host "Installing visual cpp redistributable runtimes, press enter once setup is finished"
  .\VisualCppRedist_AIO_x86_x64.exe /y
  pause
}

function installYtdlpConfigFile {
  Write-Host "Installing yt-dlp config file"
  $ytdlpConfigPath = "$env:APPDATA\yt-dlp\"
  if(Test-Path $ytdlpConfigPath) {
      backupFile("$ytdlpConfigPath\yt-dlp.conf")
      New-Item -ItemType SymbolicLink -Target ".\config\yt-dlp\yt-dlp.conf" -Path "$ytdlpConfigPath\config"
  }
  else {
    createDir($ytdlpConfigPath)
  }
}