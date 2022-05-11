#!/bin/bash

script_name=$0
command=$1

# FUNCTIONS
create_txt() {
	numFiles=$1  # first arg to func
	for i in `seq 1 $numFiles`
	do
		name="log${i}.txt"
		echo $name > $name
		echo $script_name >> $name
		echo `date` >> $name
	done
}

# COMMANDS
if [ $command = "--help" ]; then
	echo "Available commands:   --help, --date, --logs"
elif [ $command = "--date" ]; then
	data=`date`
	echo $data
elif [ $command = "--logs" ]; then
	if [ "$2" ]; then
		create_txt $2
	else 
		create_txt 100
	fi
else
	echo "Wrong command"
fi

# UPDATING .GITIGNORE FILE
ls | grep "log" > .gitignore
