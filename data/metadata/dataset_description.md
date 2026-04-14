# Dataset Description

## Overview

This dataset contains IMU-based recordings of human movement, including gait and stair negotiation tasks.

## Tasks

- gait: walking trials
- stair_ascent: ascending stairs
- stair_descent: descending stairs

## Protocols

- 10MWT: 10 Meter Walking Test
- 9SAD: Nine Stairs Ascent and Descent Test

## Data Format

Each CSV file contains two sections:

1. Metadata (header section):
   - anonymous participant metadata
   - clinical description
   - acquisition parameters
   - experimental conditions
2. Time series data:
   - joint angles
   - angular velocity
   - linear acceleration
   - footswitch signals
   - segmentation labels

## Participant Identification

- Each recording file includes a task-specific anonymous `subject_id` in the `SXX` format.
- `subject_id` values are scoped to a task and should not be assumed to match across `gait`, `stair_ascent`, and `stair_descent`.
- Use `subject_key.csv` to map task-specific `subject_id` values to dataset-level `participant_id` values for cross-task analyses.

## Acquisition

- Sampling frequency: 62.5 Hz
- Sensor type: IMU
- Measurement: unilateral (e.g., right leg)
- Sensor placement: gastrocnemius

## Notes

- Data are raw and unprocessed.
- Missing values may appear as `NaN`.
- Task folders share a common layout, but participant matching across tasks must be performed through `subject_key.csv`.
