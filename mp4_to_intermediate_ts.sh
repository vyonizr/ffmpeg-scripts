#!/bin/sh
mkdir -p -- "output"
ffmpeg -i $1 -c copy -bsf:v h264_mp4toannexb -f mpegts output/$2.ts