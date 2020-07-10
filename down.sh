#!/bin/bash

# Check if we are root
uid=$(id -u)
if [ $uid -ne 0 ]
then 
    echo "Please run as root"
    exit 1
fi

# check git & Install ffmpeg
git pull
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
mkdir ../$DOWNLOAD
cd ../$DOWNLOAD

#download
WEBCAMS="https://$URL/presentation/$meetingID/video/webcams.mp4"
DESKSHARE="https://$URL/presentation/$meetingID/deskshare/deskshare.mp4"

wget WEBCAMS
wget DESKSHARE

#Merge the recordings
ffmpeg -i webcams.mp4 -i deskshare.mp4 -c copy MEETING-VIDEO.mp4