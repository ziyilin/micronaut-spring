## Ö´ÐÐ 6w ´Î
if [ $# -lt 1 ]; then
    echo 'Usage: \$1 output file'
    exit 1;
fi

rm -I $1

n=1;
while(($n<=50000));
do
    curl -w "%{time_total}\n"  -o /dev/null -s http://localhost:8080/2016-08-15/proxy/FaaSDemo.LATEST/svm_nooptimize_hello/greeting  >>  $1
    n=$((n + 1));
done
