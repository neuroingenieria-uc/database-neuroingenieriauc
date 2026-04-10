# Raw Data

This folder contains the original, unprocessed recordings of all subjects and tasks.

## Structure

```id="jv9m3k"
raw/
├── gait/
├── stair_ascent/
└── stair_descent/
```

* **gait**: walking trials (10MWT)
* **stair_ascent**: ascending stairs (9SAD)
* **stair_descent**: descending stairs (9SAD)

## Data Organization

* Each subfolder contains CSV files corresponding to individual trials
* Each file represents one subject performing one trial
* Data are grouped by task

## File Format

Each CSV file includes:

* metadata (header section)
* time series data (IMU signals and labels)

For detailed format description, see:

```id="ml0s2k"
../metadata/dataset_description.md
```

## Notes

* All data are raw and have not been preprocessed
* Missing values may appear as NaN
* File naming follows a standardized convention

For naming details, see:

```id="e1z9l0"
../metadata/file_naming_convention.md
```
