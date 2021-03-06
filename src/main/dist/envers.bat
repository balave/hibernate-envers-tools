@echo off
if "%OS%" == "Windows_NT" setlocal

setlocal enabledelayedexpansion

rem %~dp0 is expanded pathname of the current script under NT
set ENVERS_TOOLS_HOME=%~dp0

set CP=.
set CP=!CP!;%ENVERS_TOOLS_HOME%\patches\*
for /R %ENVERS_TOOLS_HOME% %%f in (envers*.jar) do set CP=!CP!;%%f
set CP=!CP!;%ENVERS_TOOLS_HOME%\dependencies\*
set CP=!CP!;%ENVERS_TOOLS_HOME%\lib\*

rem get command line args into a variable
set CMD_LINE_ARGS=%1
if ""%1""=="""" goto done
shift
:setup
if ""%1""=="""" goto done
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto setup
:done

if not defined JAVA_OPTS set JAVA_OPTS=

java -cp "%CP%" %JAVA_OPTS% com.wds.tools.envers.cli.Main %CMD_LINE_ARGS%