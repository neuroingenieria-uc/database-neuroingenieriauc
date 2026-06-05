# Neuroengineering Dataset - Human Movement

This repository contains IMU-based recordings of healthy adults performing gait, stair-negotiation, and sit-to-stand tasks with the H-GAIT neuroprosthesis. The dataset is organized as trial-level CSV files that combine per-trial metadata with time-series signals and event labels.

## Dataset Snapshot

- **Repository type:** human movement dataset
- **Instrumentation:** NP-HGAIT (`HW : v5.1`, `FW : v5.1`)
- **Sensor placement:** posterior right leg (`Sensor Location = Gastrocnemio`)
- **Sampling frequency:** 62.5 Hz
- **Tasks:** gait, sit-to-stand, stair ascent, stair descent
- **Total trials:** 110 CSV files
- **Trials per task:** 30 gait, 20 sit-to-stand, 30 stair ascent, 30 stair descent
- **Nominal repetitions:** 3 trials per gait/stair subject-task combination; 2 trials per sit-to-stand subject
- **Global subject IDs:** 14 unique `SXX` values across the repository
- **Cross-task overlap:** 5 participants appear in all four task groups
- **Age range observed in the released files:** 23 to 38 years

## What Is Included

```text
data/
|-- raw/
|   |-- gait/
|   |-- sit-to-stand/
|   |-- stair_ascent/
|   `-- stair_descent/
|-- protocols/
|   |-- gait_10mwt_protocol.pdf
|   |-- sit-to-stand_5sts_protocol.pdf
|   `-- stair_ascent_descent_9sad_protocol.pdf
`-- metadata/
    |-- dataset_description.md
    |-- file_naming_convention.md
    `-- subject_key.csv
```

The repository currently contains:

- trial-level raw CSV recordings in `data/raw`
- evaluation protocol PDFs in `data/protocols`
- dataset-level metadata and documentation in `data/metadata`
- citation and licensing files in the repository root

## Study Overview

The released recordings were acquired under three standardized evaluation protocols:

- **10MWT:** 10 Meter Walk Test for straight walking
- **5STS:** Five Times Sit-to-Stand Test for repeated sit-to-stand movements
- **9S-A/D:** Nine Stairs Ascent and Descent Test for stair ascent and stair descent

According to the provided protocols, the evaluations were designed for healthy volunteers, used the H-GAIT neuroprosthesis with an IMU, included video recording plus optical synchronization barriers, and repeated each test with rest between repetitions.

The released protocol PDFs are stored in `data/protocols`.

## Experimental Setup

### Gait (`10MWT`)

- Straight walking over a 10 m path
- Marked path with start at 0 m and end at 10 m
- Measurement corridor described in the protocol between 2 m and 8 m
- Laser barriers used for synchronization at the measurement window
- Participant instructed to start with the right foot and walk at self-selected speed

### Stair Ascent and Stair Descent (`9S-A/D`)

- Staircase with 9 consecutive steps
- Protocol specifies a step height of 17 cm
- Start and end synchronization placed at the first and ninth step
- Participant instructed to move at self-selected speed and stop at the ninth step or final landing

### Sit-to-Stand (`5STS`)

- Repeated sit-to-stand movement from a seated starting position
- Protocol records the task duration as `Sit-to-Stand Time (s)`
- Participant performs two released repetitions in the current dataset

### Shared Acquisition Conditions

- Sensor mounted on the right lower limb
- Video recorded in parallel with each trial
- Data acquired from a serial workflow described in the protocols
- Temporal synchronization handled through `SYNC` events and external optical barriers

## Tasks

### `gait`

- Files: 30
- Protocol: `10MWT`
- Participants: 10
- Sample count range: 428 to 1441 rows per file
- Median sample count: 744 rows per file
- Mean sample count: 741.9
- Activity label in files: `Marcha`
- Segmentation label in files: `Marcha_Elizalde2023`

### `sit-to-stand`

- Files: 20
- Protocol: `5STS`
- Participants: 10
- Sample count range: 1043 to 1933 rows per file
- Median sample count: 1569 rows per file
- Mean sample count: 1557.4
- Activity label in files: `Pararse`
- Segmentation label in files: `Elizalde_STS2023`

### `stair_ascent`

- Files: 30
- Protocol: `9S-A/D`
- Participants: 10
- Sample count range: 405 to 695 rows per file
- Mean sample count: 578.7
- Activity label in files: `Subir_Escaleras`
- Segmentation label in files: `SubirEscaleras_Elizalde2023`

### `stair_descent`

- Files: 30
- Protocol: `9S-A/D`
- Participants: 10
- Sample count range: 322 to 648 rows per file
- Mean sample count: 499.4
- Activity label in files: `Bajar_Escaleras`
- Segmentation label in files: `BajarEscaleras_Elizalde2023`

## Participant Identifiers

- The `SXX` token in each filename is a dataset-level anonymous `subject_id`.
- The same `SXX` value identifies the same participant across `gait`, `sit-to-stand`, `stair_ascent`, and `stair_descent`.
- `data/metadata/subject_key.csv` maps each `subject_id` to subject initials and task availability.

This means:

- 5 participants appear in all four task groups
- 2 participants appear only in gait
- 1 participant appears only in stair tasks
- The remaining participants appear in two task groups

## File Naming

All files follow:

`SXX_task_protocol_trial.csv`

Examples:

- `S02_gait_10MWT_01.csv`
- `S04_sit-to-stand_5STS_01.csv`
- `S02_stair_ascent_9SAD_01.csv`
- `S02_stair_descent_9SAD_01.csv`

For the full naming rules, see `data/metadata/file_naming_convention.md`.

## CSV Layout

Each CSV file contains two sections:

1. A metadata header with one key-value pair per line
2. A time-series table starting after the blank separator line

Typical metadata fields include:

- `Operator`
- `Subject`
- `Clinical Description`
- `Age`
- `Height (cm)`
- `Weight (kg)`
- `Activity`
- `Inclination`
- `Instrumentation`
- `Reference Orientation`
- `Measurement`
- `Sensor Location`
- `Segmentation`
- `Sampling Frequency`
- `Number of Samples`
- `Description`
- `Trial DateTime`

Task-specific metadata may also include:

- `Speed (m/s)` for all tasks
- `Sit-to-Stand Time (s)` for sit-to-stand
- `Stair Time (s)` for stair tasks
- `Time Source` for stair and sit-to-stand tasks
- `Vertical Gain (m)` for ascent
- `Vertical Drop (m)` for descent

`Trial DateTime` is stored as the last metadata row in ISO-like minute resolution (`YYYY-MM-DDTHH:MM`) and is derived from the original acquisition filename.

## Signal Channels

The time-series section uses the following columns:

`Angle_X, Angular_Velocity_X, Linear_Acceleration_X, Angle_Y, Angular_Velocity_Y, Linear_Acceleration_Y, Angle_Z, Angular_Velocity_Z, Linear_Acceleration_Z, FootSwitch_Heel, FootSwitch_Toe, Segmentation_output, Sync, Activity`

At release time, the files include:

- angular signals
- linear acceleration channels
- footswitch channels
- segmentation labels
- synchronization markers
- activity labels

## Processing Status

The repository documentation describes the data as raw and unprocessed. In practice, the released CSV files already include:

- acquisition metadata
- synchronization-related fields
- task-specific speed, stair, and sit-to-stand metrics
- segmentation labels (`Segmentation_output`)
- per-sample activity labels (`Activity`)

So "raw" should be interpreted as trial-level exported recordings, not as sensor streams without metadata or derived labels.

## Minimal Usage Example

```python
from pathlib import Path
import pandas as pd

path = Path("data/raw/gait/S01_gait_10MWT_01.csv")
lines = path.read_text(encoding="utf-8-sig").splitlines()

blank_idx = lines.index("")
metadata = {}
for line in lines[:blank_idx]:
    key, value = line.split(",", 1)
    metadata[key] = value

signals = pd.read_csv(path, skiprows=blank_idx + 1)

print(metadata["Activity"])
print(metadata["Sampling Frequency"])
print(signals.head())
```

## Known Limitations

- The released metadata are not perfectly uniform across all files.
- Gait trial duration is heterogeneous across files, so sample count should be interpreted as exported recording length rather than as a direct proxy for one standardized walking window.
- One stair-descent trial originally lacked complete `Stair Time (s)` and `Time Source` metadata; the header layout was normalized, but those values remain empty because they could not be reconstructed with certainty from the file alone.
- The repository does not currently include the acquisition script (`DataSet.py`) or the synchronized video files referenced in the protocols.

## Recommended Uses

- descriptive analysis of gait and stair negotiation with a wearable IMU
- benchmarking event segmentation, activity recognition, or activity-specific preprocessing methods
- pilot studies on protocol standardization and metadata design
- educational use for parsing mixed metadata and time-series CSV datasets

## Out-of-Scope Uses

- clinical diagnosis
- demographic or identity inference beyond the anonymized subject IDs included in the release
- inference of demographic variables beyond what is explicitly stored in the CSV metadata

## Documentation

- `data/protocols/README.md`
- `data/protocols/gait_10mwt_protocol.pdf`
- `data/protocols/sit-to-stand_5sts_protocol.pdf`
- `data/protocols/stair_ascent_descent_9sad_protocol.pdf`
- `data/metadata/dataset_description.md`
- `data/metadata/file_naming_convention.md`
- `data/metadata/subject_key.csv`

## License

Unless otherwise noted, the dataset and documentation in this repository are licensed under `CC BY 4.0`.

See `LICENSE` for details.

## Citation

Citation metadata is provided in `CITATION.cff`.

## Authors

Neuroengineering Research Group
