# Area Mark

The area mark renders a region between a baseline and topline, commonly used for area charts.

## Constructors

```javascript
Plot.areaY(data, options)  // Horizontal (time goes right →)
Plot.areaX(data, options)  // Vertical (time goes up ↑)
Plot.area(data, options)   // Generic (rarely used)
```

## Channels

| Channel | Description |
|---------|-------------|
| `x`, `y` | Position (shorthand for x1/y1) |
| `x1`, `y1` | Baseline position |
| `x2`, `y2` | Topline position (defaults to x1/y1) |
| `z` | Series grouping |
| `fill` | Fill color |
| `stroke` | Stroke color |

## Examples

### Basic Area Chart
```javascript
Plot.areaY(data, {x: "date", y: "value"}).plot()
```

### Stacked Area Chart
When fill is a channel, data implicitly stacks:
```javascript
Plot.areaY(data, {x: "date", y: "value", fill: "category"}).plot()
```

### Streamgraph
```javascript
Plot.areaY(data, Plot.stackY({
  offset: "wiggle",
  x: "date",
  y: "value",
  fill: "category"
})).plot()
```

### Area with Line
```javascript
Plot.plot({
  marks: [
    Plot.areaY(data, {x: "date", y: "value", fillOpacity: 0.3}),
    Plot.lineY(data, {x: "date", y: "value"})
  ]
})
```

### Band/Range Area
```javascript
Plot.areaY(data, {
  x: "date",
  y1: "low",
  y2: "high",
  fill: "steelblue",
  fillOpacity: 0.3
}).plot()
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `curve` | "linear" | Interpolation method |
| `fill` | currentColor | Fill color |
| `fillOpacity` | 1 | Fill opacity |
| `stroke` | none | Stroke color |

## Important Notes

- **Data must be sorted** (typically chronologically). Unsorted data produces incorrect results.
- **Gaps appear** when channel values are undefined/null/NaN.
- Use `curve` option for different interpolation (step, basis, catmull-rom, etc.).
- The `interval` option regularizes sampled data.
