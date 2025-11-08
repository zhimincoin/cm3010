-- Happiness TCM Clinic Database Schema
-- CM3010 Practical 2

CREATE DATABASE IF NOT EXISTS cm3010_tcm;
USE cm3010_tcm;

-- 1. Roles
CREATE TABLE roles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  description TEXT NULL
);

-- 2. Staff
CREATE TABLE staff (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  role_id INT NOT NULL,
  license_number VARCHAR(20) UNIQUE NULL,
  username VARCHAR(50) UNIQUE NOT NULL,
  password VARCHAR(100) NOT NULL,
  hire_date DATE DEFAULT (CURRENT_DATE),
  FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- 3. Patients
CREATE TABLE patients (
  nric VARCHAR(9) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  phone VARCHAR(15) NOT NULL,
  email VARCHAR(100) UNIQUE NULL,
  date_of_birth DATE NOT NULL,
  chief_complaint TEXT
);

-- 4. Treatment types
CREATE TABLE treatment_types (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  duration_minutes INT NOT NULL
);

-- 5. Rooms
CREATE TABLE rooms (
  id INT AUTO_INCREMENT PRIMARY KEY,
  room_number VARCHAR(10) UNIQUE NOT NULL,
  room_type VARCHAR(50) NOT NULL
);

-- 6. Appointments
CREATE TABLE appointments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  patient_nric VARCHAR(9) NOT NULL,
  physician_staff_id INT NOT NULL,
  room_id INT NOT NULL,
  treatment_type_id INT NOT NULL,
  scheduled_datetime DATETIME NOT NULL,
  status ENUM('scheduled', 'completed', 'cancelled') DEFAULT 'scheduled',
  FOREIGN KEY (patient_nric) REFERENCES patients(nric),
  FOREIGN KEY (physician_staff_id) REFERENCES staff(id),
  FOREIGN KEY (room_id) REFERENCES rooms(id),
  FOREIGN KEY (treatment_type_id) REFERENCES treatment_types(id)
);

-- Insert roles
INSERT INTO roles (name, description) VALUES
('Administrator', 'Clinic administrator handling operations and compliance'),
('Physician', 'Licensed TCM practitioner'),
('Receptionist', 'Front desk and appointment scheduling');

-- Insert sample rooms
INSERT INTO rooms (room_number, room_type) VALUES
('A1', 'Acupuncture Room'),
('H1', 'Herbal Dispensary'),
('T1', 'Therapy Room');

-- Insert treatment types
INSERT INTO treatment_types (name, duration_minutes) VALUES
('Acupuncture', 60),
('Herbal Consultation', 30),
('Cupping Therapy', 45),
('Tuina Therapeutic Massage', 60);
