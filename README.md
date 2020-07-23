# BBB-downloader

For a video conference, the speaker has to use the [BigBlueButton](https://github.com/bigbluebutton) support. Fortunately, despite the recording of the conference, it remains accessible only on the latter's website, so it is not accessible offline. In addition to this, BBB tries to limit downloads by separating video and audio.

It is by starting from this principle and by failing with the other proposed methods, that I decided to build a shell and a batch script in order to:
- download the video AND the sound (*July 2020: not yet the comments of the conference, it's in progress, but is it really important?*)
- merge the two files
- allow the final file to be downloaded from any device (by FTP and deposit on a free server)
- **all in one action!**

> **In the end, in about 5 min for ~200Mb, you get your file ready to view and store wherever you want!**

# 4 ways to do
- **[UNIX](#unix)** : see all the details delow
- **WINDOWS** (1) : use the script '*down_win.bat*', **run as administrator** and answer the questions
- **WINDOWS** (2) : use the executable file '*bbb-downloader.exe*' which is the same thing but does not require any special skills except double-clicking on the file
- **WINDOWS** (3) : use a **virtual machine** to run the above UNIX script ([tutorial link](https://medium.com/platform-engineer/how-to-install-debian-linux-on-virtualbox-with-guest-additions-778afa0ee7e0))

---
## UNIX
*Required* :
It is necessary to install the git package in order to clone the script and the directory on your device.
```{bash}
apt install git
```

### Install Git clone
```{bash}
git clone https://framagit.org/A-d-r-i/bbb-downloader.git
cd bbb-downloader
chmod u+x down.sh
```
### Run the code
Two options :
- First: "basically" and interactively. Simply run the script and answer the questions.
```{bash}
./down.sh
```
- Secondly: quickly run the entire code using parameters like this (*see details of the parameters below*):
```{bash}
./down.sh DOWNLOAD_FOLDER URL meetingID NAME_FILE FTP EMAIL
```
**Parameters** :
The conference replay link should look like this:  
    Typical URL : https://`BBB_SERVER`/playback/presentation/2.0/playback.html?meetingId=`MEETING_ID`  
    Example URL : [https://domain.com/playback/presentation/2.0/playback.html?meetingId=65edkjejhdjbt-6322321]()


* **DOWNLOAD_FOLDER** : local address of the download folder (*preferably non-existent and empty*)
* **URL** : meeting server url (`BBB_SERVER` without "*https*" or "*http*" and without "/" slash | e.g. "*domain.com*")
* **meetingID** : the conference ID (`MEETING_ID`)
* **NAME_FILE** : the name of the final file (*without extension*)
* **FTP** : upload the final video file to a free server (two choices : `Y` for YES and `N` for NO)
* **EMAIL** : your email address so that you are notified of the file download link (if you choose `Y`)

Sample of code with parameters : `./down.sh VIDEO_FOLDER domain.com 65edkjejhdjbt-6322321 finalvideo Y mail@domain.com`

### Update Git clone
It may be necessary in the future to update this script. For this it is extremely important to place yourself in the git folder "bbb-downloader" (say in the code) and to execute the code below:
```{bash}
cd bbb-downloader
git reset --hard HEAD && git checkout master && git pull
chmod u+x down.sh 
```
**And [run the script](#run-the-code) again!**

---

*Ressources used* :
- [Git](https://github.com/git/git) / Package
- [FFmpeg](https://github.com/FFmpeg/FFmpeg) / Package
- [curl](https://github.com/curl/curl) / Package
- FTP / Package
- [Download BBB](http://dashohoxha.fs.al/download-bbb-presentation/) / Source
- [Script to the server](https://forum.ubuntu-fr.org/viewtopic.php?id=120246) / Source
- [Link to the free server](http://dl.free.fr) / Server
