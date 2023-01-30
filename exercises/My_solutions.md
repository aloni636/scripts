credits: https://github.com/learnbyexample/learn_gnuawk/tree/master/exercises
# awk introduction
a. cat addr.txt | awk '/is/'
b. cat addr.txt | awk '!/y/ {print $1}'
c. cat addr.txt | awk '$3==""'
d. cat addr.txt | awk '/is/ ~ $2'
e. cat addr.txt | awk '{sub(/o/,"0" $0); print $1}'
f. cat table.txt | awk 'BEGIN {var=1} {var*=$NF} END {print var}'
g. printf 'last\nappend\nstop\ntail\n' | awk '{print $0 "."}' 

# Regular Expression
a. lines='lovely\n1 dentist\n2 lonely\neden\nfly away\ndent\n'
   printf '%b' "$lines" | awk '$0 ~ /^den/ || $0 ~ /ly$/'
b. echo 'hi42bye nice421423 bad42 cool_42a 42c' | gawk '{gsub(/\B42\B/,"[42]"); print $0}'
c. words='sequoia subtle exhibit asset sets tests site'
   echo $words | gawk '{for (i=1;i<=NF;i++) if ($i~/e/ && $i~/t/ && $i~/^s/) $i="["$i"]"} END {print $0} ' 
* Field iteration vs Record concatenation (t=target/global final string) TODO: perl look behind substitution
d. echo 'area not a _a2_ roar took 22' | gawk '{for (i=1;i<=NF;i++) if ($i~/[ar]$/) $i=$i"\n"; print $0}'
d. echo 'area not a _a2_ roar took 22' | gawk 'BEGIN {RS=" "; t=""} {if(/[ar]$/) {t=t $0"\n"} else {t=t $0 " "}} END {print t}'
e. echo '2.3/[4]|*6 foo 5.3-[4]|*9' | gawk '{gsub (/\[4\]\|\*/, "2"); print $0}'
g. lines='handed\nhand\nhandy\nunhand\nhands\nhandle\n'
   printf '%b' "$lines" | gawk '/^hand[s|y|le]/'
h. echo 'a+42//5-c pressure*3+42/5-14256' | gawk 'BEGIN {v="(42//5|42/5)"}{gsub (v, "8"); print $0}'
* simulate the non greedy `\(.*?\)` by replacing the `.> with *all chars but* `\)>  credit: https://unix.stackexchange.com/a/49605
k. echo 'a/b(division) + c%d() - (a#(b)2(' | gawk 'gsub (/\([^\)]*\)/, "", $0)'
   echo 'a/b(division) + c%d() - (a#(b)2(' | gawk 'gsub (/\([^\)\(]*\)/, "", $0)'




