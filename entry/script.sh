#!/bin/bash
echo  "================================================================"
echo  " _____  _____ _____            _____             _              "
echo  "|  __ \|  __ \_   _|          |  __ \           | |             "
echo  "| |__) | |  | || |    ______  | |  | | ___   ___| | _____ _ __  "
echo  "|  ___/| |  | || |   |______| | |  | |/ _ \ / __| |/ / _ \ '__| "
echo  "| |    | |__| || |_           | |__| | (_) | (__|   <  __/ |    "
echo  "|_|    |_____/_____|          |_____/ \___/ \___|_|\_\___|_|    "
echo  "								       "
echo  "================================================================"

# Settings
#repo?

# Args
arquivo=$1 # get url
param=$2

ext="${arquivo:(-4)}" # get extension

# Vars
etl=/opt/PDI/data-integration/etl

ls /opt/PDI/data-integration/etl

# Get etl
#mkdir -p $etl
#ssh-keyscan -H github.com >> ~/.ssh/known_hosts # this is bad practice
#git clone $src $etl
if [ $ext == .ktr ]; then # transformation
	sh /opt/PDI/data-integration/pan.sh -file=$etl/$arquivo -norepo "$param"
elif [ $ext == .kjb ]; then # job
	sh /opt/PDI/data-integration/kitchen.sh -file=$etl/$arquivo -norepo "$param"
fi
