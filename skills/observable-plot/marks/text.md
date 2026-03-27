# Text Mark

The text mark renders text labels at specified positions, used for annotations and labels.

## Constructors

```javascript
Plot.text(data, options)   // Generic text
Plot.textX(data, options)  // x defaults to identity
Plot.textY(data, options)  // y defaults to identity
```

## Channels

| Channel | Description |
|---------|-------------|
| `x`, `y` | Position |
| `text` | Text content |
| `fontSize` | Font size in pixels |
| `rotate` | Rotation angle in degrees |

## Examples

### Label Points
```javascript
Plot.plot({
  marks: [
    Plot.dot(data, {x: "x", y: "y"}),
    Plot.text(data, {x: "x", y: "y", text: "label", dy: -8})
  ]
})
```

### Bar Labels
```javascript
Plot.plot({
  marks: [
    Plot.barY(data, {x: "category", y: "value"}),
    Plot.text(data, {
      x: "category",
      y: "value",
      text: d => d.value.toFixed(1),
      dy: -6,
      lineAnchor: "bottom"
    })
  ]
})
```

### Multi-line Text
```javascript
Plot.text([{text: "Line 1\nLine 2\nLine 3"}], {
  text: "text",
  lineHeight: 1.2
}).plot()
```

### Text with Wrapping
```javascript
Plot.text([longText], {
  lineWidth: 30,  // Characters per line
  frameAnchor: "top-left"
}).plot()
```

### Annotations
```javascript
Plot.text(
  ["Important point"],
  {x: 100, y: 50, frameAnchor: "bottom"}
).plot()
```

### Rotated Labels
```javascript
Plot.text(data, {
  x: "category",
  y: 0,
  text: "category",
  rotate: -45,
  textAnchor: "end"
}).plot()
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `textAnchor` | middle | Horizontal alignment (start, middle, end) |
| `lineAnchor` | middle | Vertical alignment (top, middle, bottom) |
| `frameAnchor` | middle | Position within frame |
| `lineHeight` | 1 | Line spacing in ems |
| `lineWidth` | Infinity | Wrap width in ems |
| `fontFamily` | system-ui | Font family |
| `fontSize` | 10 | Font size in pixels |
| `fontWeight` | normal | Font weight |
| `fontStyle` | normal | Font style |
| `paintOrder` | stroke | Render order for halos |
| `strokeWidth` | 3 | Halo thickness |

## Text Overflow Options

- `clip` - Clip overflowing text
- `ellipsis` - Add ellipsis at end
- `clip-end`, `clip-start` - Clip at specific end
- `ellipsis-start`, `ellipsis-middle`, `ellipsis-end` - Ellipsis position

## Notes

- Use `monospace: true` for tabular data alignment
- For number/date formatting, use d3-format or toLocaleString
- Set `paintOrder: "stroke"` for text halos (outlines)
- Use `dy` for vertical offset, `dx` for horizontal offset
