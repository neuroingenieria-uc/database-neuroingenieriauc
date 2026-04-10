# Neuroengineering Dataset - Human Movement

This repository contains IMU-based recordings of human movement, including gait and stair negotiation tasks.

---

## Repository Structure

```
data/
├── raw/
│   ├── gait/
│   ├── stair_ascent/
│   └── stair_descent/
└── metadata/
    ├── dataset_description.md
    ├── file_naming_convention.md
    └── subject_key.csv
```

---

## Tasks

* gait: walking trials
* stair_ascent: ascending stairs
* stair_descent: descending stairs

---

## Protocols

* 10MWT: 10 Meter Walking Test
* 9SAD: Nine Stairs Ascent and Descent Test

---

## Data Format

Each CSV file contains:

1. Metadata (header section)
2. Time series data (IMU signals and labels)

For a detailed description, see:

```
data/metadata/dataset_description.md
```

---

## File Naming

All files follow a standardized naming convention:

```
SXX_task_protocol_trial.csv
```

Examples:

* S01_gait_10MWT_01.csv
* S01_stair_ascent_9SAD_01.csv

Full details are available in:

```
data/metadata/file_naming_convention.md
```

---

## Notes

* Data are raw and unprocessed
* Missing values may appear as NaN
* Subject identifiers are anonymized

---

## Authors

Neuroengineering Research Group
