# Check if 'oh-my-posh' is already installed
winget list | Out-Null
if (!(winget list --id "JanDeDobbeleer.OhMyPosh")) {
    # If 'oh-my-posh' is not installed, install it
    winget install JanDeDobbeleer.OhMyPosh -s winget
    Write-Host "oh-my-posh has been installed."
} else {
    # If 'oh-my-posh' is already installed, print a message
    Write-Host "oh-my-posh is already installed, Updating.."
    winget upgrade JanDeDobbeleer.OhMyPosh -s winget
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
Copy-Item .omp.json $targetDir/ohp-theme.json
oh-my-posh init pwsh --config .omp.json | Invoke-Expression

# Ensure the NuGet package provider is available
if (!(Get-PackageProvider -ListAvailable -Name NuGet)) {
    Install-PackageProvider -Name NuGet -Force
}

# Check if the PSGallery repository is trusted
if ((Get-PSRepository -Name PSGallery).InstallationPolicy -ne "Trusted") {
    # If not, set PSGallery repository as trusted
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}

# install Terminal-Icons
if (!(Get-Module -ListAvailable -Name Terminal-Icons)) {
    # Check if running in elevated session
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Warning "You don't have enough permissions to install the module. Please run the script as an Administrator."
        exit
    }
    # If Terminal-Icons module isn't installed, install it
    Write-Output "Terminal-Icons module isn't installed. Installing now..."
    
    # Now, we're ready to install Terminal-Icons
    Install-Module -Name Terminal-Icons -Repository PSGallery -Force
} else {
    Write-Output "Terminal-Icons module is already installed."
}
oh-my-posh font install 0xProto
. $PROFILE
Write-Host "Do not forget to install fonts you can use 'oh-my-posh font install' in Admin PowerShell"