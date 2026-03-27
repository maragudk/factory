# Scales

Scales convert abstract data values (dates, temperatures, categories) into visual values (positions, colors, sizes).

## Position Scales

### Scale Types

| Type | Description | Use Case |
|------|-------------|----------|
| `linear` | Linear interpolation | Quantitative data |
| `utc` | UTC time (default for dates) | Temporal data |
| `time` | Local time | Local temporal data |
| `log` | Logarithmic | Wide-ranging values |
| `sqrt` | Square root | Area encoding |
| `pow` | Power (custom exponent) | Custom transforms |
| `symlog` | Symmetric log | Data crossing zero |
| `point` | Discrete points | Ordinal (scatter) |
| `band` | Discrete bands | Ordinal (bars) |

### Configuration

```javascript
Plot.plot({
  x: {
    type: "linear",
    domain: [0, 100],
    range: [0, 640],
    nice: true,
    grid: true,
    label: "Value",
    tickFormat: ".0f"
  },
  marks: [...]
})
```

### Common Options

| Option | Description |
|--------|-------------|
| `type` | Scale type |
| `domain` | Input extent [min, max] or categories |
| `range` | Output extent [min, max] |
| `nice` | Round domain to nice values |
| `clamp` | Clamp values to domain |
| `reverse` | Flip the scale |
| `zero` | Include zero in domain |
| `percent` | Multiply by 100, add % |
| `inset` | Padding in pixels |

## Color Scales

### Sequential (Continuous)

```javascript
Plot.plot({
  color: {
    type: "linear",
    scheme: "blues",
    legend: true
  },
  marks: [Plot.cell(data, {x: "x", y: "y", fill: "value"})]
})
```

**Schemes:** Blues, Greens, Greys, Oranges, Purples, Reds, Turbo, Viridis, Magma, Inferno, Plasma, Cividis, Warm, Cool, YlGnBu, YlOrRd, etc.

### Diverging

```javascript
Plot.plot({
  color: {
    type: "diverging",
    scheme: "RdBu",
    pivot: 0
  },
  marks: [...]
})
```

**Schemes:** RdBu, BrBG, PRGn, PiYG, PuOr, RdGy, RdYlBu, RdYlGn, Spectral

### Categorical

```javascript
Plot.plot({
  color: {
    type: "categorical",
    scheme: "Observable10"
  },
  marks: [...]
})
```

**Schemes:** Observable10, Tableau10, Category10, Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, Set3

### Threshold/Quantile

```javascript
// Threshold
{color: {type: "threshold", domain: [0, 50, 100]}}

// Quantile
{color: {type: "quantile", n: 5}}

// Quantize
{color: {type: "quantize", n: 5}}
```

## Other Scales

### Radius (r)

```javascript
Plot.plot({
  r: {
    type: "sqrt",  // Area proportional to value
    range: [0, 20]
  },
  marks: [Plot.dot(data, {x: "x", y: "y", r: "value"})]
})
```

### Opacity

```javascript
{opacity: {domain: [0, 100], range: [0.2, 1]}}
```

### Symbol

```javascript
{symbol: {legend: true}}
```

## Scale Inference

Plot automatically infers scale types:
- Numbers → `linear`
- Dates → `utc`
- Strings/Booleans → `ordinal` (point or band)

## Axis Options (via Scale)

```javascript
Plot.plot({
  x: {
    axis: "top",         // Position
    ticks: 5,            // Tick count
    tickFormat: ".0%",   // Format
    tickRotate: -45,     // Rotation
    label: "X Axis",     // Label
    labelAnchor: "center",
    grid: true           // Show grid
  },
  marks: [...]
})
```

## Scale Objects

Extract or reuse scales:

```javascript
// Get scale from plot
const plot = Plot.plot({...});
const colorScale = plot.scale("color");

// Reuse in another plot
Plot.plot({color: colorScale, marks: [...]})

// Standalone scale
const color = Plot.scale({color: {scheme: "Blues", domain: [0, 100]}});
color.apply(50)  // Returns color
```
