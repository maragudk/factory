# Interactions

Plot provides interactive features for data exploration through pointing, tooltips, and the pointer transform.

## Quick Tooltips

The simplest way to add interactivity:

```javascript
Plot.dot(data, {x: "x", y: "y", tip: true}).plot()
```

## Tip Mark

For more control over tooltips:

```javascript
Plot.plot({
  marks: [
    Plot.line(data, {x: "date", y: "value"}),
    Plot.tip(data, Plot.pointer({x: "date", y: "value"}))
  ]
})
```

## Pointer Transform

Filters to show only the nearest data point:

```javascript
// Two-dimensional (scatter plots)
Plot.pointer(options)

// X-dominant (time series)
Plot.pointerX(options)

// Y-dominant
Plot.pointerY(options)
```

### Example

```javascript
Plot.plot({
  marks: [
    Plot.line(data, {x: "date", y: "value"}),
    Plot.dot(data, Plot.pointerX({x: "date", y: "value", fill: "red"}))
  ]
})
```

## Crosshair Mark

Displays x and y values along axes:

```javascript
Plot.plot({
  marks: [
    Plot.line(data, {x: "date", y: "value"}),
    Plot.crosshair(data, {x: "date", y: "value"})
  ]
})
```

### Variants

```javascript
Plot.crosshair(data, options)   // Both axes
Plot.crosshairX(data, options)  // X-axis focused
Plot.crosshairY(data, options)  // Y-axis focused
```

## Pointer Options

| Option | Default | Description |
|--------|---------|-------------|
| `px`, `py` | - | Target position |
| `maxRadius` | 40 | Maximum pointing distance |
| `frameAnchor` | middle | Target within frame |

## Click to Stick

Clicking on a point locks the tooltip until clicked again, allowing text selection.

## Input Events

Pointer transforms emit input events:

```javascript
const plot = Plot.dot(data, Plot.pointer({x: "x", y: "y"})).plot();

plot.addEventListener("input", () => {
  console.log(plot.value);  // Currently focused datum
});
```

## Custom Reactivity

Update plots by replacing them:

```javascript
function updatePlot(filteredData) {
  const newPlot = Plot.plot({
    marks: [Plot.dot(filteredData, {x: "x", y: "y"})]
  });
  oldPlot.replaceWith(newPlot);
}
```

### React Integration

```jsx
function Chart({ data }) {
  const ref = useRef();

  useEffect(() => {
    const plot = Plot.plot({
      marks: [Plot.dot(data, {x: "x", y: "y", tip: true})]
    });
    ref.current.replaceChildren(plot);
    return () => plot.remove();
  }, [data]);

  return <div ref={ref} />;
}
```

## Future Features

Under development (see GitHub issues):
- **Selection**: Direct manipulation point selection (#5)
- **Zooming**: Pan and zoom (#1590)
- **Animation**: Declarative animation (#166)

## Notes

- Use `tip: true` for quick tooltips
- Use `Plot.pointer` with custom marks for more control
- `pointerX` is best for time series
- `pointerY` is best for horizontal charts
- Pointer transform still contributes to scale domains
