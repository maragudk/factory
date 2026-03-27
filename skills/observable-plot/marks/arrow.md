# Arrow Mark

The arrow mark draws directed arrows between two points, including an arrowhead.

## Constructor

```javascript
Plot.arrow(data, options)
```

## Channels

| Channel | Description |
|---------|-------------|
| `x1`, `y1` | Starting position |
| `x2`, `y2` | Ending position |
| `x` | Shorthand for both x1 and x2 |
| `y` | Shorthand for both y1 and y2 |
| `stroke` | Arrow color |

## Examples

### Basic Arrows
```javascript
Plot.arrow(data, {
  x1: "from_x",
  y1: "from_y",
  x2: "to_x",
  y2: "to_y"
}).plot()
```

### Curved Arrows
```javascript
Plot.arrow(data, {
  x1: "x1", y1: "y1",
  x2: "x2", y2: "y2",
  bend: true  // 22.5° bend
}).plot()
```

### Custom Bend Angle
```javascript
Plot.arrow(data, {
  x1: "x1", y1: "y1",
  x2: "x2", y2: "y2",
  bend: 45  // 45° bend
}).plot()
```

### State Machine Diagram
```javascript
Plot.arrow(transitions, {
  x1: d => states[d.from].x,
  y1: d => states[d.from].y,
  x2: d => states[d.to].x,
  y2: d => states[d.to].y,
  bend: true,
  inset: 20
}).plot()
```

### Change Visualization
```javascript
Plot.arrow(data, {
  x1: "before",
  x2: "after",
  y: "category",
  stroke: d => d.after > d.before ? "green" : "red"
}).plot()
```

### Arc Diagram
```javascript
Plot.arrow(links, {
  x1: "source",
  x2: "target",
  y: 0,
  bend: 90,
  stroke: "type"
}).plot({height: 200})
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `stroke` | currentColor | Arrow color |
| `strokeWidth` | 1.5 | Line thickness |
| `bend` | 0 | Bend angle (0-90°) or true for 22.5° |
| `headAngle` | 60 | Arrowhead angle in degrees |
| `headLength` | 8 | Arrowhead size scale |
| `inset` | 0 | Shortens both ends |
| `insetStart` | 0 | Shortens start |
| `insetEnd` | 0 | Shortens end |
| `sweep` | 1 | Bend direction |

## Bend/Sweep Options

- `bend: true` = `bend: 22.5`
- `bend: 45` = 45° arc
- `sweep: 1` or `sweep: -1` = clockwise or counter-clockwise
- `sweep: "+x"`, `"-x"`, `"+y"`, `"-y"` = directional

## Notes

- Unlike link, arrows include an arrowhead at the end
- Use `inset` to prevent arrows from overlapping nodes
- The `sweep` option controls which direction curved arrows bend
- For straight connecting lines without arrowheads, use link mark
