# NOTE: Grid bounds are STATIC and do not participate in the simulation!
# Think of it like Dirichlet boundary conditions.
# 1 == Alive
# 0 == Dead
BEGIN {print("iter: " iter); print("speed: " speed); print("(terminate with Ctrl-c)");}

{
  for (i=1;i<=NF;i++) grid[NR,i]=$i
} 

END {  
# for n iterations
  for (T=1;T<=iter;T++) {
    # for each row
    for (i=1; i<=NR;i++) {
      # for each column
      for (j=1; j<=NF;j++) {
        # if grid bounds
        if (i==1 || j==1 || i==NR || j==NF) {dst_grid[i,j]=grid[i,j]}
        # if not grid bounds
        else {
          neighbors = \
            grid[i-1,j-1] \
           +grid[i-1,j  ] \
           +grid[i-1,j+1] \
           +grid[i,j-1  ] \
           +grid[i,j+1  ] \
           +grid[i+1,j-1] \
           +grid[i+1,j  ] \
           +grid[i+1,j+1] 
        
        future_cell = 0
        current_cell = grid[i,j]
        if (neighbors==3 && current_cell==0) {future_cell=1}
        else if ((neighbors==2 || neighbors==3) && current_cell==1) {future_cell=1};
        dst_grid[i,j] = future_cell
        }
      }
    }
    RED_COLOR = "\033[31m%s\033[0m "
    BLUE_COLOR = "\033[34m%s\033[0m "
    for (i=1; i<=NR;i++) {
      for (j=1; j<=NF;j++) {
        dst = dst_grid[i,j]
        grid[i,j] = dst
        if (dst==0) {printf(BLUE_COLOR, dst_grid[i,j])}
        else {printf(RED_COLOR, dst_grid[i,j])}
      }
      printf ("\n") 
    }
    ANSI_TOP = "\033[" NR+1 "A"
    ANSI_BOTTOM = "\033[" NR+1 "B"

    print("Iteration: " T "/" iter)

    # system("timeout 0.1 read")
    # command |& getline line
    # system("cat /dev/stdin")
    # exit_status = system("timeout 0.1 cat /dev/stdin")
    # credits: https://www.gnu.org/software/gawk/manual/html_node/Read-Timeout.html
    # awk uses sh to run to system(<cmd>), so:
    # * I cant use read -t <speed> to check if user pressed termination key (q, <esc>, etc)
    # * I cant use timeout <speed> <cmd> because timeout need to spawn child process, and 
    #   read is run in same process as sh
    # * I cant do cat /dev/stdin beacuse it doesnt have access to the "real" stdin
    # Also, because /dev/stdin is being blocked from reading after timeout, I can only allow ctrl-c, 
    # because for some reason, when attempting to read from time-outed I/O, 
    # gwak 5.1.0 will handle termination with ctrl-c 
    # So, this is what needs to be done to allow termination:
    stdin = "/dev/stdin"
    PROCINFO[stdin, "READ_TIMEOUT"] = speed * 1000
    PROCINFO[stdin, "RETRY"] = 1
    while ((getline < stdin) > 0) {}
    printf(ANSI_TOP)
  }
  printf(ANSI_BOTTOM)
}

