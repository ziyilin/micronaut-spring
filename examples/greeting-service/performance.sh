#!/bin/bash

if [ $# -lt 2 ]; then
    echo 'Usage: \$1 java or svm;\$2 output directory'
    exit 1;
fi

retDir=$2
stdoutfile=$retDir/stdout.log
memLog=../$retDir/mem.log
responseLog=../$retDir/response.log


mkdir $retDir
MEM_OPT="-Xms1024M  -Xmx1024m"
#PRINT_GC="-verbose:gc -XX:+PrintGCDateStamps -XX:+PrintGCDetails -XX:+PrintHeapAtGC"
SVM_GC="-XX:PercentTimeInIncrementalCollection=100 -XX:+LazyReleaseMemory -XX:+EnableImageHeapBarrier"
if [ "$1" == "java" ]
then
java $PRINT_GC $MEM_OPT -jar build/libs/greeting-service-0.1.0.jar  &> $stdoutfile &
pid=`ps -ef|grep "[b]uild/libs/greeting-service"| awk '{print $2}'`
elif [ "$1" == "svm" ]
then
./bootstrap $MEM_OPT $SVM_GC &> $stdoutfile &
pid=`ps -ef|grep "[b]ootstrap -X"| awk '{print $2}'`
else
echo "\$1 should be either java or svm\n"
exit 1;
fi

echo "Start sample memory"
cd pressure
source pressure-mem.sh $pid $memLog &
echo "Start curling"
time source 6w-run.sh $responseLog
echo "finished"
kill $pid

