# BBB-downloader

For a video conference, the speaker has to use the BigBlueButton support. Fortunately, despite the recording of the conference, it remains accessible only on the latter's website, so it is not accessible offline. In addition to this, BBB tries to limit downloads by separating video and audio.

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
./down.sh
```
It may be necessary in the future to update this script for this.
## Update Git clone
```{bash}
git reset --hard HEAD && git checkout master && git pull
chmod u+x down.sh 
./down.sh
```

*Ressources used* :
- FFmpeg
- curl
- http://dashohoxha.fs.al/download-bbb-presentation/
- https://forum.ubuntu-fr.org/viewtopic.php?id=120246
- http://dl.free.fr
