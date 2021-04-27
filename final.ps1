if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
.\wsl.msi
Write-Host "Installing WSL2 Kernel"
Start-Process msiexec.exe -argumentlist "/i $env:USERPROFILE\Downloads\wsl.msi /quiet"
pause
Write-Host "Settings WSL 2 as default version"
wsl --set-default-version 2
pause
Write-Host "Please install debian first to install docker"
Invoke-Expression "cmd.exe /C start ms-windows-store://pdp?productId=9MSVKQC78PK6"
Pause
Write-Host "Installing docker"
"$env:USERPROFILE\Downloads\docker.exe"