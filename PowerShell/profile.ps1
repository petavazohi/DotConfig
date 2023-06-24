
#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
(& "C:\ProgramData\Anaconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion

function source {
    if (Test-Path $PROFILE.AllUsersAllHosts) { . $PROFILE.AllUsersAllHosts }
    if (Test-Path $PROFILE.AllUsersCurrentHost) { . $PROFILE.AllUsersCurrentHost }
    if (Test-Path $PROFILE.CurrentUserAllHosts) { . $PROFILE.CurrentUserAllHosts }
    if (Test-Path $PROFILE.CurrentUserCurrentHost) { . $PROFILE.CurrentUserCurrentHost }
}
$targetDir = Split-Path $PROFILE.CurrentUserAllHosts
oh-my-posh init pwsh --config "$targetDir\ohp-theme.json" | Invoke-Expression
Import-Module -Name Terminal-Icons -ErrorAction SilentlyContinue
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