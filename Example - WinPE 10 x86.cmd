	@echo off
	pushd %~dp0
echo This example Build Script will create WinPE 10 x86
echo This script will pause at milestones
pause
	
::	Run MakePE.cmd to load the Defaults and MySettings
	call .\Scripts\MakePE.cmd

::	Now you can make changes to the default Variables
	rem set DoPause=No

::	Rebuild BasePE instead of using the BasePE.wim
	rem set RebuildBasePE=Yes

::	Set the WinPE Version and Architecture
	set WinPEVersion=10
	set PLATFORM=x86
	
::	Run MakePE
	call .\Scripts\MakePE.cmd
	
::	You can pause at the end
	pause
