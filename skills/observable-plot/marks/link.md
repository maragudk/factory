# Link Mark

The link mark draws straight lines between two points, used for connections and relationships.

## Constructor

```javascript
Plot.link(data, options)
```

## Channels

| Channel | Description |
|---------|-------------|
| `x1`, `y1` | Starting position |
| `x2`, `y2` | Ending position |
| `x` | Shorthand for both x1 and x2 |
| `y` | Shorthand for both y1 and y2 |
| `stroke` | Line color |

## Examples

### Basic Links
```javascript
Plot.link(data, {
  x1: "source_x",
  y1: "source_y",
  x2: "target_x",
  y2: "target_y"
}).plot()
```

### Slope Graph (Change Over Time)
```javascript
Plot.link(data, {
  x1: 0,
  x2: 1,
  y1: "value_2020",
  y2: "value_2024",
  stroke: "category"
}).plot()
```

### Curved Links
```javascript
Plot.link(data, {
  x1: "x1", y1: "y1",
  x2: "x2", y2: "y2",
  curve: "bump-x"
}).plot()
```

### Hierarchical Links (Tree)
```javascript
Plot.link(hierarchy.links(), {
  x1: d => d.source.x,
  y1: d => d.source.y,
  x2: d => d.target.x,
  y2: d => d.target.y,
  curve: "bump-y"
}).plot()
```

### With Markers
```javascript
Plot.link(data, {
  x1: "x1", y1: "y1",
  x2: "x2", y2: "y2",
  marker: "dot"
}).plot()
```

### Gender Wage Gap Visualization
```javascript
Plot.link(data, {
  x1: "female_wage",
  x2: "male_wage",
  y: "occupation",
  stroke: d => d.male_wage > d.female_wage ? "blue" : "red"
}).plot()
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `stroke` | currentColor | Line color |
| `strokeWidth` | 1 | Line thickness |
| `strokeLinecap` | round | Line cap style |
| `curve` | linear | Interpolation method |
| `marker` | none | Endpoint markers |
| `markerStart` | none | Start marker |
| `markerEnd` | none | End marker |

## Recommended Curves

- `linear` - Straight lines
- `step`, `step-before`, `step-after` - Right angles
- `bump-x`, `bump-y` - Smooth S-curves

## Notes

- For arrows with direction, use the arrow mark instead
- With geographic projections, links become geodesics
- Use `marker` option to add dots or arrowheads
- Links are drawn in input order; later links on top
