#!/bin/sh
mkdir -p -- "output"
ffmpeg -i "$2" -ss $1 -to $3 -acodec libmp3lame -vcodec libx264 output/"$4"