while getopts :f:fr:n: options; do
    case $options in
        fr)
            frame=$OPTARG;;
        f)
            file_path=$OPTARG;;
        n)
            name=$OPTARG;;
    esac
done


blender -b $file_path -E CYCLES -f $frame -o "img/$name"

sftp master << EOF
    put img/$name
    quit
EOF
