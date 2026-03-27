# Box Mark

The box mark creates boxplots showing distribution quartiles, median, and outliers.

## Constructors

```javascript
Plot.boxX(data, options)  // Horizontal boxplots
Plot.boxY(data, options)  // Vertical boxplots
```

## Channels

| Channel | Description |
|---------|-------------|
| `x` | Quantitative dimension (boxX) or ordinal grouping (boxY) |
| `y` | Quantitative dimension (boxY) or ordinal grouping (boxX) |
| `fill` | Box fill color |
| `stroke` | Whisker and outlier color |

## Examples

### Basic Vertical Boxplot
```javascript
Plot.boxY(data, {x: "category", y: "value"}).plot()
```

### Horizontal Boxplot
```javascript
Plot.boxX(data, {y: "category", x: "value"}).plot()
```

### From Array of Numbers
```javascript
Plot.boxX([0, 3, 4.4, 4.5, 4.6, 5, 7]).plot()
```

### Colored by Category
```javascript
Plot.boxY(data, {
  x: "category",
  y: "value",
  fill: "category"
}).plot()
```

### Binned Data
```javascript
Plot.boxY(data, {
  x: d => Math.floor(d.x / 10) * 10,  // Bin into groups
  y: "value"
}).plot()
```

### With Custom Styling
```javascript
Plot.boxY(data, {
  x: "group",
  y: "value",
  fill: "#ccc",
  stroke: "black",
  strokeWidth: 2
}).plot({y: {grid: true}})
```

## Box Components

The box mark is a composite of:
1. **Rule** - Whiskers showing range (excluding outliers)
2. **Bar** - Box showing interquartile range (Q1 to Q3)
3. **Tick** - Median line
4. **Dot** - Outliers (points beyond 1.5× IQR)

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `fill` | #ccc | Box fill color |
| `fillOpacity` | 1 | Box opacity |
| `stroke` | currentColor | Whisker/outlier color |
| `strokeOpacity` | 1 | Stroke opacity |
| `strokeWidth` | 1 | Median tick width |
| `r` | 3 | Outlier dot radius |

## Notes

- Uses the group transform internally
- The secondary dimension must be ordinal
- Outliers are points beyond 1.5× the interquartile range
- For horizontal boxplots, use boxX with y as the grouping variable
- Customize individual components by creating your own composite
