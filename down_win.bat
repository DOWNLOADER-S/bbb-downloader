@echo off
set /p BIT="32 or 64 bit computer? "
set /p FOLDER="What is the storage folder address (e.g. C:/Users/username/desktop/) "
set /p URL="What is the server url (without "https" and "/" || e.g. domain.com)? ==> "
set /p meetingID="What is the meeting ID? ==> "
set /p fiNAME="What do you want to call the final file? ==> "

cd %FOLDER%
mkdir BBB-DOWNLOADER
cd BBB-DOWNLOADER

curl --output FFMPEG.zip --url https://ffmpeg.zeranoe.com/builds/win%BIT%/static/ffmpeg-latest-win%BIT%-static.zip
tar -xf FFMPEG.zip

copy %FOLDER%\BBB-DOWNLOADER\ffmpeg-latest-win%BIT%-static\bin\ffmpeg.exe %FOLDER%\BBB-DOWNLOADER\

curl --output webcams.mp4 --url https://%URL%/presentation/%meetingID%/video/webcams.mp4
curl --output deskshare.mp4 --url https://%URL%/presentation/%meetingID%/deskshare/deskshare.mp4

ffmpeg -i webcams.mp4 -i deskshare.mp4 -c copy %fiNAME%.mp4
echo The script is finished! If you have not had an error, everything has worked fine!
echo As a reminder, the final file is called %fiNAME%.mp4 and is located here: %FOLDER%\BBB-DOWNLOADER\
pause