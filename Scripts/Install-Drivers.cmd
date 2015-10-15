:Install-Drivers
	echo.
	echo.
	echo.
	echo.
	echo.
	echo ===============================================================================
	echo Section Install-Drivers =======================================================
	echo ===============================================================================
	if /I "%DoPause%" == "Yes" pause
	echo Applying Drivers from 
	"%dism%" /Image:"%CONTENT%" /Add-Driver /Driver:"%OPTIONAL%\Drivers\WinPE %WinPEVersion% %PLATFORM%" /Recurse /ForceUnsigned
	echo ===============================================================================
	set CMDFile=%MakePE%\ScriptsRW\Install-Drivers.cmd
	if NOT exist "%CMDFile%" echo echo Executing %CMDFile%> %CMDFile%
	if exist "%CMDFile%" call "%CMDFile%"
	echo ===============================================================================
	echo Waiting 5 Seconds for Review
	ping -n 5 127.0.0.1>nul
	goto :eof