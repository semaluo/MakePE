:Install-Packages
	echo.
	echo.
	echo.
	echo.
	echo.
	echo ===============================================================================
	echo Section Install-Packages ======================================================
	echo ===============================================================================
	if /I "%DoPause%" == "Yes" pause
	if /I "%WinPE-HTA%" == "Yes" call :WinPE-HTA
	if /I "%WinPE-Scripting%" == "Yes" call :WinPE-Scripting
	if /I "%WinPE-WMI%" == "Yes" call :WinPE-WMI
	if /I "%WinPE-SecureStartup%" == "Yes" call :WinPE-SecureStartup
	if /I "%WinPE-FMAPI%" == "Yes" call :WinPE-FMAPI
	if /I "%WinPE-MDAC%" == "Yes" call :WinPE-MDAC
	if /I "%WinPE-Dot3Svc%" == "Yes" call :WinPE-Dot3Svc
	if /I "%WinPE-PPPoE%" == "Yes" call :WinPE-PPPoE
	if /I "%WinPE-RNDIS%" == "Yes" call :WinPE-RNDIS
	if /I "%WinPE-WDS-Tools%" == "Yes" call :WinPE-WDS-Tools
	if /I "%WinPE-NetFx%" == "Yes" call :WinPE-NetFx
	if /I "%WinPE-PowerShell%" == "Yes" call :WinPE-PowerShell
	if /I "%WinPE-DismCmdlets%" == "Yes" call :WinPE-DismCmdlets
	if /I "%WinPE-SecureBootCmdlets%" == "Yes" call :WinPE-SecureBootCmdlets
	if /I "%WinPE-StorageWMI%" == "Yes" call :WinPE-StorageWMI	
	if /I "%WinPE-EnhancedStorage%" == "Yes" call :WinPE-EnhancedStorage
	if /I "%WinPE-Rejuv%" == "Yes" call :WinPE-Rejuv
	if /I "%WinPE-SRT%" == "Yes" call :WinPE-SRT
	if /I "%WinPE-WinReCfg%" == "Yes" call :WinPE-WinReCfg
	echo ===============================================================================
	set CMDFile=%MakePE%\ScriptsRW\Install-Packages.cmd
	if NOT exist "%CMDFile%" echo echo Executing %CMDFile%> %CMDFile%
	if exist "%CMDFile%" call "%CMDFile%"
	echo ===============================================================================
	echo Waiting 5 Seconds for Review
	ping -n 5 127.0.0.1>nul
	goto :eof


:WinPE-HTA
	::	WinPE-HTA provides HTML Application (HTA) support to create GUI applications through the Windows Internet Explorer® script engine and HTML services.
	::	These applications are trusted and display only the menus, icons, toolbars, and title information that you create.
	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-HTA.cab"
	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-HTA_%MyLang%.cab"
	goto :eof

:WinPE-Scripting
	::	WinPE-Scripting contains a multiple-language scripting environment that is ideal for automating system administration tasks, such as batch file processing.
	::	Scripts that run in the Windows Script Host (WSH) environment can call WSH objects and other COM-based technologies that support Automation, such as WMI, to manage the Windows subsystems that are central to many system administration tasks.
	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-Scripting.cab"
	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-Scripting_%MyLang%.cab"
	goto :eof
	
:WinPE-WMI
	::	WinPE-WMI contains a subset of the Windows Management Instrumentation (WMI) providers that enable minimal system diagnostics.
	::	WMI is the infrastructure for management data and operations on Windows-based operating systems.
	::	You can write WMI scripts or applications to automate administrative tasks on remote computers.
	::	Additionally, WMI supplies management data to other parts of the operating system and products.
	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-WMI.cab"
	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-WMI_%MyLang%.cab"
	goto :eof
	
:WinPE-SecureStartup
	::	NOT USED IN WINDOWS 7 AIK
	::	Dependencies: Install WinPE-WMI before you install WinPE-SecureStartup.
	::	New for Windows 8. WinPE-SecureStartup enables provisioning and management of BitLocker and the Trusted Platform Module (TPM).
	::	It includes BitLocker command-line tools, BitLocker WMI management libraries, a TPM driver, TPM Base Services (TBS), the Win32_TPM class, the BitLocker Unlock Wizard, and BitLocker UI libraries.
	::	The TPM driver provides better support for both BitLocker and the TPM in this preboot environment.
	if exist "%CABS%\WinPE-SecureStartup.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-SecureStartup.cab"
	if exist "%CABS%\%MyLang%\WinPE-SecureStartup_%MyLang%.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-SecureStartup_%MyLang%.cab"
	goto :eof
	
:WinPE-FMAPI
	::	NOT USED IN WINDOWS 7 AIK
	::	WinPE-FMAPI provides access to the Windows PE File Management API (FMAPI) for discovering and restoring deleted files from unencrypted volumes.
	::	The FMAPI also provides the ability to use a password or recovery key file for the discovery and recovery of deleted files from Windows BitLocker Drive Encryption encrypted volumes.
	if exist "%CABS%\WinPE-FMAPI.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-FMAPI.cab"
	goto :eof
	
:WinPE-MDAC
	::	WinPE-MDAC supports Microsoft® Open Database Connectivity (ODBC), OLE DB, and Microsoft ActiveX® Data Objects (ADO).
	::	This set of technologies provides access to various data sources, such as Microsoft SQL Server®
	::	For example, this access enables queries to Microsoft SQL Server installations that contain ADO objects.
	::	You can build a dynamic answer file from unique system information.
	::	Similarly, you can build data-driven client or server applications that integrate information from a variety of data sources, both relational (SQL Server) and non-relational.
	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-MDAC.cab"
	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-MDAC_%MyLang%.cab"
	goto :eof
	
:WinPE-Dot3Svc
	::	Adds support for the IEEE 802.X authentication protocol on wired networks.
	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-Dot3Svc.cab"
	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-Dot3Svc_%MyLang%.cab"
	goto :eof
	
:WinPE-PPPoE
	::	WinPE-PPPoE enables you to use Point-to-Point Protocol over Ethernet (PPPoE) to create, connect, disconnect, and delete PPPoE connections from Windows PE.
	::	PPPoE is a network protocol for encapsulating Point-to-Point Protocol (PPP) frames inside Ethernet frames.
	::	PPPoE enables Windows users to remotely connect their computers to the web.
	::	By using PPPoE, users can virtually dial from one computer to another over an Ethernet network, to establish a point-to-point connection between the computers.
	::	The computers can use this point-to-point connection to transport data packets.
	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-PPPoE.cab"
	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-PPPoE_%MyLang%.cab"
	goto :eof
	
:WinPE-RNDIS
	::	NOT USED IN WINDOWS 7 AIK
	::	WinPE-RNDIS contains Remote Network Driver Interface Specification (Remote NDIS) support.
	::	WinPE-RNDIS enables network support for devices that implement the Remote NDIS specification over USB.
	::	Remote NDIS defines a bus-independent message set and a description of how this message set operates over various I/O buses.
	::	Therefore, hardware vendors do not have to write an NDIS miniport device driver.
	::	Because this Remote NDIS interface is standardized, one set of host drivers can support any number of bus-attached networking devices.
	if exist "%CABS%\WinPE-RNDIS.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-RNDIS.cab"
	if exist "%CABS%\%MyLang%\WinPE-RNDIS_%MyLang%.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-RNDIS_%MyLang%.cab"
	goto :eof
	
:WinPE-WDS-Tools
	::	WinPE-WDS-Tools includes APIs to enable the Image Capture tool and a multicast scenario that involves a custom Windows Deployment Services client.
	::	It must be installed if you intend to run the Windows Deployment Services client on a custom Windows PE image.
	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-WDS-Tools.cab"
	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-WDS-Tools_%MyLang%.cab"
	goto :eof
	
:WinPE-NetFx
	::	NOT USED IN WINDOWS 7 AIK
	::	Dependencies: Install WinPE-WMI before you install WinPE-NetFX.
	::	WinPE-NetFX contains a subset of the .NET Framework 4.5 that is designed for client applications.
	::	Not all Windows binaries are present in Windows PE, and therefore not all Windows APIs are present or usable.
	::	Due to the limited API set, the following .NET Framework features have no or reduced functionality in Windows PE:
	if exist "%CABS%\WinPE-NetFx.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-NetFx.cab"
	if exist "%CABS%\%MyLang%\WinPE-NetFx_%MyLang%.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-NetFx_%MyLang%.cab"
	goto :eof
	
:WinPE-PowerShell
	::	NOT USED IN WINDOWS 7 AIK
	::	Dependencies: Install WinPE-WMI > WinPE-NetFX > WinPE-Scripting before you install WinPE-PowerShell.
	::	WinPE-PowerShell contains Windows PowerShell–based diagnostics that simplify using Windows Management Instrumentation (WMI) to query the hardware during manufacturing.
	::	You can create Windows PowerShell–based deployment and administrative Windows PE–based tools.
	::	In addition to deployment, you can use Windows PowerShell for recovery scenarios.
	::	Customers can boot in Windows RE and then use Windows PowerShell scripts to resolve issues.
	::	Customers are not limited to the toolsets that run in Windows PE.
	::	Similarly, you can build scripted offline solutions to recover some computers from no-boot scenarios.
	if exist "%CABS%\WinPE-PowerShell.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-PowerShell.cab"
	if exist "%CABS%\%MyLang%\WinPE-PowerShell_%MyLang%.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-PowerShell_%MyLang%.cab"
	goto :eof
	
:WinPE-DismCmdlets
	::	NOT USED IN WINDOWS 7 AIK
	::	Dependencies: Install WinPE-WMI > WinPE-NetFX > WinPE-Scripting > WinPE-PowerShell before you install WinPE-DismCmdlets.
	::	WinPE-DismCmdlets contains the dism PowerShell module, which includes cmdlets used for managing and servicing Windows images.
	if exist "%CABS%\WinPE-DismCmdlets.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-DismCmdlets.cab"
	if exist "%CABS%\%MyLang%\WinPE-DismCmdlets_%MyLang%.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-DismCmdlets_%MyLang%.cab"
	goto :eof
	
:WinPE-SecureBootCmdlets
	::	NOT USED IN WINDOWS 7 AIK
	::	Dependencies: Install WinPE-WMI > WinPE-NetFX > WinPE-Scripting > WinPE-PowerShell before you install WinPE-SecureBootCmdlets.
	::	WinPE-SecureBootCmdlets contains the PowerShell cmdlets for managing the UEFI (Unified Extensible Firmware Interface) environment variables for Secure Boot.
	if exist "%CABS%\WinPE-SecureBootCmdlets.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-SecureBootCmdlets.cab"
	goto :eof
	
:WinPE-StorageWMI
	::	NOT USED IN WINDOWS 7 AIK
	::	Dependencies: Install WinPE-WMI > WinPE-NetFX > WinPE-Scripting > WinPE-PowerShell before you install WinPE-StorageWMI.
	::	WinPE-StorageWMI contains PowerShell cmdlets for storage management. These cmdlets use the Windows Storage Management API (SMAPI) to manage local storage, such as disk, partition, and volume objects.
	::	Or, these cmdlets use the Windows SMAPI together with array storage management by using a storage management provider.
	::	WinPE-StorageWMI also contains Internet SCSI (iSCSI) Initiator cmdlets for connecting a host computer or server to virtual disks on external iSCSI-based storage arrays through an Ethernet network adapter or iSCSI Host Bus Adapter (HBA).
	if exist "%CABS%\WinPE-StorageWMI.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-StorageWMI.cab"
	if exist "%CABS%\%MyLang%\WinPE-StorageWMI_%MyLang%.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-StorageWMI_%MyLang%.cab"
	goto :eof
	
:WinPE-EnhancedStorage
	::	NOT USED IN WINDOWS 7 AIK
	::	New for Windows 8. WinPE-EnhancedStorage enables Windows to discover additional functionality for storage devices, such as encrypted drives, and implementations that combine Trusted Computing Group (TCG) and IEEE 1667 ("Standard Protocol for Authentication in Host Attachments of Transient Storage Devices") specifications.
	::	This optional component enables Windows to manage these storage devices natively by using BitLocker.
	if exist "%CABS%\WinPE-EnhancedStorage.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-EnhancedStorage.cab"
	if exist "%CABS%\%MyLang%\WinPE-EnhancedStorage_%MyLang%.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-EnhancedStorage_%MyLang%.cab"
	goto :eof
:WinPE-Rejuv
	::	NOT USED IN WINDOWS 7 AIK
	::	WinPE-Rejuv is used for Refresh Image and is part of the WinRE.wim.  It is not included in ADK WinPE.wim or the Boot.wim
	if exist "%CABS%\%MyLang%\WinPE-Rejuv_%MyLang%.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-Rejuv_%MyLang%.cab"
	goto :eof
	
:WinPE-SRT
	::	NOT USED IN WINDOWS 7 AIK
	::	WinPE-SRT enables Windows RE and is part of the Boot.wim and WinRE.wim.  It is not included in ADK WinPE.wim
	if exist "%CABS%\%MyLang%\WinPE-SRT_%MyLang%.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-SRT_%MyLang%.cab"
	goto :eof
	
:WinPE-WinReCfg
	::	NOT USED IN WINDOWS 7 AIK
	::	WinPE-WinReCfg contains the Winrecfg.exe tool, and it enables the following scenarios:
	::	Boot from x86-based Windows PE to configure Windows RE settings on an offline x64-based operating system image.
	::	Boot from x64-based Windows PE to configure Windows RE settings on an offline x86-based operating system image.
	if exist "%CABS%\WinPE-WinReCfg.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-WinReCfg.cab"
	if exist "%CABS%\%MyLang%\WinPE-WinReCfg_%MyLang%.cab" "%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-WinReCfg_%MyLang%.cab"
	goto :eof
	
::	Lines below are for Reference only

REM echo ===============================================================================
::	Language Components which are not necessary in most cases
REM echo ===============================================================================
	::	Enabling this feature is not necessary when using WinRE.wim
	REM	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-Fonts-Legacy.cab"
	::	WinPE-Fonts-Legacy contains 32 font files for various languages/writing scripts.
	::	Some of these fonts are no longer used as UI fonts.
	::	For example, scripts such as Bengali, Devanagari, Gujarati, Gurmukhi, Kannada, Malayalam, Oriya, Tamil, Telugu, and Sinhalese were covered by
	::	Mangal, Latha, Vrinda, Gautami, Kalinga, artika, Raavi, Shruti, and Tunga, but in Windows 8, they were all unified under Nirmala UI, a single, pan-Indian font.
REM echo ===============================================================================	
	REM	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-FontSupport-JA-JP.cab"
	::	WinPE-Font Support-JA-JP contains two Japanese font families that are packaged as TrueType Collection (TTC) files.
REM echo ===============================================================================
	REM	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-FontSupport-KO-KR.cab"
	::	WinPE-Font Support-KO-KR contains three core Korean font families: Gulim, Batang and Malgun Gothic.
REM echo ===============================================================================
	REM	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-FontSupport-ZH-CN.cab"
	::	WinPE-Font Support-ZH-CN contains two Chinese font families that are packaged as TTC files.
REM echo ===============================================================================
	REM	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-FontSupport-ZH-HK.cab"
	::	The Hong Kong and Taiwan optional components contain two Chinese font families that are packaged as TTC files
REM echo ===============================================================================
	REM	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-FontSupport-ZH-TW.cab"
	::	The Hong Kong and Taiwan optional components contain two Chinese font families that are packaged as TTC files
REM echo ===============================================================================


REM echo ===============================================================================
::	These are really just added for information.  I would not recommend installing these Components
REM echo ===============================================================================
	REM	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-LegacySetup.cab"
	REM	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-LegacySetup_%MyLang%.cab"
	::	Winpe-LegacySetup contains all Setup files from the \Sources folder on the Windows media.
	::	Add this optional component when you service Setup or the \Sources folder on the Windows media.
	::	You must add this optional component together with the optional component for the Setup feature.
	::	To add a new Boot.wim file to the media, add the parent WinPE-Setup, either of the children (WinPE-Setup-Client or WinPE-Setup-Server), and Media optional components.
	::	Media Setup is required to support Windows Server® 2008 R2 installation.
REM echo ===============================================================================
	REM	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-Setup.cab"
	REM	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-Setup_%MyLang%.cab"
	::	WinPE-Setup is the parent of WinPE-Setup-Client and WinPE-Setup-Server.
	::	It contains all Setup files from the \Sources folder that are common to the client and the server.
REM echo ===============================================================================
	REM	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-Setup-Client.cab"
	REM	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-Setup-Client_%MyLang%.cab"
	::	Dependencies: Install WinPE-Setup before you install WinPE-Setup-Client.
	::	WinPE-Setup-Client contains the client branding files for the parent WinPE-Setup optional component.
REM echo ===============================================================================	
	REM	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\WinPE-Setup-Server.cab"
	REM	"%dism%" /Add-Package /Image:"%CONTENT%" /PackagePath:"%CABS%\%MyLang%\WinPE-Setup-Server_%MyLang%.cab"
	::	Dependencies: Install WinPE-Setup before you install WinPE-Setup-Server.
	::	WinPE-Setup-Server includes the server branding files for the parent WinPE-Setup optional component.
REM echo ===============================================================================