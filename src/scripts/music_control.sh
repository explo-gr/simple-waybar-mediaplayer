#!/bin/bash

# 🙏 May we never manually manage MPRIS state again.

# preferred > ignored > unspecified
preferred_players=("harmonoid" "mpv" "vlc" "spotify" "rhythmbox")
ignored_players=("firefox" "chromium" "chrome" "brave")

available_players=($(playerctl -l 2>/dev/null))
selected_player=""
command="$1"

# Validate command
case "$command" in
    play|pause|play-pause|next|previous)
        ;;
    *)
        echo "Usage: $0 [play|pause|play-pause|next|previous]"
        exit 1
        ;;
esac

# Function to check if a player is available and has a valid status
check_player_status() {
    local player="$1"
    local status=$(playerctl -p "$player" status 2>/dev/null)
    if [[ "$status" == "Playing" || "$status" == "Paused" ]]; then
        return 0
    fi
    return 1
}

# 1. Try preferred players
for player in "${preferred_players[@]}"; do
    if [[ " ${available_players[*]} " == *" $player "* ]] && check_player_status "$player"; then
        selected_player="$player"
        break
    fi
done

# 2. Try ignored players
if [[ -z "$selected_player" ]]; then
    for player in "${available_players[@]}"; do
        for ignore in "${ignored_players[@]}"; do
            if [[ "$player" == "$ignore"* ]] && check_player_status "$player"; then
                selected_player="$player"
                break 2
            fi
        done
    done
fi

# 3. Try any other remaining players
if [[ -z "$selected_player" ]]; then
    for player in "${available_players[@]}"; do
        skip=false
        for known in "${preferred_players[@]}" "${ignored_players[@]}"; do
            if [[ "$player" == "$known"* ]]; then
                skip=true
                break
            fi
        done
        $skip && continue

        if check_player_status "$player"; then
            selected_player="$player"
            break
        fi
    done
fi

# Send command if a player was found
if [[ -n "$selected_player" ]]; then
    playerctl -p "$selected_player" "$command"
    # Update Signal
    pkill -SIGRTMIN+8 waybar
else
    echo "No active media player found."
    exit 1
fi