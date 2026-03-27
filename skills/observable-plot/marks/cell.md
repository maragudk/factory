# Cell Mark

The cell mark creates rectangles positioned by two ordinal dimensions, used for heatmaps with categorical axes.

## Constructor

```javascript
Plot.cell(data, options)   // Standard cell
Plot.cellX(data, options)  // 1D, x defaults to index
Plot.cellY(data, options)  // 1D, y defaults to index
```

## Channels

| Channel | Description |
|---------|-------------|
| `x` | Horizontal position (band scale) |
| `y` | Vertical position (band scale) |
| `fill` | Fill color |
| `stroke` | Stroke color |

## Examples

### Basic Heatmap
```javascript
Plot.cell(data, {
  x: "day",
  y: "hour",
  fill: "value"
}).plot({color: {scheme: "YlGnBu"}})
```

### With Group Transform
```javascript
Plot.cell(data, Plot.group({fill: "count"}, {
  x: "category1",
  y: "category2"
})).plot()
```

### Calendar Heatmap
```javascript
Plot.cell(data, {
  x: d => d.date.getUTCDay(),        // Day of week
  y: d => d3.utcWeek.count(d3.utcYear(d.date), d.date),  // Week
  fill: "value"
}).plot({
  color: {scheme: "Greens"}
})
```

### 1D "Barcode" Visualization
```javascript
Plot.cellX(values, {fill: Plot.identity}).plot({
  color: {scheme: "RdBu"}
})
```

### Matrix Visualization
```javascript
Plot.cell(matrix.flatMap((row, i) =>
  row.map((value, j) => ({i, j, value}))
), {
  x: "j",
  y: "i",
  fill: "value"
}).plot()
```

### With Labels
```javascript
Plot.plot({
  marks: [
    Plot.cell(data, {x: "x", y: "y", fill: "value"}),
    Plot.text(data, {x: "x", y: "y", text: "value"})
  ]
})
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `fill` | currentColor | Fill color |
| `stroke` | none | Stroke color |
| `inset` | 0.5 | Spacing between cells |
| `rx`, `ry` | 0 | Corner radius |

## Notes

- Both `x` and `y` scales are band scales (ordinal)
- For quantitative dimensions, use rect mark instead
- Commonly paired with the group transform for aggregation
- If `x` is omitted, cells span the full width
- If `y` is omitted, cells span the full height
