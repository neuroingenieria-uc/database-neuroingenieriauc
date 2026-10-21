# Raw Data

Four task folders contain 116 complete trial-level CSV exports: gait (30),
stair_ascent (33), stair_descent (33), and sit-to-stand (20).
Each combines pseudonymized acquisition metadata with the original sample
table, Sync and recorded Elizalde FSM labels. Raw does not mean unscaled
sensor packets or independently validated labels. Missing values are retained.

The global SXX identifies the same person across task folders. Availability
is in `../metadata/participants.csv`, without initials or identity mapping.
The manifest and schema in `../metadata` describe integrity and quality flags.
Protocol PDFs remain in `../protocols`. See the root README for use limits.
