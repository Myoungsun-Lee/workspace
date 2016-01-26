#! /bin/bash
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

if [ $# -eq 1 ]; then
  TEST_MODE=$1
else
  TEST_MODE=0
fi

if [ $TEST_MODE -eq 1 ]; then    
  VALIDATE_ROOT=/home/mysunny.lee/src/gst-integration-testsuites/medias/defaults/lge
else
  VALIDATE_ROOT=$(pwd)
fi

FILES=$VALIDATE_ROOT/* 

function is_there_mediainfo()
{
  filename=$1;
# echo -e "is_there_mediainfo: $filename"
  for media_file in $FILES;
  do
    if [[ "$media_file" == *\."media_info" ]] ; then
      media=`echo $media_file | sed "s/\(.*\)\.media_info/\1/g"`
#     echo -e "is_there_mediainfo media: $media_file"
      if [[ "$filename" == "$media" ]]; then
        res=1;
        return;
      fi
    fi
  done
  res=0;
}

echo -e "\033[1;33mWelcome!!!\033[0m"

for filename in $FILES;
do
  echo -e "\033[1;31mfilename: $filename\033[0m";
   
  if [[ "$filename" == *\."media_info" ]]; then
    echo -e "this is media_info file.\n"
    continue;
  else
    is_there_mediainfo $filename
#   echo "res=$res"
    if [ $res -eq 1 ]; then
      echo -e "This file already have media_info file.\n"
      continue;
    fi
  fi

  echo -e "Do you want to make media_info?[y/n]";
  read sel;
 
  if [ $sel = 'y' ]; then
    gst-validate-media-check-1.0 file://$filename \-\-output\-file $filename\.media_info
  else
    echo -e "Skip...\n";
    continue;
  fi
done 

IFS=$SAVEIFS

echo -e "\033[1;33mBye~~~!!!\033[0m"

