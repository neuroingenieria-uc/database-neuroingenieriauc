# File Naming Convention

The existing repository pattern is retained: `SXX_task_protocol_trial.csv`.

| Task folder | Protocol token | Example |
| --- | --- | --- |
| gait | 10MWT | S02_gait_10MWT_01.csv |
| sit-to-stand | 5STS | S04_sit-to-stand_5STS_01.csv |
| stair_ascent | 9SAD | S15_stair_ascent_9SAD_01.csv |
| stair_descent | 9SAD | S15_stair_descent_9SAD_01.csv |

SXX identifies the same participant across all task folders. No personal
initials or date/time strings are encoded in the filenames. Task names are
lowercase ASCII and protocol tokens keep their established capitalization.

The two-digit trial value is an ordinal within the selected participant/task
recordings, ordered by recorded capture time, with source filename as the
tie-breaker at minute resolution. It is not necessarily the original trial
number. Updated recordings can replace earlier files at the same path; pin
the repository commit and manifest checksum instead of relying on a path alone.

Task availability is in `participants.csv`, with no identity correspondence.
