# Window Transform

The window transform computes moving window statistics for time series analysis.

## Constructors

```javascript
Plot.windowX(k, options)  // Window on x channel
Plot.windowY(k, options)  // Window on y channel
Plot.window(k)            // Returns window map method
```

## Basic Usage

```javascript
// 7-day moving average
Plot.lineY(data, Plot.windowY(7, {x: "date", y: "value"}))
```

## Examples

### Moving Average
```javascript
Plot.lineY(data, Plot.windowY(7, {
  x: "date",
  y: "value"
})).plot()
```

### Trailing Average
```javascript
Plot.lineY(data, Plot.windowY({k: 7, anchor: "end"}, {
  x: "date",
  y: "value"
})).plot()
```

### With Original Data
```javascript
Plot.plot({
  marks: [
    Plot.line(data, {x: "date", y: "value", strokeOpacity: 0.3}),
    Plot.line(data, Plot.windowY(30, {x: "date", y: "value", stroke: "red"}))
  ]
})
```

### Moving Median
```javascript
Plot.lineY(data, Plot.windowY({k: 7, reduce: "median"}, {
  x: "date",
  y: "value"
})).plot()
```

### Min/Max Band
```javascript
Plot.plot({
  marks: [
    Plot.areaY(data, Plot.windowY({k: 7, reduce: "min"},
      Plot.windowY({k: 7, reduce: "max"}, {x: "date", y1: "value", y2: "value"}))),
    Plot.lineY(data, {x: "date", y: "value"})
  ]
})
```

### Multiple Series
```javascript
Plot.lineY(data, Plot.windowY(7, {
  x: "date",
  y: "value",
  stroke: "category"  // Each series gets separate window
})).plot()
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `k` | required | Window size |
| `anchor` | "middle" | Window alignment |
| `reduce` | "mean" | Calculation method |
| `strict` | false | Return undefined if any value undefined |

## Anchor Values

| Anchor | Description |
|--------|-------------|
| `"middle"` | Centered window (includes future values) |
| `"end"` | Trailing window (past values only) |
| `"start"` | Leading window (future values only) |

## Reducers

| Reducer | Description |
|---------|-------------|
| `mean` | Average (default) |
| `median` | Median value |
| `min`, `max` | Extremes |
| `sum` | Sum of values |
| `deviation` | Standard deviation |
| `variance` | Variance |
| `first`, `last` | First/last value |
| `mode` | Most common |
| `difference` | Last minus first |
| `ratio` | Last divided by first |
| `pXX` | Percentile |

## Notes

- Use `anchor: "end"` for trailing averages (no look-ahead)
- The `z` channel creates separate windows per series
- With `strict: true`, undefined output if any window value undefined
- Window size `k` is the number of data points, not time duration
