#! /usr/bin/env bash

# Define text color
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
PURPLE="\e[35m"
CYAN="\e[36m"
RESET="\e[0m"

read -rp "Enter Youtube URL (Press Q to quit): " url
if [[ "$url" == "q" || "$url" == "Q" ]]; then
  echo -e "\e[1;31mExited program.\e[0m"
  exit 1
elif [ -z "$url" ]; then # If no input
  echo -e "\e[1;31;1mError: No URL provided.\e[0m"
  exit 1
fi 



while true; do
  # Choose file destination
  echo -e "----------------------------------------"
  echo -e "${GREEN}1) Termux:${RESET} (~/storage/movies/)"
  echo -e "${BLUE}2) Linux:${RESET} (~/Videos/Youtube/)"
  echo -e "${RED}3) Quit${RESET}"
  read -rp "Choose a destination folder: " destination_choise

  case $destination_choise in 
    1)
      DESTINATION="$HOME/storage/movies" #Termux-friendly file destination
      ;;
    2)
      DESTINATION="$HOME/Videos/Youtube"
      ;;
    3)
      echo "Program exited"
      exit 1
      ;;
    *)
      echo "Error: Unknown input. Exiting program"
      exit 1
      ;;
  esac
      
  # Check if file destination exists. Ask to create if it doesn't
  if [ ! -d "$DESTINATION" ]; then
    read -rp "Destination does not exist. Create path? [y/n]: " create_path
    if [[ $create_path == "y" ]]; then
      mkdir -p "$DESTINATION" 
      echo "Destination directory created"  
    elif [[ $create_path == "n" ]]; then
      echo "Path not created. Exiting program."
      exit 1
    else
    {
      echo "Error: could not create destination: $DESTINATION"
      exit 1
    }
    fi
  fi

  echo "Destination set as $DESTINATION"

  # Choose file format
  echo -e "----------------------------------------"
  echo -e "${CYAN}1) .mp3${RESET}" 
  echo -e "${BLUE}2) .mp4${RESET}" 
  echo -e "${GREEN}3) .webm${RESET}" 
  echo -e "${PURPLE}4) .flac${RESET}" 
  echo -e "${RED}5) Exit${RESET}" 
  echo
    
  read -rp "Choose video file type: " choise

  case $choise in
      1)
          echo -e "${CYAN}Down audo as mp3...${RESET}"
          yt-dlp -f "bestaudio/best" --extract-audio --audio-format mp3 --audio-quality 0 \
            -o "${DESTINATION}/%(title)s.mp3" "$url" \
          || {
              echo -e "\e[1;31;1mError: Video failed to audio.\e[0m"
              exit 1
          }
          echo -e "${CYAN}Audio saved to $DESTINATION${RESET}"
          break
          ;;
      2)
          echo -e "${BLUE}Downloading video as mp4...${RESET}"
          yt-dlp -f "bv*[ext=mp4][height<=1080]+ba[ext=mp4]/b[ext=mp4]" \
              --merge-output-format mp4 \
              -o "${DESTINATION}/%(title)s.mp4" "$url" \
          || {
              echo -e "\e[1;31;1mError: Video failed to download.\e[0m"
              exit 1
          }
          echo -e "${BLUE}Video saved to $DESTINATION${RESET}"
          break
          ;;
      3)
          echo -e "${GREEN}Downloading video as webm...${RESET}"
          yt-dlp -f "bv*[ext=webm][height<=1080]+ba[ext=webm]/b[ext=webm]" \
              --merge-output-format webm \
              -o "${DESTINATION}%(title)s.webm" "$url" \
          || {
              echo -e "\e[1;31;1mError: Video failed to download.\e[0m"
              exit 1
          }
          echo -e "${GREEN}Video saved to $DESTINATION${RESET}"
          break
          ;;
      4)
          echo -e "${PURPLE}Downloading video as flac...${RESET}"
              yt-dlp -x --audio-format flac\
              -o "${DESTINATION}%(title)s.flac" "$url" \
          || {
              echo -e "\e[1;31;1mError: Audio failed to download.\e[0m"
              exit 1
          }
          echo -e "${PURPLE}Video saved to $DESTINATION${RESET}"
          break
          ;;
      5)
          echo -e "Exited program";
          exit 1
          ;;
      *)
          echo -e "${RED}Invalid Option${RED}";
          exit 1
          ;;
  esac
done
