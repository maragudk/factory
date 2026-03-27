# Normalize Transform

The normalize transform converts absolute values to relative values based on a reference point.

## Constructors

```javascript
Plot.normalizeX(basis, options)  // Normalize x channel
Plot.normalizeY(basis, options)  // Normalize y channel
Plot.normalize(basis)            // Returns normalize map method
```

## Basic Usage

```javascript
// Index chart (relative to first value)
Plot.lineY(data, Plot.normalizeY("first", {x: "date", y: "price", stroke: "symbol"}))
```

## Examples

### Index Chart
```javascript
Plot.lineY(stocks, Plot.normalizeY("first", {
  x: "date",
  y: "price",
  stroke: "symbol"
})).plot()
```

### Percentage of Max
```javascript
Plot.lineY(data, Plot.normalizeY("max", {
  x: "date",
  y: "value"
})).plot({y: {percent: true}})
```

### Relative to Mean
```javascript
Plot.lineY(data, Plot.normalizeY("mean", {
  x: "date",
  y: "value"
})).plot()
```

### Standardized (Z-Score)
```javascript
Plot.lineY(data, Plot.normalizeY("deviation", {
  x: "date",
  y: "value"
})).plot()
```

### Sum to 100%
```javascript
Plot.areaY(data, Plot.normalizeY("sum", {
  x: "date",
  y: "value",
  fill: "category"
})).plot({y: {percent: true}})
```

### Multiple Series Comparison
```javascript
Plot.plot({
  y: {percent: true, label: "Change (%)"},
  marks: [
    Plot.lineY(stocks, Plot.normalizeY("first", {
      x: "date",
      y: "price",
      stroke: "symbol"
    })),
    Plot.ruleY([1])  // 100% baseline
  ]
})
```

## Basis Options

| Basis | Description |
|-------|-------------|
| `"first"` | First value (default) |
| `"last"` | Last value |
| `"min"` | Minimum value |
| `"max"` | Maximum value |
| `"mean"` | Average |
| `"median"` | Median |
| `"sum"` | Sum of all values |
| `"extent"` | Maps min→0, max→1 |
| `"deviation"` | Subtract mean, divide by std dev |
| `"pXX"` | Percentile (e.g., `"p50"`) |

## Custom Basis

```javascript
Plot.normalizeY(values => values[0], options)
```

## Options Shorthand

```javascript
// All equivalent
Plot.normalizeY("first", options)
Plot.normalizeY({basis: "first"}, options)
Plot.normalizeY({basis: "first", ...otherOptions})
```

## Notes

- Groups data by z, fill, or stroke before normalizing
- Each series is normalized independently
- Commonly used for comparing trends with different scales
- Use `y: {percent: true}` to show as percentage
- The `extent` basis is useful for 0-1 normalization
