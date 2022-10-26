# Run default installation

1. Open powershell
2. `Set-ExecutionPolicy RemoteSigned -scope CurrentUser`
3. `Invoke-WebRequest -UseBasicParsing git.io/JYADd | Invoke-Expression`

# Customizing default installation

1. Open powershell
2. `git clone https://github.com/OzakIOne/win10setup`
or `curl.exe -fSL https://github.com/OzakIOne/win10setup/archive/refs/heads/master.zip --output win10setup.zip`
4. Modify either `scoop.ps1` / `install.ps1` / `final.ps1` to your needs
5. execute `scoop.ps1`

# Post installation

1. Restart your pc
2. execute `"$env:USERPROFILE\Downloads\win10setup\final.ps1"` to finish WSL installation.
