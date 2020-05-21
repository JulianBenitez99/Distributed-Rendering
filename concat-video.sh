#!/bin/bash

PATH=/home/ubuntu/videos

if [ -f "$PATH/part1.mp4" ] && [ -f "$PATH/part2.mp4" ] && [ -f "$PATH/part3.mp4" ] && [ -f "$PATH/part4.mp4" ]
then
    echo file part1.mp4 > mylist.txt
    echo file part2.mp4 >> mylist.txt
    echo file part3.mp4 >> mylist.txt
    echo file part4.mp4 >> mylist.txt
    ffmpeg -f concat -i mylist.txt -c copy output.mp4
    mv output.mp4 /home/ubuntu/rendered-projects
    rm -f /home/ubuntu/videos/part*.mp4
fi

