# Facets

Faceting creates small multiples by partitioning data and repeating the visualization for each partition.

## Basic Usage

```javascript
Plot.plot({
  facet: {data, x: "region"},
  marks: [Plot.dot(data, {x: "income", y: "lifeExpectancy"})]
})
```

Or using fx/fy channels:

```javascript
Plot.dot(data, {
  x: "income",
  y: "lifeExpectancy",
  fx: "region"
}).plot()
```

## Facet Dimensions

| Channel | Description |
|---------|-------------|
| `fx` | Horizontal faceting |
| `fy` | Vertical faceting |

```javascript
// Horizontal facets
Plot.dot(data, {x: "x", y: "y", fx: "category"}).plot()

// Vertical facets
Plot.dot(data, {x: "x", y: "y", fy: "category"}).plot()

// Grid of facets
Plot.dot(data, {x: "x", y: "y", fx: "col", fy: "row"}).plot()
```

## Plot-Level Facet Options

```javascript
Plot.plot({
  facet: {
    data: data,
    x: "category",
    y: "subcategory",
    marginTop: 50,
    marginRight: 50,
    marginBottom: 50,
    marginLeft: 50,
    grid: true,
    label: null  // Hide labels
  },
  marks: [...]
})
```

## Facet Scales

Facet scales (fx, fy) are band scales:

```javascript
Plot.plot({
  fx: {
    padding: 0.1,
    round: true,
    align: 0.5
  },
  marks: [Plot.dot(data, {x: "x", y: "y", fx: "category"})]
})
```

## Mark Facet Options

Control how marks interact with facets:

```javascript
Plot.dot(data, {
  x: "x",
  y: "y",
  facet: "include"  // or "exclude", "super", null
})
```

| Value | Description |
|-------|-------------|
| `"auto"` | Auto-detect (default) |
| `"include"` / `true` | Show data in matching facet |
| `"exclude"` | Show data NOT in current facet |
| `"super"` | Single frame covering all facets |
| `null` / `false` | Repeat across all facets |

## Mixed Faceting

Combine faceted and non-faceted marks:

```javascript
Plot.plot({
  fy: "species",
  marks: [
    // Faceted data
    Plot.dot(data, {x: "x", y: "y", fy: "species"}),
    // Repeated across facets (context)
    Plot.ruleY([0])
  ]
})
```

## Facet Wrapping

Compute row/column for wrapped layout:

```javascript
const n = 4;  // Columns
Plot.dot(data.map((d, i) => ({
  ...d,
  col: i % n,
  row: Math.floor(i / n)
})), {
  x: "x",
  y: "y",
  fx: "col",
  fy: "row"
}).plot()
```

## Facet Anchoring

Control where marks appear relative to facets:

```javascript
Plot.text(data, {
  x: "x",
  y: "y",
  fx: "category",
  facetAnchor: "top"  // or "bottom", "left", "right", null
})
```

## Highlighting Specific Facet

```javascript
Plot.plot({
  fy: "species",
  marks: [
    Plot.frame({fy: "setosa", stroke: "red"}),  // Highlight one
    Plot.dot(data, {x: "x", y: "y", fy: "species"})
  ]
})
```

## Annotations in Facets

Target specific facets with single-element arrays:

```javascript
Plot.text(
  [{text: "Note", fx: "A", x: 50, y: 100}],
  {x: "x", y: "y", fx: "fx", text: "text"}
)
```
