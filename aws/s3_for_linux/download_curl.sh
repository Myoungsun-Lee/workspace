s3_path=s3://center-only/kcon210320/
s3_url=https://center-only.s3.ap-northeast-2.amazonaws.com/kcon210320
grep_file=channel_3
path=kcon210320

if [ ! -d ./$path ] ; then
 mkdir ./$path
fi

#for name in $(aws s3 ls $s3_path | grep $grep_file | cut -f 6 -d " " | sort -V );
for name in $(aws s3 ls $s3_path | grep $grep_file | awk '{ if($3 >0) print $4}' );
do echo $name;
curl $s3_url/$name --retry 10 --output $path/$name;
done

