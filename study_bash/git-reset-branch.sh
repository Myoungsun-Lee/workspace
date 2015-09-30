#! /bin/bash

SRC_DIR=$(pwd)
LOG_DIR=$SRC_DIR/log
BRANCH=$1
CHECK=false

if [ -z $BRANCH ]; then
    echo -e "Unkown branch ==> NULL";
    exit 0;
fi


for file in */ ;
do
	echo -e "We are in $file";
	cd $SRC_DIR/$file
    
    if [ -d $SRC_DIR/$file/.git ]; then
        list=`git branch -a | grep .*remotes.*\.$BRANCH | sed "s/.*\/\(.*\)/\1/g"`
        if [ -z "$list" ]; then 
            echo -e "There is no branch about $BRANCH \n";
            continue;
        fi
        let i=0
        let j=0

        echo -e "===branch list==="
        for num in $list; do
            let i++
            echo -e "$num"
        done
        echo "================="
        
        for branch in $list ;
        do
          let j++
          echo -e "Do you want to checkout $branch?[y/n]" ; read anw
          if [ $anw = 'y' ] || [ $j -eq $i ] ; then break;
          elif [ $anw = 'n' ]; then continue;
          else echo "Wrong anwser!! Go to next branch!!"; continue;
          fi
        done

        if [ $anw != 'y' ] && [ $j -eq $i ]; then 
            echo -e "Go to next directory\n"
            continue;
        fi
        
        echo -e "...Changing branch to $branch";

		git checkout $branch
		echo -e "$file completed to change branch\n"
        echo -e "go to next directory\n"
	else
        echo -e "This is not git directory. Go to next..\n"   
		continue;
	fi
done
    echo -e "All Done! Bye..(-_-)b\n"
