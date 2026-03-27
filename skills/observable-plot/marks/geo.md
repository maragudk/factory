# Geo Mark

The geo mark renders GeoJSON features for geographic/map visualizations.

## Constructors

```javascript
Plot.geo(data, options)       // GeoJSON features
Plot.sphere(options)          // Globe outline
Plot.graticule(options)       // Grid lines (10° spacing)
```

## Channels

| Channel | Description |
|---------|-------------|
| `geometry` | GeoJSON geometry (defaults to data) |
| `fill` | Fill color |
| `stroke` | Stroke color |
| `r` | Radius for Point geometries |

## Examples

### Choropleth Map
```javascript
Plot.plot({
  projection: "albers-usa",
  color: {scheme: "Blues", legend: true},
  marks: [
    Plot.geo(states, {fill: d => data.get(d.id)})
  ]
})
```

### World Map with Graticule
```javascript
Plot.plot({
  projection: "equal-earth",
  marks: [
    Plot.sphere({fill: "lightblue"}),
    Plot.graticule({stroke: "white", strokeOpacity: 0.5}),
    Plot.geo(countries, {fill: "forestgreen"})
  ]
})
```

### Point Map
```javascript
Plot.plot({
  projection: "albers-usa",
  marks: [
    Plot.geo(states, {fill: "#eee", stroke: "white"}),
    Plot.dot(cities, {
      x: "longitude",
      y: "latitude",
      r: "population",
      fill: "red"
    })
  ]
})
```

### Sized Points on Map
```javascript
Plot.geo(earthquakes, {
  r: "magnitude",
  fill: "red",
  fillOpacity: 0.3
}).plot({
  projection: "equal-earth"
})
```

### Faceted Maps
```javascript
Plot.plot({
  projection: "albers-usa",
  facet: {data: stores, y: "decade"},
  marks: [
    Plot.geo(states, {fill: "#eee", stroke: "white"}),
    Plot.dot(stores, {x: "longitude", y: "latitude"})
  ]
})
```

## Projection Options

Configure via the `projection` plot option:

```javascript
Plot.plot({
  projection: {
    type: "albers-usa",
    domain: stateGeoJSON,  // Fit to bounds
    inset: 20
  },
  marks: [...]
})
```

## Common Projections

| Projection | Use Case |
|------------|----------|
| `equirectangular` | Simple world map |
| `equal-earth` | Equal-area world map |
| `mercator` | Web maps (preserves shapes) |
| `albers-usa` | US with Alaska/Hawaii insets |
| `orthographic` | Globe view |
| `conic-conformal` | Regional maps |

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `fill` | none | Fill color |
| `stroke` | currentColor | Stroke color |
| `r` | 3 | Point radius (for Point geometries) |

## Notes

- Data can be a single GeoJSON object, FeatureCollection, or array
- Plot searches `properties` object for field names
- For choropleths, equal-area projections are recommended
- Use `clip: "sphere"` to clip at projection boundaries
- The `r` channel creates an sqrt scale by default
