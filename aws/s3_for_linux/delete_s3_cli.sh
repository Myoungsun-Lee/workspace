s3_path=s3://center-only/kcon210320/
grep_file=channel_3

#for name in $(aws s3 ls $s3_path | grep $grep_file | cut -f 6 -d " " | sort -V );
for name in $(aws s3 ls $s3_path | grep $grep_file | awk '{ if($3 >0) print $4}' );
do echo $name;
aws s3 rm $s3_path$name;
done

