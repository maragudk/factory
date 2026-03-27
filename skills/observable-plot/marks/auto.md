# Auto Mark

The auto mark automatically selects an appropriate visualization based on data dimensions.

## Constructor

```javascript
Plot.auto(data, options)
Plot.autoSpec(data, options)  // Returns resolved options
```

## Channels

| Channel | Description |
|---------|-------------|
| `x`, `y` | Position dimensions |
| `color` | Color encoding |
| `size` | Size encoding (radius) |
| `fx`, `fy` | Facet dimensions |

## Examples

### Two Quantitative Dimensions (Scatter)
```javascript
Plot.auto(data, {
  x: "weight",
  y: "height"
}).plot()
```

### Monotonic + Numeric (Line)
```javascript
Plot.auto(data, {
  x: "date",
  y: "value"
}).plot()
```

### Single Quantitative (Histogram)
```javascript
Plot.auto(data, {x: "value"}).plot()
```

### Single Ordinal (Bar Chart)
```javascript
Plot.auto(data, {x: "category"}).plot()
```

### With Count Reducer
```javascript
Plot.auto(data, {
  x: "category",
  y: "count"  // Built-in reducer
}).plot()
```

### With Color
```javascript
Plot.auto(data, {
  x: "weight",
  y: "height",
  color: "species"
}).plot()
```

### With Faceting
```javascript
Plot.auto(data, {
  x: "value",
  fy: "category"
}).plot()
```

### Force Specific Mark
```javascript
Plot.auto(data, {
  x: "date",
  y: "value",
  mark: "area"  // Override auto-selection
}).plot()
```

## Reducer Syntax

```javascript
// String shorthand
{y: "count"}
{y: "sum"}
{y: "mean"}

// Object with value and reduce
{y: {value: "price", reduce: "sum"}}
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `x`, `y` | - | Position channels |
| `color` | - | Color encoding |
| `size` | - | Size encoding |
| `fx`, `fy` | - | Facet channels |
| `mark` | auto | Force mark type (area, bar, dot, line, rule) |
| `zero` | false | Include zero rule if significant |

## Mark Selection Logic

| Data Pattern | Selected Mark |
|--------------|---------------|
| Two quantitative | dot (scatter) |
| Monotonic x + quantitative y | line |
| Single quantitative | rect (histogram with bin) |
| Single ordinal | bar (with group) |
| Ordinal x + quantitative y | bar |

## Notes

- Designed for fast exploratory analysis
- Heuristics are undocumented and may change
- Use `mark` option to force a specific visualization type
- Use `autoSpec` to see the resolved options
- `zero: true` adds a rule at y=0 or x=0 when meaningful
