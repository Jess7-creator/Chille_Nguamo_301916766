-- Hospital / Clinic System: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."patient" (
  "patient_id" bigint NOT NULL,
  "medical_record_no" text NOT NULL,
  "given_name" text NOT NULL,
  "family_name" text NOT NULL,
  "date_of_birth" date NOT NULL,
  "active" boolean NOT NULL,
  CONSTRAINT "pk_patient" PRIMARY KEY ("patient_id"),
  CONSTRAINT "uq_patient_0" UNIQUE ("medical_record_no")
);
CREATE TABLE portfolio."clinician" (
  "clinician_id" bigint NOT NULL,
  "license_no" text NOT NULL,
  "given_name" text NOT NULL,
  "family_name" text NOT NULL,
  "specialty" text NOT NULL,
  "active" boolean NOT NULL,
  CONSTRAINT "pk_clinician" PRIMARY KEY ("clinician_id"),
  CONSTRAINT "uq_clinician_0" UNIQUE ("license_no")
);
CREATE TABLE portfolio."appointment" (
  "appointment_id" bigint NOT NULL,
  "patient_id" bigint NOT NULL,
  "clinician_id" bigint NOT NULL,
  "scheduled_at" timestamptz NOT NULL,
  "status" text NOT NULL,
  "reason" text,
  CONSTRAINT "pk_appointment" PRIMARY KEY ("appointment_id")
);
ALTER TABLE portfolio."appointment" ADD CONSTRAINT "fk_appointment_0" FOREIGN KEY ("patient_id") REFERENCES portfolio."patient" ("patient_id");
ALTER TABLE portfolio."appointment" ADD CONSTRAINT "fk_appointment_1" FOREIGN KEY ("clinician_id") REFERENCES portfolio."clinician" ("clinician_id");
ALTER TABLE portfolio."appointment" ADD CONSTRAINT "appointment_status_check" CHECK (("status" = 'scheduled') OR ("status" = 'confirmed') OR ("status" = 'cancelled') OR ("status" = 'completed'));
CREATE UNIQUE INDEX "active_clinician_slot_unique" ON portfolio."appointment" ("clinician_id", "scheduled_at") WHERE (("status" = 'scheduled') OR ("status" = 'confirmed'));
COMMIT;
