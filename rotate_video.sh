#!/bin/sh
mkdir -p -- "output"
ffmpeg -i "$1" -vf "transpose=$2" output/"$3"