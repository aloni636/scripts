#!/bin/bash
# include local tree & luajit libs
eval $(luarocks --tree lua_modules path --bin)
export LUA_PATH="/usr/share/luajit-2.1.0-beta3/?.lua;$LUA_PATH"
cd Rectangles

PROFILER="0"
while getopts 'p' opt; do 
  case "$opt" in 
    p) PROFILER="1" ;;
  esac
done

if [[ "$PROFILER" -eq "1"  ]]; 
  then
    echo "Profiling Rectangle Counter Tests:"
    luajit -jp profile.lua
  else
    echo "Testing Rectangle Counter:"
    lua test.lua
fi

cd ..
