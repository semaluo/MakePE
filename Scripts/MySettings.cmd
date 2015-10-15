	::	*******************************************************************************
	::	Pause between steps
		set DoPause=Yes
	::	*******************************************************************************
	::	Set the MDT Deployment Share
		set DEPLOYROOT=
	::	*******************************************************************************
	::	Set the Version of WinPE to Build
	::	set WinPEVersion=3
		set WinPEVersion=5
	::	set WinPEVersion=10
	::	*******************************************************************************
	::	Set the Platform of WinPE to Build
		set PLATFORM=x86
	::	set PLATFORM=x64
	::	*******************************************************************************
	::	Set the Scratch Space of WinPE
		set ScratchSpace=256
	::	*******************************************************************************
	::	Set the Time Zone of WinPE
		set TimeZone=Central Standard Time
	::	Reference http://technet.microsoft.com/en-us/library/cc749073(v=ws.10).aspx
	::	*******************************************************************************
	::	Set the proper Language for WinPE OC's
		set MyLang=en-us
	::	*******************************************************************************
	::	Opens the Validation Log in Notepad
		set DisplayLog=Yes
	::	*******************************************************************************
	::	Setting this value to Yes will cause BasePE to be rebuilt
		set RebuildBasePE=No
	::	*******************************************************************************
	::	BasePE Build Sequence
	::	1.	WIM Cleanup
	::	2.	Mount New WIM
	::	3.	WinPE Cleanup
	::	4.	Install AIK ADK Packages
			set Install-Packages=Yes
	::	5.	Install Microsoft DaRT
			set Install-DaRT=Yes
	::	6.	Install Extra Files
			set Add-ExtraFiles=Yes
	::	7.	Install BasePE Customizations
			set Customize-BasePE=Yes
	::	8.	Commit BasePE

	::	WinPE Build Sequence
	::	1.	WIM Cleanup
	::	2.	Mount Base PE
	::	3.	WinPE Cleanup
	::	4.	Install Microsoft Deployment Toolkit
			set Install-MDT=Yes
	::	5.	Install Drivers
			set Install-Drivers=Yes
	::	6.	Install Extra Files
	::		This is configured by Add-ExtraFiles in the BasePE Build Sequence
	::	7.	Install WinPE Customizations
			set Customize-WinPE=Yes
	::	8.	Commit WinPE
		
	::	ISO Build Sequence
	::	1.	Create ISO Directory
	::	2.	Export WinPE WIM
	::	3.	Install ISO Extra Files
			set Add-ExtraFilesISO=Yes
	::	4.	Commit ISO
	::	5.	ISO Cleanup
	::	*******************************************************************************
	::	WinPE AIK and ADK Packages
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
	::	*******************************************************************************