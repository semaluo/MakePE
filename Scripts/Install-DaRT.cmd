:Install-DaRT
	echo.
	echo.
	echo.
	echo.
	echo.
	echo ===============================================================================
	echo Section Install-DaRT ==========================================================
	echo ===============================================================================
	if /I "%DoPause%" == "Yes" pause
	expand.exe "%Components%\DaRT\WinPE %WinPEVersion%\Tools%PLATFORM%.cab" -F:*.* "%CONTENT%"

	::	DaRT Tools for WinPE 3 are not extracted properly, so we have to do additional steps
	if %WinPEVersion% EQU 3 robocopy "%CONTENT%\mount" "%CONTENT%" *.* /e /ndl /nfl /xj /z
	if %WinPEVersion% EQU 3 rd "%CONTENT%\mount" /S /Q
	echo ===============================================================================
	echo Applying DaRT Config from MDT
	if %WinPEVersion% EQU 3 copy "%INSTALLDIR%\Templates\DaRTConfig.dat" "%CONTENT%\Windows\System32\DaRTConfig.dat" /Y
	if %WinPEVersion% EQU 5 copy "%INSTALLDIR%\Templates\DaRTConfig8.dat" "%CONTENT%\Windows\System32\DaRTConfig.dat" /Y
	if %WinPEVersion% EQU 10 copy "%INSTALLDIR%\Templates\DaRTConfig8.dat" "%CONTENT%\Windows\System32\DaRTConfig.dat" /Y
	echo.
	echo Applying DaRT Config from MDT %Components%\DaRT
	if %WinPEVersion% EQU 3 copy "%Components%\DaRT\DaRTConfig.dat" "%CONTENT%\Windows\System32\DaRTConfig.dat" /Y
	if %WinPEVersion% EQU 5 copy "%Components%\DaRT\DaRTConfig8.dat" "%CONTENT%\Windows\System32\DaRTConfig.dat" /Y	
	if %WinPEVersion% EQU 10 copy "%Components%\DaRT\DaRTConfig8.dat" "%CONTENT%\Windows\System32\DaRTConfig.dat" /Y
	echo ===============================================================================
	set CMDFile=%MakePE%\ScriptsRW\Install-DaRT.cmd
	if NOT exist "%CMDFile%" echo echo Executing %CMDFile%> %CMDFile%
	if exist "%CMDFile%" call "%CMDFile%"
	echo ===============================================================================
	echo Waiting 5 Seconds for Review
	ping -n 5 127.0.0.1>nul
	goto :eof