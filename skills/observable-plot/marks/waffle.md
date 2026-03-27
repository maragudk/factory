# Waffle Mark

The waffle mark displays quantities using subdivided cells, making exact counts easier to read than bars.

## Constructors

```javascript
Plot.waffleX(data, options)  // Horizontal waffle (→)
Plot.waffleY(data, options)  // Vertical waffle (↑)
```

## Channels

| Channel | Description |
|---------|-------------|
| `x` (waffleY) | Ordinal grouping |
| `y` (waffleY) | Quantitative value |
| `x` (waffleX) | Quantitative value |
| `y` (waffleX) | Ordinal grouping |
| `fill` | Cell color |

## Examples

### Basic Waffle Chart
```javascript
Plot.waffleY([212, 207, 315, 11], {
  x: ["apples", "bananas", "oranges", "pears"]
}).plot({height: 420})
```

### Stacked Waffle
```javascript
Plot.waffleY(data, {
  x: "category",
  y: "value",
  fill: "subcategory"
}).plot()
```

### Counting Items
```javascript
Plot.waffleY(data, Plot.groupX({y: "count"}, {
  x: "category",
  fill: "subcategory"
})).plot()
```

### Scaled Units
```javascript
Plot.waffleY(data, {
  x: "country",
  y: "population",
  unit: 1000000,  // Each cell = 1 million
  fill: "country"
}).plot()
```

### Horizontal Waffle
```javascript
Plot.waffleX(data, {
  y: "category",
  x: "value"
}).plot()
```

### Custom Cell Layout
```javascript
Plot.waffleY(data, {
  x: "category",
  y: "value",
  multiple: 10,  // 10 cells per row
  gap: 2
}).plot()
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `unit` | 1 | Quantity each cell represents |
| `multiple` | auto | Cells per row/column |
| `gap` | 1 | Space between cells in pixels |
| `round` | false | Avoid partial cells |
| `fill` | currentColor | Cell color |
| `stroke` | none | Cell border |

## Round Options

- `false` - Allow partial cells (default)
- `true` - Round to nearest integer
- Function - Custom rounding (e.g., `Math.floor`, `Math.ceil`)

## Notes

- Rendered using SVG patterns for performance
- Ideal for counting discrete items (people, days, units)
- Supports fractional values via partial cells
- Implicit stack transform applies when using single value channel
- Better for exact quantity reading than bar charts
