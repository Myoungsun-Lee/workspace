endpoint=https://scnzdcurnikmwa.data.mediastore.ap-northeast-2.amazonaws.com
cf_endpoint=https://di88utw29kxi2.cloudfront.net
mspath=live_1031
for name in $(aws mediastore-data list-items --endpoint=$endpoint --path=$mspath | grep 0_3840x2160 | cut -d '"' -f 4 | sort -V);
do echo $name;
curl $endpoint/$mspath/$name --retry 10 --output ./_$mspath/$name;
done
