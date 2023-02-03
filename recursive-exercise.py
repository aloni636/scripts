def recurse(level: int, _symbol_count=0, _row_count=0):
    # base case
    if level == _row_count+1 and (_symbol_count+1)==level:
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
