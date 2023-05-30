#!/bin/bash
eval $(luarocks --tree lua_modules path --bin)
LUA_PATH="/usr/share/luajit-2.1.0-beta3/?.lua;$LUA_PATH"
export LUA_PATH
echo "LUA_PATH changed to:"
echo $LUA_PATH
