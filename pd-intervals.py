import pandas as pd
import numpy as np
from numpy.random import default_rng
rng = default_rng(42)

def create_interval(start:str, size:int, scale:int=1, unit:str="m") -> pd.IntervalIndex:
    timedelta = pd.TimedeltaIndex(rng.integers(1,scale+1,size).cumsum(), unit)
    timestamp = pd.Timestamp(start) + timedelta
    interval_start = timestamp[::2]
    interval_end = timestamp[1::2]
    
    interval = pd.IntervalIndex.from_arrays(interval_start, interval_end) 
    return interval

np.ravel_multi_index( 
interval = create_interval("2020-10-10", 100)

