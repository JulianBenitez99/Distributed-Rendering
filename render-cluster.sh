#!/bin/bash

animation=false
nodes=4

function send_file {

sftp "node$i" << EOF
    put $file_path
    quit
EOF

echo "File sent to node$i"
}

function process_animation {
    ssh "node$i" -f "source /etc/profile; AREP-PROJECT/run-animation.sh -s $init -e $end -f $file_path -x 3 -n part$i" > /dev/null 2>&1 &
    echo "node$i is rendering animation"
}

function process_image {
    ssh "node$i" -f "source /etc/profile; AREP-PROJECT/run-image.sh -f $file_path -x $frame" > /dev/null 2>&1 &
    echo "node$i rendering image"
}

function split {
    total="$(($end_frame - $start_frame + 1))"
    fragment="$(($total / $nodes))"
    mod="$(($total % $nodes))"
    init=$start_frame
    end=0
    for (( i=1; i<=$nodes; i++ ))
    do
        # init ok
        if (($i == $nodes))
        then
            end="$(($fragment * $i + $mod))"
        else
            end="$(($fragment * $i))"
        fi
        end="$(($end + $start_frame - 1))"
        # end ok
        
        send_file
        process_animation

        # send run
        init="$(($end+1))"
    done

} 



while getopts :as:e:f:x: options; do
    case $options in
        a)
            animation=true;;
        s)
            start_frame=$OPTARG;;
        e)
            end_frame=$OPTARG;;
        f)
            file_path=$OPTARG;;
        x)
        |   frame=$OPTARG;;
    esac
done

if [ -z "${file_path+x}" ]
then
    echo "Not file"
else
if $animation
then
    # existe start frame y no existe end frame
    if [ ! -z "${start_frame+x}" ] && [ -z "${end_frame+x}" ]
    then
        echo "End frame is unset"
    else
    # existe end frame y no existe start frame
    if [ -z "${start_frame+x}" ] && [ ! -z "${end_frame+x}" ]
    then
        echo "Start frame is unset"
    else
    # no hay (auto)
    if [ -z "${start_frame+x}" ] && [ -z "${end_frame+x}" ]
    then
        frames=$(blender -b $file_path -P get_frames.py -noaudio | grep "^[0-9]* [0-9]*$")
        start_frame=$(echo $frames | cut -d' ' -f1)
        end_frame=$(echo $frames | cut -d' ' -f2)
        split
    else
    # usa ambos
    if [ ! -z "${start_frame+x}" ] && [ ! -z "${end_frame+x}" ]
    then
        echo "Using start frame: $start_frame, end frame: $end_frame"
        split
    fi
    fi
    fi
    fi
else
    i=1
    send_file
    process_image
fi
fi

# Example
# animation mode
#   ./render-cluster -a -s 1 -e 10 -f /home/ubuntu/blend_file.blend
# image mode
#   ./render-cluster -f /home/ubuntu/blend_file.blend -x 10
# Params
# a - Animation mode
# s - Start frame (for animation)
# e - End frame (for animation)
# f - Blender file path (required)
# x - Frame (for image)
