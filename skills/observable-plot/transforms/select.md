# Select Transform

The select transform filters to specific points within each series, like first, last, or extremes.

## Constructors

```javascript
Plot.select(selector, options)  // Custom selector
Plot.selectFirst(options)       // First point
Plot.selectLast(options)        // Last point
Plot.selectMinX(options)        // Leftmost point
Plot.selectMaxX(options)        // Rightmost point
Plot.selectMinY(options)        // Lowest point
Plot.selectMaxY(options)        // Highest point
```

## Examples

### Label Last Point
```javascript
Plot.plot({
  marks: [
    Plot.line(data, {x: "date", y: "value"}),
    Plot.text(data, Plot.selectLast({
      x: "date",
      y: "value",
      text: d => d.value.toFixed(0),
      dx: 5
    }))
  ]
})
```

### Label Extremes
```javascript
Plot.plot({
  marks: [
    Plot.line(data, {x: "date", y: "value"}),
    Plot.text(data, Plot.selectMinY({
      x: "date", y: "value",
      text: d => `Min: ${d.value}`,
      dy: 10
    })),
    Plot.text(data, Plot.selectMaxY({
      x: "date", y: "value",
      text: d => `Max: ${d.value}`,
      dy: -10
    }))
  ]
})
```

### Multiple Series Labels
```javascript
Plot.plot({
  marks: [
    Plot.line(data, {x: "date", y: "value", stroke: "symbol"}),
    Plot.text(data, Plot.selectLast({
      x: "date",
      y: "value",
      z: "symbol",
      text: "symbol",
      dx: 5
    }))
  ]
})
```

### First and Last
```javascript
Plot.plot({
  marks: [
    Plot.line(data, {x: "date", y: "value"}),
    Plot.dot(data, Plot.selectFirst({x: "date", y: "value", fill: "green"})),
    Plot.dot(data, Plot.selectLast({x: "date", y: "value", fill: "red"}))
  ]
})
```

### Custom Selector
```javascript
// Select point closest to median
Plot.select({
  y: (I, V) => {
    const median = d3.median(I, i => V[i]);
    return [d3.least(I, i => Math.abs(V[i] - median))];
  }
}, options)
```

## Selector Format

```javascript
// Named selectors
Plot.select("first", options)
Plot.select("last", options)

// Channel-based selectors
Plot.select({y: "min"}, options)
Plot.select({x: "max"}, options)

// Custom function
Plot.select({y: (I, V) => [I[0]]}, options)
```

## Options

The selector can be:
- `"first"` or `"last"` - Input order
- `{channel: "min"}` or `{channel: "max"}` - By channel value
- Custom function receiving (index, values)

## Notes

- Operates within each series (grouped by z, fill, or stroke)
- Commonly used with text marks for labeling
- The custom selector function returns array of indices to keep
- Use with dots to mark specific points on lines
