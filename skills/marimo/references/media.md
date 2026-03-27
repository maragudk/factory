# Media API Reference

Display images, audio, video, PDFs, and downloadable content.

## Images

### mo.image

Display images from various sources.

```python
import marimo as mo

# From URL
mo.image(src="https://example.com/image.png")

# From local file
mo.image(src="./images/photo.jpg")

# From bytes
with open("image.png", "rb") as f:
    mo.image(src=f.read())

# With options
mo.image(
    src="image.png",
    alt="Description for accessibility",
    width=400,
    height=300,
    rounded=True
)

# Data URL
mo.image(src="data:image/png;base64,...")
```

### mo.image_compare

Compare two images side by side with a slider.

```python
mo.image_compare(
    left="before.png",
    right="after.png"
)
```

## Audio

### mo.audio

Play audio files.

```python
# From URL
mo.audio(src="https://example.com/audio.mp3")

# From local file
mo.audio(src="./audio/recording.wav")

# From bytes
mo.audio(src=audio_bytes)

# With options
mo.audio(
    src="audio.mp3",
    autoplay=False,
    controls=True,
    loop=False
)
```

## Video

### mo.video

Play video files.

```python
# From URL
mo.video(src="https://example.com/video.mp4")

# From local file
mo.video(src="./videos/demo.mp4")

# With options
mo.video(
    src="video.mp4",
    width=640,
    height=360,
    autoplay=False,
    controls=True,
    loop=False,
    muted=False
)
```

## PDF

### mo.pdf

Display PDF documents.

```python
# From URL
mo.pdf(src="https://example.com/document.pdf")

# From local file
mo.pdf(src="./docs/report.pdf")

# With options
mo.pdf(
    src="document.pdf",
    width="100%",
    height="600px"
)
```

## Downloads

### mo.download

Create downloadable content.

```python
# From string
mo.download(
    data="Hello, World!",
    filename="greeting.txt"
)

# From bytes
mo.download(
    data=csv_bytes,
    filename="data.csv",
    mimetype="text/csv"
)

# From file
with open("report.pdf", "rb") as f:
    mo.download(data=f.read(), filename="report.pdf")

# With label
mo.download(
    data=json.dumps(data),
    filename="export.json",
    label="Download JSON"
)

# DataFrame to CSV
mo.download(
    data=df.to_csv(index=False),
    filename="data.csv",
    mimetype="text/csv"
)
```

## Plain Text

### mo.plain_text

Display text preserving whitespace and formatting.

```python
mo.plain_text("Preformatted text\n  with indentation")

# Useful for:
# - Log output
# - Code without syntax highlighting
# - ASCII art
# - Fixed-width content
```

## Static Files

For images and media in markdown, place files in a `public/` directory:

```
notebook.py
public/
  logo.png
  diagram.svg
```

Reference in markdown:

```python
mo.md("""
# My Notebook

![Logo](public/logo.png)

<img src="public/diagram.svg" width="400">
""")
```

## Working with Matplotlib

Convert matplotlib figures to displayable images:

```python
import matplotlib.pyplot as plt
import io

fig, ax = plt.subplots()
ax.plot([1, 2, 3], [1, 4, 9])

# Save to bytes
buf = io.BytesIO()
fig.savefig(buf, format="png")
buf.seek(0)

mo.image(src=buf.read())
plt.close(fig)
```

Or use marimo's built-in support:

```python
# Just return the figure - marimo handles display
fig, ax = plt.subplots()
ax.plot([1, 2, 3], [1, 4, 9])
fig  # Display automatically
```

## Working with PIL/Pillow

```python
from PIL import Image
import io

# Create or load image
img = Image.open("photo.jpg")

# Process image
img = img.resize((400, 300))

# Convert to bytes for display
buf = io.BytesIO()
img.save(buf, format="PNG")
buf.seek(0)

mo.image(src=buf.read())
```
