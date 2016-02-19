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

if [ $# -eq 1 ]; then
    CONTINUE=$1
else
    let CONTINUE=0;
fi

git_func()
{
    sel=$1;
    for file in */ ;
    do
        echo -e "\e[1;31mWe are in $file\e[0m";
        cd $SRC_DIR/$file;
        
        if [ -d $SRC_DIR/$file/.git ]; then
            case $sel in
                1)git remote update \-\-prune
                    ;;
                2)git branch; git pull
                    ;;
                3)git clean -dfx
                    ;;
                4)
                echo -e "!!!This is for salmon project.!!!";
                echo -en "Please enter branch name of new version date(e.g. 20150331): ";
                read date;
                list=`git branch -a | grep .*remotes.*\.$date | sed "s/.*\/\(.*\)/\1/g"`
                if [ -z "$list" ]; then
                    echo -e "\e[31mThere is no branch about $date\e[0m\n";
                    cd $SRC_DIR
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
                    echo -n "Do you want to push $branch?[y/n] " ; read anw
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

                echo -e ".....Start push the new version from $branch branch to salmon branch";
                echo -e ".....Wait...";
                git push origin -f origin/$branch:salmon
                ;;
            esac
            echo -e "\e[32m$file completed.\e[0m\n";
        else
            echo -e "Not git directory. Pass~"
            cd $SRC_DIR;
            continue;
        fi
        
        if [ "$CONTINUE" -eq 1 ]; then
            echo -e "Please enter any key to continue...";
            read next;
        fi
    cd $SRC_DIR;
    done 
}

echo -e "\e[33mWelcome!!!\e[0m"

while :; do
    echo -e "\n========MENU======="
    echo -e " 1. remote update"
    echo -e " 2. branch update"
    echo -e " 3. branch clean"
    echo -e " 4. push new version to salmon branch"
    echo -e " 5. Quit"
    echo -e "==================="
    echo -n "Select: "
    read menu;

    case $menu in 
    1) echo -e "*** Start remote update ***"
       git_func $menu 
    ;;

    2) echo -e "*** Start branch update(pull) ***"
       git_func $menu 
    ;;

    3) echo -e "*** Start branch clean ***"
       git_func $menu 
    ;;

    4) echo -e "*** Start push salmon to update lasted version ***"
       git_func $menu
    ;;

    5) echo -e "Bye Bye~~"
       break;
    ;;
    *) echo -e "You enter wrong menu."
       continue;
    ;;
    esac
done #while done 
