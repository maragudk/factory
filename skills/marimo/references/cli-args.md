# CLI Arguments API Reference

Access command-line arguments when running notebooks as scripts.

## Overview

marimo notebooks can be run as Python scripts with command-line arguments:

```bash
python notebook.py -- --arg1 value1 --arg2 value2
```

The `--` separator distinguishes notebook arguments from Python arguments.

## Basic Usage

### mo.cli_args

Get parsed command-line arguments.

```python
import marimo as mo

# Get CLI args (dict-like object)
args = mo.cli_args()

# Read argument with default
learning_rate = args.get("lr", 0.001)
epochs = args.get("epochs", 10)

# Check if argument provided
if "output" in args:
    save_results(args["output"])
```

## Running with Arguments

### From Command Line

```bash
# Basic usage
python notebook.py -- --lr 0.001 --epochs 50

# Multiple arguments
python notebook.py -- --input data.csv --output results.json --verbose

# With marimo run
marimo run notebook.py -- --config production
```

### Argument Formats

```bash
# Key-value pairs
python notebook.py -- --name value
python notebook.py -- --name=value

# Flags parsed as boolean
python notebook.py -- --verbose=true
python notebook.py -- --debug=false

# Numeric values auto-converted
python notebook.py -- --count=10      # int
python notebook.py -- --rate=0.5      # float

# Lists (repeated arguments)
python notebook.py -- --tag important --tag urgent
# Results in: {"tag": ["important", "urgent"]}
```

## Type Conversion

`mo.cli_args()` automatically converts string arguments:

| Input | Parsed Type | Value |
|-------|-------------|-------|
| `--count=10` | int | `10` |
| `--rate=0.5` | float | `0.5` |
| `--flag=true` | bool | `True` |
| `--flag=false` | bool | `False` |
| `--name=hello` | str | `"hello"` |

## Using sys.argv

For more control, access raw arguments via `sys.argv`:

```python
import sys

# sys.argv after -- separator
# python notebook.py -- --lr 0.001 --epochs 50
# sys.argv = ["notebook.py", "--lr", "0.001", "--epochs", "50"]

print(sys.argv)
```

## Robust Argument Parsing

For complex argument handling, use `argparse` or `simple-parsing`:

### With argparse

```python
import argparse
import sys

parser = argparse.ArgumentParser(description="Training script")
parser.add_argument("--lr", type=float, default=0.001, help="Learning rate")
parser.add_argument("--epochs", type=int, default=10, help="Number of epochs")
parser.add_argument("--model", choices=["cnn", "rnn", "transformer"], default="cnn")
parser.add_argument("--verbose", action="store_true")

args = parser.parse_args()

# Use parsed arguments
learning_rate = args.lr
epochs = args.epochs
model_type = args.model
```

### With simple-parsing

```python
from dataclasses import dataclass
from simple_parsing import parse

@dataclass
class Config:
    lr: float = 0.001
    epochs: int = 10
    model: str = "cnn"
    verbose: bool = False

config = parse(Config)

# Use typed config
learning_rate = config.lr
```

## Conditional Execution

```python
args = mo.cli_args()

# Skip interactive elements in script mode
if mo.app_meta().mode == "script":
    # Use CLI args directly
    threshold = args.get("threshold", 0.5)
else:
    # Show interactive UI
    threshold = mo.ui.slider(0, 1, value=0.5).value
```

## Complete Example

```python
# Cell 1: Parse arguments
import marimo as mo

args = mo.cli_args()

# With defaults
config = {
    "input": args.get("input", "data.csv"),
    "output": args.get("output", "results.json"),
    "threshold": float(args.get("threshold", 0.5)),
    "verbose": args.get("verbose", False)
}

mo.md(f"**Configuration:** {config}")

# Cell 2: Load data
import pandas as pd

df = pd.read_csv(config["input"])
mo.md(f"Loaded {len(df)} rows from `{config['input']}`")

# Cell 3: Process
filtered = df[df["score"] > config["threshold"]]

if config["verbose"]:
    mo.md(f"Filtered to {len(filtered)} rows (threshold: {config['threshold']})")

# Cell 4: Save results
import json

results = filtered.to_dict(orient="records")
with open(config["output"], "w") as f:
    json.dump(results, f)

mo.md(f"Saved results to `{config['output']}`")
```

Run with:

```bash
python notebook.py -- --input sales.csv --output filtered.json --threshold 0.7 --verbose=true
```

## Best Practices

### Provide Defaults

```python
args = mo.cli_args()

# Always have sensible defaults
input_file = args.get("input", "default_input.csv")
output_file = args.get("output", "output.json")
```

### Validate Arguments

```python
args = mo.cli_args()

input_file = args.get("input")
if input_file and not Path(input_file).exists():
    mo.stop(True, mo.callout(f"Input file not found: {input_file}", kind="danger"))
```

### Document Arguments

```python
# At the top of notebook
mo.md("""
## Usage

```bash
python notebook.py -- --input FILE --output FILE [--threshold FLOAT] [--verbose]
```

**Arguments:**
- `--input`: Input CSV file (required)
- `--output`: Output JSON file (required)
- `--threshold`: Filter threshold (default: 0.5)
- `--verbose`: Enable verbose output
""")
```

### Handle Script vs Interactive Mode

```python
mode = mo.app_meta().mode

if mode == "script":
    # CLI mode - use arguments
    value = mo.cli_args().get("value", 50)
else:
    # Interactive mode - show UI
    slider = mo.ui.slider(0, 100, value=50)
    value = slider.value
```

## Limitations

- Arguments must come after `--` separator
- Complex nested structures not supported (use JSON files instead)
- No built-in help generation (use argparse for that)
