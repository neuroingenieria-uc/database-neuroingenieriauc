# Dataset Description

This update contains 116 selected recordings from 15 distinct participants:
30 gait, 33 stair ascent, 33 stair descent and 20 sit-to-stand CSV files.
There are 10 walking participants, 11 per stair task and 10 sit-to-stand
participants. Participants overlap across tasks; counts must not be added.

The source metadata declare NP-HGAIT HW/FW v5.1, one right-leg measurement
at the gastrocnemius and 62.5 Hz. Full trial-level exports are retained.
Signals were not re-filtered, re-signed or relabeled during this preparation.
The original Elizalde FSM output is automatic, not an independent manual
reference; a complete cycle is not evidence of exact event timing.

Subject codes are shared across tasks. `participants.csv` lists only codes
and availability; private initials/name and operator mappings are excluded.
All 116 captures use Birthdate, consistently for each of the 15 participant
codes. The date was already recorded in 35 captures, completed from another
capture of the same participant in 68, and explicitly confirmed by the dataset
maintainer in 13. No date is inferred from an age. Dates match the previously
published ages at capture, including the confirmed S09 correction. Original
source headers remain unchanged in the private archive. Exact capture dates
and times remain as recorded in Trial DateTime. Codes do not make these
records anonymous; full birth dates increase the potential for identification. Earlier Git commits require a separate disclosure review.

The time-series table starts at Angle_X after the key/value metadata and a
blank line. `schema.json` describes the latest acquisition field order, with
Birthdate in every capture, no Age field, and Trial DateTime last. Unreported
protocol values are omitted, and signal NaNs remain unchanged. Sensor descriptions
differ between acquisition periods and were not harmonized by assumption.

See the root README for protocols, available channels, handling of initial
missing values, ascent signal-quality observations and usage limits. The
manifest identifies affected file paths and exact released checksums.
