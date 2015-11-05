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
        echo -e "\033[1;31mWe are in $file\033[0m";
        cd $SRC_DIR/$file;
        
        if [ -d $SRC_DIR/$file/.git ]; then
            case $sel in
                1)git remote update \-\-prune
                    ;;
                2)git branch; git pull
                    ;;
                3)git clean -dfx
                    ;;
            esac
            echo -e "$file completed.";
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

echo -e "\033[1;33mWelcome!!!\033[0m"

while :; do
    echo -e "\n========MENU======="
    echo -e " 1. remote update"
    echo -e " 2. branch update"
    echo -e " 3. branch clean"
    echo -e " 4. Quit"
    echo -e "==================="
    echo "Select: "
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

    4) echo -e "Bye Bye~~"
       break;
    ;;
    *) echo -e "You enter wrong menu."
       continue;
    ;;
    esac
done #while done 
