# Hexbin Transform

The hexbin transform groups 2D data into hexagonal bins for heatmap visualization.

## Constructor

```javascript
Plot.hexbin(outputs, options)
```

## Basic Usage

```javascript
Plot.dot(data, Plot.hexbin({fill: "count"}, {x: "weight", y: "height"}))
```

## Examples

### Basic Hexbin Heatmap
```javascript
Plot.dot(data, Plot.hexbin({fill: "count"}, {
  x: "x",
  y: "y"
})).plot({color: {scheme: "YlGnBu"}})
```

### Sized Hexagons
```javascript
Plot.dot(data, Plot.hexbin({r: "count"}, {
  x: "x",
  y: "y",
  fill: "currentColor"
})).plot()
```

### Both Color and Size
```javascript
Plot.dot(data, Plot.hexbin({fill: "count", r: "count"}, {
  x: "weight",
  y: "height"
})).plot()
```

### With Hexgrid Background
```javascript
Plot.plot({
  marks: [
    Plot.hexgrid({binWidth: 20}),
    Plot.dot(data, Plot.hexbin({fill: "count"}, {
      x: "x",
      y: "y",
      binWidth: 20
    }))
  ]
})
```

### Mean Value per Bin
```javascript
Plot.dot(data, Plot.hexbin({fill: "mean"}, {
  x: "x",
  y: "y",
  fill: "value"  // Average this
})).plot()
```

### Grouped Hexbins
```javascript
Plot.dot(data, Plot.hexbin({r: "count"}, {
  x: "x",
  y: "y",
  stroke: "category"  // Separate hexbins per group
})).plot()
```

### Geographic Hexbin
```javascript
Plot.plot({
  projection: "albers-usa",
  marks: [
    Plot.geo(states, {fill: "#eee"}),
    Plot.dot(cities, Plot.hexbin({r: "count", fill: "count"}, {
      x: "longitude",
      y: "latitude"
    }))
  ]
})
```

## Output Channels

| Channel | Description |
|---------|-------------|
| `fill` | Color encoding |
| `r` | Radius (areal representation) |
| `stroke` | Stroke color |
| `text` | Text labels |

## Reducers

Same as bin/group transforms:
- `count`, `sum`, `mean`, `median`, `min`, `max`
- `first`, `last`, `mode`, `deviation`, `variance`
- `proportion`, `proportion-facet`
- `pXX` (percentiles)

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `binWidth` | 20 | Distance between hexagon centers (pixels) |
| `z` | - | Partition hexagons by ordinal value |

## Notes

- Operates in screen space (after scales applied)
- Outputs x, y (hexagon centers), not x1/y1/x2/y2
- Match `binWidth` with hexgrid mark for alignment
- Use `inset` scale option to prevent edge clipping
- Consider equal-area projections for geographic data
