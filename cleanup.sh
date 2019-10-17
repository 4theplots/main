#!/bin/bash

finish() {
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
}
trap finish EXIT

i=0

while [ $i -ne 1 ]
do
    i=0
done
