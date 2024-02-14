!/bin/bash

# Directory for icons
iDIR="$HOME/.config/swaync/icons"

# Note: You can add more options below with the following format:
# ["TITLE"]="link"

# Define menu options as an associative array
declare -A menu_options=(
  ["Dua Lipa"]="https://www.youtube.com/playlist?list=PLb4rrihfzrq0DdeOAXnnk3rR2eQyfWBGQ"
  ["00s"]="https://www.youtube.com/playlist?list=PL6Lt9p1lIRZ311J9ZHuzkR5A3xesae2pk"
  ["90s"]="https://www.youtube.com/playlist?list=PLD58ECddxRngHs9gZPQWOCAKwV1hTtYe4"
  ["80s"]="https://www.youtube.com/playlist?list=PLd9auH4JIHvupoMgW5YfOjqtj6Lih0MKw"
  ["Head Fuck"]="https://www.youtube.com/playlist?list=PLOUzUrKhNae6JqXAjG56Akc79vuzYCOYz"
)

# Function for displaying notifications
notification() {
	notify-send -u normal -i "$iDIR/music.png" "Playing now: $@"
}

# Main function
main() {
  choice=$(printf "%s\n" "${!menu_options[@]}" | rofi -dmenu -config ~/.config/rofi/config.rasi -i -p "")

  if [ -z "$choice" ]; then
    exit 1
  fi

  link="${menu_options[$choice]}"

  notification "$choice"
  
  # Check if the link is a playlist
  if [[ $link == *playlist* ]]; then
    mpv --shuffle --vid=no "$link"
  else
    mpv "$link"
  fi
}
pkill mpv && notify-send -u low -i "$iDIR/music.png" "Online Music stopped" || main
# Check if an online music process is running and send a notification, otherwise run the main function
