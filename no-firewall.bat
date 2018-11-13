@echo off

:: this batch file:
:: 1. sets the username, password, and web proxy server in npm, git, and the windows environment.
:: 2. tells npm which version of c++ compiler and where it is

:: constants to set for your system
:: default is C:\Program Files\nodejs\mpm.cmd
set npm_location=
set /P npm_location=please enter the full path of npm.cmd (hit enter to default to %programfiles%\nodejs\npm.cmd)
if not defined npm_location set npm_location=%programfiles%\nodejs\npm.cmd
echo using %npm_location%

:: these are just reminders for me and the things I was using on my system when I had this issue
::
echo download MS Visual C++ buidl tools from:
echo http://landinghub.visualstudio.com/visual-cpp-build-tools
echo or if you are behing a proxy that f***s up the clickonce installer
echo https://www.dropbox.com/s/mg9bi8z4luoutzf/VisualCppBuildTools_Full.exe?dl=0
:: thats a dropbox folder i put the offline installatio files in to access them from work

echo get Git from:
echo https://git-scm.com/download/win
echo.
echo get VS Code Insiders from:
echo https://code.visualstudio.com/insiders
echo.
echo get nodeJS from:
echo https://nodejs.org/en/download/current/
echo.
echo get apache CouchDB
echo http://couchdb.apache.org/#download
echo.


:: set the widows environment variables temporary and permament (set and setx.exe)
%WINDIR%\SYSTEM32\setx.exe http_proxy ""
set http_proxy=""
%WINDIR%\SYSTEM32\setx.exe https_proxy ""
set https_proxy=""
%WINDIR%\SYSTEM32\setx.exe PROXY ""
set no_proxy=""
%WINDIR%\SYSTEM32\setx.exe no_proxy ""
set no_proxy="""

:: set the npm proxy
echo removing npm strict ssl
call npm config rm strict-ssl
echo removing the npm proxy
call npm config rm proxy 
echo removing the npm https-proxy
call npm config rm https-proxy 
echo removing the npm no-proxy
call npm config rm no-proxy 

:: tell git to use the proxy
echo removing the git proxy
git config --global --unset core.gitproxy

:: set the c++ compilar version for npm
echo set the npm c++ compiler flag
call npm config set msvs_version 2015 -g
:: tel npm where the c++ compiler lives (this works if you've installed the vc++ tools from the db link)
echo set the VCTargetsPath variables for C++ in npm
%WINDIR%\SYSTEM32\setx.exe VCTargetsPath "%programfiles(x86)%\MSBuild\Microsoft.Cpp\v4.0\V140"
set VCTargetsPath=%programfiles(x86)%\MSBuild\Microsoft.Cpp\v4.0\V140
