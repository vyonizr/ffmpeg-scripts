#!/bin/sh
mkdir -p -- "output"
ffmpeg -i "$1" -vf setsar=1:1 output/$2.webm