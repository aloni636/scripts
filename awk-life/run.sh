#!/bin/bash
gawk -v iter=120 -v speed=0.1 -f script.awk ./assets/grid-5.txt

