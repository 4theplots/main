#!/bin/bash

finish() {
    echo "This script was in an infinite while loop for $SECONDS seconds"
}
trap finish EXIT

i=0

while [ $i -ne 1 ]
do
    i=0
done
