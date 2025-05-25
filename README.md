# Simple Waybar Mediaplayer

A simple mediaplayer module for waybar written with **bash** that primarily relies on **playerctl** \
You can fork it if you feel like it 👍

## Requirements
- Waybar
- `playerctl` to handle media
- any **Nerdfont** for displaying icons
- (optional) `mpv-mpris` for compatibility with mpv-based players


## Features
- Different priorities for different players
	> Manually edit the priorities in `music_control.sh` and `music_player.sh` \
	> Priorities go as follows: anything else < ignored < preferred
	>> preferred_players=("harmonoid"  "mpv"  "vlc"  "spotify"  "rhythmbox") \
	>> ignored_players=("firefox"  "chromium"  "chrome"  "brave") \

- Clicking the module pauses/resumes the song \
	</br> <img src="https://github.com/explo-gr/simple-waybar-mediaplayer/blob/main/showcase/pause_resume.gif" alt="Pause and Resume" width="410"> </br>
- Doubleclicking the module skips the song
- Different icons/backgrounds for each player \
	</br> <img src="https://github.com/explo-gr/simple-waybar-mediaplayer/blob/main/showcase/firefox.png" alt="Firefox" width="410">
	</br> <img src="https://github.com/explo-gr/simple-waybar-mediaplayer/blob/main/showcase/mpv.png" alt="Mpv" width="410">
	</br> <img src="https://github.com/explo-gr/simple-waybar-mediaplayer/blob/main/showcase/vlc.png" alt="Vlc" width="410"> </br>
- A tooltip displaying various metadata \
	</br> <img src="https://github.com/explo-gr/simple-waybar-mediaplayer/blob/main/showcase/song_information.png" alt="Metadata"  width="410"> </br>
- Easily expandable with little to no sripting required

## Installation
- Append the module in `src/config.jsonc` to your waybar config
- Move the scripts from `src/scripts` into your config folder and adjust file paths if needed
- Append the sample styles listed in `src/style.css` to your waybar style config
- Customize the script as you see fit

## Caveats
- The music player updates on an interval (unless the music is manually stopped) \
This means the module will lag behind a couple of seconds after the media changed
- Only information about *one* player can be displayed at a time
