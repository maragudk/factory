# SQL API Reference

Query databases and DataFrames using SQL with reactive integration.

## Overview

marimo enables mixing Python and SQL through `mo.sql()`. Query Python DataFrames, databases, files, and APIs, with results returned as DataFrames.

## Installation

```bash
pip install "marimo[sql]"
```

## Basic Usage

### mo.sql

Execute SQL queries.

```python
import marimo as mo

# Query a Python DataFrame
result = mo.sql(f"SELECT * FROM {df} WHERE value > 100")

# With f-string interpolation for reactivity
threshold = mo.ui.slider(0, 100, value=50)
result = mo.sql(f"SELECT * FROM {df} WHERE value > {threshold.value}")
```

## Creating SQL Cells

Three methods in the editor:
1. Right-click "add cell" → "SQL cell"
2. Convert empty cell via context menu
3. Click SQL button at notebook bottom

## Querying DataFrames

Reference Python DataFrames directly by variable name:

```python
# Python cell
import pandas as pd
sales_df = pd.DataFrame({"product": ["A", "B"], "revenue": [100, 200]})

# SQL cell
result = mo.sql(f"""
    SELECT product, revenue
    FROM {sales_df}
    WHERE revenue > 150
""")
```

## Database Connections

### UI Method

Click "Add Database Connection" in the SQL cell to configure:
- PostgreSQL
- MySQL
- SQLite
- DuckDB
- Snowflake
- BigQuery

### Code Method

```python
# SQLAlchemy
from sqlalchemy import create_engine
engine = create_engine("postgresql://user:pass@host/db")

# Use in SQL
result = mo.sql(f"SELECT * FROM users LIMIT 10", engine=engine)
```

Supported: SQLAlchemy, SQLModel, Ibis, DuckDB, ClickHouse Connect.

## Output Types

Configure output format:

```python
# Native DuckDB (recommended for large data)
result = mo.sql(f"SELECT * FROM {df}", output="native")

# Options: "native", "lazy-polars", "pandas", "polars", "auto"
```

## Querying Files

```python
# CSV
result = mo.sql(f"SELECT * FROM 'data.csv'")

# Parquet
result = mo.sql(f"SELECT * FROM 'data.parquet'")

# Remote files
result = mo.sql(f"SELECT * FROM 'https://example.com/data.csv'")

# S3
result = mo.sql(f"SELECT * FROM 's3://bucket/path/data.parquet'")
```

## Reactive Queries

SQL integrates with marimo's reactivity:

```python
# Cell 1
category = mo.ui.dropdown(["Electronics", "Books", "Clothing"])

# Cell 2 - re-runs when dropdown changes
filtered = mo.sql(f"""
    SELECT * FROM products
    WHERE category = '{category.value}'
""")
```

## Best Practices

- Use `output="native"` for large datasets
- Reference DataFrames with `{df}` syntax
- Use f-strings for reactive parameter binding
- Database tables take precedence over local DataFrames with same name
