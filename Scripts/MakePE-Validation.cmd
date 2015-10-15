@echo off
echo ===============================================================================
echo Executing MakePE Validation at %MakePE%\Scripts\MakePE-Validation.cmd
echo ===============================================================================
	echo Checking MakePE Core Directories
	set BUILDS=%MakePE%\Builds
		if NOT exist "%BUILDS%\." md "%BUILDS%"
	set COMPONENTS=%MakePE%\Components
		if NOT exist "%Components%\." md "%Components%"
		if NOT exist "%Components%\DaRT\." md "%Components%\DaRT"
		if NOT exist "%Components%\Windows AIK\." md "%Components%\Windows AIK"
		if NOT exist "%Components%\Windows Kits\." md "%Components%\Windows Kits"
		if NOT exist "%Components%\WinPE 3 x64\." md "%Components%\WinPE 3 x64"
		if NOT exist "%Components%\WinPE 3 x86\." md "%Components%\WinPE 3 x86"
		if NOT exist "%Components%\WinPE 5 x64\." md "%Components%\WinPE 5 x64"
		if NOT exist "%Components%\WinPE 5 x86\." md "%Components%\WinPE 5 x86"
		if NOT exist "%Components%\WinPE 10 x64\." md "%Components%\WinPE 10 x64"
		if NOT exist "%Components%\WinPE 10 x86\." md "%Components%\WinPE 10 x86"
	set OPTIONAL=%MakePE%\Optional
		if NOT exist "%OPTIONAL%\." md "%OPTIONAL%"
		if NOT exist "%OPTIONAL%\Drivers\." md "%OPTIONAL%\Drivers"
		if NOT exist "%OPTIONAL%\Drivers\WinPE 3 x64\." md "%OPTIONAL%\Drivers\WinPE 3 x64"
		if NOT exist "%OPTIONAL%\Drivers\WinPE 3 x86\." md "%OPTIONAL%\Drivers\WinPE 3 x86"
		if NOT exist "%OPTIONAL%\Drivers\WinPE 5 x64\." md "%OPTIONAL%\Drivers\WinPE 5 x64"
		if NOT exist "%OPTIONAL%\Drivers\WinPE 5 x86\." md "%OPTIONAL%\Drivers\WinPE 5 x86"
		if NOT exist "%OPTIONAL%\Drivers\WinPE 10 x64\." md "%OPTIONAL%\Drivers\WinPE 10 x64"
		if NOT exist "%OPTIONAL%\Drivers\WinPE 10 x86\." md "%OPTIONAL%\Drivers\WinPE 10 x86"
		if NOT exist "%MakePE%\ScriptsRW." md "%MakePE%\ScriptsRW"
	set SCRIPTS=%MakePE%\Scripts
echo ===============================================================================
	echo Checking Microsoft Deployment Integration
	echo 	Valid Locations:
	echo 	C:\Program Files\Microsoft Deployment Toolkit
	echo 	%Components%\Microsoft Deployment Toolkit
	echo 	%Components%\Microsoft Deployment Toolkit 2013
	echo 	%Components%\Microsoft Deployment Toolkit 2013 Update 1
	echo 	%Components%\MDT 2013
	echo 	%Components%\MDT 2013 Update 1
	
::	If MDT is installed, then we use that for %INSTALLDIR%
	if exist "C:\Program Files\Microsoft Deployment Toolkit\." set INSTALLDIR=C:\Program Files\Microsoft Deployment Toolkit

::	If you move your MDT directory to Components then one of these options will be set
	if exist "%Components%\Microsoft Deployment Toolkit\." set INSTALLDIR=%Components%\Microsoft Deployment Toolkit
	if exist "%Components%\Microsoft Deployment Toolkit 2013\." set INSTALLDIR=%Components%\Microsoft Deployment Toolkit 2013
	if exist "%Components%\Microsoft Deployment Toolkit 2013 Update 1\." set INSTALLDIR=%Components%\Microsoft Deployment Toolkit 2013 Update 1
	if exist "%Components%\MDT 2013\." set INSTALLDIR=%Components%\MDT 2013
	if exist "%Components%\MDT 2013 Update 1\." set INSTALLDIR=%Components%\MDT 2013 Update 1
	if /I "%INSTALLDIR%" == "" set INSTALLDIR=Not Found
echo ===============================================================================
	echo Checking MDT DeployRoot
	if /I "%DEPLOYROOT%" == "" set DEPLOYROOT=%INSTALLDIR%\Templates\Distribution
	if /I "%DEPLOYROOT%" == "\Templates\Distribution" set DEPLOYROOT=
	if /I "%DEPLOYROOT%" == "" set DEPLOYROOT=Not Found
	if /I "%INSTALLDIR%" == "Not Found" set DEPLOYROOT=Not Found
echo ===============================================================================
	echo Checking AIK Integration for WinPE 3
	echo 	Valid Locations:
	echo 	C:\Program Files\Windows AIK
	echo 	%Components%\Windows AIK

::	Set the Directory for AIK (WinPE 3)
	if exist "C:\Program Files\Windows AIK\Tools\PETools\copype.cmd" set AIK=C:\Program Files\Windows AIK
	
::	Or if AIK is relocated to Components then we will use that copy
	if exist "%Components%\Windows AIK\readme.htm" set AIK=%Components%\Windows AIK
	
	if /I "%AIK%" == "" set AIK=Not Found
echo ===============================================================================
	echo Checking ADK Integration for WinPE 5
	echo 	Valid Locations:
	echo 	C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit
	echo 	C:\Program Files (x86)\Windows Kits\8.1\Assessment and Deployment Kit
	echo 	%Components%\Windows Kits\8.1\Assessment and Deployment Kit
	
::	Set the Directory for ADK 5 (WinPE 5)
	if exist "C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\copype.cmd" set ADK5=C:\Program Files\Windows Kits\8.1
	if exist "C:\Program Files (x86)\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\copype.cmd" set ADK5=C:\Program Files (x86)\Windows Kits\8.1
	
::	Or if ADK 5 is relocated to Components then we will use that copy
	if exist "%Components%\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\copype.cmd" set ADK5=%Components%\Windows Kits\8.1
	
	if /I "%ADK5%" == "" set ADK5=Not Found
echo ===============================================================================
	echo Checking ADK Integration for WinPE 10
	echo 	Valid Locations:
	echo 	C:\Program Files\Windows Kits\10\Assessment and Deployment Kit
	echo 	C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit
	echo 	%Components%\Windows Kits\10\Assessment and Deployment Kit
	
::	Set the Directory for ADK 10 (WinPE 10)
	if exist "C:\Program Files\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\copype.cmd" set ADK10=C:\Program Files\Windows Kits\10
	if exist "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\copype.cmd" set ADK10=C:\Program Files (x86)\Windows Kits\10
	
::	Or if ADK 10 is relocated to Components then we will use that copy
	if exist "%Components%\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\copype.cmd" set ADK10=%Components%\Windows Kits\10
	if /I "%ADK10%" == "" set ADK10=Not Found
echo ===============================================================================
	if /I "%PLATFORM%" == "x86" set PLATFORMARCHITECTURE=x86
	if /I "%PLATFORM%" == "x64" set PLATFORMARCHITECTURE=amd64
	
	if %WinPEVersion% EQU 3 set WindowsKit=%AIK%
	if %WinPEVersion% EQU 5 set WindowsKit=%ADK5%
	if %WinPEVersion% EQU 10 set WindowsKit=%ADK10%
echo ===============================================================================
::	Check for DaRT

echo ===============================================================================
::	Copy Local Support
	if NOT "%AIK%" == "Not Found" robocopy "%AIK%\Tools\amd64" "%BUILDS%\ISO\Support\WinPE3x64" *.exe /njh /njs /ndl /nfl /r:0 /w:0 /xf imagex.exe intlcfg.exe w*.exe
	if NOT "%AIK%" == "Not Found" robocopy "%AIK%\Tools\x86" "%BUILDS%\ISO\Support\WinPE3x86" *.exe /njh /njs /ndl /nfl /r:0 /w:0 /xf imagex.exe intlcfg.exe w*.exe
	if NOT "%AIK%" == "Not Found" robocopy "%AIK%\Tools\PETools\amd64\boot" "%BUILDS%\ISO\Support\WinPE3x64" *.* /njh /njs /ndl /nfl /r:0 /w:0 /xf bcd boot*.*
	if NOT "%AIK%" == "Not Found" robocopy "%AIK%\Tools\PETools\x86\boot" "%BUILDS%\ISO\Support\WinPE3x86" *.* /njh /njs /ndl /nfl /r:0 /w:0 /xf bcd boot*.*
	
	if NOT "%ADK5%" == "Not Found" robocopy "%ADK5%\Assessment and Deployment Kit\Deployment Tools\amd64\BCDBoot" "%BUILDS%\ISO\Support\WinPE5x64" *.* /njh /njs /ndl /nfl /r:0 /w:0
	if NOT "%ADK5%" == "Not Found" robocopy "%ADK5%\Assessment and Deployment Kit\Deployment Tools\x86\BCDBoot" "%BUILDS%\ISO\Support\WinPE5x86" *.* /njh /njs /ndl /nfl /r:0 /w:0
	if NOT "%ADK5%" == "Not Found" robocopy "%ADK5%\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg" "%BUILDS%\ISO\Support\WinPE5x64" *.* /njh /njs /ndl /nfl /r:0 /w:0
	if NOT "%ADK5%" == "Not Found" robocopy "%ADK5%\Assessment and Deployment Kit\Deployment Tools\x86\Oscdimg" "%BUILDS%\ISO\Support\WinPE5x86" *.* /njh /njs /ndl /nfl /r:0 /w:0
	
	if NOT "%ADK10%" == "Not Found" robocopy "%ADK10%\Assessment and Deployment Kit\Deployment Tools\amd64\BCDBoot" "%BUILDS%\ISO\Support\WinPE10x64" *.* /njh /njs /ndl /nfl /r:0 /w:0
	if NOT "%ADK10%" == "Not Found" robocopy "%ADK10%\Assessment and Deployment Kit\Deployment Tools\x86\BCDBoot" "%BUILDS%\ISO\Support\WinPE10x86" *.* /njh /njs /ndl /nfl /r:0 /w:0
	if NOT "%ADK10%" == "Not Found" robocopy "%ADK10%\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg" "%BUILDS%\ISO\Support\WinPE10x64" *.* /njh /njs /ndl /nfl /r:0 /w:0
	if NOT "%ADK10%" == "Not Found" robocopy "%ADK10%\Assessment and Deployment Kit\Deployment Tools\x86\Oscdimg" "%BUILDS%\ISO\Support\WinPE10x86" *.* /njh /njs /ndl /nfl /r:0 /w:0
	
::	Set location of oscdimg
	if %WinPEVersion% EQU 3 set OSCDIMG=%WindowsKit%\Tools\%PROCESSOR_ARCHITECTURE%\oscdimg.exe
	if %WinPEVersion% NEQ 3 set OSCDIMG=%WindowsKit%\Assessment and Deployment Kit\Deployment Tools\%PROCESSOR_ARCHITECTURE%\Oscdimg\oscdimg.exe
	if exist "%BUILDS%\ISO\Support\WinPE%WinPEVersion%%PLATFORM%\oscdimg.exe" set OSCDIMG=%BUILDS%\ISO\Support\WinPE%WinPEVersion%%PLATFORM%\oscdimg.exe
	if /I "%WindowsKit%" == "Not Found" set OSCDIMG=Not Found
	
::	Set the location of etfsboot.com
	if %WinPEVersion% EQU 3 set ETFSBOOT=%WindowsKit%\Tools\PETools\%PROCESSOR_ARCHITECTURE%\boot\etfsboot.com
	if %WinPEVersion% NEQ 3 set ETFSBOOT=%WindowsKit%\Assessment and Deployment Kit\Deployment Tools\%PROCESSOR_ARCHITECTURE%\Oscdimg\etfsboot.com
	if exist "%BUILDS%\ISO\Support\WinPE%WinPEVersion%%PLATFORM%\etfsboot.com" set ETFSBOOT=%BUILDS%\ISO\Support\WinPE%WinPEVersion%%PLATFORM%\etfsboot.com
	if /I "%WindowsKit%" == "Not Found" set ETFSBOOT=Not Found
	
::	Set the location of efisys.bin
	if %WinPEVersion% EQU 3 set EFISYS=%WindowsKit%\Tools\PETools\%PROCESSOR_ARCHITECTURE%\boot\efisys.bin
	if %WinPEVersion% NEQ 3 set EFISYS=%WindowsKit%\Assessment and Deployment Kit\Deployment Tools\%PROCESSOR_ARCHITECTURE%\Oscdimg\efisys.bin
	if exist "%BUILDS%\ISO\Support\WinPE%WinPEVersion%%PLATFORM%\efisys.bin" set EFISYS=%BUILDS%\ISO\Support\WinPE%WinPEVersion%%PLATFORM%\efisys.bin
	if /I "%WindowsKit%" == "Not Found" set EFISYS=Not Found
echo ===============================================================================
::	Set the CAB Directory
	if %WinPEVersion% EQU 3 set CABS=%AIK%\Tools\PETools\%PLATFORMARCHITECTURE%\WinPE_FPs
	if %WinPEVersion% EQU 5 set CABS=%ADK5%\Assessment and Deployment Kit\Windows Preinstallation Environment\%PLATFORMARCHITECTURE%\WinPE_OCs
	if %WinPEVersion% EQU 10 set CABS=%ADK10%\Assessment and Deployment Kit\Windows Preinstallation Environment\%PLATFORMARCHITECTURE%\WinPE_OCs
	if /I "%WindowsKit%" == "Not Found" set CABS=Not Found
	
::	Set location of DISM
	if %WinPEVersion% EQU 3 set DISM=%AIK%\Tools\%PROCESSOR_ARCHITECTURE%\Servicing\dism.exe
	if %WinPEVersion% EQU 5 set DISM=%ADK5%\Assessment and Deployment Kit\Deployment Tools\%PROCESSOR_ARCHITECTURE%\DISM\dism.exe
	if %WinPEVersion% EQU 10 set DISM=%ADK10%\Assessment and Deployment Kit\Deployment Tools\%PROCESSOR_ARCHITECTURE%\DISM\dism.exe
	if /I "%WindowsKit%" == "Not Found" set DISM=Not Found
	
::	Set location of ImageX
	if %WinPEVersion% EQU 3 set IMAGEX=%AIK%\Tools\%PROCESSOR_ARCHITECTURE%\imagex.exe
	if %WinPEVersion% EQU 5 set IMAGEX=%ADK5%\Assessment and Deployment Kit\Deployment Tools\%PROCESSOR_ARCHITECTURE%\DISM\imagex.exe
	if %WinPEVersion% EQU 10 set IMAGEX=%ADK10%\Assessment and Deployment Kit\Deployment Tools\%PROCESSOR_ARCHITECTURE%\DISM\imagex.exe
	if /I "%WindowsKit%" == "Not Found" set IMAGEX=Not Found
echo ===============================================================================
	if %WinPEVersion% EQU 3 set MyWim=%WindowsKit%\Tools\PETools\%PLATFORMARCHITECTURE%\winpe.wim
	if %WinPEVersion% NEQ 3 set MyWim=%WindowsKit%\Assessment and Deployment Kit\Windows Preinstallation Environment\%PLATFORMARCHITECTURE%\en-us\winpe.wim
	set WinPEType=WinPE
	
	if exist "%Components%\WinPE %WinPEVersion% %PLATFORM%\Boot.wim" set MyWim=%Components%\WinPE %WinPEVersion% %PLATFORM%\Boot.wim
	if exist "%Components%\WinPE %WinPEVersion% %PLATFORM%\Boot.wim" set WinPEType=Boot
	
	if exist "%Components%\WinPE %WinPEVersion% %PLATFORM%\WinRE.wim" set MyWim=%Components%\WinPE %WinPEVersion% %PLATFORM%\WinRE.wim
	if exist "%Components%\WinPE %WinPEVersion% %PLATFORM%\WinRE.wim" set WinPEType=WinRE
	
	if NOT exist "%MyWim%" set MyWim=
	if NOT exist "%MyWim%" set WinPEType=
echo ===============================================================================
	set CONTENT=%Temp%\%WinPEType%
	
	set WIMTemp=%BUILDS%\TEMP WinPE %WinPEVersion% %PLATFORM% %WinPEType%.wim
	set WIMBasePE=%BUILDS%\WIMBasePE\WinPE %WinPEVersion% %PLATFORM% %WinPEType%.wim
	set WIMWinPE=%BUILDS%\WIMWinPE\WinPE %WinPEVersion% %PLATFORM% %WinPEType%.wim
	set WIMName=WinPE %WinPEVersion% %PLATFORM%
echo ===============================================================================
	if /I "%WinPEType%" == "Boot" set WinPE-Scripting=Already Installed
	if /I "%WinPEType%" == "Boot" set WinPE-WMI=Already Installed
	if /I "%WinPEType%" == "Boot" set WinPE-SecureStartup=Already Installed
	if /I "%WinPEType%" == "Boot" set WinPE-WDS-Tools=Already Installed
	
	if /I "%WinPEType%" == "WinRE" set WinPE-Scripting=Already Installed
	if /I "%WinPEType%" == "WinRE" set WinPE-WMI=Already Installed
	if /I "%WinPEType%" == "WinRE" set WinPE-SecureStartup=Already Installed
	if /I "%WinPEType%" == "WinRE" set WinPE-WDS-Tools=Already Installed

	if NOT "%MyLog%" == "SuperISO" set MyLog=%BUILDS%\WinPE %WinPEVersion% %PLATFORM% %WinPEType% Log.txt
	if "%MyLog%" == "SuperISO" set MyLog=%BUILDS%\SuperISO Log.txt

	echo Writing to "%MyLog%"
	echo Version Information:>> "%MyLog%"
	echo 	MakePE Version:  	%MakePEVersion%> "%MyLog%"
	echo ===============================================================================>> "%MyLog%"
	echo MakePE Directory Information:>> "%MyLog%"
	echo 	MakePE Directory:  	%MakePE%>> "%MyLog%"
	echo 	MakePE Builds:  	%BUILDS%>> "%MyLog%"
	echo 	MakePE Components:  	%Components%>> "%MyLog%"
	echo 	MakePE Optional:  	%OPTIONAL%>> "%MyLog%"
	echo 	MakePE Scripts:  	%SCRIPTS%>> "%MyLog%"
	echo ===============================================================================>> "%MyLog%"
	echo Microsoft Deployment Toolkit Installation Status:>> "%MyLog%"
	echo 	MDT Install Directory:  %INSTALLDIR%>> "%MyLog%"
		if /I "%INSTALLDIR%" == "Not Found" echo 	Install-MDT will be set to False because the MDT Install Directory was not found>> "%MyLog%"
		if /I "%INSTALLDIR%" == "Not Found" set Install-MDT=No
	echo 	MDT Deployment Share:  	%DEPLOYROOT%>> "%MyLog%"
		if /I "%DEPLOYROOT%" == "Not Found" echo 	Install-MDT will be set to False because the MDT Deploy Root was not found>> "%MyLog%"
		if /I "%DEPLOYROOT%" == "Not Found" set Install-MDT=No
	echo ===============================================================================>> "%MyLog%"
	echo AIK and ADK Installation Status:>> "%MyLog%"
	echo 	Windows 7 AIK:		%AIK%>> "%MyLog%"
	echo 	Windows 8.1 ADK:	%ADK5%>> "%MyLog%"
	echo 	Windows 10 ADK:		%ADK10%>> "%MyLog%"
	echo ===============================================================================>> "%MyLog%"
	echo WinPE Source Status:>> "%MyLog%"
	echo 	WinPE Version:  	%WinPEVersion% >> "%MyLog%"
	echo 	WinPE Platform:  	%PLATFORM%>> "%MyLog%"
	echo 	WinPE Architecture:  	%PLATFORMARCHITECTURE%>> "%MyLog%"
	echo 	WinPE Language:  	%MyLang%>> "%MyLog%"
	echo 	WinPE WIM:   		%MyWim%>> "%MyLog%"
	echo 	WinPE Type:  		%WinPEType%>> "%MyLog%"
	echo ===============================================================================>> "%MyLog%"
	echo WinPE Mount and Build Status:>> "%MyLog%"
	echo 	WIM Mount Directory:  	%CONTENT%>> "%MyLog%"
	echo 	WIM Temp:   		%WIMTemp%>> "%MyLog%"
	echo 	WIM BasePE:   		%WIMBasePE%>> "%MyLog%"
	echo 	WIM WinPE:   		%WIMWinPE%>> "%MyLog%"
	echo ===============================================================================>> "%MyLog%"
	echo ISO Status:>> "%MyLog%"
	set ISOSupport=%BUILDS%\ISO\Support
	echo 	ISO Supporting Files:				%ISOSupport%>> "%MyLog%"
	
	set ISOBuild=%BUILDS%\ISO\WinPE%WinPEVersion%%PLATFORM%
	echo 	ISO Source Directory:				%ISOBuild%>> "%MyLog%"
	
	set ISOSourceImageFile=%WIMWinPE%
	echo 	ISO Source WIM:					%ISOSourceImageFile%>> "%MyLog%"
	
	set ISODestinationImageFile=%ISOBuild%\Sources\Boot.wim
	echo 	ISO Destination WIM:				%ISODestinationImageFile%>> "%MyLog%"
	
	if "%ISODestination%" == "" set ISODestination=%BUILDS%\WinPE %WinPEVersion% %PLATFORM% %WinPEType%.iso
	echo 	ISO Destination (ISODestination):		%ISODestination%>> "%MyLog%"
	
	if "%ISOLabel%" == "" set ISOLabel=WinPE %WinPEVersion% %PLATFORM%
	echo 	ISO Label (ISOLabel):				%ISOLabel%>> "%MyLog%"
	
	set SuperISOBuild=%BUILDS%\ISO\SuperISO
	echo 	SuperISO Source Directory:			%SuperISOBuild%>> "%MyLog%"
	
	if "%SuperISODestination%" == "" set SuperISODestination=%BUILDS%\WinPE SuperISO.iso
	echo 	SuperISO Destination (SuperISODestination):	%SuperISODestination%>> "%MyLog%"
	
	if "%SuperISOLabel%" == "" set SuperISOLabel=WinPE SuperISO
	echo 	SuperISO Label (SuperISOLabel):			%SuperISOLabel%>> "%MyLog%"
	echo ===============================================================================>> "%MyLog%"
	echo Windows Kit Status:>> "%MyLog%"
	echo 	Windows Kit:  		%WindowsKit%>> "%MyLog%"
	echo 	CABS:  			%CABS%>> "%MyLog%"
	echo 	dism.exe:  		%DISM%>> "%MyLog%"
	echo 	imagex.exe:  		%IMAGEX%>> "%MyLog%"
	echo 	oscdimg.exe:  		%OSCDIMG%>> "%MyLog%"
	echo 	etfsboot.com:  		%ETFSBOOT%>> "%MyLog%"
	echo 	efisys.bin:  		%EFISYS%>> "%MyLog%"
	echo ===============================================================================>> "%MyLog%"
	echo MakePE Options:>> "%MyLog%"
	echo 	DoPause:		%DoPause%>> "%MyLog%"
	echo 	ScratchSpace:		%ScratchSpace%>> "%MyLog%"
	echo 	TimeZone:		%TimeZone%>> "%MyLog%"
	echo 	Install-DaRT:		%Install-DaRT%>> "%MyLog%"
	echo 	Install-MDT:		%Install-MDT%>> "%MyLog%"
	echo 	Install-Drivers:	%Install-Drivers%>> "%MyLog%"
	echo 	Add-ExtraFiles:		%Add-ExtraFiles%>> "%MyLog%"
	echo 	Add-ExtraFilesISO:	%Add-ExtraFilesISO%>> "%MyLog%"
	echo ===============================================================================>> "%MyLog%"
	echo Package Options:>> "%MyLog%"
	echo 	Install-Packages:	%Install-Packages%>> "%MyLog%"
	if /I "%Install-Packages%" == "Minimal" set WinPE-Dot3Svc=No
	if /I "%Install-Packages%" == "Minimal" set WinPE-PPPoE=No
	if /I "%Install-Packages%" == "Minimal" set WinPE-RNDIS=No
	if /I "%Install-Packages%" == "Minimal" set WinPE-WDS-Tools=No
	if /I "%Install-Packages%" == "Minimal" set WinPE-NetFx=No
	if /I "%Install-Packages%" == "Minimal" set WinPE-PowerShell=No
	if /I "%Install-Packages%" == "Minimal" set WinPE-DismCmdlets=No
	if /I "%Install-Packages%" == "Minimal" set WinPE-SecureBootCmdlets=No
	if /I "%Install-Packages%" == "Minimal" set WinPE-StorageWMI=No
	if /I "%Install-Packages%" == "Minimal" set WinPE-EnhancedStorage=No
	if /I "%Install-Packages%" == "Minimal" set WinPE-Rejuv=No
	if /I "%Install-Packages%" == "Minimal" set WinPE-SRT=No
	if /I "%Install-Packages%" == "Minimal" set WinPE-WinReCfg=No
	echo 	WinPE-HTA:		%WinPE-HTA%>> "%MyLog%"
	echo 	WinPE-Scripting:	%WinPE-Scripting%>> "%MyLog%"
	echo 	WinPE-WMI:		%WinPE-WMI%>> "%MyLog%"
	echo 	WinPE-SecureStartup:	%WinPE-SecureStartup%>> "%MyLog%"
	echo 	WinPE-FMAPI:		%WinPE-FMAPI%>> "%MyLog%"
	echo 	WinPE-MDAC:		%WinPE-MDAC%>> "%MyLog%"
	echo 	WinPE-Dot3Svc:		%WinPE-Dot3Svc%>> "%MyLog%"
	echo 	WinPE-PPPoE:		%WinPE-PPPoE%>> "%MyLog%"
	echo 	WinPE-RNDIS:		%WinPE-RNDIS%>> "%MyLog%"
	echo 	WinPE-WDS-Tools:	%WinPE-WDS-Tools%>> "%MyLog%"
	echo 	WinPE-NetFx:		%WinPE-NetFx%>> "%MyLog%"
	echo 	WinPE-PowerShell:	%WinPE-PowerShell%>> "%MyLog%"
	echo 	WinPE-DismCmdlets:	%WinPE-DismCmdlets%>> "%MyLog%"
	echo 	WinPE-SecureBootCmdlets:%WinPE-SecureBootCmdlets%>> "%MyLog%"
	echo 	WinPE-StorageWMI:	%WinPE-StorageWMI%>> "%MyLog%"
	echo 	WinPE-EnhancedStorage:	%WinPE-EnhancedStorage%>> "%MyLog%"
	echo 	WinPE-Rejuv:		%WinPE-Rejuv%>> "%MyLog%"
	echo 	WinPE-SRT:		%WinPE-SRT%>> "%MyLog%"
	echo 	WinPE-WinReCfg:		%WinPE-WinReCfg%>> "%MyLog%"
	echo ===============================================================================>> "%MyLog%"
	echo WARNINGS:>> "%MyLog%"
	
	REM	echo ===============================================================================
	if /I "%AIK%" == "Not Found" (
	echo ===============================================================================
	echo Microsoft AIK for Windows 7 was not located
	echo You will not be able to service WinPE 3
	echo Microsoft AIK for Windows 7 was not located.  You will not be able to service WinPE 3 >> "%MyLog%"
	echo ===============================================================================
	if %WinPEVersion% EQU 3 set StopScript=Yes
	)
	
	REM	echo ===============================================================================
	if /I "%ADK5%" == "Not Found" (
	echo ===============================================================================
	echo Microsoft ADK for Windows 8.1 was not located
	echo You will not be able to service WinPE 5
	echo Microsoft ADK for Windows 8.1 was not located.  You will not be able to service WinPE 5 >> "%MyLog%"
	echo ===============================================================================
	if %WinPEVersion% EQU 5 set StopScript=Yes
	)
	
	REM	echo ===============================================================================
	if /I "%ADK10%" == "Not Found" (
	echo ===============================================================================
	echo Microsoft ADK for Windows 10 was not located
	echo You will not be able to service WinPE 10
	echo Microsoft ADK for Windows 10 was not located.  You will not be able to service WinPE 10 >> "%MyLog%"
	echo ===============================================================================
	if %WinPEVersion% EQU 10 set StopScript=Yes
	)
	
	REM	echo ===============================================================================
	if /I "%WinPEVersion%" == "" (
	echo ===============================================================================
	echo WinPE version was not set properly
	echo WinPE version was not set properly >> "%MyLog%"
	echo ===============================================================================
	set StopScript=Yes
	)
	
	REM	echo ===============================================================================
	if /I "%MyLang%" == "" (
	echo ===============================================================================
	echo MyLang was not set with a Language
	echo MyLang was not set with a Language >> "%MyLog%"
	echo ===============================================================================
	set StopScript=Yes
	)
	
	REM	echo ===============================================================================
	if /I "%MyWim%" == "" (
	echo ===============================================================================
	echo Could not determine a WIM file to use
	echo Could not determine a WIM file to use >> "%MyLog%"
	echo ===============================================================================
	set StopScript=Yes
	)
	
	REM	echo ===============================================================================
	if /I "%PLATFORM%" == "" (
	echo ===============================================================================
	echo Platform for WinPE was not set properly
	echo Platform for WinPE was not set properly >> "%MyLog%"
	echo ===============================================================================
	set StopScript=Yes
	)

	REM	echo ===============================================================================
	::	Check for Elevation and give the Warning!!!!!!!
	::	http://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights/
	net session >nul 2>&1
	if %errorLevel% == 0 (
	echo ===============================================================================
	echo SCRIPT IS RUNNING ADMINISTRATOR ELEVATED AND WILL EXECUTE
	echo SCRIPT IS RUNNING ADMINISTRATOR ELEVATED AND WILL EXECUTE >> "%MyLog%"
	echo ===============================================================================
	) else (
	echo ===============================================================================
	echo YOU MUST RUN AS ADMINISTRATOR ELEVATED TO EXECUTE THIS SCRIPT
	echo YOU MUST RUN AS ADMINISTRATOR ELEVATED TO EXECUTE THIS SCRIPT >> "%MyLog%"
	echo ===============================================================================
	)
	
	REM	echo ===============================================================================
	echo ===============================================================================>> "%MyLog%"
	if /I "%DisplayLog%" == "Yes" start notepad.exe "%MyLog%"
	if /I "%StopScript%" == "Yes" goto :StopScript
	if /I "%DoPause%" == "Yes" pause
	goto :eof
	
:StopScript
	echo MakePE did not complete properly
	pause
	exit
