# NOTE: Grid bounds are STATIC and do not participate in the simulation!
# Think of it like Dirichlet boundary conditions.
# 1 == Alive
# 0 == Dead
BEGIN {}

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
        }
        future_cell = 0
        current_cell = grid[i,j]
        if (neighbors==3 && current_cell==0) {future_cell=1}
        else if ((neighbors==2 || neighbors==3) && current_cell==1) {future_cell=1};
        dst_grid[i,j] = future_cell
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
    printf("\n")
  }
}

