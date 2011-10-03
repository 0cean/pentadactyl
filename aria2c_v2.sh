#!/bin/sh

#Shell script for flashgot with aria2c
#aria2c_v2.sh DIR UFILE CFILE REFERER

#Specify where aria2c executable is
ARIA2C_BIN=/usr/bin/aria2c
 
#All unfinished downloads are saved to this file when aria2c exits.
#Since many aria2c instance can run at the same time, to avoid session
#file is overwritten on the exit of each instance, we use timestamp
#and pid of shell to generate unique enough file name.
SESSION_FILE=$1/session-`date +"%Y-%m-%d-%H:%M:%S-$$"`.txt

#Specify additional command-line options here
ARIA2C_OPTS="--save-session=$SESSION_FILE"

$ARIA2C_BIN $ARIA2C_OPTS --referer="$4" --load-cookie="$3" -d "$1" -i "$2"
#Remove empty session file.
if [ ! -s $SESSION_FILE ]; then
    rm -f $SESSION_FILE
    echo "Removed empty session file."
fi
echo ""
echo "Hit enter to continue"
read x
