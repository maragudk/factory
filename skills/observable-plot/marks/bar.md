# Bar Mark

The bar mark creates rectangular bars for bar charts. One dimension is ordinal (categorical), the other quantitative.

## Constructors

```javascript
Plot.barY(data, options)  // Vertical bars (↑)
Plot.barX(data, options)  // Horizontal bars (→)
```

## Channels

| Channel | Description |
|---------|-------------|
| `x` | Horizontal position (barY: ordinal band scale) |
| `y` | Vertical position (barX: ordinal band scale) |
| `x1`, `x2` | Horizontal extent (barX) |
| `y1`, `y2` | Vertical extent (barY) |
| `fill` | Fill color |
| `stroke` | Stroke color |

## Examples

### Basic Vertical Bar Chart
```javascript
Plot.barY(data, {x: "category", y: "value"}).plot()
```

### Horizontal Bar Chart
```javascript
Plot.barX(data, {y: "category", x: "value"}).plot()
```

### Sorted Bars
```javascript
Plot.barY(data, {
  x: "category",
  y: "value",
  sort: {x: "-y"}  // Descending by value
}).plot()
```

### Stacked Bar Chart
```javascript
Plot.barY(data, {
  x: "category",
  y: "value",
  fill: "subcategory"
}).plot()
```

### Grouped Bars (via Faceting)
```javascript
Plot.plot({
  fx: {padding: 0},
  marks: [
    Plot.barY(data, {
      x: "subcategory",
      y: "value",
      fx: "category",
      fill: "subcategory"
    }),
    Plot.ruleY([0])
  ]
})
```

### Diverging Bars
```javascript
Plot.barX(data, {
  y: "category",
  x: "value",  // Can be negative
  fill: d => d.value > 0 ? "green" : "red"
}).plot()
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `fill` | currentColor | Fill color |
| `stroke` | none | Stroke color |
| `inset` | 0 | Spacing between bars (pixels) |
| `interval` | - | Enforce uniform spacing |

## Notes

- Implicit stack transform applies when only `y` (not `y1`/`y2`) is specified
- Ordinal domains sort alphabetically by default; use `sort` to reorder
- Use `interval: 1` for data with regular spacing (e.g., annual)
