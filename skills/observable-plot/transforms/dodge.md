# Dodge Transform

The dodge transform positions marks to avoid overlapping, creating beeswarm plots.

## Constructors

```javascript
Plot.dodgeX(options)  // Compute x from y
Plot.dodgeY(options)  // Compute y from x
```

## Basic Usage

```javascript
// Beeswarm plot
Plot.dot(data, Plot.dodgeY({x: "value"}))
```

## Examples

### Basic Beeswarm
```javascript
Plot.dotX(data, Plot.dodgeY({
  x: "value",
  fill: "currentColor"
})).plot()
```

### Grouped Beeswarm
```javascript
Plot.dot(data, Plot.dodgeY({
  x: "value",
  fy: "category",
  fill: "category"
})).plot()
```

### Middle Anchor (Symmetric)
```javascript
Plot.dot(data, Plot.dodgeY("middle", {
  x: "value"
})).plot()
```

### With Facets
```javascript
Plot.dot(data, Plot.dodgeX("middle", {
  fx: "species",
  y: "measurement",
  fill: "sex"
})).plot({y: {grid: true}})
```

### Variable Radius
```javascript
Plot.dot(data, Plot.dodgeY({
  x: "value",
  r: "importance",
  fill: "category",
  sort: "importance"  // Largest first
})).plot()
```

### With Images
```javascript
Plot.image(data, Plot.dodgeY({
  x: "score",
  src: "avatar",
  r: 20
})).plot()
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `padding` | 1 | Extra pixels added to mark radius |
| `anchor` | varies | Layout baseline position |

## Anchor Values

**dodgeX:**
- `"left"` (default) - Grow rightward
- `"middle"` - Symmetric piles
- `"right"` - Grow leftward

**dodgeY:**
- `"bottom"` (default) - Grow upward
- `"middle"` - Symmetric piles
- `"top"` - Grow downward

## Shorthand Syntax

```javascript
// Full syntax
Plot.dodgeY({anchor: "middle"}, options)

// Shorthand
Plot.dodgeY("middle", options)
```

## Notes

- Uses a greedy algorithm to place marks sequentially
- With variable radius, dots sort by descending radius by default
- Pair with `sort` option for controlled ordering
- Works best with dot, circle, and image marks
- The `padding` option adds spacing between marks
