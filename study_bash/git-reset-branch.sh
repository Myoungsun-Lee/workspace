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

echo -e "Welcome!!!"

for file in */ ;
do
    if [ "$CONTINUE" -eq 1 ]; then 
        echo -e "Please enter any key to continue...";
	    read next;
    fi

    echo -e "!!!!! We are in $file";
	cd $SRC_DIR/$file
    
    if [ -d $SRC_DIR/$file/.git ]; then
        list=`git branch -a | grep .*remotes.*\.$BRANCH | sed "s/.*\/\(.*\)/\1/g"`
        if [ -z "$list" ]; then 
            echo -e "There is no branch about $BRANCH";
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
          echo "Do you want to checkout $branch?[y/n] " ; read anw
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
