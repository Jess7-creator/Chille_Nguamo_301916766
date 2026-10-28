# Hospital / Clinic System — SQL queries

## 1. Find appointment records where scheduled_at matches "2026-11-02T09:00:00Z" (up to 20).

```sql
SELECT * FROM portfolio."appointment"
WHERE "scheduled_at" IS NOT DISTINCT FROM '2026-11-02T09:00:00Z'
ORDER BY "appointment_id"
LIMIT 20;
```

| appointment_id | patient_id | clinician_id | scheduled_at | status | reason |
| --- | --- | --- | --- | --- | --- |
| 3 | 1 | 2 | 2026-11-02T09:00:00+00:00 | scheduled | Routine visit |

## 2. Show related appointment, patient records (up to 20).

```sql
SELECT t0."appointment_id" AS "appointment_appointment_id",
       t0."scheduled_at" AS "appointment_scheduled_at",
       t1."patient_id" AS "patient_patient_id",
       t1."medical_record_no" AS "patient_medical_record_no"
FROM portfolio."appointment" t0
JOIN portfolio."patient" t1 ON t0."patient_id" = t1."patient_id"
ORDER BY t0."appointment_id", t1."patient_id"
LIMIT 20;
```

| appointment_appointment_id | appointment_scheduled_at | patient_patient_id | patient_medical_record_no |
| --- | --- | --- | --- |
| 3 | 2026-11-02T09:00:00+00:00 | 1 | MR-SYN-001 |

## 3. Count appointment records for each patient_id (up to 20 groups).

```sql
SELECT "patient_id", count(*) AS record_count
FROM portfolio."appointment"
GROUP BY "patient_id"
ORDER BY record_count DESC, "patient_id" NULLS LAST
LIMIT 20;
```

| patient_id | record_count |
| --- | --- |
| 1 | 1 |

## 4. Find appointment records where scheduled_at matches "2026-11-02T09:00:00Z" (up to 20).

```sql
SELECT * FROM portfolio."appointment"
WHERE "scheduled_at" IS NOT DISTINCT FROM '2026-11-02T09:00:00Z'
ORDER BY "appointment_id"
LIMIT 20;
```

| appointment_id | patient_id | clinician_id | scheduled_at | status | reason |
| --- | --- | --- | --- | --- | --- |
| 3 | 1 | 2 | 2026-11-02T09:00:00+00:00 | scheduled | Routine visit |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 1.16 | 1.146, 1.172, 1.16 | Sort → Seq Scan | 139 |
| After index | 0.185 | 0.239, 0.182, 0.185 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 30 |

The median execution time changed from 1.16 ms to 0.185 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=1.122..1.124 rows=25 loops=1)
  Seq Scan on appointment (actual time=0.015..1.09 rows=25 loops=1)
Planning Time: 0.347 ms
Execution Time: 1.146 ms
```

### Before index, run 2

```text
Sort (actual time=1.148..1.15 rows=25 loops=1)
  Seq Scan on appointment (actual time=0.016..1.111 rows=25 loops=1)
Planning Time: 0.328 ms
Execution Time: 1.172 ms
```

### Before index, run 3

```text
Sort (actual time=1.136..1.138 rows=25 loops=1)
  Seq Scan on appointment (actual time=0.015..1.102 rows=25 loops=1)
Planning Time: 0.34 ms
Execution Time: 1.16 ms
```

### After index, run 1

```text
Sort (actual time=0.172..0.174 rows=25 loops=1)
  Bitmap Heap Scan on appointment (actual time=0.037..0.125 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.019..0.02 rows=25 loops=1)
Planning Time: 0.738 ms
Execution Time: 0.239 ms
```

### After index, run 2

```text
Sort (actual time=0.128..0.129 rows=25 loops=1)
  Bitmap Heap Scan on appointment (actual time=0.027..0.094 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.015 rows=25 loops=1)
Planning Time: 0.536 ms
Execution Time: 0.182 ms
```

### After index, run 3

```text
Sort (actual time=0.131..0.133 rows=25 loops=1)
  Bitmap Heap Scan on appointment (actual time=0.028..0.096 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.016 rows=25 loops=1)
Planning Time: 0.524 ms
Execution Time: 0.185 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Chille_Nguamo_301916766_P2_Queries.sql, then Chille_Nguamo_301916766_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Chille_Nguamo_301916766_P2_QueryResults.png) · [Index comparison](screenshots/Chille_Nguamo_301916766_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

