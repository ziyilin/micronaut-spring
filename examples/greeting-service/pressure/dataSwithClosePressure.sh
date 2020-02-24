for i in `seq 30`; 
    do 
        curl -o /dev/null -s -w %{time_total}ms http://localhost:9615/digest/pushSwitch ;
        echo " "; 
    done
