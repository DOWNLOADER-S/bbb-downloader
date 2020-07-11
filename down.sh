#!/bin/bash

# Check if we are root
uid=$(id -u)
if [ $uid -ne 0 ]
then 
    echo "Please run as root"
    exit 1
fi

# Install ffmpeg
apt install -y ffmpeg

# if ./down.sh $1 $2 $3 $4
if [[ -z $1 && -z $2 && -z $3 && -z $4 ]]

then
#ask directory & server URL & meeting ID & name of the final file
read -p 'What do you want to call the downloads folder? ==> ' DOWNLOAD
read -p 'What is the server url (without "https" and "/" || e.g. google.com)? ==> ' URL
read -p 'What is the meeting ID? ==>' meetingID
read -p 'What do you want to call the final file (if empty : MEETING-VIDEO)? ==> ' NAME

else
DOWNLOAD=$1
URL=$2
meetingID=$3
NAME=$4

fi

#create directory to download
mkdir -m 777 ../$DOWNLOAD
cd ../$DOWNLOAD

#download
WEBCAMS="https://$URL/presentation/$meetingID/video/webcams.mp4"
DESKSHARE="https://$URL/presentation/$meetingID/deskshare/deskshare.mp4"

wget "$WEBCAMS"
wget "$WEBCAMS"

#Merge the recordings
ffmpeg -i webcams.mp4 -i deskshare.mp4 -c copy $NAME.mp4

#change permissions of the folder and files
cd ../
chmod -R 777 $DOWNLOAD
cd ../bbb-downloader

#Final message for user
echo "========================================================================================="
echo "Thanks for use of BBB-downloader!"
echo "To sump up :"
echo -e "The final folder is $DOWNLOAD and you final file is $NAME.mp4"
echo "Enjoy it!"
echo "A-d-r-i"
echo "========================================================================================="