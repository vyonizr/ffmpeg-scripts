#!/bin/sh
mkdir -p -- "output"
ffmpeg -ss $1 -i "$2" -to $3 -c copy -copyts output/"$4"