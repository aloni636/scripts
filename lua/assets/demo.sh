# start recording
asciinema rec assets/demo.cast --overwrite

# generate gif
asciinema-agg assets/demo.cast assets/demo.gif --theme asciinema --cols 95
