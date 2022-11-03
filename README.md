# :scroll: FFMPEG Scripts

Outputs are placed inside `output` directory. The folder creates itself if it does not exist.

## Prerequisites

Make sure FFmpeg is already installed on your system (download [here](https://ffmpeg.org/)).

| Action | Script | Usage  |
| - | - | - |
| [Convert video or audio](#twisted_rightwards_arrows-convert-video-or-audio) | `converter.sh` | `./converter.sh input.mkv output_converted.mp4` |
| [Concatenate MP4 videos](#link-concatenate-mp4-videos) | Multiple scripts | Refer to the details |
| [Convert GIF to web-optimized MP4 and WEBM](#twisted_rightwards_arrows-convert-gif-to-web-optimized-mp4-and-webm) | `gif_to_video.sh` | `./gif_to_video.sh input.gif output_web` |
| [Convert video to GIF](#twisted_rightwards_arrows-convert-video-to-gif) | `video_to_gif.sh` | `./video_to_gif.sh input.mp4 output` |
| [Convert video to WEBM](#twisted_rightwards_arrows-convert-video-to-webm) | `webm_converter.sh` | `./webm_converter.sh input.mp4 output` |
| [Rescale video](#arrow_up_down-rescale-video) | `rescale_video.sh` | `./rescale_video.sh input.mp4 360 output_rescale.mp4` |
| [Rotate Video](#arrows_counterclockwise-rotate-video) | `rotate_video.sh` | `./rotate_video.sh input.mp4 output` |
| [Trim video](#scissors-trim-video) | `trim_video.sh` | <ul><li>`./trim_video.sh 00:03:26 input.mp4 00:05:46 output_trimmed.mp4` (in seconds)</li><li>`./trim_video.sh 00:03:26.265 input.mp4 00:05:46.197 output_trimmed.mp4` (in miliseconds)</li></ul>|

### :twisted_rightwards_arrows: Convert video or audio

```shell
./converter.sh <1> <2>
```

- `1`: File to convert
- `2`: The file with expected format

#### Example

```shell
./converter.sh input.mkv output_converted.mp4
# What it does
ffmpeg -i input.mkv output/output_converted.mp4
```

[Move to top](#scroll-ffmpeg-scripts)

### :arrow_up_down: Rescale video

Rescales video while maintaining its aspect ratio

```shell
./rescale_video.sh <1> <2> <3>
```

- `1`: file to convert
- `2`: expected height in pixels
- `3`: output file

#### Example

```shell
./converter.sh input.mp4 360 output_rescaled.mp4
# What it does
ffmpeg -i input.mp4 -vf scale=-2:360 output/"output_rescaled.mp4"
```

[Move to top](#scroll-ffmpeg-scripts)

### :scissors: Trim video

```shell
./trim_video.sh <1> <2> <3> <4>
```

- `1`: seek start with `HH:MM:SS.mmm`* format
- `2`: input file
- `3`: seek end with `HH:MM:SS.mmm`* format
- `4`: output file

*H: hours, M: minutes, S: seconds, mmm (optional): miliseconds

#### Example

```shell
./trim_video.sh 00:03:26 input.mp4 00:05:46 output_trimmed.mp4
# What it does
ffmpeg -ss 00:03:26 -i "input.mp4" -to 00:05:46 -c copy -copyts output/"output_trimmed.mp4"
```

[Move to top](#scroll-ffmpeg-scripts)

### :link: Concatenate MP4 videos

Do the following:
1. [Convert MP4 to transport streams](#convert-mp4-to-transport-streams)
2. [Concatenate transport streams](#concatenate-transport-streams)

[Move to top](#scroll-ffmpeg-scripts)

###	Convert MP4 to transport streams
```shell
./mp4_to_intermediate_ts.sh <1> <2>
```

- `1`: MP4 input file
- `2`: output name (without extension)

#### Example

```shell
./mp4_to_intermediate_ts.sh input.mp4 output_intermediate
# What it does
ffmpeg -i input.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts output/output_intermediate.ts
```

[Move to top](#scroll-ffmpeg-scripts)

### Concatenate transport streams

```shell
./concat_ts.sh <1> <2>
```

- `1`: transport streams to concacenate, separated with "|". Example: `"intermediate_1.ts|intermediate_2.ts"`
- `2`: output file

#### Example

```shell
./concat_ts.sh "intermediate_1.ts|intermediate_2.ts|intermediate_3.ts" output_concatenated.mp4
# What it does
ffmpeg -i "concat:intermediate_1.ts|intermediate_2.ts|intermediate_3.ts" -c copy -bsf:a aac_adtstoasc output/output_concatenated.mp4
```

[Move to top](#scroll-ffmpeg-scripts)


### :twisted_rightwards_arrows: Convert GIF to web-optimized MP4 and WEBM

This action creates two different files; MP4 and WEBM. Implementation: [Replace animated GIFs with video for faster page loads](https://web.dev/replace-gifs-with-videos/)

```shell
./trim_video.sh <1> <2>
```

- `1`: GIF input file
- `2`: output name (without extension)

#### Example

```shell
./gif_to_video.sh input.gif output_web
# What it does
ffmpeg -i input.gif -b:v 0 -crf 25 -f mp4 -vcodec libx264 -pix_fmt yuv420p output/output_web.mp4
ffmpeg -i input.gif -c vp9 -b:v 0 -crf 41 output/output_web.webm
```

[Move to top](#scroll-ffmpeg-scripts)

### :twisted_rightwards_arrows: Convert video to GIF

```shell
./video_to_gif.sh <1> <2>
```

- `1`: input video file
- `2`: output name (without extension)

#### Example

```shell
./video_to_gif.sh input.mp4 output
# What it does
ffmpeg -i "input.mp4" \
  -vf "fps=10,scale=360:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
  -loop 0 output.gif \
```

[Move to top](#scroll-ffmpeg-scripts)


### :twisted_rightwards_arrows: Convert video to WEBM

```shell
./webm_converter.sh <1> <2>
```

- `1`: input file
- `2`: output name (without extension)

#### Example

```shell
./webm_converter.sh input.mp4 output
# What it does
ffmpeg -i "input.mp4" -vf setsar=1:1 output/output.webm
```

[Move to top](#scroll-ffmpeg-scripts)

### :arrows_counterclockwise: Rotate Video

```shell
./rotate_video.sh <1> <2> <3>
```

- `1`: input file
- `2`: refer to [Rotate Mode](#rotate-mode)
- `3`: output name (without extension)

#### Rotate Mode
```
0 = 90° counter-clockwise and vertical flip
1 = 90° clockwise
2 = 90° counter-clockwise
3 = 90° clockwise and vertical flip
```

#### Example

```shell
./rotate_video.sh input.mp4 1 output
# What it does
ffmpeg -i "input.mp4" -vf "transpose=1" output/"output.mp4"

```

[Move to top](#scroll-ffmpeg-scripts)
