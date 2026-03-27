# Crosshair Mark

The crosshair mark displays x and y values for the nearest data point as the pointer moves.

## Constructors

```javascript
Plot.crosshair(data, options)   // Two-dimensional
Plot.crosshairX(data, options)  // X-axis dominant (time series)
Plot.crosshairY(data, options)  // Y-axis dominant
```

## Channels

| Channel | Description |
|---------|-------------|
| `x`, `y` | Position (one can be omitted) |

## Examples

### Basic Crosshair
```javascript
Plot.plot({
  marks: [
    Plot.line(data, {x: "date", y: "value"}),
    Plot.crosshair(data, {x: "date", y: "value"})
  ]
})
```

### Time Series (X-dominant)
```javascript
Plot.plot({
  marks: [
    Plot.lineY(data, {x: "date", y: "value"}),
    Plot.crosshairX(data, {x: "date", y: "value"})
  ]
})
```

### One-dimensional Crosshair
```javascript
Plot.plot({
  marks: [
    Plot.dot(data, {x: "x", y: "y"}),
    Plot.crosshair(data, {x: "x"})  // Only x
  ]
})
```

### Custom Styling
```javascript
Plot.crosshair(data, {
  x: "x",
  y: "y",
  color: "red",
  ruleStrokeWidth: 2
}).plot()
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `x`, `y` | - | Position channels |
| `color` | - | Sets both ruleStroke and textFill |
| `opacity` | - | Sets ruleStrokeOpacity |
| `ruleStroke` | - | Rule line color |
| `ruleStrokeOpacity` | 0.2 | Rule transparency |
| `ruleStrokeWidth` | 1 | Rule thickness |
| `textFill` | - | Text color |
| `textFillOpacity` | - | Text transparency |
| `textStroke` | white | Text halo color |
| `textStrokeOpacity` | 1 | Halo opacity |
| `textStrokeWidth` | 5 | Halo thickness |
| `maxRadius` | 40 | Maximum pointing distance |

## Comparison to Tip

| Feature | Crosshair | Tip |
|---------|-----------|-----|
| Display | Rules + axis labels | Floating box |
| Position | Along axes | Near point |
| Values shown | x and y | All channels |
| Format customization | Limited | Extensive |

## Notes

- Values display on bottom and left sides of the frame
- Uses pointer transform internally
- One dimension can be omitted for one-dimensional display
- Limited formatting options (use tip for custom formats)
- Supports faceting but ignores most other mark options
