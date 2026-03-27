# Inputs API Reference

All input elements are available under `mo.ui`. Each element has a `.value` property that updates reactively when users interact with them.

## Common Patterns

```python
import marimo as mo

# Create element and display it
slider = mo.ui.slider(0, 100)
slider  # Display in cell

# Access value in another cell
result = slider.value * 2
```

All inputs support:
- `.form()` - Wrap in a submittable form
- `.batch()` - Combine with other elements
- `.style()` - Apply CSS styles
- `on_change` - Callback when value changes
- `label` - Markdown label text

## Numeric Inputs

### slider

Numeric value selection across an interval.

```python
# Basic slider
slider = mo.ui.slider(start=0, stop=100, value=50)

# With step
slider = mo.ui.slider(start=0, stop=100, step=5)

# Custom steps (e.g., logarithmic)
import numpy as np
slider = mo.ui.slider(steps=np.logspace(0, 3, 10))

# From DataFrame column
slider = mo.ui.slider.from_series(df["column"])

# With options
slider = mo.ui.slider(
    start=0, stop=100,
    value=50,
    label="Select value",
    show_value=True,        # Display current value
    include_input=True,     # Editable input field
    debounce=True,          # Update only on release
    orientation="vertical", # or "horizontal"
    full_width=True
)
```

### range_slider

Select a range of values.

```python
range_slider = mo.ui.range_slider(start=0, stop=100, value=[20, 80])
# Access: range_slider.value returns [low, high]
```

### number

Numeric input field with optional bounds.

```python
number = mo.ui.number(start=0, stop=100, value=50)
number = mo.ui.number(start=0, stop=100, step=0.1, label="Enter value")
```

## Text Inputs

### text

Single-line text input.

```python
text = mo.ui.text(placeholder="Enter name")
text = mo.ui.text(value="default", label="Name", max_length=100)
```

### text_area

Multi-line text input.

```python
textarea = mo.ui.text_area(placeholder="Enter description", rows=5)
textarea = mo.ui.text_area(value="", max_length=1000)
```

### code_editor

Syntax-highlighted code editor.

```python
editor = mo.ui.code_editor(language="python", value="def hello():\n    pass")
editor = mo.ui.code_editor(
    language="sql",
    theme="dark",
    min_height=200
)
```

## Selection Inputs

### dropdown

Single selection from options.

```python
dropdown = mo.ui.dropdown(["Option A", "Option B", "Option C"])
dropdown = mo.ui.dropdown(
    options={"Display A": "value_a", "Display B": "value_b"},
    value="value_a",
    label="Select option"
)
```

### multiselect

Multiple selection from options.

```python
multiselect = mo.ui.multiselect(["A", "B", "C", "D"])
multiselect = mo.ui.multiselect(
    options=["A", "B", "C"],
    value=["A", "B"],  # Pre-selected
    max_selections=2
)
```

### radio

Radio button group.

```python
radio = mo.ui.radio(["Option 1", "Option 2", "Option 3"])
radio = mo.ui.radio(
    options={"First": 1, "Second": 2},
    value=1,
    inline=True  # Horizontal layout
)
```

### checkbox

Single checkbox.

```python
checkbox = mo.ui.checkbox(label="I agree to terms")
checkbox = mo.ui.checkbox(value=True)  # Pre-checked
```

### switch

Toggle switch.

```python
switch = mo.ui.switch(label="Enable feature")
switch = mo.ui.switch(value=True)
```

## Date and Time

### date

Date picker.

```python
from datetime import date

date_picker = mo.ui.date(label="Select date")
date_picker = mo.ui.date(
    value=date.today(),
    start=date(2020, 1, 1),
    stop=date(2030, 12, 31)
)
```

### datetime

Date and time picker.

```python
datetime_picker = mo.ui.datetime(label="Select date and time")
```

### date_range

Date range selection.

```python
date_range = mo.ui.date_range(label="Select period")
# Access: date_range.value returns (start_date, end_date)
```

## Buttons

### button

Clickable button with optional value.

```python
button = mo.ui.button(label="Click me")
button = mo.ui.button(
    label="Submit",
    value=0,
    on_click=lambda value: value + 1  # Increment on click
)
```

### run_button

Button that gates cell execution.

```python
run_button = mo.ui.run_button(label="Run analysis")
# Use with mo.stop()
mo.stop(not run_button.value, mo.md("Click to run"))
```

### refresh

Auto-refresh button with interval.

```python
refresh = mo.ui.refresh(interval=5)  # Refresh every 5 seconds
refresh = mo.ui.refresh(
    options=["1s", "5s", "10s", "off"],
    default_interval="5s"
)
```

## File Inputs

### file

File upload.

```python
file = mo.ui.file(filetypes=[".csv", ".json"])
file = mo.ui.file(
    filetypes=[".csv"],
    multiple=True,  # Allow multiple files
    label="Upload data"
)
# Access: file.value returns list of file objects
# Each has .name, .contents (bytes)
```

### file_browser

Browse local file system.

```python
browser = mo.ui.file_browser(initial_path="./data")
browser = mo.ui.file_browser(
    initial_path=".",
    filetypes=[".py", ".md"],
    multiple=True,
    restrict_navigation=True  # Prevent navigating up
)
```

### microphone

Audio recording.

```python
mic = mo.ui.microphone(label="Record audio")
# Access: mic.value returns audio data
```

## Data Inputs

### table

Interactive data table with row selection.

```python
table = mo.ui.table(df)
table = mo.ui.table(
    data=df,
    selection="multi",        # "single", "multi", "single-cell", "multi-cell", None
    pagination=True,
    page_size=10,
    show_column_summaries=True,
    show_data_types=True,
    initial_selection=[0, 2],  # Pre-select rows
    freeze_columns_left=["id"],
    max_height=400
)
# Access: table.value returns selected rows as DataFrame
```

Table formatting:

```python
table = mo.ui.table(
    data=df,
    format_mapping={
        "price": "${:.2f}",
        "date": lambda x: x.strftime("%Y-%m-%d"),
        "score": mo.ui.table.formatter.gradient(low="red", high="green")
    },
    style_cell=lambda row, col, val: {"background": "yellow"} if val > 100 else {}
)
```

### dataframe

No-code DataFrame transformations.

```python
df_editor = mo.ui.dataframe(df)
df_editor = mo.ui.dataframe(
    df,
    page_size=10,
    show_download=True,
    lazy=True  # Show "Apply" button
)
# Access: df_editor.value returns transformed DataFrame
```

Supported transformations: Filter, Select, Rename, Convert, Sort, Group By, Aggregate, Sample, Shuffle, Explode, Expand Dict, Unique, Pivot.

### data_explorer

Full data exploration interface.

```python
explorer = mo.ui.data_explorer(df)
```

## Composite Inputs

### form

Wrap any element to gate submission.

```python
# Simple form
form = mo.ui.slider(0, 100).form()

# With options
form = mo.ui.text().form(
    submit_button_label="Save",
    show_clear_button=True,
    clear_on_submit=True,
    bordered=True
)

# Form with validation
form = mo.ui.text().form(
    validate=lambda value: "Required" if not value else None
)
```

### batch

Combine multiple elements.

```python
batch = mo.md("""
Name: {name}
Age: {age}
""").batch(
    name=mo.ui.text(),
    age=mo.ui.number(0, 120)
)
# Access: batch.value returns {"name": ..., "age": ...}
```

### array

Dynamic list of elements.

```python
array = mo.ui.array([mo.ui.text() for _ in range(3)])
# Access: array.value returns list of values
```

### dictionary

Dictionary of elements.

```python
dictionary = mo.ui.dictionary({
    "name": mo.ui.text(),
    "age": mo.ui.number(0, 120)
})
# Access: dictionary.value returns dict of values
```

## Navigation

### tabs

Tabbed interface with state tracking.

```python
tabs = mo.ui.tabs({
    "Tab 1": content1,
    "Tab 2": content2,
    "Tab 3": content3
})
# Access: tabs.value returns selected tab name
```

### nav_menu

Navigation menu.

```python
nav = mo.ui.nav_menu({
    "Home": "/",
    "About": "/about",
    "Dropdown": {
        "Item 1": "/item1",
        "Item 2": "/item2"
    }
})
```

## Chat

### chat

AI chat interface.

```python
chat = mo.ui.chat(
    model,  # Function that takes messages and returns response
    prompts=["Summarize this", "Explain in detail"],
    show_configuration_controls=True
)

# With custom model function
def my_model(messages, config):
    # messages: list of {"role": str, "content": str}
    return "Response text"

chat = mo.ui.chat(my_model)
```
