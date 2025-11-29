Script that implements ` yt-dlp ` with additional options to easily choose from different file locations and formats

# Dependencies
- `yt-dlp`: https://github.com/yt-dlp/yt-dlp
# Installation
```
git clone https://github.com/KOG-13/ytdownload.git
cd ytdownload
./install.sh
```
# Usage
After running, the user will be prompted to provide a Youtube URL, or press Q to exit the program
Once provided, the script will ask for a file destination. Options include:
1. ~/Videos/Youtube
2. ~/storage/movies (follows common existing termux file structure)

The use can then choose from various file formats
1. .mp3
2. .mp4
3. .webm
4. .flac
