# Rect Mark

The rect mark creates axis-aligned rectangles, commonly used for histograms and heatmaps.

## Constructors

```javascript
Plot.rect(data, options)   // Generic rectangle
Plot.rectY(data, options)  // Vertical, implicit stackY
Plot.rectX(data, options)  // Horizontal, implicit stackX
```

## Channels

| Channel | Description |
|---------|-------------|
| `x1`, `x2` | Horizontal extent |
| `y1`, `y2` | Vertical extent |
| `fill` | Fill color |
| `stroke` | Stroke color |

## Examples

### Histogram
```javascript
Plot.rectY(data, Plot.binX({y: "count"}, {x: "value"})).plot()
```

### 2D Heatmap
```javascript
Plot.rect(data, Plot.bin({fill: "count"}, {
  x: "weight",
  y: "height"
})).plot({color: {scheme: "YlGnBu"}})
```

### Calendar Heatmap
```javascript
Plot.rect(data, {
  x: d => d3.utcWeek.count(d3.utcYear(d.date), d.date),
  y: d => d.date.getUTCDay(),
  fill: "value",
  interval: 1
}).plot()
```

### Stacked Histogram
```javascript
Plot.rectY(data, Plot.binX({y: "count"}, {
  x: "value",
  fill: "category"
})).plot()
```

### Overlapping Distributions
```javascript
Plot.rectY(data, Plot.binX({y: "count"}, {
  x: "value",
  fill: "category",
  mixBlendMode: "multiply"
})).plot()
```

### With Rounded Corners
```javascript
Plot.rect(data, {
  x1: "x1", x2: "x2",
  y1: "y1", y2: "y2",
  fill: "category",
  rx: 4
}).plot()
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `fill` | currentColor | Fill color |
| `stroke` | none | Stroke color |
| `rx`, `ry` | 0 | Corner radius |
| `inset` | 0.5 | Inset in pixels |
| `interval` | - | Convert single values to extents |

## Corner Radius Options

- `r` - All corners
- `rx1`, `rx2`, `ry1`, `ry2` - Sides
- `rx1y1`, `rx1y2`, `rx2y1`, `rx2y2` - Individual corners

## Notes

- For ordinal dimensions, use the cell mark instead
- The bin transform is commonly paired with rect for histograms
- Use `inset` to add spacing between adjacent rectangles
