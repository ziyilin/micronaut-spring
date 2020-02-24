for i in `seq 10`;  
    do     
       curl -w "@curl-format-handle.txt"  -o /dev/null -s  http://localhost:9615/health/check
    	echo " "; 
    done
