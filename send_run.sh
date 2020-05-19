#pass .blend
sftp -i "arep-aws-key.pem" ubuntu@ec2-3-92-166-121.compute-1.amazonaws.com << EOF
        put prueba.blend
        quit
EOF
echo "enviada"

#run remote
ssh -i "arep-aws-key.pem" ubuntu@ec2-3-92-166-121.compute-1.amazonaws.com -f 'source /etc/profile; ./run-dataNode.sh prueba.blend caja20' > /dev/null 2>&1 &