import numpy as np
import pandas as pd
from plotly import express as px, graph_objects as go
from geovis_utils import set_tilemap
import rasterio
rng = np.random.default_rng(42)

SIZE = 100

lat = 30 * rng.random(SIZE) + 30
lon = 10 * rng.random(SIZE) + 70
df = pd.DataFrame({"lat": lat, "lon": lon})

fig = px.scatter_mapbox(df, lat="lat", lon="lon")

# fig.update_layout_images(
#     dict(
#         source='https://raw.githubusercontent.com/plotly/datasets/master/2014_usa_states.png',
#         sizex=1,
#         sizey=1,
#         x=0,
#         y=0,
#         xref="paper",
#         yref="paper"
#     )
# )

fig = set_tilemap(fig)
fig.show()

# # Load the raster file with rasterio
# with rasterio.open('./cea.tif') as src:
#     # Read the data and transform the coordinates to WGS84
#     data = src.read(1)
#     transform = src.transform
#     crs = src.crs.to_string()
#
# # Define the layout for the mapbox figure
# layout = go.Layout(
#     mapbox=dict(
#         accesstoken='your_mapbox_access_token',
#         center=dict(
#             lat=0, lon=0
#         ),
#         style='satellite-streets',
#         zoom=3
#     ),
#     images=[go.layout.Image(
#         source=data,
#         x=transform[2],
#         y=transform[5] + transform[3] * data.shape[0],
#         sizex=transform[0] * data.shape[1],
#         sizey=transform[4] * data.shape[0],
#         sizing='stretch',
#         opacity=0.7
#     )]
# )
#
# # Create the figure object
# fig = go.Figure(layout=layout)
#
# # Show the figure
# fig.show()
