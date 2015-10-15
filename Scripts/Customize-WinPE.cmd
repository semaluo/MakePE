:Customize-WinPE
	echo.
	echo.
	echo.
	echo.
	echo.
	echo ===============================================================================
	echo Section Customize-WinPE =======================================================
	echo ===============================================================================
	if /I "%DoPause%" == "Yes" pause

	::Copy Wallpaper to System32
	set SRC=%OPTIONAL%\Wallpaper
	if NOT exist "%SRC%\." md "%SRC%"
	robocopy "%SRC%" "%CONTENT%\Windows\System32" *.* /e /ndl /nfl /xj /r:0 /w:0

	echo Creating Reboot.cmd
	echo @echo off > "%CONTENT%\Windows\Reboot.cmd"
	echo start wpeutil reboot >> "%CONTENT%\Windows\Reboot.cmd"
	
	echo Creating Restart.cmd
	echo @echo off > "%CONTENT%\Windows\Restart.cmd"
	echo start wpeutil reboot >> "%CONTENT%\Windows\Restart.cmd"
	
	echo Creating Shutdown.cmd
	echo @echo off > "%CONTENT%\Windows\Shutdown.cmd"
	echo start wpeutil shutdown >> "%CONTENT%\Windows\Shutdown.cmd"

	echo ===============================================================================
	set CMDFile=%MakePE%\ScriptsRW\Customize-WinPE.cmd
	if NOT exist "%CMDFile%" echo echo Executing %CMDFile%> %CMDFile%
	if exist "%CMDFile%" call "%CMDFile%"
	echo ===============================================================================
	goto :eof