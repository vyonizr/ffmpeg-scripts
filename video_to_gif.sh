#!/bin/sh
mkdir -p -- "output"
ffmpeg -i $1 \
  -vf "fps=10,scale=360:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
  -loop 0 $1.gif \