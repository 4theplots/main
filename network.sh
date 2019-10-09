ifstat | awk '$1 == "ens33" {print substr($7, 0, length($7) - 1)","substr($9, 0, length($9) - 1}'


start ifstat with parameters to use 100 second intervals

CLOSE IFSTAT IN EXIT TRAP -- Keep track of IFSTAT PID
