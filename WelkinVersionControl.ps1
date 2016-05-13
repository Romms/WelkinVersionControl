param([switch]$Elevated)

function Test-Admin {
	$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
	$currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } 
    else {
        #Try to run as administrator
        #Set-ExecutionPolicy Unrestricted -Force
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }

    exit
}

# Main 
cd ${env:ProgramFiles(x86)}

$currentVersion = (Get-Item "The Welkin Suite\The Welkin Suite\TheWelkinSuite.exe").VersionInfo.ProductVersion
$copyName = "The Welkin Suite $currentVersion"

$copyExists = Test-Path $copyName

if (!$copyExists) {
    # Create directory for new copy
    #New-Item "The Welkin Suite $currentVersion" -type directory
    New-Item "The Welkin Suite $currentVersion\The Welkin Suite" -type directory
    # Copy to new directory
    Copy-Item "The Welkin Suite\The Welkin Suite\*" "The Welkin Suite $currentVersion\The Welkin Suite\"
    
    # Create shortcut on desktop
    $desktopPath = [Environment]::GetFolderPath("CommonDesktopDirectory")
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut("$desktopPath\$copyName.lnk")
    $Shortcut.TargetPath = "$pwd\$copyName\The Welkin Suite\TheWelkinSuite.exe"
    $Shortcut.Save()
}
