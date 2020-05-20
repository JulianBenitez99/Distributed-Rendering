#!/bin/bash

echo file part1.mp4 > mylist.txt
echo file part2.mp4 >> mylist.txt
echo file part3.mp4 >> mylist.txt
echo file part4.mp4 >> mylist.txt
ffmpeg -f concat -i mylist.txt -c copy output.mp4
