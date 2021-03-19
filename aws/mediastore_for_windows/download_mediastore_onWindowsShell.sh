#!/bin/bash

endpoint=https://scnzdcurnikmwa.data.mediastore.ap-northeast-2.amazonaws.com
mspath=live_1031
if [ ! -d $mspath ] ; then
mkdir $mspath
fi

for name in $(aws mediastore-data list-items --endpoint=$endpoint --path=$mspath |grep 0_3840x2160 | cut -d '"' -f 4 | sort -V);
do echo $name;
aws mediastore-data get-object --endpoint=$endpoint --path=/$mspath/$name ./$mspath/$name;
done
