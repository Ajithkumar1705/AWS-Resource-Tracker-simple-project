#!/bin/bash
##################
#Project : AWS-Resource-Tracker
#Author : Ajith Kumar E
#Date : 06-06-2026
#Version : v1.0.0
#
#################
#
#
# Description:
# This script monitors AWS resources using AWS CLI and collects inventory
# information for EC2 instances, S3 buckets, Lambda functions, IAM users,
# VPCs, and Security Groups. It compares the current resource count with
# previous runs, logs the results, and sends email notifications when
# resource changes are detected.
#
# Technologies: Bash, AWS CLI
CURRENT_FILE="current_counts.txt"
PREVIOUS_FILE="previous_counts.txt"
LOG_FILE="log/aws_resource_tracker.log"
{
	echo "executed at $(date)"
#list EC2 Instances

echo " EC2 - Instances list "
aws ec2 describe-instances

#list s3 buckets

echo " S3-Buckets List "
aws s3 ls

#list lambda functions

echo "lambda-function list "
aws lambda list-functions

#list IAM users

echo " IAM-User list"
aws iam list-users

#list VPCs

echo "List of VPCs"
aws ec2 describe-vpcs

#List security groups

echo " List of Security groups"
aws ec2 describe-security-groups

} >> "$LOG_FILE"


EC2_COUNT=$(aws ec2 describe-instances --query "length(Reservations[].Instances[])" --output text)

S3_COUNT=$(aws s3api list-buckets --query "length(Buckets)" --output text)

LAMBDA_COUNT=$(aws lambda list-functions --query "length(Functions)" --output text)

IAM_COUNT=$(aws iam list-users --query "length(Users)" --output text)

VPC_COUNT=$(aws ec2 describe-vpcs --query "length(Vpcs)" --output text)

SG_COUNT=$(aws ec2 describe-security-groups --query "length(SecurityGroups)" --output text)

#update the file

cat > "$CURRENT_FILE" << EOF
EC2=$EC2_COUNT
S3=$S3_COUNT
LAMBDA=$LAMBDA_COUNT
IAM=$IAM_COUNT
VPC=$VPC_COUNT
SG=$SG_COUNT
EOF

#handle first run

if [ ! -f "$PREVIOUS_FILE" ]; then
    cp "$CURRENT_FILE" "$PREVIOUS_FILE"
    echo "Baseline created."
    exit 0
fi


#Email Notification

TOPIC_ARN="arn:aws:sns:ap-south-1:666432071447:aws-resource-tracker-alerts"

if ! diff "$PREVIOUS_FILE" "$CURRENT_FILE" > /dev/null; then

    CHANGES=$(diff "$PREVIOUS_FILE" "$CURRENT_FILE")

    aws sns publish \
        --topic-arn "$TOPIC_ARN" \
        --subject "AWS Resource Change Detected" \
        --message "Changes detected on $(date)

$CHANGES

Current Inventory:
$(cat $CURRENT_FILE)"
fi


#Update previous file

cp "$CURRENT_FILE" "$PREVIOUS_FILE"

