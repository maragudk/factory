# Cell API Reference

Work with individual cells, including cross-notebook execution and testing.

## Cell Basics

Cells are the fundamental execution units in marimo notebooks. Each cell:
- Defines variables (accessible to other cells)
- References variables (from other cells)
- Produces output (displayed in the notebook)
- Can be imported and run independently

## Cell Structure

```python
import marimo

app = marimo.App()

@app.cell
def _():
    # Cell without inputs
    x = 42
    return (x,)

@app.cell
def _(x):
    # Cell with input 'x' from another cell
    y = x * 2
    return (y,)

@app.cell
def _(x, y):
    # Cell with multiple inputs
    result = x + y
    return (result,)
```

## Cell Properties

### defs

Variables defined by the cell.

```python
from my_notebook import calculate

calculate.defs  # Set of variable names defined
# e.g., {"result", "intermediate"}
```

### refs

Variables referenced (inputs) by the cell.

```python
from my_notebook import calculate

calculate.refs  # Set of variable names used as inputs
# e.g., {"input_data", "config"}
```

### name

The cell's identifier (if named).

```python
@app.cell(name="process_data")
def _(data):
    result = process(data)
    return (result,)

# Later
from my_notebook import process_data
process_data.name  # "process_data"
```

## Running Cells

### cell.run

Execute a cell and get its output and definitions.

```python
from my_notebook import calculate

# Run with automatic dependency resolution
output, defs = calculate.run()

# output: The cell's visual output (if any)
# defs: Dict of variable names to values
result = defs["result"]
```

### With Parameter Override

```python
# Override input values
output, defs = calculate.run(x=10, y=20)

# The cell runs with x=10, y=20 instead of
# resolving them from parent cells
```

### Automatic Dependency Resolution

When parameters aren't provided, marimo runs parent cells:

```python
# If calculate depends on prepare
# and prepare depends on load_data

output, defs = calculate.run()
# Automatically runs: load_data -> prepare -> calculate
```

```python
# Override one dependency
output, defs = calculate.run(prepared_data=my_data)
# Only runs calculate, skips load_data and prepare
```

## Async Cells

Async cells return awaitables:

```python
@app.cell
async def _(url):
    data = await fetch_data(url)
    return (data,)

# Running async cell
from my_notebook import fetch_cell

output, defs = await fetch_cell.run(url="https://api.example.com")
```

## UI Elements in Cells

When a cell's output contains interactive UI elements stored in `defs`, frontend interactions trigger reactive execution:

```python
@app.cell
def _():
    slider = mo.ui.slider(0, 100)
    return (slider,)

# When embedded or run, slider interactions
# trigger dependent cells to re-execute
```

## Named Cells

Give cells names for clearer imports:

```python
@app.cell(name="load_config")
def _():
    config = load_config_file()
    return (config,)

@app.cell(name="process_data")
def _(config, raw_data):
    processed = transform(raw_data, config)
    return (processed,)

# Import by name
from my_notebook import load_config, process_data
```

## Testing Cells

### With pytest

```python
# test_notebook.py
import pytest
from my_notebook import process_data, validate_input

def test_process_data():
    """Test the process_data cell."""
    output, defs = process_data.run(
        raw_data=[1, 2, 3],
        config={"scale": 2}
    )
    assert defs["processed"] == [2, 4, 6]

def test_validate_input():
    """Test validation logic."""
    output, defs = validate_input.run(data=None)
    assert defs["is_valid"] == False

def test_validate_input_with_data():
    output, defs = validate_input.run(data=[1, 2, 3])
    assert defs["is_valid"] == True
```

### Testing with Fixtures

```python
import pytest
from my_notebook import analyze

@pytest.fixture
def sample_data():
    return pd.DataFrame({"x": [1, 2, 3], "y": [4, 5, 6]})

def test_analyze(sample_data):
    output, defs = analyze.run(df=sample_data)
    assert "summary" in defs
    assert defs["summary"]["mean_x"] == 2.0
```

### Testing Output

```python
def test_cell_output():
    output, defs = report_cell.run(data=test_data)

    # Check output exists
    assert output is not None

    # Check output content (if HTML)
    assert "Summary" in str(output)
```

## Cross-Notebook Imports

### Basic Import

```python
# main_notebook.py
from utils_notebook import helper_function, process

result = helper_function(data)
processed = process(raw_data)
```

### Import and Run Cell

```python
from data_loader import load_data

# Run the cell to get fresh data
output, defs = load_data.run(path="data.csv")
df = defs["df"]
```

### Selective Execution

```python
from pipeline import step1, step2, step3

# Run only what you need
_, defs1 = step1.run(raw_data=my_data)
_, defs3 = step3.run(
    intermediate=defs1["processed"],
    config=my_config
)
# Skipped step2 entirely
```

## Best Practices

### Clear Cell Boundaries

```python
# Good - single responsibility
@app.cell(name="load_data")
def _():
    df = pd.read_csv("data.csv")
    return (df,)

@app.cell(name="clean_data")
def _(df):
    cleaned = df.dropna()
    return (cleaned,)

# Avoid - too much in one cell
@app.cell
def _():
    df = pd.read_csv("data.csv")
    cleaned = df.dropna()
    transformed = cleaned.apply(...)
    result = analyze(transformed)
    return (df, cleaned, transformed, result,)
```

### Name Important Cells

```python
# Name cells you'll import or test
@app.cell(name="calculate_metrics")
def _(data):
    metrics = compute_metrics(data)
    return (metrics,)

# Anonymous cells are fine for display-only
@app.cell
def _(metrics):
    mo.md(f"Metrics: {metrics}")
    return ()
```

### Design for Testability

```python
# Testable - clear inputs and outputs
@app.cell(name="transform")
def _(df, config):
    result = apply_transform(df, config)
    return (result,)

# Hard to test - hidden dependencies
@app.cell
def _():
    # Uses global state
    result = process(GLOBAL_DATA)
    return (result,)
```

### Document Cell Purpose

```python
@app.cell(name="feature_engineering")
def _(raw_features):
    """
    Transform raw features into model-ready format.

    Input: raw_features (DataFrame)
    Output: engineered (DataFrame with new columns)
    """
    engineered = create_features(raw_features)
    return (engineered,)
```
