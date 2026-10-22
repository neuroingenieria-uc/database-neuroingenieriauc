# Neuroengineering Dataset - Human Movement

This repository contains trial-level H-GAIT recordings of walking, stair
ascent, stair descent, and sit-to-stand tasks. Each CSV combines acquisition
metadata, time-series samples, synchronization markers, and the original
recorded Elizalde finite-state-machine (FSM) segmentation labels.

## Dataset Snapshot

- **Total trials:** 116 CSV files: 30 gait, 33 stair ascent, 33 stair descent,
  and 20 sit-to-stand.
- **Participants:** 15 distinct dataset-level subject codes; participants do
  not all have recordings for every task. Five appear in all four tasks.
- **Trials per participant/task:** three for walking and each stair task;
  two CSV recordings of the 5STS protocol for sit-to-stand.
- **Age range in the selected recordings:** 23 to 47 completed years at capture.
- **Declared instrumentation:** NP-HGAIT, HW v5.1, FW v5.1.
- **Declared placement:** gastrocnemius, right leg, unilateral recording.
- **Sampling frequency:** 62.5 Hz.
- **Scope:** individual-task recordings only; no continuous circuits are included.

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
    |-- participants.csv
    |-- schema.json
    `-- manifest.json
```

The protocol PDFs, LICENSE, and CITATION.cff accompany the dataset. Participant
availability is listed without personal initials in `data/metadata/participants.csv`.

## Study Overview and Experimental Setup

The supplied protocols describe healthy volunteers, the H-GAIT wearable
device, parallel video recording, optical synchronization barriers, and rest
between repetitions. Protocol PDFs describe the intended acquisition setup;
videos are not distributed with the CSV files.

- **10MWT (10 Meter Walk Test):** walking along a 10 m path, with the protocol
  describing a measurement corridor between 2 m and 8 m. Optical barriers
  delimit the measurement window. The participant starts with the right foot
  and walks at self-selected speed.
- **9SAD (Nine Stairs Ascent and Descent):** nine consecutive steps, with a
  stated step height of 17 cm. The protocol describes start/end synchronization
  at the first/ninth step and self-selected speed.
- **5STS (Five Times Sit-to-Stand):** repeated standing up from a seated
  starting position. Two CSV recordings per participant are included; this
  does not mean two individual sit-to-stand movements. The target movement is
  standing up, not a separately annotated sitting-down activity.

## Tasks

### `gait`

- Task: Walking; protocol: `10MWT`.
- Files: 30; participants: 10.
- Sample count range: 553 to 1441 rows per file.
- Recorded segmentation: `Marcha_Elizalde2023`.

### `stair_ascent`

- Task: Stair ascent; protocol: `9SAD`.
- Files: 33; participants: 11.
- Sample count range: 405 to 723 rows per file.
- Recorded segmentation: `SubirEscaleras_Elizalde2023`.

### `stair_descent`

- Task: Stair descent; protocol: `9SAD`.
- Files: 33; participants: 11.
- Sample count range: 322 to 831 rows per file.
- Recorded segmentation: `BajarEscaleras_Elizalde2023`.

### `sit-to-stand`

- Task: Sit-to-stand; protocol: `5STS`.
- Files: 20; participants: 10.
- Sample count range: 1043 to 1933 rows per file.
- Recorded segmentation: `Elizalde_STS2023`.

## Participant Identifiers and Privacy

The same `SXX` identifies the same participant across task folders. Operators
use `OPXX` codes. Private participant/operator correspondence and personal
initials are not included. All 116 CSV files use `Birthdate`, consistently
within each of the 15 participant codes; there is no `Age` metadata field.
Dates were already recorded in 35 source captures. Another 68 captures use
the date recorded in a different capture of the same participant. The
remaining 13 use dates explicitly confirmed by the dataset maintainer for
three participants. No birth date was inferred from an age. Original source
headers remain unchanged in the private archive.

Every date was checked against the previously published age at capture. Nine historical S09
records have a documented metadata correction from 36 to 37 years based on a
confirmed birth year and the full date recorded in later captures.
`Trial DateTime` preserves the exact date and time recorded for each capture,
including the source precision. No additional seconds or timezone are inferred.

The files use participant/operator codes, but are not anonymous. Full birth
dates, height, weight, clinical description, exact capture time and movement
signals remain in the release. Full birth dates increase the potential for
identification; do not use this dataset for identity inference. This update
does not erase identifying information from previous Git commits.

## File Naming

Files retain the repository convention `SXX_task_protocol_trial.csv`, such as
`S02_gait_10MWT_01.csv` or `S15_stair_ascent_9SAD_03.csv`.
Trial ordinals are assigned within the selected subject/task recordings in
recorded capture order; tied minute timestamps use source filename order.
An ordinal is not necessarily the original acquisition number. A refreshed
file path can now refer to a replacement capture: pin the Git commit and use
the manifest hashes for reproducibility.

## CSV Layout

Each CSV has key/value metadata rows, a blank separator, and a sample table
starting at the `Angle_X,...,Activity` header. Metadata follow the latest
acquisition layout: `Birthdate` in every capture, operators use codes,
and `Trial DateTime` is last, after the available protocol fields. Unavailable,
empty or inapplicable fields are omitted rather than filled by assumption.
Values containing commas are CSV-quoted. Locate the sample header rather
than assuming a fixed number of metadata rows. `schema.json` lists all fields.
Recorded descriptive values may remain in Spanish; they were not translated
into a different physical axis convention.

## Signal Channels

The 14 columns are:

`Angle_X, Angular_Velocity_X, Linear_Acceleration_X, Angle_Y, Angular_Velocity_Y, Linear_Acceleration_Y, Angle_Z, Angular_Velocity_Z, Linear_Acceleration_Z, FootSwitch_Heel, FootSwitch_Toe, Segmentation_output, Sync, Activity`

Available measurements include Angle_X (degrees) and acceleration (m/s2).
Column presence does not prove a channel was acquired: several channels may
be entirely NaN. Blank/NaN values are preserved, not filled or interpolated.
There are no per-sample timestamps; sample indices and the declared sampling
frequency do not independently verify the absence of acquisition gaps.

## Processing and Label Provenance

`raw` means complete trial-level exported recordings, not unscaled sensor
packets without derived fields. The CSV files already contain acquisition
processing, protocol metadata, Sync and original automatic segmentation.
`Segmentation_output` is the recorded Elizalde FSM output, not ICNR/AITADIS
relabeling or a manually validated reference. It can miss cycles or transitions;
state numbers should not be treated as equivalent across activities.

During this update, the complete sample table was preserved byte for byte
relative to each selected source: no signal sign changes, filtering,
segmentation reruns, missing-value imputation or sample deletion were applied.
The manifest provides full-file and sample-block SHA-256 checksums.

## Minimal Usage Example

```python
import csv
import io
from pathlib import Path
import pandas as pd

path = Path("data/raw/gait/S01_gait_10MWT_01.csv")
lines = path.read_text(encoding="utf-8-sig").splitlines()
start = next(i for i, line in enumerate(lines) if line.startswith("Angle_X,"))
metadata = dict(row for row in csv.reader(lines[:start]) if row)
signals = pd.read_csv(io.StringIO("\n".join(lines[start:])))
print(metadata["Subject"], metadata["Birthdate"])
print(signals.head())
```

## Known Limitations

- The selection excluded known repeated-signal captures and walking trials
  ending with active Sync. Previous audits found no exact shared runs of at
  least 100 samples among these 116 selected recordings; this is not proof of
  absence of every form of error.
- Walking recordings have a closed active Sync interval; known initial missing
  Angle_X/acceleration-Z values lie outside it. Complete recordings are retained.
- Initial Angle_X or acceleration-Z missing values remain in 18 recordings
  (14 gait, 1 ascent, 3 sit-to-stand). Analysis-specific handling is required.
- All 33 selected ascent recordings show the same repeated acceleration-Z
  minimum (-16.0124 m/s2). A measurement limit is a possibility, not a confirmed
  saturation diagnosis. One ascent trial also contains a 16.2-degree angle jump.
- One descent recording lacks reported stair timing metadata. Those fields
  are omitted; they were not inferred.
- Older and newer recordings have different declared X/Y orientation descriptions.
  These original descriptions are retained, not assumed to have been physically
  harmonized by this update. Review them before combining axis interpretations.
- Automatic segmentation is not an independent biomechanical gold standard.
  Detailed flags identify affected paths in `data/metadata/manifest.json`.
- Acquisition scripts and synchronized videos are not included. Isolated-task
  recordings do not establish performance on continuous activity transitions.

## Recommended and Out-of-Scope Uses

The recordings support descriptive IMU analysis, automatic-segmentation studies
with stated label limitations, and parsing/preprocessing experiments. They do
not establish diagnostic validity and should not be used for identity inference.

## Documentation

- [Dataset description](data/metadata/dataset_description.md)
- [File naming](data/metadata/file_naming_convention.md)
- [Participants and task availability](data/metadata/participants.csv)
- [Metadata schema](data/metadata/schema.json)
- [Inventory, checksums and quality flags](data/metadata/manifest.json)
- [Evaluation protocols](data/protocols/README.md)

## License and Citation

The repository's existing [LICENSE](LICENSE) applies (CC BY 4.0 unless otherwise
noted). Use the authorship and citation metadata in [CITATION.cff](CITATION.cff).
This update does not change the group attribution or the license.

## Authors

Neuroengineering Research Group
