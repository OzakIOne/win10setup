$TERMINAL_CONFIG_PATH="$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$PS_PROFILE_PATH="$env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

function backupFile {
  param (
    $File
  )
  $path = ".\win10setup\Backup"
  if(!(Test-Path $path))
  {
    New-Item -ItemType Directory -Force -Path $path
  }
  Copy-Item -Path $File -Destination .\win10setup\Backup
  if($?) {
    Remove-Item $File
  } else {
    Write-Error "There was an error while backuping $File"
  }
}

function closeRunningProcess {
  param (
    $ProcessName
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
}
function installOhMyPosh {
  Write-Host "Installing oh my posh"
  Install-PackageProvider NuGet -Force
  Install-Module -Name oh-my-posh -Scope CurrentUser -Force
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
  dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
  dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart  
}

function installWindowsTerminal {
  Write-Host "Install Windows Terminal"
  Start-Sleep 3
  Invoke-Expression "cmd.exe /C start ms-windows-store://pdp?productId=9N0DX20HK701"
  pause
}

function installConfigFiles {
  Write-Host "Copying PowerShell Profile and Windows Terminal settings"
  New-Item -ItemType Directory -Force -Path $env:USERPROFILE\Documents\WindowsPowerShell
  closeRunningProcess("WindowsTerminal")
  if (Test-Path -Path $PS_PROFILE_PATH -PathType Leaf) {
    backupFile($PS_PROFILE_PATH)
  } else {
    New-Item -ItemType SymbolicLink -Target .\win10setup\config\Microsoft.PowerShell_profile.ps1 -Path $PS_PROFILE_PATH
  }

  if (Test-Path -Path $TERMINAL_CONFIG_PATH -PathType Leaf) {
    backupFile($TERMINAL_CONFIG_PATH)
  } else {
    New-Item -ItemType SymbolicLink -Target .\win10setup\config\settings.json -Path $TERMINAL_CONFIG_PATH
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
