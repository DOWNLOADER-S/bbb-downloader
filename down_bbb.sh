#!/bin/bash

# Check if we are root
uid=$(id -u)
if [ $uid -ne 0 ]
then 
    echo "Please run as root"
    exit 1
fi

# Install ffmpeg & ftp & curl
apt install -y ffmpeg
apt install -y ftp
apt install -y curl

# if ./down.sh $1 $2 $3 $4 $5 $6
if [[ -z $1 && -z $2 && -z $3 && -z $4 && -z $5 && -z $6 ]]

then
#ask informations
read -p 'What do you want to call the download folder? ==> ' DOWNLOAD
read -p 'What is the server url (without "https" and "/" || e.g. domain.com)? ==> ' URL
read -p 'What is the meeting ID? ==> ' meetingID
read -p 'What do you want to call the final file? ==> ' NAME
read -p 'Do you want to receive the final file by email (in a download link)? (Y for yes and N for no) ==>' FTP

if [ FTP=Y ]
then read -p 'What is your email address? ==>' EMAIL
fi

else
DOWNLOAD=$1
URL=$2
meetingID=$3
NAME=$4
FTP=$5
EMAIL=$6

fi

#create directory to download
mkdir -m 777 ../$DOWNLOAD
cd ../$DOWNLOAD

#download
WEBCAMS="https://$URL/presentation/$meetingID/video/webcams.mp4"
DESKSHARE="https://$URL/presentation/$meetingID/deskshare/deskshare.mp4"

wget "$WEBCAMS"
wget "$DESKSHARE"

#Merge the recordings
fiNAME="$NAME.mp4"
ffmpeg -i webcams.mp4 -i deskshare.mp4 -c copy $fiNAME

#change permissions of the folder and files
cd ../
chmod -R 777 $DOWNLOAD
cd bbb-downloader

#send by ftp (always the same password)
if [ FTP=Y ]
then
curl -q -T "../$DOWNLOAD/$fiNAME" -u "$EMAIL":'test' ftp://dl.free.fr/

if [ $? -eq 0 ]
then
    echo "$FiNAME successfully transferred to the server! the download link was sent to $EMAIL."
else
    echo "Error during transfer! check your configuration or try again later."
fi

fi

#Final message for user
echo "================================================================"
echo "Thanks for use of BBB-downloader!"
echo "To sump up :"
echo -e " - The final folder is $DOWNLOAD and you final file is $NAME.mp4"

if [ FTP=Y ]
then echo -e " - The final file has been uploaded to the server, you will receive an email to download it to this address: $EMAIL"
fi

echo "Enjoy it!"
echo "A-d-r-i"
echo "================================================================"