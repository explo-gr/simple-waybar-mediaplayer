#!/bin/bash

# Get all core temps from `sensors`
temps=$(sensors | grep '^Core ' | awk '{gsub(/[+°C]/,"",$3); print $3}')

# Calculate average
avg=$(echo "$temps" | awk '{sum+=$1} END {if (NR>0) print sum/NR; else print 0}')

# Define icon based on temperature
if (( $(echo "$avg < 45" | bc -l) )); then
    icon=""  # Cool
elif (( $(echo "$avg < 65" | bc -l) )); then
    icon=""  # Warm
elif (( $(echo "$avg < 80" | bc -l) )); then
    icon=""  # Hot
else
    icon=""  # Overheating
fi

# Output for Waybar
printf "%.1f°C %s\n" "$avg" "$icon"