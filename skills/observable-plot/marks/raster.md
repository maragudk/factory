# Raster Mark

The raster mark renders pixel grids as heatmaps, displaying gridded data or interpolating point samples.

## Constructor

```javascript
Plot.raster(data, options)
```

## Data Formats

1. **Gridded array** - Values in row-major order
2. **Point samples** - x, y coordinates with values
3. **Function** - f(x, y) evaluated at each pixel

## Channels

| Channel | Description |
|---------|-------------|
| `x`, `y` | Position (for point samples) |
| `fill` | Pixel color value |

## Examples

### Gridded Data
```javascript
Plot.raster(volcano.values, {
  width: volcano.width,
  height: volcano.height
}).plot({color: {scheme: "YlGnBu"}})
```

### Mathematical Function
```javascript
Plot.raster({
  fill: (x, y) => Math.atan2(y, x),
  x1: -1, x2: 1,
  y1: -1, y2: 1
}).plot({color: {scheme: "RdBu"}})
```

### Mandelbrot Set
```javascript
Plot.raster({
  x1: -2, x2: 1,
  y1: -1.5, y2: 1.5,
  fill: (x, y) => {
    let i = 0, zr = 0, zi = 0;
    while (i < 100 && zr * zr + zi * zi < 4) {
      [zr, zi] = [zr * zr - zi * zi + x, 2 * zr * zi + y];
      i++;
    }
    return i;
  }
}).plot({color: {scheme: "Turbo"}})
```

### Interpolated Point Data
```javascript
Plot.raster(samples, {
  x: "longitude",
  y: "latitude",
  fill: "temperature",
  interpolate: "barycentric"
}).plot()
```

### With Contours
```javascript
Plot.plot({
  marks: [
    Plot.raster(data, {width: 100, height: 100, fill: Plot.identity}),
    Plot.contour(data, {width: 100, height: 100, stroke: "white"})
  ]
})
```

### Categorical Raster
```javascript
Plot.raster(data, {
  x: "x",
  y: "y",
  fill: "category"
}).plot({color: {type: "categorical"}})
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `width`, `height` | - | Grid dimensions |
| `x1`, `x2`, `y1`, `y2` | - | Spatial bounds |
| `pixelSize` | 1 | Screen pixels per raster pixel |
| `interpolate` | - | Spatial interpolation method |
| `blur` | 0 | Smoothing radius |
| `imageRendering` | "auto" | Rendering mode |

## Interpolation Methods

- `"none"` - Assign sample to containing pixel
- `"nearest"` - Nearest neighbor (Voronoi)
- `"barycentric"` - Delaunay triangulation
- `"random-walk"` - Walk-on-spheres

## Notes

- For line-based contours, use the contour mark instead
- Grid data uses row-major order, y-axis pointing up
- Set `imageRendering: "pixelated"` for sharp pixel boundaries
- The first grid value represents the bottom-left pixel center
- Works with projections for geographic data
