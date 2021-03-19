#!/bin/bash

args=$1
url=https://b09fbb15f65fe502.mediapackage.ap-northeast-2.amazonaws.com/in/v2/b836f35b2db245f886f18f9f5c08c00f/b836f35b2db245f886f18f9f5c08c00f/
username=d1f49652a0b94429901755e84866955d
password=b3b4e479dcff473f82d3a09fef8fea1c

filename_ext=`basename $args`
filedir=`dirname $args`
filename="${filename_ext%%.*}"
filenum=`echo $filename | cut -d "_" -f 3`
segnum=`echo $filename | cut -d "_" -f 2`

if [[ "$args" =~ "channel_0" ]];
then
#    cp -f $filedir/index.m3u8 $filedir/channel_0.m3u8
    m3u8=$filedir/channel_0.m3u8
elif [[ "$args" =~ "channel_1" ]];
then
#    cp -f $filedir/index.m3u8 $filedir/channel_1.m3u8
    m3u8=$filedir/channel_1.m3u8
else
#    cp -f $filedir/index.m3u8 $filedir/channel_2.m3u8
    m3u8=$filedir/channel_2.m3u8
fi

if [ $filenum -gt 0 ];
then
    num=`expr $filenum - 1`
else
    exit
fi

finalfile=$filedir"/channel_"$segnum"_"$num".ts"

echo ""
echo ""
echo "********************************************************"
echo "******** $finalfile  ********"
echo "********************************************************"
echo "push the stream main manifestfile to aws"
curl -u $username:$password -X PUT --retry 3 -L --digest -T /mnt/p/라이브테스트/ffmpeg_abr/channel.m3u8 --http1.1 $url
echo ""
echo "push the stream $args to aws"
curl -u $username:$password -X PUT --retry 3 -L --digest -T $finalfile --http1.1 $url
echo ""
echo "push the stream $m3u8 to aws"
curl -u $username:$password -X PUT --retry 3 -L --digest -T $m3u8 --http1.1 $url
echo "********************************************************"
echo ""
echo ""
exit