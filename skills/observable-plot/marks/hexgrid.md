# Hexgrid Mark

The hexgrid mark draws a hexagonal grid, typically used with the hexbin transform.

## Constructor

```javascript
Plot.hexgrid(options)  // Note: no data argument
```

## Examples

### Basic Hexgrid
```javascript
Plot.hexgrid().plot()
```

### With Hexbin Transform
```javascript
Plot.plot({
  marks: [
    Plot.hexgrid(),
    Plot.dot(data, Plot.hexbin({r: "count"}, {
      x: "x",
      y: "y",
      fill: "currentColor"
    }))
  ]
})
```

### Custom Styling
```javascript
Plot.hexgrid({
  stroke: "gray",
  strokeOpacity: 0.2,
  binWidth: 30
}).plot()
```

### Colored Hexbins with Grid
```javascript
Plot.plot({
  color: {scheme: "YlGnBu"},
  marks: [
    Plot.hexgrid({binWidth: 20}),
    Plot.dot(data, Plot.hexbin({fill: "count"}, {
      x: "weight",
      y: "height"
    }))
  ]
})
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `binWidth` | 20 | Distance between hexagon centers |
| `stroke` | currentColor | Grid line color |
| `strokeOpacity` | 0.1 | Grid line opacity |
| `clip` | true | Clip to frame |

## Notes

- Does not accept data or support channels
- The `fill` option is not supported (use frame mark for background)
- Match `binWidth` with the hexbin transform for alignment
- Grid lines help visualize empty bins
- Typically used as a background layer under hexbin marks
