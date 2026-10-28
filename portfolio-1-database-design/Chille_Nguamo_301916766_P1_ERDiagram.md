# Hospital / Clinic System — ER diagram

```mermaid
erDiagram
    direction LR
    patient {
        bigint patient_id PK
        text medical_record_no UK
        text given_name
        text family_name
        date date_of_birth
        boolean active
    }
    clinician {
        bigint clinician_id PK
        text license_no UK
        text given_name
        text family_name
        text specialty
        boolean active
    }
    appointment {
        bigint appointment_id PK
        bigint patient_id FK
        bigint clinician_id FK
        timestamptz scheduled_at
        text status
        text reason "Optional"
    }
    patient ||--o{ appointment : "patient_id"
    clinician ||--o{ appointment : "clinician_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Chille_Nguamo_301916766_ERDiagram.png)
