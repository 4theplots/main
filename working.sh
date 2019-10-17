#!/bin/bash

ip=$1


init() {
	echo | cat > system_metrics.csv
	echo | cat > apm1_metrics.csv
	echo | cat > apm2_metrics.csv
	echo | cat > apm3_metrics.csv
	echo | cat > apm4_metrics.csv
	echo | cat > apm5_metrics.csv
	echo | cat > apm6_metrics.csv

	pkill ifstat

	ifstat -d 1 &

	./APM1 $ip &

	lastid=$!

	apm1=$lastid


	echo $lastid | cat >> id.txt

	./APM2 $ip &

	lastid=$!

	apm2=$lastid

	echo $lastid | cat >> id.txt

	./APM3 $ip &

	lastid=$!

	apm3=$lastid

	echo $lastid | cat >> id.txt

	./APM4 $ip &

	lastid=$!

	apm4=$lastid

	echo $lastid | cat >> id.txt

	./APM5 $ip &

	lastid=$!

	apm5=$lastid

	echo $lastid | cat >> id.txt

	./APM6 $ip &

	lastid=$!

	apm6=$lastid

	echo $lastid | cat >> id.txt

}

finish() {
    echo
    echo "This script was in an infinite while loop for $SECONDS seconds"
    while [ $(wc -l id.txt | cut -d ' ' -f 1) -gt 0 ]
    do
        line=$(head -n 1 id.txt)
        echo $line
        tail -n +2 id.txt > temp.txt
        kill $line
	    cat temp.txt > id.txt
    done
	    pkill ifstat
	    rm id.txt
            rm temp.txt
}
trap finish EXIT


process() {

	cpu=$(ps h -p $1 -o %cpu)
	mem=$(ps h -p $1 -o %mem)
	echo "$cpu, $mem" | cat >> $2
}

system() {
	access=$(iostat -k sda | awk '{print $4}' | tail -n -2 | head -n 1)
	util=$(df / --block-size M | awk '{print $3}' | tail -n -1 | tr -cd '0-9\n')
	net=$(ifstat | awk '$1 == "ens33" {print $7","$9}' | tr -cd '0-9,\n')

	echo "$access, $util, $net" | cat >> "system_metrics.csv"
}

write_data() {
	process $apm1 "apm1_metrics.csv"
	process $apm2 "apm2_metrics.csv"
	process $apm3 "apm3_metrics.csv"
	process $apm4 "apm4_metrics.csv"
	process $apm5 "apm5_metrics.csv"
	process $apm6 "apm6_metrics.csv"

	
	system

}


init


i=0

while [ $i -ne 1 ]
do
	if [ $(($SECONDS % 5)) -eq 0 ]
	then
		echo "$SECONDS"
		echo "writing data"
		write_data
		sleep 1
	fi
    i=0
done
