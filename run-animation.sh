while getopts :s:e:f:n:fr: options; do
    case $options in
        s)
            start_frame=$OPTARG;;
        e)
            end_frame=$OPTARG;;
        f)
            file_path=$OPTARG;;
        n)
            video_name=$OPTARG;;
        fr)
            frame_rate=$OPTARG;;
    esac
done

blender -b $file_path -E CYCLES -s $start_frame -e $end_frame -t 1 -a

ffmpeg -framerate $frame_rate -pattern_type glob -i '*.jpg' "videos/$video_name"

