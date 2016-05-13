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
		Set-ExecutionPolicy Unrestricted -Force
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
	}

	exit
}


cd ${env:ProgramFiles(x86)}
#cd "The Welkin Suite"

$currentVersion = (Get-Item "The Welkin Suite\The Welkin Suite\TheWelkinSuite.exe").VersionInfo.ProductVersion
$copyName = "The Welkin Suite $currentVersion"

$copyExists = Test-Path $copyName

if (!$copyExists) {
	# Copy
	New-Item "The Welkin Suite $currentVersion" -type directory
	Copy-Item "The Welkin Suite\The Welkin Suite" "The Welkin Suite $currentVersion\" -recurse 
	
	# Create Shortcut
	$desktopPath = [Environment]::GetFolderPath("CommonDesktopDirectory")
	$WScriptShell = New-Object -ComObject WScript.Shell
	$Shortcut = $WScriptShell.CreateShortcut("$desktopPath\$copyName.lnk")
	$Shortcut.TargetPath = "$pwd\$copyName\The Welkin Suite\TheWelkinSuite.exe"
	$Shortcut.Save()
}