# Linear Regression Mark

The linear regression mark shows a fitted trend line with confidence intervals.

## Constructors

```javascript
Plot.linearRegressionY(data, options)  // y as dependent variable
Plot.linearRegressionX(data, options)  // x as dependent variable
```

## Channels

| Channel | Description |
|---------|-------------|
| `x`, `y` | Data positions |
| `z`, `fill`, `stroke` | Grouping for multiple regressions |

## Examples

### Basic Regression Line
```javascript
Plot.linearRegressionY(data, {
  x: "income",
  y: "spending"
}).plot()
```

### With Scatter Plot
```javascript
Plot.plot({
  marks: [
    Plot.dot(data, {x: "x", y: "y"}),
    Plot.linearRegressionY(data, {x: "x", y: "y"})
  ]
})
```

### Grouped Regressions
```javascript
Plot.plot({
  marks: [
    Plot.dot(data, {x: "x", y: "y", stroke: "category"}),
    Plot.linearRegressionY(data, {
      x: "x",
      y: "y",
      stroke: "category"
    })
  ]
})
```

### Without Confidence Band
```javascript
Plot.linearRegressionY(data, {
  x: "x",
  y: "y",
  ci: 0  // No confidence interval
}).plot()
```

### Custom Confidence Level
```javascript
Plot.linearRegressionY(data, {
  x: "x",
  y: "y",
  ci: 0.99  // 99% confidence
}).plot()
```

### Custom Styling
```javascript
Plot.linearRegressionY(data, {
  x: "x",
  y: "y",
  stroke: "red",
  fill: "red",
  fillOpacity: 0.1
}).plot()
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `stroke` | currentColor | Line color |
| `fill` | stroke | Confidence band color |
| `fillOpacity` | 0.1 | Band opacity |
| `ci` | 0.95 | Confidence interval (0–1); 0 to hide |
| `precision` | 4 | Pixels between band samples |

## Model

The mark fits `y = a + bx` using least squares:
- `a` = intercept
- `b` = slope

The confidence band shows the likely range for these parameters.

## Cautions

1. **Non-linear data**: Linear regression can mislead when relationships are curved
2. **Subpopulations**: Simpson's paradox may cause aggregate trends to differ from group trends
3. **Asymmetry**: Regressing y on x gives different results than x on y
4. **Outliers**: Can significantly affect the fitted line

## Notes

- Use separate groups (via z, fill, or stroke) to avoid misleading aggregate trends
- Always visualize the underlying data alongside the regression line
- Consider the scatter to verify linear relationship is appropriate
