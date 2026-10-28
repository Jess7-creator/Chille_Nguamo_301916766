-- Fictional sample records for Hospital / Clinic System.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."patient" ("patient_id", "medical_record_no", "given_name", "family_name", "date_of_birth", "active") VALUES (1, 'MR-SYN-001', 'Avery', 'Example', '1985-04-12', TRUE);
INSERT INTO portfolio."clinician" ("clinician_id", "license_no", "given_name", "family_name", "specialty", "active") VALUES (2, 'LIC-SYN-001', 'Jordan', 'Sample', 'Family Medicine', TRUE);
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason") VALUES (3, 1, 2, '2026-11-02T09:00:00Z', 'scheduled', 'Routine visit');
COMMIT;
