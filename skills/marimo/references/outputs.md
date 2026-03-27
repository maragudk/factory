# Outputs API Reference

Control cell outputs programmatically, including replacing, appending, and redirecting console output.

## Cell Output Modification

### mo.output.replace

Replace the current cell's output.

```python
import marimo as mo

# Replace output (default behavior for last expression)
mo.output.replace(mo.md("New output"))

# Multiple replacements - only last one shows
mo.output.replace("First")
mo.output.replace("Second")  # This is what displays
```

### mo.output.append

Build output incrementally by stacking vertically.

```python
# Append multiple outputs
mo.output.append("Line 1")
mo.output.append("Line 2")
mo.output.append("Line 3")

# Append in a loop
for i in range(5):
    result = process(i)
    mo.output.append(f"Processed {i}: {result}")
```

### mo.output.clear

Remove all current cell output.

```python
mo.output.clear()

# Then add new output
mo.output.append("Fresh start")
```

### mo.output.replace_at_index

Replace output at a specific position.

```python
# Build initial output
mo.output.append("Item 0")
mo.output.append("Item 1")
mo.output.append("Item 2")

# Replace specific item
mo.output.replace_at_index(1, "Updated Item 1")

# Append at end (index equals length)
mo.output.replace_at_index(3, "Item 3")
```

## Code Display

### mo.show_code

Display cell source code alongside output in app mode.

```python
# Show code above output
mo.show_code()

# Show code below output
mo.show_code(position="below")

# Show code with specific output
mo.show_code(output=my_chart, position="above")

# Default position is "above"
result = expensive_computation()
mo.show_code(output=result)
```

Use cases:
- Educational notebooks showing implementation
- Reproducible reports with visible methodology
- Debugging in app mode

## Console Output Redirection

By default, `print()` statements don't appear in marimo apps. Use these utilities to capture or redirect console output.

### mo.redirect_stdout / mo.redirect_stderr

Redirect console output to cell output area.

```python
# Redirect stdout to cell output
with mo.redirect_stdout():
    print("This appears in the cell output")
    print("So does this")

# Redirect stderr
with mo.redirect_stderr():
    import sys
    print("Error message", file=sys.stderr)

# Redirect both
with mo.redirect_stdout(), mo.redirect_stderr():
    print("stdout message")
    print("stderr message", file=sys.stderr)
```

### mo.capture_stdout / mo.capture_stderr

Capture console output to StringIO for programmatic access.

```python
from io import StringIO

# Capture stdout
with mo.capture_stdout() as stdout:
    print("Captured output")
    print("More output")

captured = stdout.getvalue()
mo.md(f"```\n{captured}\n```")

# Capture stderr
with mo.capture_stderr() as stderr:
    import warnings
    warnings.warn("A warning")

warning_text = stderr.getvalue()
```

## Working with External Libraries

### Capturing Library Output

```python
# Capture verbose library output
with mo.capture_stdout() as output:
    model.fit(X, y, verbose=True)

training_log = output.getvalue()
mo.md(f"**Training Log:**\n```\n{training_log}\n```")
```

### Redirecting Progress

```python
# Show training progress in cell
with mo.redirect_stdout():
    for epoch in range(100):
        loss = train_epoch()
        print(f"Epoch {epoch}: loss={loss:.4f}")
```

## Streaming Output

### Live Updates

```python
# Stream output during long operations
for i in range(10):
    result = process_step(i)
    mo.output.append(f"Step {i}: {result}")
    # Output updates in real-time
```

### With Threading

```python
def worker():
    thread = mo.current_thread()
    for i in range(100):
        if thread.should_exit:
            return
        mo.output.append(f"Progress: {i}%")

thread = mo.Thread(target=worker)
thread.start()
```

## Combining Output Methods

```python
# Clear and rebuild output
mo.output.clear()
mo.output.append(mo.md("# Results"))

for item in items:
    result = process(item)
    mo.output.append(mo.hstack([
        mo.md(f"**{item.name}:**"),
        mo.md(f"{result}")
    ]))

mo.output.append(mo.md("---\n*Processing complete*"))
```

## Output in Different Contexts

### Edit Mode vs App Mode

```python
mode = mo.app_meta().mode

if mode == "edit":
    # Show detailed debug output
    mo.output.append(f"Debug: {debug_info}")
elif mode == "run":
    # Clean output for app users
    pass
```

### Conditional Output

```python
verbose = mo.ui.checkbox(label="Show details")

if verbose.value:
    mo.output.append(mo.md("## Detailed Output"))
    for step, detail in enumerate(details):
        mo.output.append(f"Step {step}: {detail}")
```

## Best Practices

### Use append for Progressive Output

```python
# Good - shows progress
for item in items:
    mo.output.append(f"Processing {item}...")
    result = process(item)
    mo.output.append(f"  Result: {result}")

# Less informative - only shows final state
results = []
for item in items:
    results.append(process(item))
results  # Only shows at end
```

### Clear Before Rebuilding

```python
# Prevent duplicate output on re-run
mo.output.clear()

# Build fresh output
mo.output.append(header)
for item in items:
    mo.output.append(format_item(item))
```

### Capture for Processing

```python
# Use capture when you need the text
with mo.capture_stdout() as out:
    external_function()  # Prints to stdout

log_content = out.getvalue()
# Process or display log_content
```

### Redirect for Display

```python
# Use redirect when you just want to show output
with mo.redirect_stdout():
    verbose_function()  # Output appears in cell
```

## Limitations

- Output methods work per-cell
- Clearing one cell doesn't affect others
- Console redirection is synchronous
- Large outputs may impact performance
