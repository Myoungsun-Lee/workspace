endpoint=https://scnzdcurnikmwa.data.mediastore.ap-northeast-2.amazonaws.com
mspath=live
for name in $(aws mediastore-data list-items --endpoint=$endpoint --path=$mspath | cut -f 6);
do echo $name;
aws mediastore-data delete-object --endpoint=$endpoint --path=$mspath/$name;
done

