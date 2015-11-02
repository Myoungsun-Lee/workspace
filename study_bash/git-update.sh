#! /bin/bash

SRC_DIR=$(pwd)
LOG_DIR=$SRC_DIR/log

<<COMMENT
cd $LOG_DIR
if [ `pwd` != "$LOG_DIR" ]; then
	echo "log directory doesn't exist, so make directory."
	mkdir $SRC_DIR/log
fi
cd $SRC_DIR
ls > $LOG_DIR/log
COMMENT

for file in */ ;
do
	echo -e "We are in $file";
	cd $SRC_DIR/$file

	if [ -d $SRC_DIR/$file/.git ]; then
		git remote update \-\-prune; git branch; git pull
		echo -e "$file update completed\n"
	else
		echo -e "Not git directory. Pass~\n"
		continue;
	fi
done

