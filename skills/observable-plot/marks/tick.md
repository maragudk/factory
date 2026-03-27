# Tick Mark

The tick mark draws horizontal or vertical lines with an ordinal secondary dimension.

## Constructors

```javascript
Plot.tickX(data, options)  // Vertical ticks
Plot.tickY(data, options)  // Horizontal ticks
```

## Channels

### tickX
| Channel | Description |
|---------|-------------|
| `x` | Horizontal position |
| `y` | Vertical position (band scale) |

### tickY
| Channel | Description |
|---------|-------------|
| `y` | Vertical position |
| `x` | Horizontal position (band scale) |

## Examples

### Distribution "Barcode" Plot
```javascript
Plot.tickX(data, {x: "value"}).plot()
```

### Grouped Ticks
```javascript
Plot.tickX(data, {
  x: "value",
  y: "category"
}).plot()
```

### Bar Endpoints
```javascript
Plot.plot({
  marks: [
    Plot.barY(data, {x: "category", y: "value", fill: "#ddd"}),
    Plot.tickY(data, {x: "category", y: "value", strokeWidth: 2})
  ]
})
```

### Box Plot Medians
```javascript
Plot.plot({
  marks: [
    Plot.boxY(data, {x: "group", y: "value"}),
    // Median already included in box mark
  ]
})
```

### Full-Width Ticks
```javascript
Plot.tickY(data, {y: "value"}).plot()
// Spans full frame when x is omitted
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `stroke` | currentColor | Tick color |
| `strokeWidth` | 1 | Tick thickness |
| `inset` | 0 | Shortens tick at both ends |
| `insetStart` | 0 | Shortens start |
| `insetEnd` | 0 | Shortens end |
| `marker` | none | Endpoint markers |

## Tick vs Rule

| Feature | Tick | Rule |
|---------|------|------|
| Secondary dimension | Ordinal (band scale) | Quantitative |
| Use case | Categorical groupings | Reference lines |

## Notes

- When the secondary dimension is omitted, ticks span the full frame
- Unlike rules, ticks require ordinal secondary dimensions
- Commonly used to show distribution within categories
- Use `marker` option to add dots at endpoints
