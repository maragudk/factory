# Bin Transform

The bin transform aggregates quantitative or temporal data into discrete bins for histograms and heatmaps.

## Constructors

```javascript
Plot.binX(outputs, options)   // Bin on x-axis
Plot.binY(outputs, options)   // Bin on y-axis
Plot.bin(outputs, options)    // Bin on both axes
```

## Basic Usage

```javascript
// Histogram
Plot.rectY(data, Plot.binX({y: "count"}, {x: "value"}))

// 2D Heatmap
Plot.rect(data, Plot.bin({fill: "count"}, {x: "weight", y: "height"}))
```

## Output Channels

The first argument specifies output channels:

```javascript
{y: "count"}           // Count items per bin
{y: "sum"}             // Sum values
{fill: "mean"}         // Mean for color
{r: "count"}           // Count for size
```

## Examples

### Basic Histogram
```javascript
Plot.rectY(data, Plot.binX({y: "count"}, {x: "value"})).plot()
```

### Stacked Histogram
```javascript
Plot.rectY(data, Plot.binX({y: "count"}, {
  x: "value",
  fill: "category"
})).plot()
```

### 2D Heatmap
```javascript
Plot.rect(data, Plot.bin({fill: "count"}, {
  x: "weight",
  y: "height"
})).plot({color: {scheme: "YlGnBu"}})
```

### Custom Thresholds
```javascript
Plot.rectY(data, Plot.binX({y: "count"}, {
  x: "value",
  thresholds: 20  // ~20 bins
})).plot()
```

### Specific Bin Edges
```javascript
Plot.rectY(data, Plot.binX({y: "count"}, {
  x: "value",
  thresholds: [0, 10, 20, 50, 100]
})).plot()
```

### Cumulative Distribution
```javascript
Plot.rectY(data, Plot.binX({y: "count"}, {
  x: "value",
  cumulative: 1
})).plot()
```

### Time-Based Bins
```javascript
Plot.rectY(data, Plot.binX({y: "count"}, {
  x: "date",
  thresholds: d3.utcMonth
})).plot()
```

## Reducers

| Reducer | Description |
|---------|-------------|
| `count` | Number of items |
| `sum` | Sum of values |
| `mean` | Average |
| `median` | Median value |
| `min`, `max` | Extremes |
| `mode` | Most common |
| `first`, `last` | First/last value |
| `deviation` | Standard deviation |
| `variance` | Variance |
| `proportion` | Proportion of total |
| `pXX` | Percentile (e.g., `p50`) |

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `thresholds` | "auto" | Bin count, edges, or method |
| `interval` | - | Alternative to thresholds |
| `domain` | - | Omit values outside range |
| `cumulative` | 0 | 1 for cumulative, -1 for reverse |

## Threshold Methods

- `"auto"` - Scott's rule (default)
- `"freedman-diaconis"` - Freedman-Diaconis rule
- `"scott"` - Scott's rule
- `"sturges"` - Sturges' formula
- Number - Approximate bin count
- Array - Explicit bin edges
- Interval - Time or numeric interval

## Notes

- Outputs channels like x1, x2, y1, y2 for bin boundaries
- Use `domain` to exclude outliers
- Subdivide bins using z, fill, or stroke channels
- Works with faceting for small multiples
