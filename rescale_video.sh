#!/bin/sh
mkdir -p -- "output"
ffmpeg -i $1 -vf scale=-2:$2 output/"$3"