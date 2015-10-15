:Add-ExtraFilesISO
	echo.
	echo.
	echo.
	echo.
	echo.
	echo ===============================================================================
	echo Section Add-ExtraFilesISO =====================================================
	echo ===============================================================================
	if /I "%DoPause%" == "Yes" pause

	::Create the ExtraFilesISO directory if it doesn't exist already
	if NOT exist "%OPTIONAL%\ExtraFilesISO\." md "%OPTIONAL%\ExtraFilesISO"
	
	::Extra Files for All WinPE Configurations
	set SRC=%OPTIONAL%\ExtraFilesISO\All
	if NOT exist "%SRC%\." md "%SRC%"
	robocopy "%SRC%" "%ISOBuildTemp%" *.* /e /ndl /nfl /xj /r:0 /w:0
	
	::Extra Files for All WinPE %PLATFORM% Configurations
	set SRC=%OPTIONAL%\ExtraFilesISO\All %PLATFORM%
	if NOT exist "%SRC%\." md "%SRC%"
	robocopy "%SRC%" "%ISOBuildTemp%" *.* /e /ndl /nfl /xj /r:0 /w:0
	
	::Extra Files for All WinPE %WinPEVersion% Configurations
	set SRC=%OPTIONAL%\ExtraFilesISO\WinPE %WinPEVersion%
	if NOT exist "%SRC%\." md "%SRC%"
	robocopy "%SRC%" "%ISOBuildTemp%" *.* /e /ndl /nfl /xj /r:0 /w:0
	
	::Extra Files for WinPE %WinPEVersion% %PLATFORM% Configurations
	set SRC=%OPTIONAL%\ExtraFilesISO\WinPE %WinPEVersion% %PLATFORM%
	if NOT exist "%SRC%\." md "%SRC%"
	robocopy "%SRC%" "%ISOBuildTemp%" *.* /e /ndl /nfl /xj /r:0 /w:0
	echo ===============================================================================
	set CMDFile=%MakePE%\ScriptsRW\Add-ExtraFilesISO.cmd
	if NOT exist "%CMDFile%" echo echo Executing %CMDFile%> %CMDFile%
	if exist "%CMDFile%" call "%CMDFile%"
	echo ===============================================================================
	echo Waiting 5 Seconds for Review
	ping -n 5 127.0.0.1>nul
	goto :eof
	
