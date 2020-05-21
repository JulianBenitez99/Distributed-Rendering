#!/bin/bash

while getopts :f:x: options; do
    case $options in
        f)
            file_path=$OPTARG;;
        x)
            frame=$OPTARG;;
    esac
done

blender -b "$file_path" -o "/home/ubuntu/img/render_" -E CYCLES -f $frame -F PNG

sftp master << EOF
    cd /home/ubuntu/img
    put /home/ubuntu/img/*$frame.png
    quit
EOF

rm -f /home/ubuntu/img/*.png

# Example
# ./run-image.sh -f /home/ubuntu/test.blend -x 10
# f - file 
# x - frame to render
