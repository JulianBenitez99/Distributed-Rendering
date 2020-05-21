#!/bin/bash

while getopts :s:e:f:n:x: options; do
    case $options in
        s)
            start_frame=$OPTARG;;
        e)
            end_frame=$OPTARG;;
        f)
            file_path=$OPTARG;;
        n)
            video_name=$OPTARG;;
        x)
            frame_rate=$OPTARG;;
    esac
done

blender -b $file_path  -o /home/ubuntu/frames/ -E CYCLES -s $start_frame -e $end_frame -t 2 -a -F PNG

ffmpeg -framerate $frame_rate -pattern_type glob -i '/home/ubuntu/frames/*.png' "/home/ubuntu/videos/$video_name.mp4"

sftp master << EOF
    cd /home/ubuntu/videos
    put /home/ubuntu/videos/$video_name.mp4
    quit
EOF

rm -f /home/ubuntu/frames/*.png
rm -f /home/ubuntu/videos/*.mp4
rm -f /home/ubuntu/*.blend

# Example
# ./run-animation.sh -s 23 -e 270 -f /home/ubuntu/prueba.blend -n part1 -x 20
# s - Start frame
# e - End frame
# f - File path
# n - Video name
# x - Video frame rate
