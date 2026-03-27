# Projections

Projections map geographic coordinates (longitude, latitude) to screen positions for map visualizations.

## Basic Usage

```javascript
Plot.plot({
  projection: "equal-earth",
  marks: [
    Plot.geo(countries)
  ]
})
```

## Built-in Projections

| Projection | Description |
|------------|-------------|
| `equirectangular` | Plate carrée (simple) |
| `equal-earth` | Equal-area world map |
| `mercator` | Web maps (shapes preserved) |
| `orthographic` | Globe view |
| `stereographic` | Preserves circles |
| `azimuthal-equal-area` | Equal-area from point |
| `azimuthal-equidistant` | Equal distance from point |
| `conic-conformal` | Regional (shapes) |
| `conic-equal-area` | Regional (areas) |
| `conic-equidistant` | Regional (distances) |
| `gnomonic` | Great circles as lines |
| `transverse-mercator` | Rotated Mercator |
| `albers` | Conic equal-area |
| `albers-usa` | US with Alaska/Hawaii |
| `identity` | Planar geometry |
| `reflect-y` | Identity with flipped y |
| `null` | Pre-projected coordinates |

## Configuration

```javascript
Plot.plot({
  projection: {
    type: "albers-usa",
    domain: statesGeoJSON,  // Fit to bounds
    inset: 10,              // Padding
    rotate: [0, 0, 0]       // Euler angles
  },
  marks: [...]
})
```

## Options

| Option | Description |
|--------|-------------|
| `type` | Projection name |
| `domain` | GeoJSON to fit in frame |
| `inset` | Padding in pixels |
| `rotate` | [λ, φ, γ] Euler angles |
| `parallels` | Standard parallels (conic) |
| `precision` | Sampling threshold |
| `clip` | Clipping method |

## Clipping

```javascript
{
  projection: {
    type: "orthographic",
    clip: true  // Clip to frame
  }
}

// Or clip to sphere
{clip: "sphere"}

// Or clip to angle
{clip: 90}  // Great circle radius in degrees
```

## Common Patterns

### US Map
```javascript
Plot.plot({
  projection: "albers-usa",
  marks: [
    Plot.geo(states, {fill: d => data.get(d.id)})
  ]
})
```

### World Map
```javascript
Plot.plot({
  projection: "equal-earth",
  marks: [
    Plot.sphere({fill: "lightblue"}),
    Plot.graticule({stroke: "white"}),
    Plot.geo(countries, {fill: "green"})
  ]
})
```

### Globe
```javascript
Plot.plot({
  projection: {
    type: "orthographic",
    rotate: [-100, -40]  // Center on location
  },
  marks: [
    Plot.sphere({fill: "lightblue"}),
    Plot.geo(countries)
  ]
})
```

### Fit to Region
```javascript
Plot.plot({
  projection: {
    type: "conic-conformal",
    domain: regionGeoJSON
  },
  marks: [Plot.geo(regionGeoJSON)]
})
```

## Points on Maps

```javascript
Plot.plot({
  projection: "albers-usa",
  marks: [
    Plot.geo(states, {fill: "#eee"}),
    Plot.dot(cities, {x: "longitude", y: "latitude", r: 3})
  ]
})
```

## Notes

- For choropleths, use equal-area projections
- Marks with x1/y1/x2/y2 project both points
- Lines become geodesics with spherical projections
- Band scale marks (bars, cells, ticks) can't use projections
- Use `clip: "sphere"` for globe clipping
