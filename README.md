1. Open powershell
2. `Set-ExecutionPolicy RemoteSigned -scope CurrentUser`
3. `Invoke-WebRequest -UseBasicParsing git.io/JYADd | Invoke-Expression`

After running the script you'll have to restart your pc to and execute `final.ps1` script to finish WSL installation.
