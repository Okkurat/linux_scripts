#!/bin/bash

output_directory=
output_screen=
fps=
output_filename="${output_directory}/$(date +'%Y%m%d_%H%M%S').mp4"

# Check if gpu-screen-recorder is running, if yes, kill it
if pgrep -fl "gpu-screen-recorder" > /dev/null; then
    echo "Recording process is already running. Stopping it."
    killall -SIGINT gpu-screen-recorder
    notify-send "Saved recording"

else
    # Start a new recording process
    echo "Recording started."
    notify-send -t 500 "GPU Screen Recorder"
    gpu-screen-recorder -w "${output_screen}" -f "${fps}" -a "$(pactl get-default-sink).monitor" -k h264 -c mp4 -ac aac -o "${output_filename}"
fi
