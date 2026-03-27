# Grid Mark

The grid mark draws axis-aligned grid lines, typically used as a background reference.

## Constructors

```javascript
Plot.gridX(options)   // Vertical grid lines
Plot.gridY(options)   // Horizontal grid lines
Plot.gridFx(options)  // Facet x grid
Plot.gridFy(options)  // Facet y grid
```

## Examples

### Basic Grid via Scale Option
```javascript
Plot.plot({
  y: {grid: true},
  marks: [Plot.line(data, {x: "date", y: "value"})]
})
```

### Explicit Grid Mark
```javascript
Plot.plot({
  marks: [
    Plot.gridY({stroke: "#ddd"}),
    Plot.line(data, {x: "date", y: "value"})
  ]
})
```

### Grid on Top
```javascript
Plot.plot({
  marks: [
    Plot.barY(data, {x: "category", y: "value", fill: "#ddd"}),
    Plot.gridY({stroke: "white"})  // After bars = on top
  ]
})
```

### Custom Tick Values
```javascript
Plot.gridY({
  ticks: [0, 25, 50, 75, 100]
}).plot()
```

### Dashed Grid
```javascript
Plot.gridY({
  strokeDasharray: "4,4",
  strokeOpacity: 0.5
}).plot()
```

### Interval-Based Grid
```javascript
Plot.plot({
  marks: [
    Plot.gridX({interval: d3.utcMonth}),
    Plot.line(data, {x: "date", y: "value"})
  ]
})
```

### Both Axes
```javascript
Plot.plot({
  marks: [
    Plot.gridX(),
    Plot.gridY(),
    Plot.dot(data, {x: "x", y: "y"})
  ]
})
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `stroke` | currentColor | Line color |
| `strokeWidth` | 1 | Line thickness |
| `strokeOpacity` | 0.1 | Line transparency |
| `strokeDasharray` | - | Dash pattern |
| `ticks` | auto | Tick count or values |
| `tickSpacing` | - | Pixels between ticks |
| `interval` | - | Time interval |

## Shorthand via Scale

The simplest way to add a grid:

```javascript
Plot.plot({
  x: {grid: true},
  y: {grid: true},
  marks: [...]
})
```

## Notes

- Grid is a specialized configuration of the rule mark
- Draws lines across the entire frame at tick positions
- Use explicit grid marks to control layering (before or after data marks)
- Automatically generated when using `grid: true` scale option
- Use low `strokeOpacity` to keep grid subtle
