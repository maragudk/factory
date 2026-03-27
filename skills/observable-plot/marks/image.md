# Image Mark

The image mark renders images at x/y positions, useful for scatter plots with image glyphs.

## Constructor

```javascript
Plot.image(data, options)
```

## Channels

| Channel | Description |
|---------|-------------|
| `x`, `y` | Position |
| `src` | Image URL or path |
| `width`, `height` | Dimensions in pixels |
| `r` | Radius for circular clipping |
| `rotate` | Rotation in degrees |

## Examples

### Basic Image Scatter
```javascript
Plot.image(data, {
  x: "score",
  y: "rating",
  src: "imageUrl"
}).plot()
```

### Fixed Size Images
```javascript
Plot.image(data, {
  x: "x",
  y: "y",
  src: "photo",
  width: 40,
  height: 40
}).plot()
```

### Circular Cropped Images
```javascript
Plot.image(data, {
  x: "x",
  y: "y",
  src: "avatar",
  r: 20  // Circular clip with 20px radius
}).plot()
```

### Presidential Portraits
```javascript
Plot.image(presidents, {
  x: "favorability",
  y: "unfavorability",
  src: "portrait",
  width: 50,
  r: 25
}).plot()
```

### With Dodge Transform
```javascript
Plot.image(data, Plot.dodgeY({
  x: "category",
  src: "image",
  r: 20
})).plot()
```

### Variable Size
```javascript
Plot.image(data, {
  x: "x",
  y: "y",
  src: "url",
  width: d => d.importance * 10,
  height: d => d.importance * 10
}).plot()
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `src` | required | Image URL (constant or channel) |
| `width` | 16 | Image width in pixels |
| `height` | 16 | Image height in pixels |
| `r` | - | Radius for circular clipping |
| `rotate` | 0 | Rotation in degrees |
| `preserveAspectRatio` | "xMidYMid meet" | Aspect ratio handling |
| `crossOrigin` | - | CORS setting |
| `imageRendering` | "auto" | Rendering mode |
| `frameAnchor` | "middle" | Position within frame |

## preserveAspectRatio Options

- `"xMidYMid meet"` - Fit image, preserve aspect ratio (default)
- `"xMidYMid slice"` - Fill and crop to fit
- `"none"` - Stretch to fit

## Notes

- Images are drawn in input order (later images on top)
- Use `r` option for circular avatar-style clipping
- The image mark does not support fill or stroke
- Set `imageRendering: "pixelated"` for sharp scaling of pixel art
- Default size is 16×16 pixels
