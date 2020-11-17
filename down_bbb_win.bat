@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
echo #___________________________________________________________________________________
echo #
echo                This script need to run with administrator privileges            
echo #___________________________________________________________________________________
echo #
set /p FOLDER="What is the storage folder address (e.g. C:\Users\username\desktop)? ==> "
echo #
set /p URL="What is the url of the document? ==> "
echo #
set /p fiNAME="What do you want to call the final file? ==> "
echo #
set /p KEEP="Would you like to keep the videos in a folder after merging? (Y for yes and N for no) ==> "
echo #
set /p FTP="Do you want to receive the final file by email (in a download link)? (Y for yes and N for no) ==> "
echo #
if %FTP% == Y (
set /p EMAIL="What is your email address? ==> "
)

cd %FOLDER%
mkdir BBB-DOWNLOADER
cd BBB-DOWNLOADER
mkdir DOWNLOAD
cd DOWNLOAD

curl --output ffmpeg.exe --url https://framagit.org/downloader-s/bbb-downloader/-/raw/master/BIN/ffmpeg.exe

REM Obtain host and meeting ID by use a python script
echo %URL%>"TMP-URL-BBB-DOWNLOADER.txt"
set URL=%URL%fin
curl -o "BBB-DOWNLOADER-HOST.py" https://framagit.org/downloader-s/bbb-downloader/-/raw/master/BBB-DOWNLOADER-HOST.py
curl -o "BBB-DOWNLOADER-MEETINGID.py" https://framagit.org/downloader-s/bbb-downloader/-/raw/master/BBB-DOWNLOADER-MEETINGID.py
python BBB-DOWNLOADER-HOST.py TMP-URL-BBB-DOWNLOADER.txt > TMP-HOST-BBB-DOWNLOADER.txt
set /p HOST=<TMP-HOST-BBB-DOWNLOADER.txt
python BBB-DOWNLOADER-MEETINGID.py TMP-URL-BBB-DOWNLOADER.txt > TMP-MID-BBB-DOWNLOADER.txt
set /p MID=<TMP-MID-BBB-DOWNLOADER.txt

del TMP-URL-BBB-DOWNLOADER.txt
del TMP-HOST-BBB-DOWNLOADER.txt
del TMP-MID-BBB-DOWNLOADER.txt
del BBB-DOWNLOADER-HOST.py
del BBB-DOWNLOADER-MEETINGID.py

curl --output webcams.mp4 --url https://%HOST%/presentation/%MID%/video/webcams.mp4
curl --output deskshare.mp4 --url https://%HOST%/presentation/%MID%/deskshare/deskshare.mp4

ffmpeg -i webcams.mp4 -i deskshare.mp4 -c copy "../%fiNAME%.mp4"

REM save images in library
if %KEEP% == Y (
cd "%FOLDER%\BBB-DOWNLOADER"
md LIBRARY\%NAME%
move /y DOWNLOAD\*.mp4 LIBRARY\%NAME% > NUL
rmdir /s /q DOWNLOAD > NUL
) else (
cd "%FOLDER%\BBB-DOWNLOADER"
rmdir /s /q DOWNLOAD > NUL
)

if %FTP% == Y (
curl -q -T %FOLDER%\BBB-DOWNLOADER\%fiNAME%.mp4 -u %EMAIL%:'test' ftp://dl.free.fr
)

echo #___________________________________________________________________________________
echo The script is finished! If you have not had an error, everything has worked fine!
echo Thanks for use of BBB-downloader!
echo #
echo To sump up :
echo The final file is called %fiNAME%.mp4 and is located here: %FOLDER%\BBB-DOWNLOADER\
if %KEEP% == Y (
echo All downloaded videos are saved in this folder: %FOLDER%\BBB-DOWNLOADER\LIBRARY\%NAME%
 )
if %FTP% == Y (
echo The final file has been uploaded to the server, you will receive an email to download it to this address: %EMAIL%
)
echo #
echo Enjoy it!
echo A-d-r-i
echo #
echo Answer the question to finish the script and open the folder.
echo #___________________________________________________________________________________
set /p OTHER="Would you like to download another conference? (Y for yes and N for no) ==> "
if %OTHER% == Y (
start "BBB-DOWNLOADER" "%~f0"
%SystemRoot%\explorer.exe "%FOLDER%\BBB-DOWNLOADER\"
exit
) else (
%SystemRoot%\explorer.exe "%FOLDER%\BBB-DOWNLOADER\"
exit
)