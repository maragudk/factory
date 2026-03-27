# Difference Mark

The difference mark visualizes the difference between two values, using alternating colors for above/below.

## Constructors

```javascript
Plot.differenceY(data, options)  // Vertical difference
Plot.differenceX(data, options)  // Horizontal difference
```

## Channels

| Channel | Description |
|---------|-------------|
| `x1`, `y1` | Comparison/baseline position |
| `x2`, `y2` | Metric position |

## Examples

### Temperature Anomaly
```javascript
Plot.differenceY(data, {
  x: "date",
  y1: 0,         // Baseline at zero
  y2: "anomaly"  // Temperature anomaly
}).plot()
```

### Year-over-Year Comparison
```javascript
Plot.differenceY(data, {
  x: "date",
  y1: "lastYear",
  y2: "thisYear"
}).plot()
```

### Comparing Two Metrics
```javascript
Plot.differenceY(data, {
  x: "date",
  y1: "benchmark",
  y2: "actual"
}).plot()
```

### Custom Colors
```javascript
Plot.differenceY(data, {
  x: "date",
  y1: 0,
  y2: "value",
  positiveFill: "green",
  negativeFill: "red"
}).plot()
```

### With Line Overlay
```javascript
Plot.plot({
  marks: [
    Plot.differenceY(data, {
      x: "date",
      y1: "baseline",
      y2: "value",
      fillOpacity: 0.3
    }),
    Plot.lineY(data, {x: "date", y: "value"}),
    Plot.lineY(data, {x: "date", y: "baseline", strokeDasharray: "4,4"})
  ]
})
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `positiveFill` | green | Color when y2 > y1 |
| `negativeFill` | blue | Color when y1 > y2 |
| `fillOpacity` | 1 | Area opacity |
| `positiveFillOpacity` | - | Positive area opacity |
| `negativeFillOpacity` | - | Negative area opacity |
| `stroke` | currentColor | Line color |
| `strokeOpacity` | 1 | Line opacity |

## Behavior

- When `x1` equals `x2`, `y1` defaults to 0 (baseline comparison)
- When `y1` equals `y2`, `x1` defaults to 0 (horizontal baseline)
- The metric line (x2, y2) is drawn on top

## Notes

- Great for showing deviations from a baseline
- Color indicates whether metric is above or below comparison
- Commonly used for temperature anomalies, budget vs actual, etc.
- The stroke shows the metric line for reference
