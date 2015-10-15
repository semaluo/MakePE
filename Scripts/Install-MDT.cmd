:Install-MDT
	echo.
	echo.
	echo.
	echo.
	echo.
	echo ===============================================================================
	echo Section Install-MDT ===========================================================
	echo ===============================================================================
	if /I "%DoPause%" == "Yes" pause
	echo Creating Mount Directories
	md %CONTENT%\Deploy
	md %CONTENT%\Deploy\Scripts
	md %CONTENT%\Deploy\Tools
	md %CONTENT%\Deploy\Tools\%PLATFORM%
	md %CONTENT%\Deploy\Tools\%PLATFORM%\00000409
	echo ===============================================================================
	echo Copying MDT Files from %DEPLOYROOT%
	
	REM <!-- Configuration -->
	copy "%INSTALLDIR%\Templates\Bootstrap.ini" "%CONTENT%\Deploy\Scripts\Bootstrap.ini" /Y
	copy "%DEPLOYROOT%\Control\Bootstrap.ini" "%CONTENT%\Deploy\Scripts\Bootstrap.ini" /Y
	copy "%INSTALLDIR%\Templates\Unattend_PE_%PLATFORM%.xml" "%CONTENT%\Unattend.xml" /Y
	copy "%INSTALLDIR%\Templates\winpeshl.ini" "%CONTENT%\Windows\system32\winpeshl.ini" /Y
	
	REM <!-- Scripts -->
	copy "%DEPLOYROOT%\Scripts\LiteTouch.wsf" "%CONTENT%\Deploy\Scripts\LiteTouch.wsf" /Y
	copy "%DEPLOYROOT%\Scripts\ZTIUtility.vbs" "%CONTENT%\Deploy\Scripts\ZTIUtility.vbs" /Y
	copy "%DEPLOYROOT%\Scripts\ZTIBCDUtility.vbs" "%CONTENT%\Deploy\Scripts\ZTIBCDUtility.vbs" /Y
	copy "%DEPLOYROOT%\Scripts\ZTIDiskUtility.vbs" "%CONTENT%\Deploy\Scripts\ZTIDiskUtility.vbs" /Y
	copy "%DEPLOYROOT%\Scripts\ZTIDataAccess.vbs" "%CONTENT%\Deploy\Scripts\ZTIDataAccess.vbs" /Y
	copy "%DEPLOYROOT%\Scripts\ZTIConfigFile.vbs" "%CONTENT%\Deploy\Scripts\ZTIConfigFile.vbs" /Y
	copy "%DEPLOYROOT%\Scripts\ZTIGather.wsf" "%CONTENT%\Deploy\Scripts\ZTIGather.wsf" /Y
	copy "%DEPLOYROOT%\Scripts\ZTIGather.xml" "%CONTENT%\Deploy\Scripts\ZTIGather.xml" /Y
	copy "%DEPLOYROOT%\Scripts\Wizard.hta" "%CONTENT%\Deploy\Scripts\Wizard.hta" /Y
	copy "%DEPLOYROOT%\Scripts\Credentials_ENU.xml" "%CONTENT%\Deploy\Scripts\Credentials_ENU.xml" /Y
	copy "%DEPLOYROOT%\Scripts\Credentials_scripts.vbs" "%CONTENT%\Deploy\Scripts\Credentials_scripts.vbs" /Y
	copy "%DEPLOYROOT%\Scripts\WizUtility.vbs" "%CONTENT%\Deploy\Scripts\WizUtility.vbs" /Y
	copy "%DEPLOYROOT%\Scripts\Wizard.css" "%CONTENT%\Deploy\Scripts\Wizard.css" /Y
	copy "%DEPLOYROOT%\Scripts\Wizard.ico" "%CONTENT%\Deploy\Scripts\Wizard.ico" /Y
	copy "%DEPLOYROOT%\Scripts\BackButton.jpg" "%CONTENT%\Deploy\Scripts\BackButton.jpg" /Y
	copy "%DEPLOYROOT%\Scripts\plusicon.gif" "%CONTENT%\Deploy\Scripts\plusicon.gif" /Y
	copy "%DEPLOYROOT%\Scripts\minusico.gif" "%CONTENT%\Deploy\Scripts\minusico.gif" /Y
	copy "%DEPLOYROOT%\Scripts\Summary_Definition_ENU.xml" "%CONTENT%\Deploy\Scripts\Summary_Definition_ENU.xml" /Y
	copy "%DEPLOYROOT%\Scripts\Summary_scripts.vbs" "%CONTENT%\Deploy\Scripts\Summary_scripts.vbs" /Y
	copy "%DEPLOYROOT%\Scripts\LTICleanup.wsf" "%CONTENT%\Deploy\Scripts\LTICleanup.wsf" /Y
	copy "%DEPLOYROOT%\Scripts\BDD_Welcome_ENU.xml" "%CONTENT%\Deploy\Scripts\BDD_Welcome_ENU.xml" /Y
	copy "%DEPLOYROOT%\Scripts\WelcomeWiz_Choice.xml" "%CONTENT%\Deploy\Scripts\WelcomeWiz_Choice.xml" /Y
	copy "%DEPLOYROOT%\Scripts\WelcomeWiz_Choice.vbs" "%CONTENT%\Deploy\Scripts\WelcomeWiz_Choice.vbs" /Y
	copy "%DEPLOYROOT%\Scripts\WelcomeWiz_DeployRoot.xml" "%CONTENT%\Deploy\Scripts\WelcomeWiz_DeployRoot.xml" /Y
	copy "%DEPLOYROOT%\Scripts\WelcomeWiz_DeployRoot.vbs" "%CONTENT%\Deploy\Scripts\WelcomeWiz_DeployRoot.vbs" /Y
	copy "%DEPLOYROOT%\Scripts\WelcomeWiz_Initialize.xml" "%CONTENT%\Deploy\Scripts\WelcomeWiz_Initialize.xml" /Y
	copy "%DEPLOYROOT%\Scripts\WelcomeWiz_Initialize.vbs" "%CONTENT%\Deploy\Scripts\WelcomeWiz_Initialize.vbs" /Y
	copy "%DEPLOYROOT%\Scripts\SelectItem.jpg" "%CONTENT%\Deploy\Scripts\SelectItem.jpg" /Y
	copy "%DEPLOYROOT%\Scripts\WelcomeBanner.jpg" "%CONTENT%\Deploy\Scripts\WelcomeBanner.jpg" /Y
	copy "%DEPLOYROOT%\Scripts\btnout.png" "%CONTENT%\Deploy\Scripts\btnout.png" /Y
	copy "%DEPLOYROOT%\Scripts\btnover.png" "%CONTENT%\Deploy\Scripts\btnover.png" /Y
	copy "%DEPLOYROOT%\Scripts\btnsel.png" "%CONTENT%\Deploy\Scripts\btnsel.png" /Y
	copy "%DEPLOYROOT%\Scripts\LTIGetFolder.wsf" "%CONTENT%\Deploy\Scripts\LTIGetFolder.wsf" /Y
	copy "%DEPLOYROOT%\Scripts\NICSettings_Definition_ENU.xml" "%CONTENT%\Deploy\Scripts\NICSettings_Definition_ENU.xml" /Y
	copy "%DEPLOYROOT%\Scripts\ZTINicUtility.vbs" "%CONTENT%\Deploy\Scripts\ZTINicUtility.vbs" /Y
	copy "%DEPLOYROOT%\Scripts\ZTINicConfig.wsf" "%CONTENT%\Deploy\Scripts\ZTINicConfig.wsf" /Y
	copy "%DEPLOYROOT%\Scripts\BackButton.png" "%CONTENT%\Deploy\Scripts\BackButton.png" /Y
	copy "%DEPLOYROOT%\Scripts\FolderIcon.png" "%CONTENT%\Deploy\Scripts\FolderIcon.png" /Y
	copy "%DEPLOYROOT%\Scripts\ItemIcon1.png" "%CONTENT%\Deploy\Scripts\ItemIcon1.png" /Y
	copy "%DEPLOYROOT%\Scripts\MinusIcon1.png" "%CONTENT%\Deploy\Scripts\MinusIcon1.png" /Y
	copy "%DEPLOYROOT%\Scripts\PlusIcon1.png" "%CONTENT%\Deploy\Scripts\PlusIcon1.png" /Y
	copy "%DEPLOYROOT%\Scripts\SelectItem.png" "%CONTENT%\Deploy\Scripts\SelectItem.png" /Y
	copy "%DEPLOYROOT%\Scripts\header-image.png" "%CONTENT%\Deploy\Scripts\header-image.png" /Y
	copy "%DEPLOYROOT%\Scripts\NavBar.png" "%CONTENT%\Deploy\Scripts\NavBar.png" /Y
	copy "%DEPLOYROOT%\Scripts\Computer.png" "%CONTENT%\Deploy\Scripts\Computer.png" /Y
	copy "%DEPLOYROOT%\Scripts\WelcomeWiz_Background.jpg" "%CONTENT%\Deploy\Scripts\WelcomeWiz_Background.jpg" /Y
	copy "%DEPLOYROOT%\Scripts\DeployWiz_Administrator.png" "%CONTENT%\Deploy\Scripts\DeployWiz_Administrator.png" /Y
	
	REM <!-- Tools -->
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\BDDRUN.exe" "%CONTENT%\Windows\system32\BDDRUN.exe" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\WinRERUN.exe" "%CONTENT%\Deploy\Tools\%PLATFORM%\WinRERUN.exe" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\CcmCore.dll" "%CONTENT%\Deploy\Tools\%PLATFORM%\CcmCore.dll" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\CcmUtilLib.dll" "%CONTENT%\Deploy\Tools\%PLATFORM%\CcmUtilLib.dll" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\Smsboot.exe" "%CONTENT%\Deploy\Tools\%PLATFORM%\Smsboot.exe" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\SmsCore.dll" "%CONTENT%\Deploy\Tools\%PLATFORM%\SmsCore.dll" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\TsCore.dll" "%CONTENT%\Deploy\Tools\%PLATFORM%\TsCore.dll" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\TSEnv.exe" "%CONTENT%\Deploy\Tools\%PLATFORM%\TSEnv.exe" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\TsManager.exe" "%CONTENT%\Deploy\Tools\%PLATFORM%\TsManager.exe" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\TsmBootstrap.exe" "%CONTENT%\Deploy\Tools\%PLATFORM%\TsmBootstrap.exe" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\TsMessaging.dll" "%CONTENT%\Deploy\Tools\%PLATFORM%\TsMessaging.dll" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\TsmBootstrap.exe" "%CONTENT%\Deploy\Tools\%PLATFORM%\TsmBootstrap.exe" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\TsProgressUI.exe" "%CONTENT%\Deploy\Tools\%PLATFORM%\TsProgressUI.exe" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\TSResNlc.dll" "%CONTENT%\Deploy\Tools\%PLATFORM%\TSResNlc.dll" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\00000409\tsres.dll" "%CONTENT%\Deploy\Tools\%PLATFORM%\00000409\tsres.dll" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\Microsoft.BDD.Utility.dll" "%CONTENT%\Deploy\Tools\%PLATFORM%\Microsoft.BDD.Utility.dll" /Y
	
	REM <!-- Tools --> MDT 2013
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\xprslib.dll" "%CONTENT%\Deploy\Tools\%PLATFORM%\xprslib.dll" /Y
	
	REM <!-- Tools --> MDT 2013 Update 1
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\CommonUtils.dll" "%CONTENT%\Deploy\Tools\%PLATFORM%\CommonUtils.dll" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\ccmgencert.dll" "%CONTENT%\Deploy\Tools\%PLATFORM%\ccmgencert.dll" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\msvcp120.dll" "%CONTENT%\Deploy\Tools\%PLATFORM%\msvcp120.dll" /Y
	copy "%DEPLOYROOT%\Tools\%PLATFORM%\msvcr120.dll" "%CONTENT%\Deploy\Tools\%PLATFORM%\msvcr120.dll" /Y
	
	REM <!-- Custom -->
	copy "%DEPLOYROOT%\Control\LocationServer.xml" "%CONTENT%\Deploy\Scripts\LocationServer.xml" /Y
	
	echo ===============================================================================
	set CMDFile=%MakePE%\ScriptsRW\Install-MDT.cmd
	if NOT exist "%CMDFile%" echo echo Executing %CMDFile%> %CMDFile%
	if exist "%CMDFile%" call "%CMDFile%"
	echo ===============================================================================
	echo Waiting 5 Seconds for Review
	ping -n 5 127.0.0.1>nul
	goto :eof