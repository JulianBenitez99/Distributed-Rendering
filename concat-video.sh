#!/bin/bash

VPATH=/home/ubuntu/videos

if [ -f "$VPATH/part1.mp4" ] && [ -f "$VPATH/part2.mp4" ] && [ -f "$VPATH/part3.mp4" ] && [ -f "$VPATH/part4.mp4" ]
then
    echo file "$VPATH/part1.mp4" >  "$VPATH/mylist.txt"
    echo file "$VPATH/part2.mp4" >> "$VPATH/mylist.txt"
    echo file "$VPATH/part3.mp4" >> "$VPATH/mylist.txt"
    echo file "$VPATH/part4.mp4" >> "$VPATH/mylist.txt"
    ffmpeg -f concat -i "$VPATH/mylist.txt" -c copy "$VPATH/output.mp4"
    mv "$VPATH/output.mp4" /home/ubuntu/rendered-projects
    rm -f /home/ubuntu/videos/part*.mp4
fi

