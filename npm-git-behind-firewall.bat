@echo off

:: this batch file:
:: 1. sets the username, password, and web proxy server in npm, git, and the windows environment.
:: 2. tells npm which version of c++ compiler and where it is

:: constants to set for your system
:: default is C:\Program Files\nodejs\mpm.cmd
set npm_location=
set /P npm_location=please enter the full path of npm.cmd (hit enter to default to %programfiles%\nodejs\npm.cmd)
if not defined npm_location set npm_location=%programfiles%\nodejs\npm.cmd
echo %npm_location%
exit /b

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

:: get the url and port of the web proxy and then the user's password
set /P proxy_url_and_port=please enter your proxy server url and port in the format url:port beginning after http://
set /P password=please enter your windows password: 

:: use this info to create a proxy string
set address=http://%username%:%password%@%proxy_url_and_port%
set node_address=http://%username%:%password%@%proxy_url_and_port%

:: set the widows environment variables temporary and permament (set and setx.exe)
%WINDIR%\SYSTEM32\setx.exe http_proxy %address%
set http_proxy=%address%
%WINDIR%\SYSTEM32\setx.exe https_proxy %address%
set https_proxy=%address%
%WINDIR%\SYSTEM32\setx.exe PROXY %address%
set no_proxy=localhost,127.0.0.1
%WINDIR%\SYSTEM32\setx.exe no_proxy localhost,127.0.0.1
set no_proxy=localhost,127.0.0.1

echo the proxy address we're going to use is...
echo %node_address%

:: set the npm proxy
echo setting npm strict ssl to false
call npm config set strict-ssl false
echo setting the npm proxy
call npm config set proxy %node_address%
echo setting the npm https-proxy
call npm config set https-proxy %node_address%
echo setting the npm no-proxy
call npm config set no-proxy %node_address%

:: tell git to use the proxy
echo setting the git proxy
git config --global http.proxy %address%

:: set the c++ compilar version for npm
echo setting the npm c++ compiler flag
call npm config set msvs_version 2015 -g
:: tel npm where the c++ compiler lives (this works if you've installed the vc++ tools from the db link)
echo set the VCTargetsPath variables for C++ in npm
%WINDIR%\SYSTEM32\setx.exe VCTargetsPath "%programfiles(x86)%\MSBuild\Microsoft.Cpp\v4.0\V140"
set VCTargetsPath=%programfiles(x86)%\MSBuild\Microsoft.Cpp\v4.0\V140
