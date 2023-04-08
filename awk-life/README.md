# GAWK Game Of Life
Realtime game of life implementation in GAWK, because why not?

# Requirements
A working copy of `gawk`

*Note: you cannot use regular `awk` because it doesn't supported timeouts with I/O, 
meaning I cant support ctrl-c termination*

# Usage:

run `gawk -v iter=<int> -v speed=<float> -f script.awk <grid file>`

* `iter`: controls number of iterations
* `speed`: controls how fast to run the simulation
* `grid file`: one of the ready made grid files, or your own!

Example in `./run.sh`

# Screenshots



# Enjoy!

