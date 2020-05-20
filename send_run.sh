#pass .blend
sftp -i "arep-aws-key.pem" ubuntu@ec2-3-92-166-121.compute-1.amazonaws.com << EOF
        put prueba.blend
        quit
EOF
echo "enviada"

#run remote
ssh -i "arep-aws-key.pem" ubuntu@ec2-3-92-166-121.compute-1.amazonaws.com -f 'source /etc/profile; ./run-dataNode.sh prueba.blend caja20' > /dev/null 2>&1 &

sftp "node$i" << EOF
        put $file_path
        quit
EOF


ssh "node$i" -f "source /etc/profile; ./run-animation.sh -s $start_frame -e $end_frame -f $file_path -fr 20 -n part$i" > /dev/null 2>&1 &
