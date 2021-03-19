#! /bin/bash

SRC_DIR=$(pwd)
LOG_DIR=$SRC_DIR/log
BRANCH=$1
CHECK=false

if [ $# -eq 2 ]; then
    CONTINUE=$2
else
    let CONTINUE=0;
fi

if [ -z $BRANCH ]; then
    echo -e "Unkown branch ==> NULL";
    exit 0;
fi

echo -e "\033[1;33mWelcome!!!\033[0m"

for file in */ ;
do
    if [ "$CONTINUE" -eq 1 ]; then 
        echo -ne "Please enter any key to continue...";
	    read next;
    fi

    echo -e "\033[1;31mWe are in $file\033[0m";
	cd $SRC_DIR/$file
    
    if [ -d $SRC_DIR/$file/.git ]; then
        list=`git branch -a | grep .*remotes.*\.$BRANCH | sed "s/.*\/\(.*\)/\1/g"`
        if [ -z "$list" ]; then 
            echo -e "There is no branch about $BRANCH";
	        cd $SRC_DIR;
            continue;
        fi
        let i=0
        let j=0

        echo -e "===branch list==="
        for num in $list; do
            let i++
            echo -e "$num"
        done
        echo -e "================="
        
        for branch in $list ;
        do
          let j++
          echo -n "Do you want to checkout $branch?[y/n] " ; read anw
          if [ "$anw" = 'y' ] || [ "$j" -eq "$i" ] ; then break;
          elif [ "$anw" = 'n' ]; then continue;
          else echo "Wrong anwser!! Go to next branch!!";
          continue;
          fi
        done

        if [ "$anw" != 'y' ] && [ "$j" -eq "$i" ]; then 
            echo -e "Go to next directory"
            continue;
        fi
        
        echo -e "...Changing branch to $branch";

		git checkout $branch
		echo -e "$file completed to change branch"
        echo -e "go to next directory"
	else
        echo -e "This is not git directory. Go to next.."   
        continue;
	fi
done
echo -e "\nAll Done! Bye..(-_-)b"
