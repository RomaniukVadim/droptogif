#!/bin/bash

filepath=$1 # changed to $2 since $1 now contains the working folder


eval $(ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=height,width $filepath)
size=${streams_stream_0_height}

palette="/tmp/palette.png"
filters="fps=15,scale=$size:-1:flags=lanczos"

./ffmpeg -v warning -i $1 -vf "$filters,palettegen" -y $palette
./ffmpeg -v warning -i $1 -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $2
