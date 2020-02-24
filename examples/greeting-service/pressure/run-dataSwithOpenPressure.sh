for i in `seq 10`; 
    do 
       ##  curl -o /dev/null -s -w %{time_total}ms http://localhost:9615/stopPushDataSwitch/open ;
       curl -w "@curl-format-handle.txt"  -o /dev/null -s http://localhost:9615/stopPushDataSwitch/open ;
        echo " "; 
    done
