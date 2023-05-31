# Lua

A great little language with **surprisingly** powerful features!

Here I implemented list-ops and rectangles counting exercises:

* **List-ops** requires OOP implementation in Lua.
* **Rectangles counting** requires algorithm design and Lua implementation.

## Setup

Locally install `luaunit` and point Lua paths to local install:

```bash
$ luarocks --tree ./lua_modules install luaunit 
$ luarocks --tree ./lua_modules install debugger  # for debugging
$ source ./pathconfig.sh
```

## Usage

To run tests, simply execute the appropriate Lua files:
```bash
$ lua ./rectangles/test.lua
$ lua ./list-ops/test.lua
```

You can also profile the rectangles counter:
```bash
$ luajit -jp ./rectangles/profile.lua
```



## Screenshots

*  Running this command opens a live demo of the rectangles counter:
    ```bash
    $ lua ./rectangles/demo.lua
    ```
    ![screenshot of ./rectangles/demo.lua](./assets/demo.gif)

## Credits

All credits for the exercises go to Exercism!

Exercises link: https://exercism.org/tracks/lua/exercises

