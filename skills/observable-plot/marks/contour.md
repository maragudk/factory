# Contour Mark

The contour mark draws isolines representing continuous values, used for topographic maps and density visualization.

## Constructor

```javascript
Plot.contour(data, options)
```

## Data Formats

1. **Gridded data** - Array of values in row-major order
2. **Point samples** - x, y coordinates with values
3. **Function** - f(x, y) evaluated at pixel positions

## Channels

| Channel | Description |
|---------|-------------|
| `x`, `y` | Position (for point samples) |
| `value` | Quantitative value |
| `fill` | Fill color (for filled contours) |
| `stroke` | Stroke color (for line contours) |

## Examples

### Basic Contour Lines
```javascript
Plot.contour(volcano.values, {
  width: volcano.width,
  height: volcano.height
}).plot()
```

### Filled Contours
```javascript
Plot.contour(volcano.values, {
  width: volcano.width,
  height: volcano.height,
  fill: Plot.identity,
  stroke: "black"
}).plot({color: {scheme: "YlGnBu"}})
```

### From Point Samples
```javascript
Plot.contour(data, {
  x: "longitude",
  y: "latitude",
  fill: "temperature",
  interpolate: "barycentric"
}).plot()
```

### Mathematical Function
```javascript
Plot.contour({
  fill: (x, y) => Math.sin(x) * Math.cos(y),
  x1: 0, y1: 0,
  x2: 6 * Math.PI, y2: 4 * Math.PI
}).plot({color: {scheme: "RdBu"}})
```

### With Smoothing
```javascript
Plot.contour(data, {
  width: 100,
  height: 100,
  fill: Plot.identity,
  blur: 2  // Gaussian blur
}).plot()
```

### Geographic Contours
```javascript
Plot.plot({
  projection: "equal-earth",
  marks: [
    Plot.contour(vapor, {
      fill: Plot.identity,
      width: 360, height: 180,
      x1: -180, y1: 90, x2: 180, y2: -90,
      blur: 1,
      clip: "sphere"
    })
  ]
})
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `width`, `height` | - | Grid dimensions |
| `x1`, `x2`, `y1`, `y2` | - | Spatial bounds |
| `pixelSize` | 1 | Screen pixels per grid pixel |
| `blur` | 0 | Gaussian blur radius |
| `smooth` | true | Linear interpolation |
| `thresholds` | - | Contour levels (count or array) |
| `interval` | - | Regular contour spacing |
| `interpolate` | "nearest" | Spatial interpolation method |

## Interpolation Methods

- `"none"` - Sample to pixel
- `"nearest"` - Voronoi-style nearest neighbor
- `"barycentric"` - Delaunay triangulation
- `"random-walk"` - Walk-on-spheres algorithm

## Notes

- Contours render in ascending value order (highest on top)
- Grid coordinates have y-axis inverted (first row is bottom)
- Use `interval` for evenly-spaced contour levels
- Filled contours use `fill`, line contours use `stroke`
- Combine with color legend for value reference
