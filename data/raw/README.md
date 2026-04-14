# Raw Data

This folder contains the original, unprocessed recordings of all subjects and tasks.

## Structure

```text
raw/
|-- gait/
|-- stair_ascent/
`-- stair_descent/
```

- **gait**: walking trials (10MWT)
- **stair_ascent**: ascending stairs (9SAD)
- **stair_descent**: descending stairs (9SAD)

## Data Organization

- Each subfolder contains CSV files corresponding to individual trials.
- Each file represents one subject performing one trial.
- Data are grouped by task.

## File Format

Each CSV file includes:

- metadata (header section)
- time series data (IMU signals and labels)

For detailed format description, see `../metadata/dataset_description.md`.

## Subject Identifiers

- The `SXX` value in each file name is a task-specific `subject_id`.
- Cross-task participant matching should use `../metadata/subject_key.csv`, not the `SXX` value alone.

## Notes

- All data are raw and have not been preprocessed.
- Missing values may appear as `NaN`.
- File naming follows a standardized convention.

For naming details, see `../metadata/file_naming_convention.md`.
