#Tells hard disk access rates and utilization
#!/bin/bash

#read hard disk access rates of sda in kB/s
iostat -k sda | awk '{print $4}' | tail -n -2 | head -n 1

#read hard disk utilization (used) on root in M
df / --block-size M | awk '{print $3}' | tail -n -1 | tr -cd '0-9\n'
