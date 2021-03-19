endpoint=https://scnzdcurnikmwa.data.mediastore.ap-northeast-2.amazonaws.com
mspath=live_0708
for name in $(aws mediastore-data list-items --endpoint=$endpoint --path=$mspath |grep 0_3840x2160 | cut -f 6 | sort -V);
do echo $name;
aws mediastore-data get-object --endpoint=$endpoint --path=$mspath/$name $mspath/$name;
done

