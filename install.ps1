if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

cd C:\Users\$env:USERNAME\Downloads\win10setup

Write-Host "Monitor HZ options and disable mouse acceleration"
C:\Windows\system32\rundll32.exe display.dll,ShowAdapterSettings 0
C:\Windows\System32\rundll32.exe C:\Windows\System32\shell32.dll,Control_RunDLL C:\Windows\System32\main.cpl
pause

Write-Host "Enabling features for WSL"
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Write-Host "Install Windows Terminal"
start "ms-windows-store://pdp?productId=9N0DX20HK701"
pause

Write-Host "Copying PowerShell Profile and Windows Terminal settings"
mkdir C:\Users\$env:USERNAME\Documents\WindowsPowerShell
Copy-Item -Path .\config\Microsoft.PowerShell_profile.ps1 -Destination C:\Users\$env:USERNAME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 
Copy-Item -Path .\config\settings.json -Destination C:\Users\$env:USERNAME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json

Write-Host "Debloating windows press enter to start"
pause
..\Win10-Initial-Setup-Script-master\DefaultOzak.cmd
