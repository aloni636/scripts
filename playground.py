import pandas as pd
import numpy as np

# Basic exercise on joins, groupby and cumsum
DATA_PATH = './data.csv'
COLORS_PATH = './colors.csv'

colors = pd.read_csv(COLORS_PATH)
colors['Ord'] = colors.index

data = pd.read_csv(DATA_PATH)

# Create DataFrame ordered by group & colors orignal positions
data = data.merge(colors, right_on='Group', left_on='Group') \
    .set_index(['Day', 'Ord']).sort_index()

# Cumsum using groupby
data = data.join(
    data.groupby('Day', sort=True, group_keys=False)['Value']
    .apply(np.cumsum)._set_name('CumSum')
)

print(data)
