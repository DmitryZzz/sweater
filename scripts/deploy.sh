#!/usr/bin/env bash

mvn clean package

echo 'Copying files...'

scp -i "C:\_tmp\AWS\AWS.pem" \
    target/sweater-0.0.1-SNAPSHOT.jar \
    ubuntu@ec2-3-142-20-170.us-east-2.compute.amazonaws.com:/home/ubuntu

echo 'Restarting server...'

ssh -i "C:\_tmp\AWS\AWS.pem" ubuntu@ec2-3-142-20-170.us-east-2.compute.amazonaws.com << EOF

pgrep java | xargs kill -9
nohup java -jar sweater-0.0.1-SNAPSHOT.jar > log.txt &

EOF

echo 'Bye'