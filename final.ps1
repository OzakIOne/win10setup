if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Set-Location $env:USERPROFILE\Downloads
.\wsl.msi
Write-Host "Installing WSL2 Kernel"
Start-Process msiexec.exe -argumentlist "/i $env:USERPROFILE\Downloads\wsl.msi /quiet"
pause
Write-Host "Settings WSL 2 as default version"
wsl --set-default-version 2
pause
Write-Host "Installing debian"
Add-AppxPackage -Path .\debian.AppxBundle
Pause
Write-Host "Installing docker"
"$env:USERPROFILE\Downloads\docker.exe"