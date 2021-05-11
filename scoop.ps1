Write-Host "Installing scoop"
Invoke-WebRequest -UseBasicParsing get.scoop.sh | Invoke-Expression
scoop install git 7zip
scoop bucket add extras
scoop bucket add nerd-fonts
scoop install aria2 scoop-search sudo
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

git clone https://github.com/ozakione/win10setup

Write-Host "Downloading brave vscode wsl and debloat setup"
$LINES = (Get-Content .\win10setup\config\url.txt | Measure-Object -line).Lines / 2
aria2c "-j$LINES" -i .\win10setup\config\url.txt

7z x .\debloat.zip > $null
Remove-Item .\debloat.zip

7z x .\vcppaio.zip > $null
Remove-Item .\vcppaio.zip

Write-Host "Brave install"
.\brave.exe
pause
Write-Host "VSCode install"
.\vscode.exe
pause

Start-Process .\win10setup\
sudo .\win10setup\install.ps1
