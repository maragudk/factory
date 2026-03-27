# Intervals

Intervals define regular spacing for scales, bins, and ticks, particularly useful for temporal data.

## Usage

```javascript
// Scale ticks
Plot.plot({
  x: {interval: "month"},
  marks: [...]
})

// Bin transform
Plot.rectY(data, Plot.binX({y: "count"}, {
  x: "date",
  interval: d3.utcMonth
}))
```

## Built-in Intervals

### Time Intervals (UTC)

| Interval | Description |
|----------|-------------|
| `"second"` | Every second |
| `"minute"` | Every minute |
| `"hour"` | Every hour |
| `"day"` | Every day |
| `"week"` | Every Sunday |
| `"month"` | Every month |
| `"quarter"` | Every quarter |
| `"half"` | Every half year |
| `"year"` | Every year |

### Weekday Intervals

| Interval | Description |
|----------|-------------|
| `"monday"` | Every Monday |
| `"tuesday"` | Every Tuesday |
| `"wednesday"` | Every Wednesday |
| `"thursday"` | Every Thursday |
| `"friday"` | Every Friday |
| `"saturday"` | Every Saturday |
| `"sunday"` | Every Sunday |

### Skip Intervals

```javascript
"3 months"   // Every 3 months
"2 weeks"    // Every 2 weeks
"10 years"   // Every 10 years
```

## Interval Functions

### Plot.utcInterval(period)

Creates UTC time interval:

```javascript
const monthly = Plot.utcInterval("month");
monthly.floor(date)   // Start of month
monthly.offset(date)  // Next month
monthly.range(start, end)  // All months between
```

### Plot.timeInterval(period)

Same as utcInterval but uses local time.

### Plot.numberInterval(period)

Creates numeric interval:

```javascript
const byFives = Plot.numberInterval(5);
byFives.floor(12)  // 10
byFives.range(0, 20)  // [0, 5, 10, 15]
```

## Scale Applications

### Axis Ticks
```javascript
Plot.plot({
  x: {
    type: "utc",
    ticks: "month",  // or interval: "month"
    tickFormat: "%b"
  },
  marks: [...]
})
```

### Ordinal Scale Domain
```javascript
Plot.plot({
  x: {interval: "day"},  // Show all days, even missing
  marks: [Plot.barY(data, {x: "date", y: "value"})]
})
```

## Transform Applications

### Binning
```javascript
Plot.rectY(data, Plot.binX({y: "count"}, {
  x: "date",
  thresholds: d3.utcMonth
}))
```

### Line with Interval
```javascript
Plot.lineY(data, {
  x: "date",
  y: "value",
  interval: "day"  // Regularize sampled data
})
```

## Custom Intervals

Implement floor and offset methods:

```javascript
const fiscalQuarter = {
  floor: d => {
    const m = d.getUTCMonth();
    const q = Math.floor((m + 3) / 3) * 3 - 3;
    return new Date(Date.UTC(d.getUTCFullYear(), q, 1));
  },
  offset: (d, n = 1) => {
    return new Date(Date.UTC(d.getUTCFullYear(), d.getUTCMonth() + n * 3, 1));
  }
};
```

## Notes

- UTC intervals recommended for consistency
- String intervals (e.g., "month") are converted to d3 intervals
- Use with `thresholds` in bin transform
- The `interval` scale option enforces regular spacing
- Negative numeric periods use 1/period for precision
