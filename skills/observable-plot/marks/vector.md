# Vector Mark

The vector mark draws directional arrows at x/y positions, used for visualizing vector fields like wind patterns.

## Constructors

```javascript
Plot.vector(data, options)   // Generic vector
Plot.vectorX(data, options)  // x defaults to identity
Plot.vectorY(data, options)  // y defaults to identity
Plot.spike(data, options)    // Spike shape (starts at point)
```

## Channels

| Channel | Description |
|---------|-------------|
| `x`, `y` | Position |
| `length` | Arrow length in pixels |
| `rotate` | Direction in degrees clockwise |
| `stroke` | Color |

## Examples

### Wind Field
```javascript
Plot.vector(windData, {
  x: "longitude",
  y: "latitude",
  length: "speed",
  rotate: "direction"
}).plot()
```

### Spike Map
```javascript
Plot.spike(data, {
  x: "longitude",
  y: "latitude",
  length: "value",
  stroke: "red"
}).plot({
  projection: "albers-usa"
})
```

### From Array of Numbers
```javascript
Plot.vectorY(values).plot()  // Upward arrows
```

### Gradient Field
```javascript
Plot.vector({
  length: 500,
  x: i => (i % 20) * 30,
  y: i => Math.floor(i / 20) * 30,
  rotate: i => Math.atan2((i % 20) - 10, Math.floor(i / 20) - 8) * 180 / Math.PI
}).plot()
```

### With Projection
```javascript
Plot.plot({
  projection: "equal-earth",
  marks: [
    Plot.geo(countries),
    Plot.vector(windData, {
      x: "lon",
      y: "lat",
      rotate: "angle",
      length: "speed",
      stroke: "speed"
    })
  ]
})
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `shape` | "arrow" | Arrow shape (arrow, spike, or custom) |
| `anchor` | "middle" | Position relative to point (start, middle, end) |
| `length` | 12 | Arrow length in pixels |
| `rotate` | 0 | Rotation in degrees clockwise |
| `r` | 3.5 | Radius for anchor calculation |
| `stroke` | currentColor | Arrow color |
| `strokeWidth` | 1.5 | Line thickness |

## Shape Options

- `"arrow"` - Standard arrowhead
- `"spike"` - Triangular spike (like spike maps)
- Custom object with `draw` method

## Anchor Options

- `"start"` - Arrow points away from position
- `"middle"` - Arrow centered on position
- `"end"` - Arrow points toward position

## Notes

- Negative lengths invert the direction
- Rotation is clockwise from up (0° = up, 90° = right)
- Spike mark is useful for maps showing magnitudes at locations
- Vectors render in input order; use sort to manage overlapping
