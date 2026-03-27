# Plotting API Reference

marimo integrates with major plotting libraries and provides reactive chart components for interactive data selection.

## Supported Libraries

marimo renders output from these libraries automatically:
- Matplotlib
- Plotly
- Altair
- Seaborn
- Bokeh
- HoloViews
- hvPlot
- Leafmap
- Pygwalker

Simply return a figure/chart as the last expression in a cell.

## Reactive Charts

Interactive charts that return selected data.

### Altair Charts

```python
import marimo as mo
import altair as alt

# Create reactive Altair chart
chart = mo.ui.altair_chart(
    alt.Chart(df).mark_point().encode(
        x="x:Q",
        y="y:Q",
        color="category:N"
    )
)

# Display chart
chart

# In another cell - access selected data
selected_df = chart.value  # Returns filtered DataFrame
```

Options:

```python
chart = mo.ui.altair_chart(
    alt_chart,
    chart_selection="point",    # "point", "interval", True, False
    legend_selection=True,      # Enable legend filtering
    label="Select data points"
)

# Apply selection to external DataFrame
filtered = chart.apply_selection(other_df)
```

Selection types:
- **Point selection**: Click individual points
- **Interval selection**: Drag to select region
- **Legend selection**: Click legend items to filter

Performance note: marimo's CSV transformer handles up to 400,000+ rows efficiently.

### Plotly Charts

```python
import marimo as mo
import plotly.express as px

fig = px.scatter(df, x="x", y="y", color="category")

# Create reactive Plotly chart
chart = mo.ui.plotly(fig)

# Display
chart

# Access selection data
chart.value      # Complete selection info
chart.indices    # Selected point indices
chart.points     # Selected point data as dicts
chart.ranges     # Axis range selections
```

### Matplotlib Interactive

```python
import marimo as mo
import matplotlib.pyplot as plt

fig, ax = plt.subplots()
ax.plot(x, y)

# Create interactive viewer with pan/zoom
mo.mpl.interactive(fig)
```

Features:
- Pan and zoom
- Coordinate hover
- Requires WebSocket (not available in WASM)

## Static Plots

### Matplotlib

```python
import matplotlib.pyplot as plt

fig, ax = plt.subplots()
ax.plot([1, 2, 3], [1, 4, 9])
ax.set_xlabel("X")
ax.set_ylabel("Y")
fig  # Display
```

### Seaborn

```python
import seaborn as sns

fig = sns.scatterplot(data=df, x="x", y="y", hue="category")
fig.figure  # Display
```

### Plotly (non-reactive)

```python
import plotly.express as px

fig = px.line(df, x="date", y="value")
fig  # Display
```

### Altair (non-reactive)

```python
import altair as alt

chart = alt.Chart(df).mark_bar().encode(
    x="category:N",
    y="count:Q"
)
chart  # Display
```

## Embedding Plots in Markdown

```python
import matplotlib.pyplot as plt

fig, ax = plt.subplots()
ax.plot([1, 2, 3], [1, 4, 9])

mo.md(f"""
## Analysis Results

{mo.as_html(fig)}

The plot shows a quadratic relationship.
""")
```

## Custom Selection Behavior

Disable automatic selections and use custom Altair selections:

```python
import altair as alt

# Create custom selection
brush = alt.selection_interval()

chart = alt.Chart(df).mark_point().encode(
    x="x:Q",
    y="y:Q",
    color=alt.condition(brush, "category:N", alt.value("lightgray"))
).add_params(brush)

# Wrap without automatic selection
mo.ui.altair_chart(
    chart,
    chart_selection=False,
    legend_selection=False
)
```

## Multiple Linked Charts

```python
# Brush selection shared between charts
brush = alt.selection_interval()

chart1 = alt.Chart(df).mark_point().encode(
    x="x:Q",
    y="y:Q"
).add_params(brush)

chart2 = alt.Chart(df).mark_bar().encode(
    x="category:N",
    y="count()"
).transform_filter(brush)

mo.hstack([
    mo.ui.altair_chart(chart1),
    chart2
])
```

## Faceted Charts

```python
chart = alt.Chart(df).mark_point().encode(
    x="x:Q",
    y="y:Q"
).facet(
    column="category:N"
)

mo.ui.altair_chart(chart)
```

## Large Datasets

For large datasets, consider:

1. **Sampling**: Plot a representative sample
2. **Aggregation**: Use binning or grouping
3. **Canvas rendering**: Use Plotly with `render_mode="webgl"`
4. **Lazy loading**: Load data on demand

```python
# Plotly WebGL for large datasets
import plotly.express as px

fig = px.scatter(
    large_df,
    x="x", y="y",
    render_mode="webgl"  # GPU acceleration
)
```

## Reactive Plot Updates

Charts automatically update when dependent variables change:

```python
# Cell 1
n_points = mo.ui.slider(10, 1000, value=100, label="Points")

# Cell 2
import numpy as np

x = np.random.randn(n_points.value)
y = np.random.randn(n_points.value)

# Cell 3
import matplotlib.pyplot as plt

fig, ax = plt.subplots()
ax.scatter(x, y, alpha=0.5)
ax.set_title(f"{n_points.value} Points")
fig  # Updates when slider changes
```
