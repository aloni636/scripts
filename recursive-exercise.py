# Goal: draw hourglass by using recursion only
# The string is constructed from outside to inside, simultaneously adding characters to the start and end of the string
# Each function call is wrapping the next callee with predefined characters
#
# Definitions:
# "symbols" = predefined characters
# "levels" = amount of rows the user asked for
#
# Each function keeps track of 3 things:
# A. The amount of desired levels
# A. The amount of symbols already inserted to current row
# A. The current row
def recurse(level: int, _symbol_count=0, _row_count=0):
    # base case
    if level == _row_count+1 and _symbol_count==level-1:
        return "!"
    # recursive case
    else:
        # last row handling
        if level == _row_count+1:
            _symbol_count+=1
            return f" {recurse(level, _symbol_count, _row_count)}"
        # char initialization
        r_char="" # right char
        l_char="" # left char
        
        # row filled, dropping to next level
        if _symbol_count==level:
            _symbol_count=0
            _row_count+=1
            r_char="\n"
            l_char="\n"
        # row not filled yet, continue to fill it
        else:
            _symbol_count+=1
            r_char = "!."
            l_char = ".!"
            # right row padding
            if _symbol_count<=_row_count:
                r_char=" "
            # right row ending
            elif _symbol_count==level:
                r_char="!"
            # left row padding
            if _symbol_count>level-_row_count:
                l_char=" "
            # left row ending
            elif _symbol_count==level-_row_count:
               l_char="!" 
            
        return f"{r_char}{recurse(level, _symbol_count, _row_count)}{l_char}"

print(recurse(5))

# !.!.!.!.!
#  !.!.!.!
#   !.!.!
#    !.!
#     !
#    !.!
#   !.!.!
#  !.!.!.!
# !.!.!.!.!
