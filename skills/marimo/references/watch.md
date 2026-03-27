# Watch API Reference

Reactive file system monitoring that triggers cell re-execution on changes.

## File Watching

### mo.watch.file

Watch a file for content changes.

```python
import marimo as mo

# Watch a file
config_file = mo.watch.file("config.json")

# Read content (cell re-runs when file changes)
content = config_file.read_text()
```

### mo.watch.directory

Watch a directory for structural changes (files added/removed).

```python
data_dir = mo.watch.directory("./data")

# List files (re-runs when directory changes)
files = list(data_dir.glob("*.csv"))
```

**Note**: Directory watching does NOT react to file content changes, only to files being added or removed.

## Common Patterns

```python
# Auto-reload config
config_file = mo.watch.file("config.yaml")
config = yaml.safe_load(config_file.read_text())

# Watch for new data files
data_dir = mo.watch.directory("./input")
for csv in data_dir.glob("*.csv"):
    process(csv)
```

## Caveats

- Don't write to watched files (causes loops)
- Directory watching is shallow
- Not available in WASM
