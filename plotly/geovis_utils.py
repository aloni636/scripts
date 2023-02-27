from plotly import express as px, graph_objects as go
from rasterio.io import DatasetReader
from rasterio.coords import BoundingBox


def set_tilemap(fig: go.Figure):
    return fig.update_layout(
        mapbox=dict(
            center=dict(lat=40.76, lon=-73.97),
            style='open-street-map',
            zoom=12
        )
    )


def add_markers(fig: go.Figure, lat, lon, size=8, color="black", opacity=.7, name="", hovertemplate="lat = %{lat}, lon = %{lon}"):
    trace = go.Scattermapbox(
        lat=lat,
        lon=lon,
        mode='markers',
        marker=dict(
            size=size,
            color=color,
            opacity=opacity
        ),
        hovertemplate=hovertemplate
    )
    trace = trace.update(
        name=name
    )
    return fig.add_trace(trace)


# TODO: transform to wgs84 and overlay using fig.add_layout_image()
def raster_overlay(fig: go.Figure, raster: DatasetReader, bounds: BoundingBox):
    pass
