-- Find appointment records where scheduled_at matches "2026-11-02T09:00:00Z" (up to 20).
SELECT * FROM portfolio."appointment"
WHERE "scheduled_at" IS NOT DISTINCT FROM '2026-11-02T09:00:00Z'
ORDER BY "appointment_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."appointment"
WHERE "scheduled_at" IS NOT DISTINCT FROM '2026-11-02T09:00:00Z'
ORDER BY "appointment_id"
LIMIT 20;

-- Show related appointment, patient records (up to 20).
SELECT t0."appointment_id" AS "appointment_appointment_id",
       t0."scheduled_at" AS "appointment_scheduled_at",
       t1."patient_id" AS "patient_patient_id",
       t1."medical_record_no" AS "patient_medical_record_no"
FROM portfolio."appointment" t0
JOIN portfolio."patient" t1 ON t0."patient_id" = t1."patient_id"
ORDER BY t0."appointment_id", t1."patient_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."appointment_id" AS "appointment_appointment_id",
       t0."scheduled_at" AS "appointment_scheduled_at",
       t1."patient_id" AS "patient_patient_id",
       t1."medical_record_no" AS "patient_medical_record_no"
FROM portfolio."appointment" t0
JOIN portfolio."patient" t1 ON t0."patient_id" = t1."patient_id"
ORDER BY t0."appointment_id", t1."patient_id"
LIMIT 20;

-- Count appointment records for each patient_id (up to 20 groups).
SELECT "patient_id", count(*) AS record_count
FROM portfolio."appointment"
GROUP BY "patient_id"
ORDER BY record_count DESC, "patient_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "patient_id", count(*) AS record_count
FROM portfolio."appointment"
GROUP BY "patient_id"
ORDER BY record_count DESC, "patient_id" NULLS LAST
LIMIT 20;

-- Find appointment records where scheduled_at matches "2026-11-02T09:00:00Z" (up to 20).
SELECT * FROM portfolio."appointment"
WHERE "scheduled_at" IS NOT DISTINCT FROM '2026-11-02T09:00:00Z'
ORDER BY "appointment_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."appointment"
WHERE "scheduled_at" IS NOT DISTINCT FROM '2026-11-02T09:00:00Z'
ORDER BY "appointment_id"
LIMIT 20;
