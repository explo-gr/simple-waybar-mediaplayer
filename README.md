# Simple Waybar Mediaplayer

A simple mediaplayer module for waybar written with **bash** that primarily relies on **playerctl** \
*It's recommended to also install `mpv-mpris` for compatibility with mpv-based players*

You can fork it if you feel like it

## Requirements
- Waybar
- Playerctl
- Nerdfonts *for displaying icons*


## Features
- Different priorities for different players
	> Manually edit the priorities in `music_control.sh` and `music_player.sh` \
	> Priorities go as follows: anything else < ignored < preferred
	>> preferred_players=("harmonoid"  "mpv"  "vlc"  "spotify"  "rhythmbox") \
	>> ignored_players=("firefox"  "chromium"  "chrome"  "brave") \

- Clicking the module pauses/resumes the song \
	</br> <img src="https://github.com/explo-gr/simple-waybar-mediaplayer/blob/main/showcase/pause_resume.gif" width="410"> </br>
- Doubleclicking the module skips the song
- Different icons/backgrounds for each player \
	</br> <img src="https://github.com/explo-gr/simple-waybar-mediaplayer/blob/main/showcase/firefox.png" width="410">
	</br> <img src="https://github.com/explo-gr/simple-waybar-mediaplayer/blob/main/showcase/mpv.png" width="410">
	</br> <img src="https://github.com/explo-gr/simple-waybar-mediaplayer/blob/main/showcase/vlc.png" width="410"> </br>
- A tooltip displaying various metadata \
	</br> <img src="https://github.com/explo-gr/simple-waybar-mediaplayer/blob/main/showcase/song_information.png" width="410"> </br>

## Installation
- Append the module in `src/config.jsonc` to your waybar configuration
- Move the scripts from `src/scripts` into your config and adjust file paths if needed
- Append the sample styles listed in `src/style.css` to your waybar configuration
- Customize the script as you see fit

## Caveats
- The music player updates on an interval (unless the music is manually stopped) \
This means the module will lag behind a couple of seconds after the media changed
- Only information about *one* player can be displayed at a time
