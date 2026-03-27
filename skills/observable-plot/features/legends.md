# Legends

Legends explain color, opacity, and symbol encodings in your visualization.

## Enabling Legends

```javascript
Plot.plot({
  color: {legend: true},
  marks: [Plot.dot(data, {x: "x", y: "y", fill: "category"})]
})
```

## Legend Types

### Swatches (Categorical)

For ordinal/categorical color scales:

```javascript
Plot.plot({
  color: {
    type: "categorical",
    legend: true,
    scheme: "Observable10"
  },
  marks: [...]
})
```

### Ramp (Continuous)

For continuous color scales:

```javascript
Plot.plot({
  color: {
    type: "linear",
    scheme: "Blues",
    legend: true
  },
  marks: [...]
})
```

### Symbol Legend

```javascript
Plot.plot({
  symbol: {legend: true},
  marks: [Plot.dot(data, {x: "x", y: "y", symbol: "category"})]
})
```

## Swatches Options

```javascript
{
  color: {
    legend: true,
    tickFormat: d => d.toUpperCase(),
    swatchSize: 15,
    swatchWidth: 15,
    swatchHeight: 15,
    columns: 3,
    marginLeft: 0,
    className: "my-legend",
    opacity: 1,
    width: 200
  }
}
```

## Ramp Options

```javascript
{
  color: {
    legend: true,
    label: "Temperature (°C)",
    ticks: 5,
    tickFormat: ".1f",
    tickSize: 6,
    width: 240,
    height: 44,
    marginTop: 18,
    marginRight: 0,
    marginBottom: 16,
    marginLeft: 0,
    round: true,
    opacity: 1
  }
}
```

## Symbol Options

```javascript
{
  symbol: {
    legend: true,
    fill: "black",
    stroke: "none",
    strokeWidth: 1.5,
    r: 4.5,
    fillOpacity: 1,
    strokeOpacity: 1
  }
}
```

## Standalone Legends

Create legends independently:

```javascript
const legend = Plot.legend({
  color: {
    type: "categorical",
    domain: ["A", "B", "C"],
    scheme: "Observable10"
  }
});
document.body.append(legend);
```

## Multiple Legends

```javascript
Plot.plot({
  color: {legend: true},
  symbol: {legend: true},
  marks: [Plot.dot(data, {
    x: "x",
    y: "y",
    fill: "category",
    symbol: "type"
  })]
})
```

## Custom Legend Placement

Legends are added to the figure element. For custom placement:

```javascript
const plot = Plot.plot({
  color: {legend: false},  // Disable auto legend
  marks: [...]
});

const legend = Plot.legend({
  color: plot.scale("color")
});

// Position legend manually
customContainer.append(legend);
document.body.append(plot);
```

## Legend from Scale

```javascript
const plot = Plot.plot({...});
const colorLegend = plot.legend("color");
const symbolLegend = plot.legend("symbol");
```

## Notes

- Legends only available for color, opacity, and symbol scales
- Position scales (x, y) use axes instead
- Swatches for categorical, ramps for continuous
- Use `label` option to add title to ramp legends
- Standalone legends useful for custom layouts
