#!/bin/bash

pkill "ifstat"

ifstat -d 100 &

lastid=$!

echo $lastid

echo $lastid | cat > id.txt
