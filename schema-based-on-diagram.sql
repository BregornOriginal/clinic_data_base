CREATE TABLE patients(
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    name VARCHAR(255) NOT NULL,
    date_of_birth INTEGER NOT NULL,
    PRIMARY KEY(id),
    ON DELETE CASCADE
);

CREATE TABLE medical_histories(
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    admitted_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    patient_id INTEGER NOT NULL,
    status VARCHAR(255) NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT medical_histories_patient_id_foreign FOREIGN KEY(patient_id) REFERENCES patients(id);
    ON DELETE CASCADE
);

CREATE TABLE treatments(
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    type VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id),
);

CREATE TABLE invoices(
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    total_amount DECIMAL(8, 2) NOT NULL,
    generated_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    payed_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    medical_history_id INTEGER NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT invoices_medical_history_id_foreign FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id),
    ON DELETE CASCADE
);
CREATE TABLE invoice_items(
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    unit_price DECIMAL(8, 2) NOT NULL,
    quantity INTEGER NOT NULL,
    total_price DECIMAL(8, 2) NOT NULL,
    invoice_id INTEGER NOT NULL,
    treatment_id INTEGER NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT invoice_items_treatment_id_foreign FOREIGN KEY(treatment_id) REFERENCES treatments(id),
    CONSTRAINT invoice_items_invoice_id_foreign FOREIGN KEY(invoice_id) REFERENCES invoices(id),        
    ON DELETE CASCADE
);

CREATE TABLE treatments_histories (
    medical_histories_id INT NOT NULL,
    treatments_id INT NOT NULL,
    CONSTRAINT fk_treatments FOREIGN KEY(treatments_id) REFERENCES treatments(id),
    CONSTRAINT fk_medical_histories FOREIGN KEY(medical_histories_id) REFERENCES medical_histories(id),
    ON DELETE CASCADE
);

CREATE INDEX patient_asc ON medical_histories(patient_id ASC);
