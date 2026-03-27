# Layouts API Reference

Layout components organize and display content in marimo notebooks and apps.

## Stacking

### hstack / vstack

Arrange elements horizontally or vertically.

```python
import marimo as mo

# Horizontal stack
mo.hstack([element1, element2, element3])

# With options
mo.hstack(
    [element1, element2],
    justify="space-between",  # "start", "center", "end", "space-between", "space-around"
    align="center",           # "start", "center", "end", "stretch"
    gap=2,                    # Spacing between items (in units)
    wrap=True                 # Wrap to next line if needed
)

# Vertical stack
mo.vstack([element1, element2, element3])

# Nested stacks
mo.hstack([
    mo.vstack([a, b]),
    mo.vstack([c, d])
])
```

## Alignment

### center / left / right

Position content horizontally.

```python
mo.center(element)
mo.left(element)
mo.right(element)

# Can also use Html methods
element.center()
element.left()
element.right()
```

## Containers

### accordion

Collapsible sections.

```python
mo.accordion({
    "Section 1": content1,
    "Section 2": content2,
    "Section 3": content3
})

# With options
mo.accordion(
    {"Section 1": content1, "Section 2": content2},
    multiple=True,    # Allow multiple open sections
    lazy=True         # Render content only when opened
)
```

### tabs

Tabbed content (stateful - tracks selected tab).

```python
tabs = mo.ui.tabs({
    "Overview": overview_content,
    "Details": details_content,
    "Settings": settings_content
})

# Access selected tab
selected = tabs.value
```

### callout

Highlighted content box.

```python
mo.callout("Important information here", kind="info")

# Kinds: "info", "warn", "danger", "success", "neutral"
mo.callout(content, kind="danger")
mo.callout(content, kind="success")

# Can also use Html method
element.callout(kind="warn")
```

### carousel

Slideshow of content.

```python
mo.carousel([slide1, slide2, slide3])
```

### sidebar

Side panel content.

```python
mo.sidebar([
    mo.md("# Navigation"),
    nav_menu,
    filters
])

# Sidebar content appears alongside main notebook content
```

## Navigation

### routes

Multi-page navigation.

```python
mo.routes({
    "/": home_page,
    "/about": about_page,
    "/users/{user_id}": user_page,  # Dynamic route
    mo.routes.CATCH_ALL: not_found_page
})
```

### nav_menu

Navigation menu component.

```python
nav = mo.ui.nav_menu({
    "Home": "/",
    "Products": {
        "Category A": "/products/a",
        "Category B": "/products/b"
    },
    "Contact": "/contact"
})
```

### outline

Table of contents from markdown headers.

```python
mo.outline()  # Auto-generates from notebook headings
```

## Data Display

### tree

Hierarchical data display.

```python
mo.tree({
    "Root": {
        "Child 1": {
            "Grandchild": "value"
        },
        "Child 2": ["item1", "item2"]
    }
})

# From nested dict/list
mo.tree(nested_data)
```

### json

JSON viewer with syntax highlighting.

```python
mo.json(data)

# With options
mo.json(data, name="config")
```

### stat

Statistics card.

```python
mo.stat(
    value="$1,234",
    label="Revenue",
    caption="vs last month",
    direction="increase",  # "increase", "decrease", None
    bordered=True
)

# Multiple stats
mo.hstack([
    mo.stat("150", "Users", direction="increase"),
    mo.stat("$5K", "Revenue", direction="increase"),
    mo.stat("3.2%", "Bounce Rate", direction="decrease")
])
```

## Performance

### lazy

Defer content rendering until visible.

```python
mo.lazy(expensive_content)

# Useful for large outputs or expensive computations
mo.lazy(lambda: generate_large_chart())
```

### plain

Remove default styling.

```python
mo.plain(content)

# Renders content without marimo's default formatting
```

## Layout Utilities

### justify

Wrapper for horizontal alignment.

```python
mo.justify(element, justify="center")
# justify: "start", "center", "end", "space-between", "space-around"
```

## Grid Layout (App Mode)

In app mode, configure grid layouts through the editor:

1. Open layout settings (gear icon)
2. Select "Grid" layout
3. Drag and drop cells to arrange
4. Resize cells as needed

Grid configuration saves to `layouts/` folder in notebook directory.

## Combining Layouts

```python
# Complex layout example
mo.vstack([
    mo.md("# Dashboard"),
    mo.hstack([
        mo.stat("100", "Total"),
        mo.stat("50", "Active"),
        mo.stat("25", "New")
    ]),
    mo.accordion({
        "Filters": mo.vstack([filter1, filter2]),
        "Settings": settings_panel
    }),
    mo.ui.tabs({
        "Chart": chart,
        "Table": table,
        "Raw Data": mo.json(data)
    })
])
```
