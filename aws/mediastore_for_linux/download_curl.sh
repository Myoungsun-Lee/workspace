endpoint=https://scnzdcurnikmwa.data.mediastore.ap-northeast-2.amazonaws.com
cf_endpoint=https://di88utw29kxi2.cloudfront.net
mspath=live_1031
for name in $(aws mediastore-data list-items --endpoint=$cf_endpoint --path=$mspath |grep 0_3840x2160 | cut -f 6 | sort -V);
do echo $name;
curl $endpoint/$mspath/$name --retry 10 --output $mspath/$name;
done

