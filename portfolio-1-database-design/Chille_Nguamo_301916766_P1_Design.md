# Hospital / Clinic System — database design

My case study records patient, clinician, appointment.

## Users

- Clinic schedulers
- Clinicians
- Reporting staff

## Main operations

- Register synthetic patients and clinicians
- Schedule, reschedule, or cancel appointments
- Review appointment schedules and summary counts

## Entities

| Entity | Information stored |
| --- | --- |
| patient | Stores a synthetic patient identity and basic registration details. |
| clinician | Stores a synthetic clinician identity, license reference, and specialty. |
| appointment | Records a patient visit with one clinician at a scheduled time and a lifecycle status. |

## patient

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| patient_id | BIGINT | PK | Yes |
| medical_record_no | TEXT | Unique | Yes |
| given_name | TEXT |  | Yes |
| family_name | TEXT |  | Yes |
| date_of_birth | DATE |  | Yes |
| active | BOOLEAN |  | Yes |
- Unique key: (medical_record_no).

## clinician

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| clinician_id | BIGINT | PK | Yes |
| license_no | TEXT | Unique | Yes |
| given_name | TEXT |  | Yes |
| family_name | TEXT |  | Yes |
| specialty | TEXT |  | Yes |
| active | BOOLEAN |  | Yes |
- Unique key: (license_no).

## appointment

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| appointment_id | BIGINT | PK | Yes |
| patient_id | BIGINT | FK | Yes |
| clinician_id | BIGINT | FK | Yes |
| scheduled_at | TIMESTAMPTZ |  | Yes |
| status | TEXT |  | Yes |
| reason | TEXT |  | No |
- patient_id → patient.patient_id
- clinician_id → clinician.clinician_id

## Relationships and business rules

- Each patient must have a distinct synthetic medical record number.
- Each clinician must have a distinct synthetic license number.
- Every appointment must reference an existing patient through patient_id to patient.patient_id.
- Every appointment must reference an existing clinician through clinician_id to clinician.clinician_id.
- Appointment status must be one of scheduled, confirmed, cancelled, or completed.
- A clinician may have at most one scheduled or confirmed appointment at an exact scheduled_at timestamp; cancelled or completed appointments do not reserve the slot.

## Assumptions

- Each appointment refers to exactly one patient and one clinician.
- Identifier values are UUIDs generated from one shared namespace, making primary keys globally unique across these entity types.
- An active appointment is scheduled or confirmed; cancelled and completed appointments do not reserve a clinician's time slot.
- For the worked normalization example, start with an appointment relation that repeats patient_name; move that attribute to Patient and retain patient_id as the appointment's foreign key. The clinician relationship is not part of this example.

