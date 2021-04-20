if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

Write-Host "Installing oh my posh"
Install-PackageProvider NuGet -Force
Install-Module -Name oh-my-posh -Scope CurrentUser -Force

Write-Host "Installing nerdfont"
scoop install CascadiaCode-NF-Mono

Set-Location $env:USERPROFILE\Downloads\win10setup

Write-Host "Monitor HZ options and disable mouse acceleration"
C:\Windows\system32\rundll32.exe display.dll,ShowAdapterSettings 0
C:\Windows\System32\rundll32.exe C:\Windows\System32\shell32.dll,Control_RunDLL C:\Windows\System32\main.cpl
pause

Write-Host "Enabling features for WSL"
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Write-Host "Install Windows Terminal /!\ DO NOT LAUNCH IT /!\"
Start-Sleep 3
Invoke-Expression "cmd.exe /C start ms-windows-store://pdp?productId=9N0DX20HK701"
pause

Write-Host "Copying PowerShell Profile and Windows Terminal settings"
mkdir $env:USERPROFILE\Documents\WindowsPowerShell
New-Item -ItemType SymbolicLink -Target .\config\Microsoft.PowerShell_profile.ps1 -Path $env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
New-Item -ItemType SymbolicLink -Target .\config\settings.json -Path $env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json

Write-Host "Debloating windows press enter to start"
pause
..\Win10-Initial-Setup-Script-master\DefaultOzak.cmd
