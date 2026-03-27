# App API Reference

Work with marimo notebooks programmatically, embed notebooks, and access runtime metadata.

## App Class

### marimo.App

Represents a marimo notebook as a dataflow graph.

```python
import marimo

# In a notebook file
app = marimo.App()

@app.cell
def _():
    x = 42
    return (x,)

@app.cell
def _(x):
    result = x * 2
    return (result,)

if __name__ == "__main__":
    app.run()
```

## Embedding Notebooks

### app.embed

Embed one notebook's output into another (async).

```python
import marimo as mo

# Import another notebook
from other_notebook import app as other_app

# Embed it
async def embed_notebook():
    result = await other_app.embed()
    return result.output

# In a cell
output = await other_app.embed()
output.output  # Visual output
output.defs    # Variable definitions
```

With parameter override:

```python
# Override definitions in embedded notebook
result = await other_app.embed(defs={"threshold": 0.8})

# The embedded notebook runs with threshold=0.8
# instead of its default value
```

### Nested Embedding

Notebooks can be nested multiple levels:

```python
# notebook_a.py embeds notebook_b.py
# notebook_b.py embeds notebook_c.py
# All work correctly with reactive updates
```

### Interactive Embedded Notebooks

When embedded notebooks contain UI elements, interactions trigger updates:

```python
# other_notebook.py defines a slider
# When embedded, slider interactions update the parent notebook

result = await other_app.embed()
result.output  # Contains interactive slider
# Slider changes propagate reactively
```

## Running Programmatically

### app.run

Execute a notebook and get outputs.

```python
from my_notebook import app

# Run the notebook
outputs, definitions = app.run()

# outputs: Sequence of cell outputs
# definitions: Mapping of variable names to values

print(definitions["result"])  # Access computed value
```

With definition overrides:

```python
# Override input values
outputs, definitions = app.run(defs={
    "input_data": my_data,
    "config": my_config
})

# Cells defining input_data and config are skipped
# Their dependents run with the provided values
```

## App Metadata

### mo.app_meta

Access runtime information about the current app.

```python
import marimo as mo

meta = mo.app_meta()
```

### Properties

**mode**: Execution context.

```python
mode = mo.app_meta().mode

# Possible values:
# - "edit": Running in marimo editor
# - "run": Running as app (marimo run)
# - "script": Running as Python script
# - "test": Running in pytest
# - None: Unknown context
```

**theme**: Current display theme.

```python
theme = mo.app_meta().theme

# Possible values:
# - "light"
# - "dark"
```

**request**: HTTP request data (in app mode).

```python
request = mo.app_meta().request

# Access request information
request.headers      # HTTP headers
request.cookies      # Cookies
request.query_params # URL query parameters
request.user         # Authenticated user info (if available)
```

## Conditional Behavior

### Based on Mode

```python
mode = mo.app_meta().mode

if mode == "edit":
    # Show debug information
    mo.output.append(f"Debug: {debug_data}")
elif mode == "run":
    # Production app behavior
    pass
elif mode == "script":
    # Script execution
    print("Running as script")
```

### Based on Theme

```python
theme = mo.app_meta().theme

# Adapt visualization colors
if theme == "dark":
    bg_color = "#1a1a1a"
    text_color = "#ffffff"
else:
    bg_color = "#ffffff"
    text_color = "#000000"

# Use in plots
import matplotlib.pyplot as plt
plt.style.use("dark_background" if theme == "dark" else "default")
```

### Based on User

```python
request = mo.app_meta().request

if request and request.user:
    user_name = request.user.get("name", "Guest")
    mo.md(f"Welcome, {user_name}!")
else:
    mo.md("Please log in")
```

## Notebook as Module

Import and use notebooks as Python modules:

```python
# utils_notebook.py defines utility functions
from utils_notebook import process_data, validate_input

# Use exported functions
result = process_data(my_data)
```

Cells can be imported individually:

```python
from utils_notebook import calculate

# Run the cell
output, defs = calculate.run()
result = defs["result"]
```

## Testing Notebooks

```python
# test_notebook.py
import pytest
from my_notebook import app, process_cell

def test_process_cell():
    output, defs = process_cell.run(input_data=[1, 2, 3])
    assert defs["result"] == [2, 4, 6]

def test_full_notebook():
    outputs, defs = app.run(defs={"test_mode": True})
    assert defs["final_result"] is not None
```

## Best Practices

### Design for Embedding

```python
# Good - notebook has clear inputs and outputs
@app.cell
def _(input_data, config):  # Clear inputs
    result = process(input_data, config)
    return (result,)  # Clear output

# Avoid - hidden dependencies
@app.cell
def _():
    global_var = something  # Hard to override
```

### Check Mode Before UI

```python
mode = mo.app_meta().mode

if mode == "script":
    # Use CLI args or defaults
    threshold = mo.cli_args().get("threshold", 0.5)
else:
    # Show interactive UI
    threshold = mo.ui.slider(0, 1, value=0.5).value
```

### Handle Missing Request

```python
request = mo.app_meta().request

# Always check for None
if request is not None:
    user = request.user
else:
    user = None
```

### Export Clean APIs

```python
# In notebook, define clean interface
@app.cell
def _():
    def public_function(data):
        """Process data and return results."""
        return _internal_process(data)

    return (public_function,)

# Other notebooks can import and use
from my_notebook import public_function
```
