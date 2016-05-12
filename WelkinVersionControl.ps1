cd ${env:ProgramFiles(x86)}
#cd "The Welkin Suite"

$currentVersion = (Get-Item "The Welkin Suite\The Welkin Suite\TheWelkinSuite.exe").VersionInfo.ProductVersion
$copyName = "The Welkin Suite $currentVersion"

$copyExists = Test-Path $copyName

if (!$copyExists) {
	# Copy
	New-Item "The Welkin Suite $currentVersion" -type directory
	Copy-Item "The Welkin Suite\The Welkin Suite" "The Welkin Suite $currentVersion\"
	
	# Create Shortcut
	$desktopPath = [Environment]::GetFolderPath("CommonDesktopDirectory")
	$WScriptShell = New-Object -ComObject WScript.Shell
	$Shortcut = $WScriptShell.CreateShortcut("$desktopPath\$copyName.lnk")
	$Shortcut.TargetPath = "$pwd\$copyName\The Welkin Suite\TheWelkinSuite.exe"
	$Shortcut.Save()
}