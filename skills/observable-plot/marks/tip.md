# Tip Mark

The tip mark displays floating tooltips anchored to x/y coordinates, commonly used with the pointer transform for interactive data exploration.

## Constructor

```javascript
Plot.tip(data, options)
```

## Channels

| Channel | Description |
|---------|-------------|
| `x`, `y` | Position |
| `x1`, `x2`, `y1`, `y2` | Range positions |
| `title` | Custom text content |

## Examples

### Simple Interactive Tooltip
```javascript
Plot.lineY(data, {x: "date", y: "value", tip: true}).plot()
```

### With Pointer Transform
```javascript
Plot.plot({
  marks: [
    Plot.lineY(data, {x: "date", y: "value"}),
    Plot.tip(data, Plot.pointerX({x: "date", y: "value"}))
  ]
})
```

### Custom Tooltip Content
```javascript
Plot.tip(data, Plot.pointer({
  x: "x",
  y: "y",
  title: d => `${d.name}\n${d.value.toLocaleString()}`
})).plot()
```

### Static Annotation
```javascript
Plot.tip(
  ["Important event occurred here"],
  {x: new Date("2024-06-15"), y: 100, anchor: "bottom"}
).plot()
```

### With Extra Channels
```javascript
Plot.tip(data, Plot.pointer({
  x: "x",
  y: "y",
  channels: {
    "Population": "population",
    "Area": "area"
  }
})).plot()
```

### Formatting Values
```javascript
Plot.plot({
  marks: [
    Plot.dot(data, {x: "x", y: "y", tip: {
      format: {
        x: d => `$${d.toFixed(2)}`,
        y: d => `${d}%`,
        fill: false  // Hide this channel
      }
    }})
  ]
})
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `anchor` | varies | Placement (top, bottom, left, right, etc.) |
| `preferredAnchor` | bottom | Default if not specified |
| `pointerSize` | 12 | Tip pointer size in pixels |
| `textPadding` | 8 | Text padding in pixels |
| `pathFilter` | drop-shadow | Visual effect for tip box |
| `fontFamily` | system-ui | Font family |
| `fontSize` | 10 | Font size in pixels |
| `lineHeight` | 1 | Line spacing |
| `lineWidth` | 20 | Wrap width in ems |
| `monospace` | false | Use monospace font |

## Anchor Options

- `top`, `bottom`, `left`, `right`
- `top-left`, `top-right`, `bottom-left`, `bottom-right`
- `middle`

## Format Options

```javascript
format: {
  channelName: true,        // Use default format
  channelName: false,       // Hide channel
  channelName: null,        // Hide channel
  channelName: ",.2f",      // d3-format string
  channelName: d => `${d}m` // Custom function
}
```

## Notes

- If no `title` channel, tip auto-displays all bound channel values
- The tip displays color swatches for color-bound channels
- Paired channels (x1/x2, y1/y2) display as ranges
- Click on a point to "stick" the tooltip until clicked again
