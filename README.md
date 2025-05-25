# Simple Waybar Mediaplayer

A simple mediaplayer module for waybar written with **bash** that primarily relies on **playerctl**. *It's recommended to also install mpv-mpris for compatibility with mpv-based players.*

You can fork it if you feel like it

## Requirements
- Waybar
- Playerctl
- Nerdfonts *for displaying icons*


## Features
- Different priorities for different players
	> (1) preferred_players=("harmonoid"  "mpv"  "vlc"  "spotify"  "rhythmbox") \
	> (2) ignored_players=("firefox"  "chromium"  "chrome"  "brave") \
	> (3) anything not in either (1) or (2) \
	> *I know 'ignored' is a stupid name but I won't bother changing it* \
	> Manually edit the priorities in `music_control.sh` and `music_player.sh`

- Clicking the module pauses the song
- Doubleclicking the module skips the song
- Different icons/backgrounds for each player \
![Generic Browser](https://github.com/explo-gr/simple-waybar-mediaplayer/blob/main/showcase/firefox.png) \
![Generic Browser](https://github.com/explo-gr/simple-waybar-mediaplayer/blob/main/showcase/mpv.png) \
![Generic Browser](https://github.com/explo-gr/simple-waybar-mediaplayer/blob/main/showcase/vlc.png)
- A tooltip displaying various metadata \
![Generic Browser](https://github.com/explo-gr/simple-waybar-mediaplayer/blob/main/showcase/song_information.png)

*The code is very easily expandable so feel free to do whatever you want with it*

## Caveats
- The music player updates on an interval unless the music is manually stopped
This means the module will lag behind a couple of seconds after the media changed
- Only information about *one* player can be displayed at a time
