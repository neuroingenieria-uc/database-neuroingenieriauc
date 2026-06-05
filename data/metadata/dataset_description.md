# Dataset Description

## Overview

This dataset contains IMU-based recordings of human movement, including gait, stair negotiation, and sit-to-stand tasks.

## Tasks

- gait: walking trials
- sit-to-stand: repeated sit-to-stand trials
- stair_ascent: ascending stairs
- stair_descent: descending stairs

## Protocols

- 10MWT: 10 Meter Walking Test
- 5STS: Five Times Sit-to-Stand Test
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
   - activity labels

## Participant Identification

- Each recording file includes a dataset-level anonymous `subject_id` in the `SXX` format.
- The same `subject_id` is reused for the same participant across `gait`, `sit-to-stand`, `stair_ascent`, and `stair_descent`.
- Use `subject_key.csv` to map each `subject_id` to subject initials and task availability.

## Acquisition

- Sampling frequency: 62.5 Hz
- Sensor type: IMU
- Measurement: unilateral (e.g., right leg)
- Sensor placement: gastrocnemius

## Notes

- Data are raw and unprocessed.
- Missing values may appear as `NaN`.
- Task folders share a common layout, and cross-task participant matching can be done directly through the shared `subject_id`.
