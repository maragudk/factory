# Frame Mark

The frame mark draws a rectangle around the plot area, useful for visual separation especially with facets.

## Constructor

```javascript
Plot.frame(options)  // Note: no data argument
```

## Examples

### Basic Frame
```javascript
Plot.frame().plot()
```

### Styled Frame
```javascript
Plot.frame({
  stroke: "red",
  strokeWidth: 2
}).plot()
```

### Frame with Plot
```javascript
Plot.plot({
  marks: [
    Plot.frame(),
    Plot.dot(data, {x: "x", y: "y"})
  ]
})
```

### Highlight Specific Facet
```javascript
Plot.plot({
  fy: "species",
  marks: [
    Plot.frame({fy: "setosa", stroke: "red"}),
    Plot.dot(data, {x: "x", y: "y", fy: "species"})
  ]
})
```

### Single Side (Line)
```javascript
Plot.frame({
  anchor: "bottom",
  stroke: "currentColor"
}).plot()
```

### Background Fill
```javascript
Plot.frame({
  fill: "#f0f0f0",
  stroke: "none"
}).plot()
```

### With Facets
```javascript
Plot.plot({
  facet: {data, x: "category"},
  marks: [
    Plot.frame(),
    Plot.dot(data, {x: "x", y: "y"})
  ]
})
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `stroke` | currentColor | Border color |
| `fill` | none | Background color |
| `strokeWidth` | 1 | Border thickness |
| `inset` | 0 | Inset in pixels |
| `rx`, `ry` | 0 | Corner radius |
| `anchor` | none | Draw single side (top, right, bottom, left) |

## Anchor Option

When `anchor` is set, only that side is drawn as a line:

```javascript
Plot.frame({anchor: "bottom"})  // Bottom line only
Plot.frame({anchor: "left"})    // Left line only
```

Note: When using `anchor`, `fill`, `fillOpacity`, `rx`, and `ry` are ignored.

## Notes

- Unlike most marks, frame does not accept data as first argument
- Primarily useful with facets for visual grouping
- Can be used for background color by setting fill
- Supports standard mark options including insets and rounded corners
