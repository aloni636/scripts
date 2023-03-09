#!/bin/bash
echo 'number of iterations: 5'
awk -v iter=5 -f script.awk grid

