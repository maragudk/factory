# Dot Mark

The dot mark draws circles or symbols at x/y coordinates, used for scatter plots and bubble charts.

## Constructors

```javascript
Plot.dot(data, options)     // Standard 2D scatter
Plot.dotX(data, options)    // 1D on x-axis
Plot.dotY(data, options)    // 1D on y-axis
Plot.circle(data, options)  // Preset: circle symbol
Plot.hexagon(data, options) // Preset: hexagon symbol
```

## Channels

| Channel | Description |
|---------|-------------|
| `x` | Horizontal position |
| `y` | Vertical position |
| `r` | Radius (bound to sqrt scale by default) |
| `fill` | Fill color |
| `stroke` | Stroke color |
| `symbol` | Symbol type |
| `rotate` | Rotation angle in degrees |

## Examples

### Basic Scatter Plot
```javascript
Plot.dot(data, {x: "weight", y: "height"}).plot()
```

### Colored by Category
```javascript
Plot.dot(data, {
  x: "weight",
  y: "height",
  fill: "species"
}).plot({color: {legend: true}})
```

### Bubble Chart
```javascript
Plot.dot(data, {
  x: "gdp",
  y: "lifeExpectancy",
  r: "population",
  fill: "continent"
}).plot()
```

### With Different Symbols
```javascript
Plot.dot(data, {
  x: "x",
  y: "y",
  symbol: "category"  // Accessibility-friendly
}).plot({symbol: {legend: true}})
```

### 1D Distribution
```javascript
Plot.dotX(values).plot()
```

### Jittered Dots (Beeswarm)
```javascript
Plot.dot(data, Plot.dodgeY({
  x: "category",
  fill: "category"
})).plot()
```

## Symbol Types

**Filled symbols:** circle, cross, diamond, square, star, triangle, wye

**Stroked symbols:** asterisk, circle, diamond2, plus, square2, times, triangle2

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `r` | 3 (or 4.5 with symbol) | Radius in pixels |
| `fill` | currentColor | Fill color |
| `stroke` | none | Stroke color |
| `strokeWidth` | 1.5 | Stroke width |
| `symbol` | circle | Symbol type |
| `frameAnchor` | middle | Position within frame |

## Notes

- Dots sort by descending radius by default to minimize occlusion
- The `r` scale defaults to sqrt so area is proportional to value
- Combine with rule marks for lollipop charts
