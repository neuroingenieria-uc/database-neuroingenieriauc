# Dataset Description

## Overview

This dataset contains IMU-based recordings of human movement, including gait and stair negotiation tasks.

## Tasks

* gait: walking trials
* stair_ascent: ascending stairs
* stair_descent: descending stairs

## Protocols

* 10MWT: 10 Meter Walking Test
* 9SAD: Nine Stairs Ascent and Descent Test

## Data Format

Each CSV file contains two sections:

1. Metadata (header section):

   * subject information
   * clinical description
   * acquisition parameters
   * experimental conditions

2. Time series data:

   * joint angles
   * angular velocity
   * linear acceleration
   * footswitch signals
   * segmentation labels

## Acquisition

* Sampling frequency: 62.5 Hz
* Sensor type: IMU
* Measurement: unilateral (e.g., right leg)
* Sensor placement: gastrocnemius

## Notes

* Data are raw and unprocessed
* Missing values may appear as NaN
* File structure is consistent across all recordings
