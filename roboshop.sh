#!/bin/bash

AMI_ID="09c813fb71547fc4f"
SG_ID="sg-08bed850ebb359b45" #replace with your sg id 

for instance in $@
do
   INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t3.micro --security-group-ids sg-08bed850ebb359b45 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)

    if [ $instance != "frontend"]; then 
        IP=$(aws ec2 describe-instances --instance-ids i-0d7783e53c63b97fd --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
    else
       IP=$(aws ec2 describe-instances --instance-ids i-0d7783e53c63b97fd --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)  
    fi

    echo $instance:"$IP"
done