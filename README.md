# BBB-downloader

For a video conference, the speaker has to use the [BigBlueButton](https://github.com/bigbluebutton) support. Fortunately, despite the recording of the conference, it remains accessible only on the latter's website, so it is not accessible offline. In addition to this, BBB tries to limit downloads by separating video and audio.

It is by starting from this principle and by failing with the other proposed methods, that I decided to build a shell script in order to:
- download the video AND the sound (*July 2020: not yet the comments of the conference, it's in progress, but is it really important?*)
- merge the two files
- allow the final file to be downloaded from any device (by FTP and deposit on a free server).

**In the end, in about 5 min for ~200Mb, you get your file ready to view and store wherever you want!**

## Install Git clone
```{bash}
git clone https://framagit.org/A-d-r-i/bbb-downloader.git
cd bbb-downloader
chmod u+x down.sh
```
## Run the code
Two options :
- First: "basically" and interactively. Simply run the script and answer the questions.
```{bash}
./down.sh
```
- Secondly: quickly run the entire code using parameters like this (see details of the parameters below):
```{bash}
./down.sh DOWNLOAD_FOLDER URL meetingID NAME_FILE FTP EMAIL
```
**Parameters** :
The conference replay link should look like this:\n
https://`BBB_SERVER`/playback/presentation/2.0/playback.html?meetingId=`MEETING_ID`
* DOWNLOAD_FOLDER : local address of the download folder *(*preferably non-existent and empty*)
* URL : meeting server url (`BBB_SERVER` without "https" or "http" and without "/" slash | e.g. "google.com")
* meetingID : the conference ID (`MEETING_ID`)

## Update Git clone
It may be necessary in the future to update this script. For this it is extremely important to place yourself in the git folder "bbb-downloader" (say in the code) and to execute the code below:
```{bash}
cd bbb-downloader
git reset --hard HEAD && git checkout master && git pull
chmod u+x down.sh 
./down.sh
```

*Ressources used* :
- [FFmpeg](https://github.com/FFmpeg/FFmpeg)
- [curl](https://github.com/curl/curl)
- [Download BBB](http://dashohoxha.fs.al/download-bbb-presentation/)
- [Script to the server](https://forum.ubuntu-fr.org/viewtopic.php?id=120246)
- [Link to the free server](http://dl.free.fr)
