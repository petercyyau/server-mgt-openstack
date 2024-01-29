##########################################################
# Set CRON
# 0 3 * * * /home/ubuntu/_scripts/docker2tar.sh > /home/ubuntu/_backups/$(date +\%Y\%m\%d\%H\%M\%S).bk.log 2>&1
##########################################################

#!/bin/bash

#TODO change to scan directory
regular_list=(
	"_scripts"
)

function regular2tar(){
	_array=("$1")
	for i in ${_array[@]};
		do
			echo === REGULAR2TAR "$i"
			#declare variables
			dt=$(date '+%Y%m%d%H%M')
			path=/home/ubuntu
			fn="$i"_$dt

			#01 tar
			cd $path
			sudo tar -zcvf $path/_backups/$fn.tar.gz $path/"$i" > $path/_backups/$fn.log

			#02 chown
			cd $path/_backups
			sudo chown -R ubuntu:ubuntu $fn.tar.gz
			sudo chown -R ubuntu:ubuntu $fn.log
		done
		echo === COMPLETE
}

function pause5sec(){
	SEC=3
        for ((i = $SEC; i > 0; i--)); do
            printf "Start in %1s seconds\n" "$i"
            sleep 1
        done
	echo "Start now!"
}

if [ $# -eq 0 ]
  then
    echo "=== Target: regular_list"
		pause5sec
		regular2tar "$(echo ${regular_list[@]})"
elif [ $# -eq 1 ]
	then
    echo "=== Target: $1"
		pause5sec
		a=("$1")
		regular2tar "${a[@]}"
else
    echo "Too many arguments supplied"
fi
