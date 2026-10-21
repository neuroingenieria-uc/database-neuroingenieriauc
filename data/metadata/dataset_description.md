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
Age is at capture; exact personal dates and precise capture timestamps are
not distributed in the updated files. Data are pseudonymized, not guaranteed
anonymous. Earlier Git commits require a separate disclosure review.

The time-series table starts at Angle_X after the key/value metadata and a
blank line. `schema.json` describes the common layout. Unreported protocol
values remain empty, and signal NaNs remain unchanged. Sensor descriptions
differ between acquisition periods and were not harmonized by assumption.

See the root README for protocols, available channels, handling of initial
missing values, ascent signal-quality observations and usage limits. The
manifest identifies affected file paths and exact released checksums.
