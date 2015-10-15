@echo off

::Set MakePE Version
	set MakePEVersion=20151013

::Set MakePE Directory
	for %%A in ("%~dp0..") do @set MakePE=%%~fA

::	Gather Settings (First Run)
	if /I "%MySettings%" == "" goto :MySettings

::	Execute Build BasePE (Second Run)
	call :BasePEBuildSequence
	goto StopScript

:MySettings
	:: This section is only processed once
	echo ===============================================================================
	echo David Segura
	echo.
	echo MakePE %MakePEVersion%
	echo.
	echo Purpose:  To modify Boot WIM's for use in WinRE and WinPE
	echo ===============================================================================

	echo ===============================================================================
	echo Executing Default Settings at %MakePE%\Scripts\MySettings.cmd
	echo ===============================================================================
	if exist "%MakePE%\Scripts\MySettings.cmd" call "%MakePE%\Scripts\MySettings.cmd"

	echo ===============================================================================
	echo Executing User Settings at %MakePE%\ScriptsRW\MySettings.cmd
	echo ===============================================================================
	if NOT exist "%MakePE%\ScriptsRW." md "%MakePE%\ScriptsRW"
	if exist "%MakePE%\ScriptsRW\MySettings.cmd" call "%MakePE%\ScriptsRW\MySettings.cmd"
	if NOT exist "%MakePE%\ScriptsRW\MySettings.cmd" copy "%MakePE%\Scripts\MySettings.cmd" "%MakePE%\ScriptsRW"
	
	::	Mark as Complete
	set MySettings=Yes
	
	::	Stop processing (First Run)
	goto StopScript

:BasePEBuildSequence
	echo ===============================================================================
	echo Starting BasePEBuildSequence
	echo ===============================================================================
	::	Check Validation
		call "%MakePE%\Scripts\MakePE-Validation.cmd"
		
	::	Check for Existing BasePE
		if /I "%RebuildBasePE%" == "Yes" del "%WIMBasePE%" /F /Q
		if exist "%WIMBasePE%" goto WinPEBuildSequence
		
	::	WIM Cleanup
		call :WIM-Cleanup
	
	::	WIM Mount
		call :WIM-Mount
		
	::	WinPE Cleanup
		call :WinPE-Cleanup
	
	::	Install AIK ADK Packages
		::	set Install-Packages=Yes
		if /I "%Install-Packages%" == "Yes" call "%SCRIPTS%\Install-Packages.cmd"
		if /I "%Install-Packages%" == "Minimal" call "%SCRIPTS%\Install-Packages.cmd"
		
	::	Install Microsoft DaRT
		::	set Install-DaRT=Yes
		if /I "%Install-DaRT%" == "Yes" call "%SCRIPTS%\Install-DaRT.cmd"
		
	::	Customize BasePE
		::	set Customize-BasePE=Yes
		if /I "%Customize-BasePE%" == "Yes" call "%SCRIPTS%\Customize-BasePE.cmd"
		
	::	Commit BasePE
		call :BasePE-Commit
		
		call :WinPEBuildSequence
		
		exit /b
		
:WinPEBuildSequence
	echo ===============================================================================
	echo Starting WinPEBuildSequence
	echo ===============================================================================
		
	::	WIM Cleanup
		call :WIM-Cleanup
		
	::	BasePE Mount
		call :BasePE-Mount
	
	::	WinPE Cleanup
		call :WinPE-Cleanup
	
	::	Install MDT from Templates or DeployRoot
		::	set Install-MDT=Yes
		if /I "%Install-MDT%" == "Yes" call "%SCRIPTS%\Install-MDT.cmd"
	
	::	Install Drivers from %OPTIONAL%\Drivers
		::	set Install-Drivers=Yes
		if /I "%Install-Drivers%" == "Yes" call "%SCRIPTS%\Install-Drivers.cmd"
	
	::	Install Extra Files
		::	set Add-ExtraFiles=Yes
		if /I "%Add-ExtraFiles%" == "Yes" call "%SCRIPTS%\Add-ExtraFiles.cmd"
		
	::	Customize WinPE
		::	set Customize-WinPE=Yes
		if /I "%Customize-WinPE%" == "Yes" call "%SCRIPTS%\Customize-WinPE.cmd"
	
	::	Commit WinPE
		call :WinPE-Commit
		
	::	Build the ISO
		call "%SCRIPTS%\MakePE-BuildISO.cmd"
	
		exit /b


:WIM-Cleanup
	echo.
	echo.
	echo.
	echo.
	echo.
	echo ===============================================================================
	echo Section WIM-Cleanup ===========================================================
	echo ===============================================================================
	echo Unmounting WIM using Command:
	if %WinPEVersion% EQU 3 set sCMD="%imagex%" /Unmount "%CONTENT%"
	if %WinPEVersion% NEQ 3 set sCMD="%dism%" /Unmount-WIM /MountDir:"%CONTENT%" /Discard
	echo %sCMD%
	%sCMD%
	echo ===============================================================================
	echo Performing WIM Cleanup using Command:
	if %WinPEVersion% EQU 3 set sCMD="%imagex%" /Cleanup
	if %WinPEVersion% NEQ 3 set sCMD="%dism%" /Cleanup-Wim
	echo %sCMD%
	%sCMD%
	echo ===============================================================================
	if %WinPEVersion% NEQ 3 echo Cleaning Mount Points using Command:
	if %WinPEVersion% NEQ 3 set sCMD="%dism%" /Cleanup-Mountpoints
	if %WinPEVersion% NEQ 3 echo %sCMD%
	if %WinPEVersion% NEQ 3 %sCMD%
	echo ===============================================================================
	echo Deleting Existing Mount Directory %CONTENT%
	rd "%CONTENT%" /S /Q
	if exist "%WIMTemp%" echo Deleting Existing Temp WinPE WIM at %WIMTemp%
	if exist "%WIMTemp%" del "%WIMTemp%" /F /Q
	echo ===============================================================================
	set CMDFile=%MakePE%\ScriptsRW\WIM-Cleanup.cmd
	if NOT exist "%CMDFile%" echo echo Executing %CMDFile%> %CMDFile%
	if exist "%CMDFile%" call "%CMDFile%"
	echo ===============================================================================
	goto :eof
	
:WIM-Mount
	echo.
	echo.
	echo.
	echo.
	echo.
	echo ===============================================================================
	echo Section WIM-Mount =============================================================
	echo ===============================================================================
	if /I "%DoPause%" == "Yes" pause
	echo ===============================================================================
	echo Creating BUILDS Directory at %BUILDS%
	md "%BUILDS%"
	echo ===============================================================================
	echo Creating Mount Directory at %CONTENT%
	md "%CONTENT%"
	echo ===============================================================================
	echo Deleting Existing WinPE WIM at "%WIMWinPE%"
	if exist "%WIMWinPE%" del "%WIMWinPE%" /f /q
	echo ===============================================================================
	echo Exporting New WIM using Command:
	if %WinPEVersion% EQU 3 set sCMD="%imagex%" /Export /Boot "%MyWim%" 1 "%WIMTemp%" "Microsoft %WIMName%"
	if %WinPEVersion% NEQ 3 set sCMD="%dism%" /Export-Image /Bootable /SourceImageFile:"%MyWim%" /SourceIndex:1 /DestinationImageFile:"%WIMTemp%" /DestinationName:"Microsoft %WIMName%"
	echo %sCMD%
	%sCMD%
	echo ===============================================================================
	echo Mounting WIM using Command:
	::	if %WinPEVersion% EQU 3 set sCMD="%imagex%" /MountRW "%WIMTemp%" 1 "%CONTENT%"
	::	if %WinPEVersion% NEQ 3 set sCMD="%dism%" /Mount-WIM /WimFile:"%WIMTemp%" /Index:1 /MountDir:"%CONTENT%"
	set sCMD="%dism%" /Mount-WIM /WimFile:"%WIMTemp%" /Index:1 /MountDir:"%CONTENT%"
	echo %sCMD%
	%sCMD%
	echo ===============================================================================
	echo Setting TargetPath using Command:
	set sCMD="%dism%" /image:"%CONTENT%" /Set-TargetPath:X:\
	echo %sCMD%
	%sCMD%
	echo ===============================================================================
	echo Setting ScratchSpace using Command:
	set sCMD="%dism%" /image:"%CONTENT%" /Set-ScratchSpace:%ScratchSpace%
	echo %sCMD%
	%sCMD%
	echo ===============================================================================
	echo Setting TimeZone using Command:
	set sCMD="%dism%" /image:"%CONTENT%" /Set-TimeZone:"%TimeZone%"
	echo %sCMD%
	%sCMD%
	echo ===============================================================================
	set CMDFile=%MakePE%\ScriptsRW\WIM-Mount.cmd
	if NOT exist "%CMDFile%" echo echo Executing %CMDFile%> %CMDFile%
	if exist "%CMDFile%" call "%CMDFile%"
	echo ===============================================================================
	goto :eof
	
:WinPE-Cleanup
	echo.
	echo.
	echo.
	echo.
	echo.
	echo ===============================================================================
	echo Section WinPE-Cleanup =========================================================
	echo ===============================================================================
	if /I "%DoPause%" == "Yes" pause
	echo ===============================================================================
	echo Taking Ownership of System Files
	echo ===============================================================================
	set MyFile=%CONTENT%\Windows\System32\winpeshl.ini
	takeown /F "%MyFile%"
	cacls "%MyFile%" /E /G "Everyone":F
	attrib "%MyFile%" -s -h -r
	echo ===============================================================================
	set MyFile=%CONTENT%\Windows\System32\winpe.bmp
	takeown /F "%MyFile%"
	cacls "%MyFile%" /E /G "Everyone":F
	attrib "%MyFile%" -s -h -r
	echo ===============================================================================
	set MyFile=%CONTENT%\Windows\System32\winpe.jpg
	takeown /F "%MyFile%"
	cacls "%MyFile%" /E /G "Everyone":F
	attrib "%MyFile%" -s -h -r
	echo ===============================================================================
	set MyFile=%CONTENT%\Windows\System32\winre.jpg
	takeown /F "%MyFile%"
	cacls "%MyFile%" /E /G "Everyone":F
	attrib "%MyFile%" -s -h -r
	echo ===============================================================================
	set CMDFile=%MakePE%\ScriptsRW\WinPE-Cleanup.cmd
	if NOT exist "%CMDFile%" echo echo Executing %CMDFile%> %CMDFile%
	if exist "%CMDFile%" call "%CMDFile%"
	echo ===============================================================================
	goto :eof

:BasePE-Commit
	echo.
	echo.
	echo.
	echo.
	echo.
	echo ===============================================================================
	echo Section BasePE-Commit =========================================================
	echo ===============================================================================
	echo Opening Windows Explorer %CONTENT%
	if /I "%DoPause%" == "Yes" explorer "%CONTENT%"
	if /I "%DoPause%" == "Yes" pause
	echo ===============================================================================	
	echo Creating BasePE Directory at %BUILDS%\WIMBasePE
	md "%BUILDS%\WIMBasePE"
	echo Creating WinPE Directory at %BUILDS%\WIMWinPE
	md "%BUILDS%\WIMWinPE"
	echo ===============================================================================
	echo Dism Component Cleanup
	::	https://technet.microsoft.com/en-us/library/Dn613859.aspx
	if %WinPEVersion% NEQ 3 set sCMD="%dism%" /Image:"%CONTENT%" /Cleanup-Image /StartComponentCleanup /ResetBase
	echo %sCMD%
	%sCMD%
	echo ===============================================================================
	echo Unmounting WIM using Command:
	::	if %WinPEVersion% EQU 3 set sCMD="%imagex%" /Unmount /Commit "%CONTENT%"
	::	if %WinPEVersion% NEQ 3 set sCMD="%dism%" /Unmount-WIM /MountDir:"%CONTENT%" /Commit
	set sCMD="%dism%" /Unmount-WIM /MountDir:"%CONTENT%" /Commit
	echo %sCMD%
	%sCMD%
	echo ===============================================================================
	echo Exporting WIM using Command:
	if %WinPEVersion% EQU 3 set sCMD="%imagex%" /Export "%WIMTemp%" 1 "%WIMBasePE%" "Microsoft %WIMName%"
	if %WinPEVersion% NEQ 3 set sCMD="%dism%" /Export-Image /Bootable /SourceImageFile:"%WIMTemp%" /SourceIndex:1 /DestinationImageFile:"%WIMBasePE%" /DestinationName:"Microsoft %WIMName%"
	echo %sCMD%
	%sCMD%
	echo ===============================================================================
	set CMDFile=%MakePE%\ScriptsRW\BasePE-Commit.cmd
	if NOT exist "%CMDFile%" echo echo Executing %CMDFile%> %CMDFile%
	if exist "%CMDFile%" call "%CMDFile%"
	echo ===============================================================================
	goto :eof

:BasePE-Mount
	echo.
	echo.
	echo.
	echo.
	echo.
	echo ===============================================================================
	echo Section BasePE-Mount ==========================================================
	echo ===============================================================================
	if /I "%DoPause%" == "Yes" pause
	echo Creating Builds Directory at %BUILDS%
	md "%BUILDS%"
	echo ===============================================================================
	echo Creating Mount Directory at %CONTENT%
	md "%CONTENT%"
	echo ===============================================================================
	echo Exporting WIM using Command:
	if %WinPEVersion% EQU 3 set sCMD="%imagex%" /Export "%WIMBasePE%" 1 "%WIMTemp%" "Microsoft %WIMName%"
	if %WinPEVersion% NEQ 3 set sCMD="%dism%" /Export-Image /Bootable /SourceImageFile:"%WIMBasePE%" /SourceIndex:1 /DestinationImageFile:"%WIMTemp%" /DestinationName:"Microsoft %WIMName%"
	echo %sCMD%
	%sCMD%
	echo ===============================================================================
	echo Mounting WIM using Command:
	if %WinPEVersion% EQU 3 set sCMD="%imagex%" /MountRW "%WIMTemp%" 1 "%CONTENT%"
	if %WinPEVersion% NEQ 3 set sCMD="%dism%" /Mount-WIM /WimFile:"%WIMTemp%" /Index:1 /MountDir:"%CONTENT%"
	echo %sCMD%
	%sCMD%
	echo ===============================================================================
	set CMDFile=%MakePE%\ScriptsRW\BasePE-Mount.cmd
	if NOT exist "%CMDFile%" echo echo Executing %CMDFile%> %CMDFile%
	if exist "%CMDFile%" call "%CMDFile%"
	echo ===============================================================================
	goto :eof

:WinPE-Commit
	echo.
	echo.
	echo.
	echo.
	echo.
	echo ===============================================================================
	echo Section WinPE-Commit ==========================================================
	echo ===============================================================================
	echo Opening Windows Explorer %CONTENT%
	if /I "%DoPause%" == "Yes" explorer "%CONTENT%"
	if /I "%DoPause%" == "Yes" pause
	echo ===============================================================================		

	echo ===============================================================================
	echo Unmounting WIM
	if %WinPEVersion% EQU 3 "%imagex%" /Unmount /Commit "%CONTENT%"
	if %WinPEVersion% NEQ 3 "%dism%" /Unmount-WIM /MountDir:"%CONTENT%" /Commit
	echo ===============================================================================
	echo Deleting Existing %WIMWinPE%
	del "%WIMWinPE%" /F /Q
	echo ===============================================================================
	echo Compressing WIM
	if %WinPEVersion% EQU 3 "%imagex%" /Export "%WIMTemp%" 1 "%WIMWinPE%" "Microsoft %WIMName%"
	if %WinPEVersion% NEQ 3 "%dism%" /Export-Image /Bootable /SourceImageFile:"%WIMTemp%" /SourceIndex:1 /DestinationImageFile:"%WIMWinPE%" /DestinationName:"Microsoft %WIMName%"
	del "%WIMTemp%" /F /Q
	echo ===============================================================================
	set CMDFile=%MakePE%\ScriptsRW\WinPE-Commit.cmd
	if NOT exist "%CMDFile%" echo echo Executing %CMDFile%> %CMDFile%
	if exist "%CMDFile%" call "%CMDFile%"
	echo ===============================================================================
	goto :eof

:TheEnd
	echo.
	echo.
	echo.
	echo.
	echo.
	echo ===============================================================================
	echo MakePE.cmd Script is Complete ================================================
	echo ===============================================================================
	set CMDFile=%MakePE%\ScriptsRW\TheEnd.cmd
	if NOT exist "%CMDFile%" echo echo Executing %CMDFile%> %CMDFile%
	if exist "%CMDFile%" call "%CMDFile%"
	echo ===============================================================================
	if /I "%DoPause%" == "Yes" pause
	exit /b
	
:StopScript
	echo.
	echo.
	echo.
	echo.
	echo.
	echo ===============================================================================
	echo Script Processing has Stopped =================================================
	echo ===============================================================================
	exit /b
