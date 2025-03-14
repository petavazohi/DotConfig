#region conda initialize
# Check for Anaconda or Miniconda installations
$condaPathAnaconda = "C:\ProgramData\Anaconda3\Scripts\conda.exe"
$condaPathMiniconda = "C:\ProgramData\miniconda3\Scripts\conda.exe"

if (Test-Path $condaPathAnaconda) {
    # Initialize Anaconda
    & $condaPathAnaconda "shell.powershell" "hook" | Out-String | Invoke-Expression
    Write-Host "Anaconda initialization complete."
} elseif (Test-Path $condaPathMiniconda) {
    # Initialize Miniconda
    & $condaPathMiniconda "shell.powershell" "hook" | Out-String | Invoke-Expression
    Write-Host "Miniconda initialization complete."
} else {
    # Skip initialization if neither exists
    Write-Warning "Neither Anaconda nor Miniconda found. Skipping Conda initialization."
}
#endregion


$targetDir = Split-Path $PROFILE
oh-my-posh init pwsh --config "$targetDir\ohp-theme.json" | Invoke-Expression
Import-Module -Name Terminal-Icons 

function ChnDir {
    param(
        [string]$Path
    )

    process {
        # Resolve the full path
        if ($Path.Length -eq 0) {
            $Path = $HOME
        }

        $FullPath = Resolve-Path $Path


        if ($FullPath -like "*.lnk") {
            $shell = New-Object -COM WScript.Shell
            $shortcut = $shell.CreateShortcut($FullPath)
            if (Test-Path $shortcut.TargetPath) {
                $Path = $shortcut.TargetPath
            } else {
                return
            }
        }

        Set-Location -Path $Path
    }
}
Set-Alias -Name cd -Value ChnDir -Option AllScope

# function ConvertTo-RelativePath {
#     param($Path)
#     if ($Path.StartsWith($HOME)) {
#         return $Path.Replace($HOME, "~")
#     } else {
#         return $Path
#     }
# }

# function prompt {
#     $user = $env:USERNAME
#     $hst = $env:COMPUTERNAME
#     $path = (Get-Location).Path
#     $relativePath = ConvertTo-RelativePath $path
#     $psVersion = $PSVersionTable.PSVersion
    
#     $CondaEnv = (Get-Content env:CONDA_PROMPT_MODIFIER -ErrorAction SilentlyContinue)

#     if ($CondaEnv) {
#         Write-Host -NoNewLine -ForegroundColor Magenta $CondaEnv
#     }

#     $GitBranch = (Get-Content env:__PS_GIT_BRANCH -ErrorAction SilentlyContinue)

#     Get-Date -Format "ddd MMM dd hh:mm tt" | Write-Host -NoNewLine -ForegroundColor Red
#     Write-Host "-[" -NoNewLine -ForegroundColor White
#     Write-Host $user -NoNewLine -ForegroundColor Blue
#     Write-Host "@" -NoNewLine -ForegroundColor White
#     Write-Host $hst -NoNewLine -ForegroundColor Green
#     Write-Host "]: " -NoNewLine -ForegroundColor White
#     Write-Host -NoNewline -ForegroundColor Yellow $relativePath
#     Write-Host 
#     Write-Host "PS $($psVersion.Major).$($psVersion.Minor)>" -NoNewline -ForegroundColor White
#     return " "
# }