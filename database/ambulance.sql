CREATE TABLE ratings (
    rating_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    rating_value INT NOT NULL,
    comments TEXT,
    request_id BIGINT
);
CREATE TABLE ambulances (
    ambulance_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ambulance_plate VARCHAR(20) UNIQUE,
    in_use BOOLEAN DEFAULT FALSE,
    issuing_organization varchar(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    in_contract BOOLEAN DEFAULT TRUE,
    lease_expiry_date DATETIME,
    driver_contact varchar(50),
    ambulance_location VARCHAR(50),
    comments TEXT,
    current_request_id BIGINT -- FOREIGN KEY (current_request_id) REFERENCES ambulance_requests(request_id)
);
CREATE TABLE ambulance_requests (
    request_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    patient_id BIGINT unsigned NOT NULL,
    pickup_location VARCHAR(255) NOT NULL,
    destination_address VARCHAR(255) NOT NULL,
    distance VARCHAR(50) NOT NULL,
    pickup_date DATETIME NOT NULL,
    patient_state TEXT NOT NULL,
    request_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    request_status ENUM(
        'Pending',
        'Dispatched',
        'Arrived',
        'Completed',
        'Canceled'
    ) NOT NULL,
    -- emergency_nature VARCHAR(50),
    -- emergency_severity VARCHAR(50),
    ambulance_id BIGINT,
    rating_id BIGINT,
    FOREIGN KEY (patient_id) REFERENCES users(id),
    FOREIGN KEY (ambulance_id) REFERENCES ambulances(ambulance_id),
    FOREIGN KEY (rating_id) REFERENCES ratings(rating_id)
);
ALTER TABLE ambulances
ADD CONSTRAINT FK_current_request FOREIGN KEY (current_request_id) REFERENCES ambulance_requests(request_id);
ALTER TABLE ratings
ADD CONSTRAINT FK_request_id FOREIGN KEY (request_id) REFERENCES ambulance_requests(request_id);