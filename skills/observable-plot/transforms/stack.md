# Stack Transform

The stack transform arranges data into stacked layers for area and bar charts.

## Constructors

```javascript
Plot.stackY(options)     // Vertical stacking
Plot.stackY1(options)    // Returns y1 as y
Plot.stackY2(options)    // Returns y2 as y
Plot.stackX(options)     // Horizontal stacking
Plot.stackX1(options)    // Returns x1 as x
Plot.stackX2(options)    // Returns x2 as x
```

## Basic Usage

Many marks apply stacking implicitly:

```javascript
// Implicit stacking
Plot.barY(data, {x: "category", y: "value", fill: "group"})

// Explicit stacking
Plot.barY(data, Plot.stackY({x: "category", y: "value", fill: "group"}))
```

## Examples

### Stacked Area Chart
```javascript
Plot.areaY(data, {
  x: "date",
  y: "value",
  fill: "category"
}).plot()
```

### Streamgraph
```javascript
Plot.areaY(data, Plot.stackY({
  offset: "wiggle",
  x: "date",
  y: "value",
  fill: "category"
})).plot()
```

### Normalized Stack (100%)
```javascript
Plot.barY(data, Plot.stackY({
  offset: "normalize",
  x: "category",
  y: "value",
  fill: "group"
})).plot({y: {percent: true}})
```

### Centered Stack
```javascript
Plot.barY(data, Plot.stackY({
  offset: "center",
  x: "category",
  y: "value",
  fill: "group"
})).plot()
```

### Diverging Stack
```javascript
Plot.barX(data, Plot.stackX({
  x: d => d.response === "Positive" ? d.count : -d.count,
  y: "question",
  fill: "response"
})).plot()
```

### Custom Order
```javascript
Plot.areaY(data, Plot.stackY({
  order: "sum",
  x: "date",
  y: "value",
  fill: "category"
})).plot()
```

## Offset Options

| Offset | Description |
|--------|-------------|
| `null` | Zero baseline (default) |
| `"normalize"` | Scale stacks to fill [0, 1] |
| `"center"` | Center stacks around zero |
| `"wiggle"` | Minimize movement (streamgraph) |

## Order Options

| Order | Description |
|-------|-------------|
| `null` | Input order (default) |
| `"value"` | Ascending value |
| `"sum"` | By total series value |
| `"appearance"` | By position of maximum |
| `"inside-out"` | Earliest series on inside |

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `offset` | null | Baseline method |
| `order` | null | Layer ordering |
| `reverse` | false | Reverse layer order |

## Notes

- Stack converts single y channel to y1/y2 bounds
- Use `reverse: true` to flip layer order
- The `wiggle` offset creates streamgraphs
- Negative values create diverging stacks
- Midpoint channels computed lazily for label positioning
