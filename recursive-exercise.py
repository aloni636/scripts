def recurse(level: float, _symbol_count=0, _row_count=0):
    # base case
    if level == 0:
        return "!"
    # recursive case
    else:
        if _symbol_count==level:
            pass
        else:
            return f"!.{recurse(level, _symbol_count+1)}.!"


# !.!.!.!.!
#  !.!.!.!
#   !.!.!
#    !.!
#     !
