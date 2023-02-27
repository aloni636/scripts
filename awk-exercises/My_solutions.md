credits: https://github.com/learnbyexample/learn_gnuawk/tree/master/exercises
# awk introduction

a. `cat addr.txt | awk '/is/'`

b. `cat addr.txt | awk '!/y/ {print $1}'`

c. `cat addr.txt | awk '$3==""'`

d. `cat addr.txt | awk '/is/ ~ $2'`

e. `cat addr.txt | awk '{sub(/o/,"0" $0); print $1}'`

f. `cat table.txt | awk 'BEGIN {var=1} {var*=$NF} END {print var}'`

g. `printf 'last\nappend\nstop\ntail\n' | awk '{print $0 "."}' `

# Regular Expression

a. 
```
   lines='lovely\n1 dentist\n2 lonely\neden\nfly away\ndent\n'
   printf '%b' "$lines" | awk '$0 ~ /^den/ || $0 ~ /ly$/'
```

b. `echo 'hi42bye nice421423 bad42 cool_42a 42c' | gawk '{gsub(/\B42\B/,"[42]"); print $0}'`

c. 
```
   words='sequoia subtle exhibit asset sets tests site'
   echo $words | gawk '{for (i=1;i<=NF;i++) if ($i~/e/ && $i~/t/ && $i~/^s/) $i="["$i"]"} END {print $0} ' 
```

*Field iteration vs Record concatenation (t=target/global final string) TODO: perl look behind substitution*

d. `echo 'area not a _a2_ roar took 22' | gawk '{for (i=1;i<=NF;i++) if ($i~/[ar]$/) $i=$i"\n"; print $0}'`

d. `echo 'area not a _a2_ roar took 22' | gawk 'BEGIN {RS=" "; t=""} {if(/[ar]$/) {t=t $0"\n"} else {t=t $0 " "}} END {print t}'`

e. `echo '2.3/[4]|*6 foo 5.3-[4]|*9' | gawk '{gsub (/\[4\]\|\*/, "2"); print $0}'`

g. 
   ```
   lines='handed\nhand\nhandy\nunhand\nhands\nhandle\n'
   printf '%b' "$lines" | gawk '/^hand[s|y|le]/'
   ```

h. `echo 'a+42//5-c pressure*3+42/5-14256' | gawk 'BEGIN {v="(42//5|42/5)"}{gsub (v, "8"); print $0}'`

* simulate the non greedy `\(.*?\)` by replacing the `.>` with *all chars but* `\)>  credit: https://unix.stackexchange.com/a/49605

k. 
```
   echo 'a/b(division) + c%d() - (a#(b)2(' | gawk 'gsub (/\([^\)]*\)/, "", $0)'
   echo 'a/b(division) + c%d() - (a#(b)2(' | gawk 'gsub (/\([^\)\(]*\)/, "", $0)'
```

m. 
  ```
   wget https://www.gutenberg.org/files/345/345-0.txt -O dracula.txt
   cat dracula.txt | awk '{if (tolower($0) ~ /professor/ && $0 ~ /(quip|this)/) print $0}'
  ```

n. 
  ```
   echo 'lion,ant,road,neon' | awk 'BEGIN {FS=","; OFS=FS} {$3 = "42"} {print $0}
   echo '_;3%,.,=-=,:' | awk 'BEGIN {FS=","; OFS=FS} {$3 = "42"} {print $0}'
  ```

o. 
  ```
   printf 'so and so also sow and soup' | awk '{ if (match ($0, /(so[^so]*){4}$/)!=0) print substr($0, 0, RSTART-1) "X" substr($0, RSTART+2, RSTART+RLENGTH)}'
   printf 'sososososososo\nso and so\n' | awk '{ if (match ($0, /(so[^so]*){4}$/)!=0) print substr($0, 0, RSTART-1) "X" substr($0, RSTART+2, RSTART+RLENGTH)}'
  ```

*a little cursed, but *technically* works with no sub/gsub calls*
p. 
  ```
   words='tiger imp goat eagle ant important'
   echo "$words" | awk 'BEGIN {RS=" "; ORS=" "} /^(imp|ant)$/ {$0=""} {print "("$1")"}'
  ```

# Field separators
*field seperator is "(" or ")":*

a. `cat brackets.txt | awk -F '(\\(|\\))' '{print $2}'`

b. `cat scores.csv | awk -F ',' '{print $1":"$3}'`

c. `cat scores.csv | awk -F ',' '$2>70 && $1!="Name" {print $1}'`

d. 
  ```
   echo 'hi there' | awk -F '\\w' '{print NF-1}'
   echo 'u-no;co%."(do_12:as' | awk -F '\\w' '{print NF-1}'
  ```
*print first & last double quotation marked words that are more then single letters:*

e. 
  ```
   echo '1 "grape" and "mango" and "guava"' | awk -F '"' '{if (length($(NF-1))==1) {R=3} else {R=1}; print $2 " " $(NF-R)}'
   echo '("a 1""b""c-2""d")' | awk -F '"' '{if (length($(NF-1))==1) {R=3} else {R=1}; print $2 " " $(NF-R)}'
  ```
