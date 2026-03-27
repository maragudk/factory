# Delaunay Marks

The Delaunay marks compute and visualize Delaunay triangulation, Voronoi tessellation, and convex hull.

## Constructors

```javascript
Plot.voronoi(data, options)       // Voronoi cells
Plot.voronoiMesh(data, options)   // Voronoi cell boundaries
Plot.delaunayMesh(data, options)  // Delaunay triangles
Plot.delaunayLink(data, options)  // Delaunay edges
Plot.hull(data, options)          // Convex hull
```

## Channels

| Channel | Description |
|---------|-------------|
| `x`, `y` | Point positions |
| `z`, `fill`, `stroke` | Grouping for separate tessellations |

## Examples

### Voronoi Diagram
```javascript
Plot.voronoi(data, {
  x: "x",
  y: "y",
  fill: "category"
}).plot()
```

### Voronoi Mesh
```javascript
Plot.plot({
  marks: [
    Plot.voronoiMesh(data, {x: "x", y: "y"}),
    Plot.dot(data, {x: "x", y: "y"})
  ]
})
```

### Delaunay Triangulation
```javascript
Plot.plot({
  marks: [
    Plot.delaunayMesh(data, {x: "x", y: "y"}),
    Plot.dot(data, {x: "x", y: "y"})
  ]
})
```

### Delaunay Links with Color
```javascript
Plot.delaunayLink(data, {
  x: "x",
  y: "y",
  stroke: "category"
}).plot()
```

### Convex Hull
```javascript
Plot.plot({
  marks: [
    Plot.hull(data, {x: "x", y: "y", fill: "#ddd"}),
    Plot.dot(data, {x: "x", y: "y"})
  ]
})
```

### Grouped Hulls
```javascript
Plot.hull(data, {
  x: "x",
  y: "y",
  fill: "category",
  fillOpacity: 0.3
}).plot()
```

### With Projection
```javascript
Plot.plot({
  projection: "albers-usa",
  marks: [
    Plot.voronoiMesh(cities, {x: "longitude", y: "latitude"}),
    Plot.dot(cities, {x: "longitude", y: "latitude"})
  ]
})
```

## Mark-Specific Options

### voronoi
| Option | Default | Description |
|--------|---------|-------------|
| `fill` | none | Cell fill |
| `stroke` | currentColor | Cell border |

### voronoiMesh / delaunayMesh
| Option | Default | Description |
|--------|---------|-------------|
| `stroke` | currentColor | Line color |
| `strokeOpacity` | 0.2 | Line opacity |

### delaunayLink
Supports all link mark options (stroke, strokeWidth, marker, etc.)

### hull
| Option | Default | Description |
|--------|---------|-------------|
| `stroke` | currentColor | Hull border |
| `fill` | none | Hull fill |

## Notes

- One-dimensional data (x or y only) is supported
- Specifying `z`, `stroke`, or `fill` creates separate tessellations per group
- Works with Plot's projection system for geographic visualization
- delaunayLink aesthetic values inherit from endpoints arbitrarily
- Hull groups by z, or defaults to fill or stroke channel
