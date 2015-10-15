	@echo off
	pushd %~dp0
echo This example Build Script will create all WinPE versions
echo This script will not pause at milestones
pause
	
::	Run MakePE.cmd to load the Defaults and MySettings
	call .\Scripts\MakePE.cmd

::	Now you can make changes to the default Variables
	set DoPause=No

::	Rebuild BasePE instead of using the BasePE.wim
	rem set RebuildBasePE=Yes

::	And build a WinPE 3 x86
	set WinPEVersion=3
	set PLATFORM=x86
	call .\Scripts\MakePE.cmd

::	Followed by a WinPE 3 x64
	set WinPEVersion=3
	set PLATFORM=x64
	call .\Scripts\MakePE.cmd
	
::	Jumping next to WinPE 5 x86
	set WinPEVersion=5
	set PLATFORM=x86
	call .\Scripts\MakePE.cmd
	
::	And ending with WinPE 5 x64
	set WinPEVersion=5
	set PLATFORM=x64
	call .\Scripts\MakePE.cmd
	
::	Jumping next to WinPE 10 x86
	set WinPEVersion=10
	set PLATFORM=x86
	call .\Scripts\MakePE.cmd
	
::	And ending with WinPE 10 x64
	set WinPEVersion=10
	set PLATFORM=x64
	call .\Scripts\MakePE.cmd
	
::	You can pause at the end
	pause

