# Line Mark

The line mark draws connected lines, typically for time series visualization.

## Constructors

```javascript
Plot.line(data, options)   // Generic line
Plot.lineY(data, options)  // x defaults to index [0, 1, 2, ...]
Plot.lineX(data, options)  // y defaults to index [0, 1, 2, ...]
```

## Channels

| Channel | Description |
|---------|-------------|
| `x` | Horizontal position |
| `y` | Vertical position |
| `z` | Series grouping |
| `stroke` | Line color |
| `strokeWidth` | Line thickness |

## Examples

### Basic Line Chart
```javascript
Plot.lineY(data, {x: "date", y: "value"}).plot({y: {grid: true}})
```

### Multiple Series
```javascript
Plot.lineY(data, {
  x: "date",
  y: "value",
  stroke: "category"  // Color and group by category
}).plot({color: {legend: true}})
```

### With Markers
```javascript
Plot.lineY(data, {
  x: "date",
  y: "value",
  marker: true  // Adds dots at data points
}).plot()
```

### Curved Interpolation
```javascript
Plot.line(data, {
  x: "x",
  y: "y",
  curve: "catmull-rom"
}).plot()
```

### Step Line
```javascript
Plot.lineY(data, {
  x: "date",
  y: "value",
  curve: "step"
}).plot()
```

### From Array of Numbers
```javascript
Plot.lineY([1, 2, 4, 3, 5, 2]).plot()
```

### From Array of Points
```javascript
Plot.line([[0, 1], [1, 2], [2, 4], [3, 3]]).plot()
```

### Creating Gaps
Return undefined/NaN to create breaks:
```javascript
Plot.lineY(data, {
  x: "date",
  y: d => d.valid ? d.value : NaN
}).plot()
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `stroke` | currentColor | Line color |
| `strokeWidth` | 1.5 | Line thickness |
| `curve` | "linear" | Interpolation method |
| `marker` | none | Marker at data points |
| `strokeLinecap` | round | Line cap style |
| `strokeLinejoin` | round | Line join style |

## Curve Types

- `linear` - Straight line segments
- `step`, `step-after`, `step-before` - Step functions
- `basis` - B-spline
- `cardinal` - Cardinal spline
- `catmull-rom` - Catmull-Rom spline
- `monotone-x`, `monotone-y` - Monotonic interpolation
- `natural` - Natural cubic spline
- `bump-x`, `bump-y` - Bézier curves

## Notes

- Data must be sorted for meaningful lines
- Use `sort: "date"` transform if data isn't pre-sorted
- The `z` channel groups data into separate lines
- Use `stroke` channel to color each series differently
