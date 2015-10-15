:Customize-BasePE
	echo.
	echo.
	echo.
	echo.
	echo.
	echo ===============================================================================
	echo Section Customize-BasePE ======================================================
	echo ===============================================================================
	if /I "%DoPause%" == "Yes" pause
	
	::Copy Wallpaper to System32
	set SRC=%OPTIONAL%\Wallpaper
	if NOT exist "%SRC%\." md "%SRC%"

	if exist "%SRC%\setup.bmp" ren "%CONTENT%\Windows\System32\setup.bmp" oldsetup.bmp
	if exist "%SRC%\winpe.bmp" ren "%CONTENT%\Windows\System32\winpe.bmp" oldwinpe.bmp
	if exist "%SRC%\winpe.jpg" ren "%CONTENT%\Windows\System32\winpe.jpg" oldwinpe.jpg
	if exist "%SRC%\winre.jpg" ren "%CONTENT%\Windows\System32\winre.jpg" oldwinre.jpg
	robocopy "%SRC%" "%CONTENT%\Windows\System32" *.* /e /ndl /nfl /xj /r:0 /w:0

	::	reg load HKLM\WinPE "%CONTENT%\Windows\System32\config\SOFTWARE"
	::	reg add "HKLM\WinPE\Microsoft\Windows NT\CurrentVersion\WinPE" /v CustomBackground /t REG_EXPAND_SZ /d "x:\windows\system32\wallpaper.bmp" /f
	::	reg unload HKLM\WinPE
	
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
	set CMDFile=%MakePE%\ScriptsRW\Customize-BasePE.cmd
	if NOT exist "%CMDFile%" echo echo Executing %CMDFile%> %CMDFile%
	if exist "%CMDFile%" call "%CMDFile%"
	echo ===============================================================================
	echo Waiting 5 Seconds for Review
	ping -n 5 127.0.0.1>nul
	goto :eof