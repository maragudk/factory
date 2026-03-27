# Shorthand Syntax

Plot provides concise shorthand for common visualizations with minimal configuration.

## One-Dimensional Data

For arrays of numbers `[v₀, v₁, v₂, ...]`:

### Lines and Areas
```javascript
Plot.lineY([1, 4, 2, 5, 3]).plot()   // X = index
Plot.areaY([1, 4, 2, 5, 3]).plot()   // X = index, baseline at 0
```

### Bars
```javascript
Plot.rectY([1, 4, 2, 5]).plot()      // Separated bars (interval)
Plot.barY([1, 4, 2, 5]).plot()       // Band scale bars
```

### Points
```javascript
Plot.dotX([1, 4, 2, 5, 3]).plot()    // Distribution plot
Plot.tickX([1, 4, 2, 5, 3]).plot()   // Tick marks
Plot.ruleX([1, 4, 2, 5, 3]).plot()   // Vertical rules
```

### Vectors
```javascript
Plot.vectorY([1, 4, 2, 5, 3]).plot() // Upward arrows
```

### Cells (Color)
```javascript
Plot.cellX([1, 4, 2, 5, 3]).plot()   // Color-encoded cells
```

### Box Plot
```javascript
Plot.boxX([0, 3, 4.4, 4.5, 4.6, 5, 7]).plot()
```

## Two-Dimensional Data

For arrays of [x, y] pairs `[[x₀, y₀], [x₁, y₁], ...]`:

### Lines and Areas
```javascript
Plot.line([[0, 1], [1, 4], [2, 2]]).plot()
Plot.area([[0, 1], [1, 4], [2, 2]]).plot()
```

### Points
```javascript
Plot.dot([[0, 1], [1, 4], [2, 2]]).plot()
Plot.vector([[0, 1], [1, 4], [2, 2]]).plot()
```

### Cells (Ordinal Grid)
```javascript
Plot.cell([[0, 0], [0, 1], [1, 0], [1, 1]]).plot()
```

## With Transforms

### Histogram
```javascript
Plot.rectY([1, 2, 2, 3, 3, 3, 4], Plot.binX()).plot()
```

### Grouped Counts
```javascript
Plot.barY(["a", "b", "a", "c", "a", "b"], Plot.groupX()).plot()
```

### Beeswarm
```javascript
Plot.dotX([1, 2, 2, 3, 3, 3, 4], Plot.dodgeY()).plot()
```

## Common Patterns

### Quick Line Chart
```javascript
Plot.lineY(values).plot()
```

### Quick Scatter Plot
```javascript
Plot.dot(points).plot()  // [[x,y], [x,y], ...]
```

### Quick Bar Chart
```javascript
Plot.barY(categories, Plot.groupX({y: "count"})).plot()
```

### Quick Histogram
```javascript
Plot.rectY(values, Plot.binX({y: "count"})).plot()
```

## Plot Shorthand

Most marks have a `.plot()` method:

```javascript
// These are equivalent:
Plot.lineY(data, options).plot(plotOptions)
Plot.plot({...plotOptions, marks: [Plot.lineY(data, options)]})
```

## Notes

- Shorthand uses identity function for the primary channel
- Index [0, 1, 2, ...] used for secondary channel when not specified
- Not all marks have shorthand (arrow, link need coordinates)
- Time series work with [[Date, value], ...] pairs
- Combine with transforms for more complex visualizations
