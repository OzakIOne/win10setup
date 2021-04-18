Write-Host "Installing scoop"
Invoke-WebRequest -UseBasicParsing get.scoop.sh | Invoke-Expression
scoop install git 7zip ; scoop bucket add extras ; scoop bucket add nerd-fonts ; scoop install aria2 scoop-search
scoop config aria2-enabled true
scoop alias add i 'scoop install $args[0]' 'Innstall app'
scoop alias add r 'scoop uninstall $args[0]' 'Uninnstall app'
scoop alias add ua 'scoop update *' 'Update all installed apps'
scoop alias add ca 'scoop cleanup *' 'Delete all old installed versions'
scoop alias add cc 'scoop cache rm *' 'Empty download cache'
scoop alias add h 'scoop home $args[0]' 'Home app'
scoop alias add s 'scoop search $args[0]' 'Search app'
scoop alias add ls 'scoop list' 'List installed apps'

Set-Location $env:USERPROFILE\Downloads

Write-Host "Downloading brave vscode wsl and debloat setup"
aria2c "https://referrals.brave.com/latest/BraveBrowserSetup.exe" -o brave.exe
aria2c "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user" -o vscode.exe
aria2c "https://github.com/OzakIOne/Win10-Initial-Setup-Script/archive/refs/heads/master.zip" -o debloat.zip
aria2c "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -o wsl.msi

7z x .\debloat.zip > $null
Remove-Item .\debloat.zip

Write-Host "Brave install"
.\brave.exe
pause
Write-Host "VSCode install"
.\vscode.exe
pause

git clone https://github.com/ozakione/win10setup
Start-Process .\win10setup\
powershell.exe .\win10setup\install.ps1
