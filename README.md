# Neuroengineering Dataset - Human Movement

This repository contains datasets in CSV format related to human movement experiments, including gait and stair activities.

---

## Repository Structure

```
data/
└── raw/
    ├── gait/
    ├── stair_ascent/
    └── stair_descent/
```

* **gait**: walking recordings
* **stair_ascent**: ascending stairs recordings
* **stair_descent**: descending stairs recordings

---

## Data Format

Each CSV file contains two sections:

### 1. Metadata (header section)

Key-value pairs describing:

* subject information (age, height, weight)
* clinical condition
* activity type
* acquisition parameters (sampling frequency, instrumentation)
* experimental conditions

### 2. Time Series Data

Multivariate signals including:

* joint angles
* angular velocity
* linear acceleration
* footswitch signals (heel/toe)
* segmentation labels

Metadata and signal data are stored in the same file.

---

## Acquisition Details

* Sampling frequency: 62.5 Hz
* Sensors: IMU-based system
* Measurement: unilateral (e.g., right leg)
* Sensor location: e.g., gastrocnemius

---

## Notes

* Data in this repository are raw (unprocessed)
* Missing values may appear as `NaN`

---

## Authors

Neuroengineering Group
