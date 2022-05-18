#!/bin/bash

script_name=$0
command=$1

# FUNCTIONS
create_txt() {
	type=$1      # type of file: log or error
	numFiles=$2  # 2d arg to func
	for i in `seq 1 $numFiles`
	do
		name="$type${i}"
		filen="$name/$name.txt"
		if [ ! -e $name ]; then    # if the dir already exists, just overwrite the txt inside it.
			mkdir $name
		fi

		echo $filen > $filen
		echo $script_name >> $filen
		echo `date` >> $filen
	done
}

# COMMANDS
if [ $command = "--help" ] || [ $command = "-h" ]; then
	echo "Available commands:   --help / -h, --date / -d, --logs / -l, --error / -e, --init"
elif [ $command = "--date" ] || [ $command = "-d" ]; then
	data=`date`
	echo $data
elif [ $command = "--logs" ] || [ $command = "-l" ]; then
	if [ "$2" ]; then
		create_txt "log" $2
	else
		create_txt "log" 100
	fi
elif [ $command = "--error" ] || [ $command = "-e" ]; then
	if [ "$2" ]; then
		create_txt "error" $2
	else
		create_txt "error" 100
	fi
elif [ $command = "--init" ]; then
	if [ "$2" ]; then
		git clone $2   # if the name of repo is given at start
		export PATH=$PATH:$PWD
	else 
		echo "No repo name is given" 
	fi

else
	echo "Wrong command"
fi

# UPDATING .GITIGNORE FILE
ls | grep "log" > .gitignore
ls | grep "error" >> .gitignore
