# Axis Mark

The axis mark conveys meaning for position scales. Plot generates axes automatically, but you can customize or explicitly declare them.

## Constructors

```javascript
Plot.axisX(options)   // Horizontal axis
Plot.axisY(options)   // Vertical axis
Plot.axisFx(options)  // Facet x-axis
Plot.axisFy(options)  // Facet y-axis
```

## Examples

### Custom Axis Options via Scale
```javascript
Plot.plot({
  x: {
    label: "Year",
    tickFormat: "d",
    ticks: 5
  },
  marks: [Plot.line(data, {x: "year", y: "value"})]
})
```

### Axis on Both Sides
```javascript
Plot.plot({
  y: {axis: "both"},
  marks: [Plot.line(data, {x: "x", y: "y"})]
})
```

### Disable Axis
```javascript
Plot.plot({
  x: {axis: null},
  marks: [Plot.dot(data, {x: "x", y: "y"})]
})
```

### Explicit Axis Mark
```javascript
Plot.plot({
  x: {axis: null},  // Disable implicit axis
  marks: [
    Plot.dot(data, {x: "x", y: "y"}),
    Plot.axisX({anchor: "top", label: "Custom Label"})
  ]
})
```

### Rotated Labels
```javascript
Plot.plot({
  x: {
    tickRotate: -45,
    labelAnchor: "right"
  },
  marks: [Plot.barY(data, {x: "category", y: "value"})]
})
```

### Multi-line Time Labels
```javascript
Plot.plot({
  x: {type: "utc"},  // Auto multi-line format
  marks: [Plot.line(data, {x: "date", y: "value"})]
})
```

### Data-Driven Axis Styling
```javascript
Plot.axisX({
  ticks: [0, 50, 100],
  stroke: d => d === 50 ? "red" : "currentColor"
}).plot()
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `anchor` | varies | Position (top, bottom, left, right) |
| `ticks` | auto | Count, interval, or array |
| `tickSize` | 6 | Tick length in pixels |
| `tickPadding` | 3 | Space between tick and label |
| `tickFormat` | auto | Format function or specifier |
| `tickRotate` | 0 | Rotation in degrees |
| `label` | auto | Axis label |
| `labelAnchor` | varies | Label position |
| `labelArrow` | auto | Arrow indicator |
| `labelOffset` | varies | Label distance |
| `color` | currentColor | Tick and label color |
| `stroke` | varies | Tick color override |
| `fill` | varies | Label color override |

## Tick Options

- `ticks: 5` - Approximately 5 ticks
- `ticks: d3.utcMonth` - Monthly ticks
- `ticks: [1, 2, 5, 10]` - Specific values
- `tickSpacing: 50` - Pixels between ticks

## Label Arrow Options

- `auto` - Arrow indicating scale direction
- `up`, `down`, `left`, `right` - Specific direction
- `none` - No arrow
- `true` - Default arrow

## Notes

- Time axes default to multi-line format (e.g., "Jan" and "2024")
- Use `labelOffset` to adjust label distance from axis
- Facet axes (axisFx, axisFy) have tickSize default of 0
