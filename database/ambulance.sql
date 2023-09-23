CREATE TABLE ratings (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    rating_value INT NOT NULL,
    comments TEXT
);
CREATE TABLE ambulances (
    ambulance_id INT AUTO_INCREMENT PRIMARY KEY,
    ambulance_plate VARCHAR(20) NOT NULL,
    current_request_id INT -- FOREIGN KEY (current_request_id) REFERENCES ambulance_requests(request_id)
);
CREATE TABLE ambulance_requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_name VARCHAR(255) NOT NULL,
    pickup_location VARCHAR(255) NOT NULL,
    request_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM(
        'Pending',
        'Dispatched',
        'Arrived',
        'Completed',
        'Canceled'
    ) NOT NULL,
    emergency_nature VARCHAR(50),
    emergency_severity VARCHAR(50),
    ambulance_id INT,
    FOREIGN KEY (ambulance_id) REFERENCES ambulances(ambulance_id),
    rating_id INT,
    FOREIGN KEY (rating_id) REFERENCES ratings(rating_id)
);