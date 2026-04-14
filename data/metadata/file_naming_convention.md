# File Naming Convention

All dataset files follow the format:

`SXX_task_protocol_trial.csv`

## Components

- `SXX`: task-specific anonymized `subject_id` (e.g., `S01`, `S02`)
- `task`: movement task
  - `gait`
  - `stair_ascent`
  - `stair_descent`
- `protocol`: experimental protocol
  - `10MWT` (10 Meter Walking Test)
  - `9SAD` (Nine Stairs Ascent and Descent Test)
- `trial`: repetition number (two digits, e.g., `01`, `02`, `03`)

## Participant ID Scope

- `SXX` values are defined within each task folder and are not dataset-level participant IDs.
- The same `SXX` value may refer to different participants in different tasks.
- Use `data/metadata/subject_key.csv` to link task-specific `subject_id` values to dataset-level `participant_id` values.

## Examples

- `S01_gait_10MWT_01.csv`
- `S01_gait_10MWT_02.csv`
- `S01_stair_ascent_9SAD_01.csv`
- `S01_stair_descent_9SAD_01.csv`

## Notes

- Task names use lowercase.
- Protocol codes are uppercase.
- Underscore (`_`) is used as separator.
- No spaces or special characters are allowed.
