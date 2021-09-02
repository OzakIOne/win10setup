# Run default installation

1. Open powershell
2. `Set-ExecutionPolicy RemoteSigned -scope CurrentUser`
3. `Invoke-WebRequest -UseBasicParsing git.io/JYADd | Invoke-Expression`

# Customizing default installation

1. Without cloning

   1. Open powershell
   2. `Set-ExecutionPolicy RemoteSigned -scope CurrentUser`
   3. `Invoke-WebRequest -UseBasicParsing git.io/JYADd | Invoke-Expression`
   4. Cancel the run as administrator prompt
   5. `code "$env:USERPROFILE\Downloads\win10setup\install.ps1"`
   6. Comment the lines you don't want to be run with `#` (or press `ctrl+/` to comment cursor line)
   7. Then `sudo "$env:USERPROFILE\Downloads\win10setup\install.ps1"`

2. With git clone
   1. Open powershell
   2. `git clone https://github.com/OzakIOne/win10setup`
   3. Modify either `scoop.ps1` / `install.ps1` / `final.ps1` to your needs
   4. execute `scoop.ps1`

# Post installation

1. Restart your pc
2. `"$env:USERPROFILE\Downloads\win10setup\final.ps1"` to finish WSL installation.
3. open wsl
4. `cd "$env:USERPROFILE\Downloads" ; wsl.exe`
5. `cp wsl.sh $HOME && cd $HOME`
6. `bash wsl.sh`
7. `nvm install node`
8. `npm config set cache ~/.cache/npm`

## Install zsh ohmyzsh nvm antigen without cloning this repo

1. Open wsl
2. `cd $HOME && bash -c "$(curl -fsSL https://raw.githubusercontent.com/OzakIOne/win10setup/master/wsl.sh)"`
