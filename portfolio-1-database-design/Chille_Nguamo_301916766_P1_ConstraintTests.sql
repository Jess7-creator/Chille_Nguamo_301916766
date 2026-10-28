-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. patient pk. Expected: pk_patient, SQLSTATE 23505.
INSERT INTO portfolio."patient" ("patient_id", "medical_record_no", "given_name", "family_name", "date_of_birth", "active")
VALUES (1, 'MR-SYN-101', 'Casey', 'Test', '1990-01-01', TRUE);

-- 2. patient unique. Expected: uq_patient_0, SQLSTATE 23505.
INSERT INTO portfolio."patient" ("patient_id", "medical_record_no", "given_name", "family_name", "date_of_birth", "active")
VALUES (101, 'MR-SYN-001', 'Casey', 'Test', '1990-01-01', TRUE);

-- 3. patient nn id. Expected: patient_id, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "medical_record_no", "given_name", "family_name", "date_of_birth", "active")
VALUES (NULL, 'MR-SYN-102', 'Casey', 'Test', '1990-01-01', TRUE);

-- 4. patient nn record. Expected: medical_record_no, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "medical_record_no", "given_name", "family_name", "date_of_birth", "active")
VALUES (102, NULL, 'Casey', 'Test', '1990-01-01', TRUE);

-- 5. patient nn given. Expected: given_name, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "medical_record_no", "given_name", "family_name", "date_of_birth", "active")
VALUES (103, 'MR-SYN-103', NULL, 'Test', '1990-01-01', TRUE);

-- 6. patient nn family. Expected: family_name, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "medical_record_no", "given_name", "family_name", "date_of_birth", "active")
VALUES (104, 'MR-SYN-104', 'Casey', NULL, '1990-01-01', TRUE);

-- 7. patient nn dob. Expected: date_of_birth, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "medical_record_no", "given_name", "family_name", "date_of_birth", "active")
VALUES (105, 'MR-SYN-105', 'Casey', 'Test', NULL, TRUE);

-- 8. patient nn active. Expected: active, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "medical_record_no", "given_name", "family_name", "date_of_birth", "active")
VALUES (106, 'MR-SYN-106', 'Casey', 'Test', '1990-01-01', NULL);

-- 9. clinician pk. Expected: pk_clinician, SQLSTATE 23505.
INSERT INTO portfolio."clinician" ("clinician_id", "license_no", "given_name", "family_name", "specialty", "active")
VALUES (2, 'LIC-SYN-101', 'Taylor', 'Demo', 'Pediatrics', TRUE);

-- 10. clinician unique. Expected: uq_clinician_0, SQLSTATE 23505.
INSERT INTO portfolio."clinician" ("clinician_id", "license_no", "given_name", "family_name", "specialty", "active")
VALUES (201, 'LIC-SYN-001', 'Taylor', 'Demo', 'Pediatrics', TRUE);

-- 11. clinician nn id. Expected: clinician_id, SQLSTATE 23502.
INSERT INTO portfolio."clinician" ("clinician_id", "license_no", "given_name", "family_name", "specialty", "active")
VALUES (NULL, 'LIC-SYN-202', 'Taylor', 'Demo', 'Pediatrics', TRUE);

-- 12. clinician nn license. Expected: license_no, SQLSTATE 23502.
INSERT INTO portfolio."clinician" ("clinician_id", "license_no", "given_name", "family_name", "specialty", "active")
VALUES (202, NULL, 'Taylor', 'Demo', 'Pediatrics', TRUE);

-- 13. clinician nn given. Expected: given_name, SQLSTATE 23502.
INSERT INTO portfolio."clinician" ("clinician_id", "license_no", "given_name", "family_name", "specialty", "active")
VALUES (203, 'LIC-SYN-203', NULL, 'Demo', 'Pediatrics', TRUE);

-- 14. clinician nn family. Expected: family_name, SQLSTATE 23502.
INSERT INTO portfolio."clinician" ("clinician_id", "license_no", "given_name", "family_name", "specialty", "active")
VALUES (204, 'LIC-SYN-204', 'Taylor', NULL, 'Pediatrics', TRUE);

-- 15. clinician nn specialty. Expected: specialty, SQLSTATE 23502.
INSERT INTO portfolio."clinician" ("clinician_id", "license_no", "given_name", "family_name", "specialty", "active")
VALUES (205, 'LIC-SYN-205', 'Taylor', 'Demo', NULL, TRUE);

-- 16. clinician nn active. Expected: active, SQLSTATE 23502.
INSERT INTO portfolio."clinician" ("clinician_id", "license_no", "given_name", "family_name", "specialty", "active")
VALUES (206, 'LIC-SYN-206', 'Taylor', 'Demo', 'Pediatrics', NULL);

-- 17. appointment pk. Expected: pk_appointment, SQLSTATE 23505.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (3, 1, 2, '2026-11-02T10:00:00Z', 'scheduled', 'Follow-up');

-- 18. appointment fk patient. Expected: fk_appointment_0, SQLSTATE 23503.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (301, 9991, 2, '2026-11-03T09:00:00Z', 'scheduled', 'Routine visit');

-- 19. appointment fk clinician. Expected: fk_appointment_1, SQLSTATE 23503.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (302, 1, 9992, '2026-11-03T10:00:00Z', 'scheduled', 'Routine visit');

-- 20. appointment nn id. Expected: appointment_id, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (NULL, 1, 2, '2026-11-04T09:00:00Z', 'scheduled', 'Routine visit');

-- 21. appointment nn patient. Expected: patient_id, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (303, NULL, 2, '2026-11-04T10:00:00Z', 'scheduled', 'Routine visit');

-- 22. appointment nn clinician. Expected: clinician_id, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (304, 1, NULL, '2026-11-04T11:00:00Z', 'scheduled', 'Routine visit');

-- 23. appointment nn time. Expected: scheduled_at, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (305, 1, 2, NULL, 'scheduled', 'Routine visit');

-- 24. appointment nn status. Expected: status, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (306, 1, 2, '2026-11-04T12:00:00Z', NULL, 'Routine visit');

-- 25. appointment check. Expected: appointment_status_check, SQLSTATE 23514.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (307, 1, 2, '2026-11-04T13:00:00Z', 'waiting', 'Routine visit');

-- 26. appointment slot unique. Expected: active_clinician_slot_unique, SQLSTATE 23505.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (308, 1, 2, '2026-11-02T09:00:00Z', 'confirmed', 'Routine visit');
