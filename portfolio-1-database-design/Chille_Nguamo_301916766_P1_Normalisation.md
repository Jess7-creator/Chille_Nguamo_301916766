# Hospital / Clinic System — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| patient_id | appointment records (list) |
| --- | --- |
| 1 | [3] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| appointment.appointment_id | appointment.patient_id | appointment.clinician_id | appointment.status | patient.patient_id | patient.medical_record_no | clinician.clinician_id | clinician.license_no |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 3 | 1 | 2 | scheduled | 1 | MR-SYN-001 | 2 | LIC-SYN-001 |

Key: appointment_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## appointment_example

| appointment.appointment_id | appointment.patient_id | appointment.clinician_id | appointment.status | patient.patient_id | patient.medical_record_no | clinician.clinician_id | clinician.license_no |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 3 | 1 | 2 | scheduled | 1 | MR-SYN-001 | 2 | LIC-SYN-001 |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## patient

| patient_id | medical_record_no | given_name | family_name | date_of_birth | active |
| --- | --- | --- | --- | --- | --- |
| 1 | MR-SYN-001 | Avery | Example | 1985-04-12 | true |

## clinician

| clinician_id | license_no | given_name | family_name | specialty | active |
| --- | --- | --- | --- | --- | --- |
| 2 | LIC-SYN-001 | Jordan | Sample | Family Medicine | true |

## appointment

| appointment_id | patient_id | clinician_id | scheduled_at | status | reason |
| --- | --- | --- | --- | --- | --- |
| 3 | 1 | 2 | 2026-11-02T09:00:00+00:00 | scheduled | Routine visit |

## Dependencies

- patient: (patient_id) → medical_record_no, given_name, family_name, date_of_birth, active
- clinician: (clinician_id) → license_no, given_name, family_name, specialty, active
- appointment: (appointment_id) → patient_id, clinician_id, scheduled_at, status, reason

Joining the decomposed sample tables reproduces the original 1 example rows. The design assumes the declared keys describe the relevant business dependencies.
