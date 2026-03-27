# Curves

Curves define how to interpolate between discrete data points in line, area, and link marks.

## Usage

```javascript
Plot.line(data, {x: "x", y: "y", curve: "catmull-rom"})
```

## Curve Types

### Linear

| Curve | Description |
|-------|-------------|
| `linear` | Straight line segments (default) |
| `linear-closed` | Closed polygon |

### Step Functions

| Curve | Description |
|-------|-------------|
| `step` | Y changes at midpoint |
| `step-after` | Y changes after X |
| `step-before` | Y changes before X |

```javascript
// Step chart
Plot.lineY(data, {x: "date", y: "value", curve: "step"}).plot()
```

### Splines

| Curve | Description |
|-------|-------------|
| `basis` | Cubic B-spline |
| `basis-open` | Open B-spline |
| `basis-closed` | Closed B-spline |
| `cardinal` | Cardinal spline |
| `cardinal-open` | Open cardinal |
| `cardinal-closed` | Closed cardinal |
| `catmull-rom` | Catmull-Rom spline |
| `catmull-rom-open` | Open Catmull-Rom |
| `catmull-rom-closed` | Closed Catmull-Rom |
| `natural` | Natural cubic spline |
| `bundle` | Straightened B-spline (lines only) |

```javascript
// Smooth line
Plot.line(data, {x: "x", y: "y", curve: "natural"}).plot()
```

### Bézier

| Curve | Description |
|-------|-------------|
| `bump-x` | Horizontal tangents |
| `bump-y` | Vertical tangents |

```javascript
// Organizational chart links
Plot.link(hierarchy, {
  x1: "parent.x", y1: "parent.y",
  x2: "x", y2: "y",
  curve: "bump-y"
})
```

### Monotone

| Curve | Description |
|-------|-------------|
| `monotone-x` | Preserves monotonicity in x |
| `monotone-y` | Preserves monotonicity in y |

```javascript
// Avoid overshooting
Plot.line(data, {x: "x", y: "y", curve: "monotone-x"}).plot()
```

### Special

| Curve | Description |
|-------|-------------|
| `auto` | Geodesic with projection |

## Tension Parameter

Affects bundle, cardinal, and Catmull-Rom curves:

```javascript
Plot.line(data, {
  x: "x",
  y: "y",
  curve: "cardinal",
  tension: 0.5  // 0 to 1
})
```

## Choosing a Curve

| Use Case | Recommended Curve |
|----------|------------------|
| Default | `linear` |
| Smooth continuous | `natural` or `catmull-rom` |
| Step changes | `step`, `step-after` |
| No overshooting | `monotone-x` |
| Hierarchical links | `bump-x` or `bump-y` |
| Geographic | `auto` (with projection) |

## Examples

### Area with Step
```javascript
Plot.areaY(data, {
  x: "date",
  y: "value",
  curve: "step"
}).plot()
```

### Smooth Line
```javascript
Plot.line(data, {
  x: "date",
  y: "value",
  curve: "catmull-rom"
}).plot()
```

### Tree Links
```javascript
Plot.link(tree.links(), {
  x1: d => d.source.x,
  y1: d => d.source.y,
  x2: d => d.target.x,
  y2: d => d.target.y,
  curve: "bump-y"
}).plot()
```

## Notes

- All curves implemented via d3-shape
- Closed curves connect last point to first
- Open curves don't pass through endpoints
- Use `monotone-x` to prevent overshooting in charts
- Geographic lines become geodesics with `auto` curve
