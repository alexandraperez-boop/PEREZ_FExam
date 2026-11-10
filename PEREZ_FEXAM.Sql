CREATE DATABASE PEREZ_FINALEXAM;

USE PEREZ_FINALEXAM;
 
CREATE TABLE Profile (
    Profile_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    Age INT,
    Department VARCHAR(100),
    Position VARCHAR(100)
);
 
INSERT INTO Profile (Profile_ID, Name, Address, Age, Department, Position) VALUES
(1016, 'Michael Santos', 'Taguig, Philippines', 26, 'IT Department', 'Network Administrator'),
(1017, 'Samantha Reyes', 'Pasay, Philippines', 24, 'Human Resources', 'HR Assistant'),
(1018, 'Daniel Cruz', 'Caloocan, Philippines', 30, 'Engineering', 'Computer Engineer'),
(1019, 'Angela Garcia', 'San Juan, Philippines', 23, 'IT Department', 'Web Developer'),
(1020, 'Joshua Mendoza', 'Marikina, Philippines', 28, 'Engineering', 'System Developer');
 
CREATE DATABASE PEREZ_FINALEXAM_RESTORED;

USE PEREZ_FINALEXAM_RESTORED;
 
CREATE TABLE Profile AS SELECT * FROM PEREZ_FINALEXAM.Profile;

ALTER TABLE Profile ADD PRIMARY KEY (Profile_ID);

ALTER TABLE Profile ADD Encrypted_Address VARBINARY(512);

SET SQL_SAFE_UPDATES = 0;

UPDATE Profile 
SET Encrypted_Address = AES_ENCRYPT(Address, 'MySecretKey123');
 
SELECT 
    Profile_ID,
    Name,
    CAST(AES_DECRYPT(Encrypted_Address, 'MySecretKey123') AS CHAR) AS Decrypted_Address,
    Age, Department, Position
FROM Profile
WHERE Profile_ID IN (1017, 1018);
 
SELECT 
    Profile_ID, Name, 
    HEX(Encrypted_Address) AS Encrypted_Address, 
    Department, Position 
FROM Profile;