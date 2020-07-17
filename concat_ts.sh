#!/bin/sh
mkdir -p -- "output"
ffmpeg -i "concat:$1" -c copy -bsf:a aac_adtstoasc output/$2