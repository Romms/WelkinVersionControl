# WelkinVersionControl

WelkinVersionControl.ps1 makes copy of installed The Welkin Suite version to Program Files (x86) directory and add shortcut on the desktop

Please **run WelkinVersionControl.ps1 as administrator**
or previously change Execution Policy in PowerShell:

<!-- language: PowerShell -->
    PowerShell> Set-ExecutionPolicy Unrestricted -Force


#### Recommend using:
* Right click on WelkinVersionControl.ps1 -> "Run with PowerShell"
* Add script to Task Scheduler (don't forget run script with highest privileges)
  * Action: powershell.exe -ExecutionPolicy ByPass -File "C:\Program Files (x86)\The Welkin Suite\WelkinVersionControl.ps1" -elevated

#### The Welkin Suite - Developer friendly Force.com IDE
https://welkinsuite.com/
