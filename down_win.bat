@echo off
set /p BIT="32 or 64 bit computer? "
set /p FOLDER="What is the storage folder address (e.g. C:/Users/username/desktop/) "
set /p URL="What is the server url (without "https" and "/" || e.g. domain.com)? ==> "
set /p meetingID="What is the meeting ID? ==> "
set /p fiNAME="What do you want to call the final file? ==> "
set /p FTP="Do you want to receive the final file by email (in a download link)? (Y for yes and N for no) ==> "
if %FTP% == Y (
set /p EMAIL="What is your email address? ==> "
)

cd %FOLDER%
mkdir BBB-DOWNLOADER
cd BBB-DOWNLOADER

curl --output FFMPEG.zip --url https://ffmpeg.zeranoe.com/builds/win%BIT%/static/ffmpeg-latest-win%BIT%-static.zip
tar -xf FFMPEG.zip

copy %FOLDER%\BBB-DOWNLOADER\ffmpeg-latest-win%BIT%-static\bin\ffmpeg.exe %FOLDER%\BBB-DOWNLOADER\

curl --output webcams.mp4 --url https://%URL%/presentation/%meetingID%/video/webcams.mp4
curl --output deskshare.mp4 --url https://%URL%/presentation/%meetingID%/deskshare/deskshare.mp4

ffmpeg -i webcams.mp4 -i deskshare.mp4 -c copy %fiNAME%.mp4

if %FTP% == Y (
curl -q -T %FOLDER%\BBB-DOWNLOADER\%fiNAME%.mp4 -u %EMAIL%:'test' ftp://dl.free.fr
)

echo ================================================================
echo The script is finished! If you have not had an error, everything has worked fine!
echo Thanks for use of BBB-downloader!
echo To sump up :
echo The final file is called %fiNAME%.mp4 and is located here: %FOLDER%\BBB-DOWNLOADER\
if %FTP% == Y (
echo The final file has been uploaded to the server, you will receive an email to download it to this address: %EMAIL%
)
echo _
echo Enjoy it!
echo A-d-r-i
echo _
echo Press a key to close the script and open the folder.
echo ================================================================
pause
%SystemRoot%\explorer.exe "%FOLDER%\BBB-DOWNLOADER\"