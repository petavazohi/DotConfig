# Check if 'oh-my-posh' is already installed
winget list | Out-Null
if (!(winget list --id "JanDeDobbeleer.OhMyPosh")) {
    # If 'oh-my-posh' is not installed, install it
    winget install JanDeDobbeleer.OhMyPosh -s winget
    Write-Host "oh-my-posh has been installed."
} else {
    # If 'oh-my-posh' is already installed, print a message
    Write-Host "oh-my-posh is already installed."
}

# Define the source file - replace this with your actual file path
$sourceFile = "PowerShell\profile.ps1"
$targetDir = Split-Path $PROFILE
# Check if the profile exists
if (Test-Path $PROFILE) {
    # Ask the user if they want to overwrite the existing profile
    $overwrite = Read-Host "`$targetDir already exists. Do you want to overwrite it? (Y/N)"
    
    # If the user chooses to overwrite the profile
    if ($overwrite.ToUpper() -eq "Y") {
        # Overwrite the profile with the content of the source file
        Copy-Item $sourceFile $PROFILE -Force
        Write-Host "`$PROFILE has been overwritten with the content of $sourceFile."
    } else {
        Write-Host "No changes have been made to `$PROFILE"
    }
} else {
    # If the profile doesn't exist, create it with the content of the source file 
    New-Item -Type File -Path $PROFILE -Force
    Copy-Item $sourceFile $PROFILE -Force
    Write-Host "`$PROFILE has been created with the content of $sourceFile
    ."
}
Copy-Item PowerShell\ohp-theme.json $targetDir
oh-my-posh init pwsh --config PowerShell\ohp-theme.json | Invoke-Expression
. $PROFILE
Write-Host "Do not forget to install fonts you can use 'oh-my-posh font install' in Admin PowerShell"