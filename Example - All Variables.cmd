	@echo off
	pushd %~dp0
echo This example Build Script shows all the Variables for usage in Build Scripts
echo This script will pause at milestones
pause

::	Authenticate to remote server for MDT files
	rem net use \\DeploymentServer\DeploymentShare /USER:Domain\UserName

::	Run MakePE.cmd to load the Defaults and MySettings
	call .\Scripts\MakePE.cmd

::	Engine Variables
	set DoPause=Yes
	set DisplayLog=Yes
	
::	BasePE Variables
	set RebuildBasePE=No
	set ScratchSpace=256
	set TimeZone=Central Standard Time
	set Install-DaRT=Yes
	set Add-ExtraFiles=Yes
	set Customize-BasePE=Yes
	
::	AIK and ADK Variables
	set Install-Packages=Yes
		set MyLang=en-us
		set WinPE-HTA=Yes
		set WinPE-Scripting=Yes
		set WinPE-WMI=Yes
		set WinPE-SecureStartup=Yes
		set WinPE-FMAPI=Yes
		set WinPE-MDAC=Yes
		set WinPE-Dot3Svc=Yes
		set WinPE-PPPoE=Yes
		set WinPE-RNDIS=Yes
		set WinPE-WDS-Tools=Yes
		set WinPE-NetFx=Yes
		set WinPE-PowerShell=Yes
		set WinPE-DismCmdlets=Yes
		set WinPE-SecureBootCmdlets=Yes
		set WinPE-StorageWMI=Yes
		set WinPE-EnhancedStorage=Yes
		set WinPE-Rejuv=Yes
		set WinPE-SRT=Yes
		set WinPE-WinReCfg=Yes

::	WinPE Options
	set Install-MDT=Yes
		rem set DEPLOYROOT=
	set Install-Drivers=Yes
	set Customize-WinPE=Yes
	
::	ISO Options
	set Add-ExtraFilesISO=Yes

::	Set the WinPE Version and Architecture
	set WinPEVersion=10
	set PLATFORM=x86
	
::	Run MakePE
	call .\Scripts\MakePE.cmd
	
::	You can pause at the end
	pause
