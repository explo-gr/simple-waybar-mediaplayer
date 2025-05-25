#!/bin/bash

# 🙏 Thank the gods of prompt engineering that I shall never touch bash scripting

# preferred > ignored > unspecified
preferred_players=("harmonoid" "mpv" "vlc" "spotify" "rhythmbox")
ignored_players=("firefox" "chromium" "chrome" "brave")
available_players=($(playerctl -l 2>/dev/null))

selected_player=""

# Function to check player status
check_player_status() {
    local player="$1"
    local status=$(playerctl -p "$player" status 2>/dev/null)
    if [[ "$status" == "Playing" || "$status" == "Paused" ]]; then
        echo "$status"
        return 0
    fi
    return 1
}

# 1. Try preferred players
for player in "${preferred_players[@]}"; do
    if [[ " ${available_players[*]} " == *" $player "* ]]; then
        status=$(check_player_status "$player")
        if [[ $? -eq 0 ]]; then
            selected_player="$player"
            break
        fi
    fi
done

# 2. Try ignored players (as second priority)
if [[ -z "$selected_player" ]]; then
    for player in "${available_players[@]}"; do
        for ignore in "${ignored_players[@]}"; do
            if [[ "$player" == "$ignore"* ]]; then
                status=$(check_player_status "$player")
                if [[ $? -eq 0 ]]; then
                    selected_player="$player"
                    break 2
                fi
            fi
        done
    done
fi

# 3. Try remaining (unspecified) players
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

        status=$(check_player_status "$player")
        if [[ $? -eq 0 ]]; then
            selected_player="$player"
            break
        fi
    done
fi

# Output metadata if a valid player is found
if [[ -n "$selected_player" ]]; then
    status=$(playerctl -p "$selected_player" status 2>/dev/null)
    title=$(playerctl -p "$selected_player" metadata title 2>/dev/null | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')
    artist=$(playerctl -p "$selected_player" metadata artist 2>/dev/null | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')
    album=$(playerctl -p "$selected_player" metadata album 2>/dev/null | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')
    length=$(playerctl -p "$selected_player" metadata mpris:length 2>/dev/null)

    # Convert microseconds to mm:ss
    if [[ -z "$length" || "$length" -eq 0 ]]; then
        duration="N/A"
    else
        duration=$(awk "BEGIN {print int($length / 60000000) \":\" sprintf(\"%02d\", int(($length / 1000000) % 60))}")
    fi

    status_class=$(echo "$status" | tr '[:upper:]' '[:lower:]')

    case "$selected_player" in
        spotify) icon=""; player_class="spotify" ;;
        *firefox*) icon="󰈹"; player_class="browser" ;;
        *chromium*|*chrome*|*brave*) icon="󰖟" player_class="browser" ;;
        vlc) icon="󰕼"; player_class="vlc" ;;
        mpv) icon=""; player_class="mpv" ;;
        harmonoid) icon="󰓃"; player_class="harmonoid" ;;
        *) icon="🎜"; player_class="generic" ;;
    esac

    jq -c -n --arg icon "$icon" --arg title "$title" --arg artist "$artist" --arg album "$album" --arg duration "$duration" --arg player_class "$player_class" --arg status_class "$status_class" '{
        text: ($icon + " " + $title),
        tooltip: ("🎜 " + $title + "\n󰀄 " + $artist + "\n󰀥 " + $album + "\n󱎫 " + $duration),
        class: [$player_class, $status_class]
    }'
else
    echo -n "{}"
fi