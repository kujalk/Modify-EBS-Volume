#!/bin/bash

#Requirements -
# [1] Make ure you have aws cli installed and configured the region
# [2] sudo yum install jq -y

log_message()
{
    echo "$(date) :: [$1] :: [$2]"
}

all_volumes=$(aws ec2 describe-volumes --filters Name=volume-type,Values=gp3 | jq -r '.Volumes[].VolumeId')

for volume in $all_volumes
do
    log_message "INFO" "Working on $volume"

    error_output=$(aws ec2 modify-volume --volume-id $volume --volume-type gp2 2>&1 )

    if [ $? -eq 0 ]
    then
        log_message "INFO" "Successfully modified volume"
    else
        log_message "ERROR" "Failed modifying volume :: $error_output"
    fi
done
