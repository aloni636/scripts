from itertools import product

s = 20
grid = product(range(-s, s+1), repeat=2)

def str_circle(x):
    dst = ''
    if (x[0]**2+x[1]**2)<=s**2: 
        dst = '**'
    else:
        dst = '  '
    if x[1]==s:
        dst+='\n'
    
    return dst

circle = map(str_circle, grid)

print(''.join(circle))
