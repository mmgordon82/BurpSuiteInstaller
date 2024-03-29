@echo off
cd %~dp0

echo.
echo +--------------------------------+
echo ^|                             ^|
echo ^| BurpSuite Installer Builder ^|
echo ^|                             ^|
echo +--------------------------------+
echo.

:: Check if jdk is installed
if not exist "jdk/" goto JDKNotFound

echo [+] Using JDK from "jdk/":
type jdk\release | findstr "JAVA_"

echo [+] Looking for BurpSuite jar files...
if not [%1]==[] (set burpfile=%1) else (for %%i in (burpsuite_pro*.jar) do (set burpfile=%%i))

if not exist "%burpfile%" goto BurpNotFound

:: check if can find burp version
echo %burpfile% | findstr "burpsuite_pro_v[0-9][0-9][0-9][0-9]\." >nul
if %errorlevel% neq 0 goto PromptVersion


:: The jar file should match the pattern "burpsuite_pro_vXXXX.X.X.jar" (i.e. burpsuite_pro_v2022.3.9.jar)
set version=%burpfile%
set version=%version:burpsuite_pro_v=%
set version=%version:.jar=%
if not [%version%] == [] goto BuildInstaller

:PromptVersion
echo [!] Couldn't determine BurpSuite version from jar file name.
set /p version=Enter BurpSuite version (e.g. 2022.3.9):

:BuildInstaller
:: %version% = burpsuite version (XXXX.X.X, i.e 2022.3.9)
echo [+] BurpSuite "%burpfile%" version: %version%

echo [+] Creating Run-Burp.bat...
echo @echo off > Run-Burp.bat
echo cd %%~dp0 >> Run-Burp.bat
echo start .\jdk\bin\javaw.exe -noverify -javaagent:burploader.jar --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -jar burpsuite_pro.jar >> Run-Burp.bat

set dir_output=Build-%version%
echo [+] Creating Installer in "%dir_output%/"...

"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" /Qp "/O%dir_output%" "/DBurpVersion=%version%" "/DBurpJarFile=%burpfile%" Installer.iss
if %errorlevel% neq 0 goto :CompilationError


echo [+] Done! Installer created in "%dir_output%/".

:: Proper exit
timeout 3 /nobreak >nul
call :Cleanup
exit 0

:: Error handling

:Cleanup
del /Q Run-Burp.bat
exit 0

:JDKNotFound
echo [!] JDK was not found in "jdk/". Aborting...
pause
exit 1

:BurpNotFound
echo [!] BurpSuite jar file not found. Please place the jar file in the same directory as this script.
pause
exit 1

:CompilationError
echo [!] Error while compiling the installer. Aborting...
call :Cleanup
pause
exit 1