import pandas as pd
import numpy as np
import plotly.express as px
from numpy.random import default_rng

rng = default_rng(42)


# fake data
def create_interval(
    start: str, size: int, scale: int = 1, unit: str = "m"
) -> pd.DataFrame:
    timedelta = pd.TimedeltaIndex(rng.integers(1, scale + 1, size).cumsum(), unit)
    timestamp = pd.Timestamp(start) + timedelta
    interval_start = timestamp[::2]
    interval_end = timestamp[1::2]

    intervals = pd.DataFrame(
        {"interval_start": interval_start, "interval_end": interval_end}
    )
    return intervals


# visualize
print(create_interval())
