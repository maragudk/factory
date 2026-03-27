# Bollinger Mark

The Bollinger mark displays a moving average with volatility bands, commonly used for financial data.

## Constructors

```javascript
Plot.bollingerY(data, options)  // Horizontal time (→)
Plot.bollingerX(data, options)  // Vertical time (↑)
Plot.bollinger(k)               // Low-level map method
```

## Channels

| Channel | Description |
|---------|-------------|
| `x` (bollingerY) | Time dimension |
| `y` (bollingerY) | Value dimension |
| `x` (bollingerX) | Value dimension |
| `y` (bollingerX) | Time dimension |

## Examples

### Basic Bollinger Bands
```javascript
Plot.bollingerY(data, {
  x: "date",
  y: "close",
  n: 20,
  k: 2
}).plot()
```

### With Price Line
```javascript
Plot.plot({
  marks: [
    Plot.bollingerY(data, {x: "date", y: "close", opacity: 0.1}),
    Plot.lineY(data, {x: "date", y: "close"})
  ]
})
```

### Custom Styling
```javascript
Plot.bollingerY(data, {
  x: "date",
  y: "close",
  fill: "steelblue",
  fillOpacity: 0.2,
  stroke: "steelblue",
  strokeWidth: 2
}).plot()
```

### From Array (Auto-indexed)
```javascript
Plot.bollingerY(prices).plot()
```

### Using Map Transform
```javascript
Plot.lineY(data, Plot.mapY(Plot.bollinger({n: 20, k: -2}), {
  x: "date",
  y: "close",
  stroke: "red"
})).plot()
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `n` | 20 | Window size (periods) |
| `k` | 2 | Band width (standard deviations) |
| `color` | currentColor | Fill and stroke color |
| `opacity` | 0.2 | Band fill opacity |
| `fill` | - | Band color override |
| `fillOpacity` | - | Band opacity override |
| `stroke` | - | Line color override |
| `strokeOpacity` | 1 | Line opacity |
| `strokeWidth` | 1.5 | Line thickness |

## Components

The Bollinger mark is a composite of:
1. **Area** - Volatility band (±k standard deviations)
2. **Line** - Moving average

## Notes

- The mark uses a trailing moving average (anchor: "end")
- `strict: true` by default (outputs undefined if any window value is undefined)
- Commonly used with daily stock prices (n=20 trading days ≈ 1 month)
- The `k` parameter controls band width (typically 2 standard deviations)
- Negative `k` values show the lower band only
