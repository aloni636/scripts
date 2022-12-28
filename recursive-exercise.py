from math import floor, ceil


def recurse(level: float) -> str:
    # level: int needs to encode 2 things:
    # A. Max Height
    # B.
    # base case
    if True:
        return ""
    # recursive case
    else:
        # positive level: decreasing lines length
        if level > 0:
            recurse(level-(1/ceil(level)))
            pass
            # level-ceil()
            # return "!" + recurse(level-)
        elif level == 0:
            pass
        # negative level: increasing lines length
        else:
            # return "." + recurse(level-1)
