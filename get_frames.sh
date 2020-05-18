#!/bin/bash


frames=$(blender -b Blender3.blend -P test.py | grep "^[0-9]* [0-9]*$")
start_frame=$(echo $frames | cut -d' ' -f1)
end_frame=$(echo $frames | cut -d' ' -f2)
echo $start_frame
echo $end_frame