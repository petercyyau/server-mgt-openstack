##########################################################
# Set CRON
# 0 3 * * * /home/ubuntu/_scripts/mv2cloud.sh> /home/ubuntu/_backups/$(date +\%Y\%m\%d\%H\%M\%S).rc.log 2>&1
##########################################################
#!/bin/bash

rclone move -P /home/ubuntu/_backups/ rc_server_cloud_name:
