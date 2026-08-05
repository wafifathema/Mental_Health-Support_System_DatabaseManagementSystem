-- Mental Health Support System Database Project
-- Create and use the database
CREATE DATABASE IF NOT EXISTS mental_health_db;
USE mental_health_db;

-- Drop existing tables if they exist (for rerun safety)
DROP TABLE IF EXISTS session_log;
DROP TABLE IF EXISTS Feedback;
DROP TABLE IF EXISTS Sessions;
DROP TABLE IF EXISTS Billing;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Counselors;

-- Table 1: Users
CREATE TABLE Users (
  user_id INT PRIMARY KEY,
  name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  email VARCHAR(50) UNIQUE,
  phone VARCHAR(15)
);

-- Table 2: Counselors
CREATE TABLE Counselors (
  counselor_id INT PRIMARY KEY,
  name VARCHAR(50),
  specialization VARCHAR(50),
  email VARCHAR(50),
  phone VARCHAR(15)
);

-- Table 3: Sessions
CREATE TABLE Sessions (
  session_id INT PRIMARY KEY,
  user_id INT,
  counselor_id INT,
  session_date DATE,
  session_time TIME,
  status VARCHAR(20),
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (counselor_id) REFERENCES Counselors(counselor_id)
);

-- Table 4: Feedback
CREATE TABLE Feedback (
  feedback_id INT PRIMARY KEY,
  session_id INT,
  rating INT,
  comments TEXT,
  FOREIGN KEY (session_id) REFERENCES Sessions(session_id)
);

-- Table 5: Billing
CREATE TABLE Billing (
  bill_id INT PRIMARY KEY,
  user_id INT,
  amount DECIMAL(10,2),
  billing_date DATE,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Table 6: Session Log (for trigger)
CREATE TABLE session_log (
  log_id INT AUTO_INCREMENT PRIMARY KEY,
  session_id INT,
  log_message TEXT,
  log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert Data into Users
INSERT INTO Users VALUES
(1, 'Ayesha Khan', 24, 'Female', 'ayesha24@gmail.com', '01711111111'),
(2, 'Rafiq Islam', 27, 'Male', 'rafiq27@gmail.com', '01722222222'),
(3, 'Mehjabin Noor', 22, 'Female', 'mehjabin22@gmail.com', '01733333333'),
(4, 'Tariq Ahmed', 30, 'Male', 'tariq30@gmail.com', '01744444444'),
(5, 'Farhana Jahan', 28, 'Female', 'farhana28@gmail.com', '01755555555'),
(6, 'Nabil Hossain', 26, 'Male', 'nabil26@gmail.com', '01766666666'),
(7, 'Samira Islam', 23, 'Female', 'samira23@gmail.com', '01777777777'),
(8, 'Imran Aziz', 31, 'Male', 'imran31@gmail.com', '01788888888'),
(9, 'Tania Rahman', 25, 'Female', 'tania25@gmail.com', '01799999999'),
(10, 'Adnan Kabir', 29, 'Male', 'adnan29@gmail.com', '01800000000');

-- Insert Data into Counselors
INSERT INTO Counselors VALUES
(1, 'Dr. Mehnaz Rahman', 'Clinical Psychologist', 'mehnaz@clinic.com', '01811111111'),
(2, 'Dr. Saif Hossain', 'Counseling Psychologist', 'saif@therapy.com', '01822222222');

-- Insert Data into Sessions
INSERT INTO Sessions VALUES
(1, 1, 1, '2024-06-01', '10:00:00', 'Completed'),
(2, 2, 2, '2024-06-02', '11:00:00', 'Scheduled'),
(3, 3, 1, '2024-06-03', '09:30:00', 'Completed'),
(4, 4, 2, '2024-06-04', '12:00:00', 'Scheduled'),
(5, 5, 1, '2024-06-05', '10:30:00', 'Completed'),
(6, 6, 2, '2024-06-06', '11:15:00', 'Cancelled'),
(7, 7, 1, '2024-06-07', '10:45:00', 'Completed'),
(8, 8, 2, '2024-06-08', '09:00:00', 'Scheduled'),
(9, 9, 1, '2024-06-09', '08:30:00', 'Completed'),
(10, 10, 2, '2024-06-10', '10:15:00', 'Scheduled');

-- Insert Data into Feedback
INSERT INTO Feedback VALUES
(1, 1, 5, 'Very helpful session'),
(2, 2, 4, 'Looking forward to next one'),
(3, 3, 5, 'Excellent counseling'),
(4, 5, 3, 'Helpful, but a bit rushed'),
(5, 6, 2, 'Did not meet expectations'),
(6, 7, 4, 'Good advice given'),
(7, 8, 5, 'Nice experience overall'),
(8, 9, 5, 'Very professional and empathetic'),
(9, 10, 3, 'Average session'),
(10, 4, 4, 'Hope to continue more');

-- Insert Data into Billing
INSERT INTO Billing VALUES
(1, 1, 1000.00, '2024-06-01'),
(2, 2, 1200.00, '2024-06-02'),
(3, 3, 900.00, '2024-06-03'),
(4, 4, 950.00, '2024-06-04'),
(5, 5, 1100.00, '2024-06-05'),
(6, 6, 850.00, '2024-06-06'),
(7, 7, 1050.00, '2024-06-07'),
(8, 8, 1150.00, '2024-06-08'),
(9, 9, 990.00, '2024-06-09'),
(10, 10, 1000.00, '2024-06-10');

-- Stored Procedure: Get User Info
DELIMITER //

CREATE PROCEDURE GetUserInfo (IN uid INT)
BEGIN
    SELECT name, age, phone
    FROM Users
    WHERE user_id = uid;
END //

DELIMITER ;

-- Function: Count Completed Sessions
DELIMITER //

CREATE FUNCTION CountCompletedSessions(uid INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Sessions
    WHERE user_id = uid AND status = 'Completed';
    RETURN total;
END //

DELIMITER ;

-- Trigger: After Session Insert
DELIMITER //

CREATE TRIGGER after_session_insert
AFTER INSERT ON Sessions
FOR EACH ROW
BEGIN
    INSERT INTO session_log (session_id, log_message)
    VALUES (NEW.session_id, CONCAT('New session added with ID: ', NEW.session_id));
END //

DELIMITER ;
