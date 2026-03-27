# Tree Mark

The tree mark creates hierarchical tree diagrams from path-based data.

## Constructors

```javascript
Plot.tree(data, options)     // Tidy tree layout
Plot.cluster(data, options)  // Cluster layout (leaf-aligned)
```

## Data Format

Path-delimited strings representing hierarchy:

```javascript
const data = [
  "root/child1/grandchild1",
  "root/child1/grandchild2",
  "root/child2/grandchild3"
];
```

## Examples

### Basic Tree
```javascript
Plot.tree(hierarchy).plot()
```

### With Text Labels
```javascript
Plot.tree(hierarchy, {
  textStroke: "white"  // Label halo
}).plot()
```

### Cluster Layout
```javascript
Plot.cluster(hierarchy).plot()
```

### Flare Visualization
```javascript
Plot.tree(flare, {
  textStroke: "white",
  treeLayout: d3.tree,
  dx: 10,
  dy: 100
}).plot({
  height: 2000,
  marginLeft: 100
})
```

### Custom Node Styling
```javascript
Plot.tree(data, {
  fill: "node:internal",  // Color internal vs leaf nodes
  stroke: "node:internal"
}).plot()
```

### Horizontal Tree
```javascript
Plot.tree(hierarchy, {
  textLayout: "normal",
  treeLayout: d3.tree().nodeSize([20, 150])
}).plot({
  marginLeft: 100,
  marginRight: 100
})
```

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `path` | identity | Slash-separated path accessor |
| `treeLayout` | d3.tree | Layout function |
| `textLayout` | varies | Label positioning ("mirrored" or "normal") |
| `text` | node:name | Label text |
| `title` | node:path | Tooltip text |
| `fill` | node:internal | Node color |
| `stroke` | fill | Link color |
| `textStroke` | white | Label halo color |
| `dot` | false | Show node dots |
| `dx` | 6 | Horizontal text offset |
| `dy` | 0 | Vertical text offset |

## Node Properties

Special node accessors:
- `node:name` - Node name (last path segment)
- `node:path` - Full path
- `node:internal` - Boolean (true for non-leaf nodes)
- `node:depth` - Depth in tree
- `node:height` - Height (distance to deepest leaf)

## Components

The tree mark is a composite of:
1. **Links** - Parent-child connections (treeLink transform)
2. **Dots** - Node circles (optional)
3. **Text** - Node labels

## Notes

- Manual height and margin adjustment often required
- Use `cluster` for leaf-aligned layouts
- The `textLayout: "mirrored"` option mirrors labels on left/right sides
- Supports custom d3 tree layouts via `treeLayout` option
