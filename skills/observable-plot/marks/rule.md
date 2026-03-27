# Rule Mark

The rule mark draws horizontal or vertical lines across quantitative dimensions. Use for reference lines, annotations, and range visualizations.

## Constructors

```javascript
Plot.ruleX(data, options)  // Vertical lines
Plot.ruleY(data, options)  // Horizontal lines
```

## Channels

### ruleX
| Channel | Description |
|---------|-------------|
| `x` | Horizontal position |
| `y1`, `y2` | Vertical extent (defaults to frame) |

### ruleY
| Channel | Description |
|---------|-------------|
| `y` | Vertical position |
| `x1`, `x2` | Horizontal extent (defaults to frame) |

## Examples

### Zero Line
```javascript
Plot.plot({
  marks: [
    Plot.barY(data, {x: "category", y: "value"}),
    Plot.ruleY([0])  // Reference line at y=0
  ]
})
```

### Mean Line
```javascript
Plot.plot({
  marks: [
    Plot.dot(data, {x: "x", y: "y"}),
    Plot.ruleY([d3.mean(data, d => d.y)], {stroke: "red"})
  ]
})
```

### Vertical Reference Lines
```javascript
Plot.ruleX([new Date("2020-01-01")], {
  stroke: "red",
  strokeDasharray: "4,4"
}).plot()
```

### Range/Error Bars
```javascript
Plot.plot({
  marks: [
    Plot.ruleY(data, {x: "category", y1: "low", y2: "high"}),
    Plot.dot(data, {x: "category", y: "mean"})
  ]
})
```

### Candlestick Chart
```javascript
Plot.plot({
  marks: [
    Plot.ruleX(data, {x: "date", y1: "low", y2: "high"}),
    Plot.ruleX(data, {
      x: "date",
      y1: "open",
      y2: "close",
      stroke: d => d.close > d.open ? "green" : "red",
      strokeWidth: 4
    })
  ]
})
```

### Lollipop Chart
```javascript
Plot.plot({
  marks: [
    Plot.ruleY(data, {x: "category", y: "value"}),
    Plot.dot(data, {x: "category", y: "value"})
  ]
})
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `stroke` | currentColor | Line color |
| `strokeWidth` | 1 | Line thickness |
| `strokeDasharray` | none | Dash pattern |
| `marker` | none | Endpoint markers |

## Notes

- If `x` is null for ruleX, the rule centers horizontally
- If `y` is null for ruleY, the rule centers vertically
- Shorthand `y` = `y2` with `y1` defaulting to zero
- Use `marker` option to add dots or arrowheads at endpoints
