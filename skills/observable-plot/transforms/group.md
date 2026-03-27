# Group Transform

The group transform aggregates ordinal/categorical data and computes summary statistics.

## Constructors

```javascript
Plot.groupX(outputs, options)  // Group by x
Plot.groupY(outputs, options)  // Group by y
Plot.groupZ(outputs, options)  // Group by z/fill/stroke only
Plot.group(outputs, options)   // Group by x and y
```

## Basic Usage

```javascript
// Bar chart with counts
Plot.barY(data, Plot.groupX({y: "count"}, {x: "category"}))

// Heatmap
Plot.cell(data, Plot.group({fill: "count"}, {x: "category1", y: "category2"}))
```

## Examples

### Vertical Bar Chart
```javascript
Plot.barY(data, Plot.groupX({y: "count"}, {x: "species"})).plot()
```

### Horizontal Bar Chart
```javascript
Plot.barX(data, Plot.groupY({x: "count"}, {y: "species"})).plot()
```

### Stacked Bars
```javascript
Plot.barY(data, Plot.groupX({y: "count"}, {
  x: "category",
  fill: "subcategory"
})).plot()
```

### Sum Instead of Count
```javascript
Plot.barY(data, Plot.groupX({y: "sum"}, {
  x: "category",
  y: "value"  // Sum this field
})).plot()
```

### Mean with Error Bars
```javascript
Plot.plot({
  marks: [
    Plot.barY(data, Plot.groupX({y: "mean"}, {x: "category", y: "value"})),
    Plot.ruleY(data, Plot.groupX({y1: "min", y2: "max"}, {x: "category", y: "value"}))
  ]
})
```

### Heatmap
```javascript
Plot.cell(data, Plot.group({fill: "count"}, {
  x: "day",
  y: "hour"
})).plot({color: {scheme: "YlGnBu"}})
```

### Proportion
```javascript
Plot.barY(data, Plot.groupX({y: "proportion"}, {
  x: "category"
})).plot({y: {percent: true}})
```

## Reducers

| Reducer | Description |
|---------|-------------|
| `count` | Number of items |
| `sum` | Sum of values |
| `mean` | Average |
| `median` | Median |
| `min`, `max` | Extremes |
| `first`, `last` | First/last value |
| `mode` | Most common value |
| `proportion` | Fraction of total |
| `proportion-facet` | Fraction within facet |
| `pXX` | Percentile (e.g., `p25`, `p75`) |
| `deviation` | Standard deviation |
| `variance` | Variance |

## Custom Reducers

```javascript
// Function reducer
Plot.groupX({y: values => d3.sum(values) / values.length}, {x: "category", y: "value"})

// Object reducer
Plot.groupX({
  y: {
    reduce: (values, extent) => /* custom logic */
  }
}, options)
```

## Options

Groups by x (groupX), y (groupY), or both (group), plus any z, fill, or stroke channel.

## Notes

- Use groupX for vertical bars, groupY for horizontal bars
- Groups by first of z, fill, or stroke if present
- Implicit stack transform applies for stacked charts
- Works with faceting for grouped small multiples
