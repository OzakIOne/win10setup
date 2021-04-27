# Run default installation

1. Open powershell
2. `Set-ExecutionPolicy RemoteSigned -scope CurrentUser`
3. `Invoke-WebRequest -UseBasicParsing git.io/JYADd | Invoke-Expression`

# Customizing default installation

1. Open powershell
2. `Set-ExecutionPolicy RemoteSigned -scope CurrentUser`
3. `Invoke-WebRequest -UseBasicParsing git.io/JYADd | Invoke-Expression`
4. Cancel the run as administrator prompt
5. `code "$env:USERPROFILE\Downloads\win10setup\install.ps1"`
6. Comment the lines you don't want to be run with `#` (or press `ctrl+/` to comment cursor line)
7. Then `sudo "$env:USERPROFILE\Downloads\win10setup\install.ps1"`

# Post installation

1. Restart your pc
2. `"$env:USERPROFILE\Downloads\win10setup\final.ps1"` to finish WSL installation.
3. `cd "$env:USERPROFILE\Downloads" ; wsl.exe`
4. `bash wsl.sh`
