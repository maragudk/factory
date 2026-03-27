# Markers

Markers are symbols drawn at vertices of line and link marks.

## Usage

```javascript
Plot.line(data, {x: "x", y: "y", marker: true})
```

## Marker Options

| Option | Description |
|--------|-------------|
| `marker` | Apply to all points |
| `markerStart` | Start point only |
| `markerMid` | Intermediate points |
| `markerEnd` | End point only |

## Marker Types

| Type | Description |
|------|-------------|
| `none` | No marker (default) |
| `arrow` | Arrowhead (auto-oriented) |
| `arrow-reverse` | Reversed arrowhead |
| `dot` | Filled circle (2.5px) |
| `circle` | Filled circle with white stroke (3px) |
| `circle-fill` | Same as `circle` |
| `circle-stroke` | Hollow circle (3px) |
| `tick` | Small opposing line |
| `tick-x` | Horizontal tick |
| `tick-y` | Vertical tick |

## Examples

### Dots at Data Points
```javascript
Plot.line(data, {
  x: "date",
  y: "value",
  marker: "dot"
}).plot()
```

### Circle Markers
```javascript
Plot.line(data, {
  x: "date",
  y: "value",
  marker: "circle"
}).plot()
```

### Arrows on Links
```javascript
Plot.link(data, {
  x1: "x1", y1: "y1",
  x2: "x2", y2: "y2",
  markerEnd: "arrow"
}).plot()
```

### Only at Endpoints
```javascript
Plot.line(data, {
  x: "date",
  y: "value",
  markerStart: "circle",
  markerEnd: "circle"
}).plot()
```

### Directional Line
```javascript
Plot.line(data, {
  x: "date",
  y: "value",
  markerEnd: "arrow"
}).plot()
```

### Ticks at Points
```javascript
Plot.line(data, {
  x: "date",
  y: "value",
  marker: "tick"
}).plot()
```

## Shorthand

```javascript
// marker: true is equivalent to marker: "circle"
Plot.line(data, {x: "x", y: "y", marker: true})
```

## Marker Colors

Markers inherit color from the mark's stroke:

```javascript
Plot.line(data, {
  x: "date",
  y: "value",
  stroke: "red",
  marker: "circle"  // Red circles
}).plot()
```

## Custom Markers

Provide a function that returns an SVG marker element:

```javascript
Plot.line(data, {
  x: "x",
  y: "y",
  marker: (color) => {
    const marker = document.createElementNS("http://www.w3.org/2000/svg", "marker");
    // Configure marker...
    return marker;
  }
})
```

## Notes

- Arrow markers automatically orient along the path
- With curved lines, markers may not appear at exact data positions
- For precise data point markers, use the dot mark instead
- Markers work with line, area, and link marks
- The `dot` marker has no stroke; `circle` has white stroke
