# Density Mark

The density mark visualizes 2D point cloud density using contours, revealing concentration patterns.

## Constructor

```javascript
Plot.density(data, options)
```

## Channels

| Channel | Description |
|---------|-------------|
| `x`, `y` | Point positions |
| `weight` | Point contribution to density |
| `z`, `fill`, `stroke` | Grouping for separate densities |

## Examples

### Basic Density Contours
```javascript
Plot.density(data, {
  x: "x",
  y: "y"
}).plot()
```

### With Dots Overlay
```javascript
Plot.plot({
  marks: [
    Plot.density(data, {x: "x", y: "y", stroke: "blue"}),
    Plot.dot(data, {x: "x", y: "y", fill: "currentColor", r: 1})
  ]
})
```

### Filled Density
```javascript
Plot.density(data, {
  x: "x",
  y: "y",
  fill: "density"
}).plot({color: {scheme: "YlOrRd"}})
```

### Grouped Densities
```javascript
Plot.density(data, {
  x: "x",
  y: "y",
  stroke: "category"
}).plot({color: {legend: true}})
```

### Weighted Density
```javascript
Plot.density(data, {
  x: "x",
  y: "y",
  weight: "count"
}).plot()
```

### Custom Bandwidth
```javascript
Plot.density(data, {
  x: "x",
  y: "y",
  bandwidth: 30  // Larger = smoother
}).plot()
```

### 1D Density
```javascript
Plot.density(data, {x: "value"}).plot()
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `bandwidth` | 20 | Gaussian kernel radius in pixels |
| `thresholds` | 20 | Number of contour levels |
| `weight` | 1 | Point weight channel |

## Fill and Stroke

- `fill: "density"` - Color by density value
- `stroke: "density"` - Stroke by density value
- `fill: "category"` - Separate densities per category

## Notes

- Density estimation reveals patterns hidden in dense scatter plots
- Use `bandwidth` to control smoothing (larger = smoother)
- The `thresholds` option controls contour level count
- Negative weights create non-overlapping regions
- Works with Plot's projection system for geographic data
- Commonly overlaid with a dot mark showing actual points
