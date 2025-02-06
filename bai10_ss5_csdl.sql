CREATE DATABASE bai10;
USE bai10;
CREATE TABLE Patients(
	patientId INT PRIMARY KEY AUTO_INCREMENT,
    fullName VARCHAR(100),
    dateOfBirth DATE,
    gender VARCHAR(10),
    phoneNumber VARCHAR(15)
);

CREATE TABLE Doctors(
	doctorId INT PRIMARY KEY AUTO_INCREMENT,
    fullName VARCHAR(100),
    specialization VARCHAR(50),
    phoneNumber VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE Appointments(
	appointmentId INT PRIMARY KEY AUTO_INCREMENT,
    patientId INT,
    doctorId INT,
    appointmentDate DATETIME,
    status VARCHAR(20),
    FOREIGN KEY (patientId) REFERENCES Patients(patientId),
    FOREIGN KEY (doctorId) REFERENCES Doctors(doctorId)
);

CREATE TABLE MedicalRecords(
	recordId INT PRIMARY KEY AUTO_INCREMENT,
    patientId INT,
    doctorId INT,
    diagnosis TEXT,
    treatmentPlan TEXT,
    FOREIGN KEY (patientId) REFERENCES Patients(patientId),
    FOREIGN KEY (doctorId) REFERENCES Doctors(doctorId)
);

INSERT INTO Patients (fullName, dateOfBirth, gender, phoneNumber)
VALUES
    ('Nguyen Van An', '1985-05-15', 'Nam', '0901234567'),
    ('Tran Thi Binh', '1990-09-12', 'Nu', '0912345678'),
    ('Pham Van Cuong', '1978-03-20', 'Nam', '0923456789'),
    ('Le Thi Dung', '2000-11-25', 'Nu', '0934567890'),
    ('Vo Van Em', '1982-07-08', 'Nam', '0945678901'),
    ('Hoang Thi Phuong', '1995-01-18', 'Nu', '0956789012'),
    ('Ngo Van Giang', '1988-12-30', 'Nam', '0967890123'),
    ('Dang Thi Hanh', '1992-06-10', 'Nu', '0978901234'),
    ('Bui Van Hoa', '1975-10-22', 'Nam', '0989012345');

INSERT INTO Doctors (fullName, specialization, phoneNumber, email)
VALUES
    ('Le Minh', 'Noi Tong Quat', '0908765432', 'leminh@hospital.vn'),
    ('Phan Huong', 'Nhi Khoa', '0918765432', 'phanhuong@hospital.vn'),
    ('Nguyen Tuan', 'Tim Mach', '0928765432', 'nguyentuan@hospital.vn'),
    ('Dang Quang', 'Than Kinh', '0938765432', 'dangquang@hospital.vn'),
    ('Hoang Dung', 'Da Lieu', '0948765432', 'hoangdung@hospital.vn'),
    ('Vu Hanh', 'Phu San', '0958765432', 'vuhanh@hospital.vn'),
    ('Tran An', 'Noi Tiet', '0968765432', 'tranan@hospital.vn'),
    ('Lam Phong', 'Ho Hap', '0978765432', 'lamphong@hospital.vn'),
    ('Pham Ha', 'Chan Thuong Chinh Hinh', '0988765432', 'phamha@hospital.vn');

INSERT INTO Appointments (patientId, doctorId, appointmentDate, status)
VALUES
    (1, 2, '2025-01-20 09:00:00', 'Da Dat'),
    (3, 1, '2025-01-21 10:30:00', 'Da Dat'),
    (5, 3, '2025-01-22 08:00:00', 'Da Dat'),
    (2, 4, '2025-01-23 14:00:00', 'Da Dat'),
    (4, 5, '2025-01-24 11:00:00', 'Da Dat'),
    (6, 6, '2025-01-25 15:00:00', 'Da Dat'),
    (7, 7, '2025-01-26 16:30:00', 'Da Dat'),
    (8, 8, '2025-01-27 09:00:00', 'Da Dat'),
    (9, 9, '2025-01-28 10:00:00', 'Da Dat');

INSERT INTO MedicalRecords (patientId, doctorId, diagnosis, treatmentPlan)
VALUES
    (1, 2, 'Cam Cum', 'Nghi ngoi, uong nhieu nuoc, su dung paracetamol 500mg khi sot.'),
    (3, 1, 'Dau Dau Man Tinh', 'Kiem tra huyet ap dinh ky, giam cang thang, su dung thuoc giam dau khi can.'),
    (5, 3, 'Roi Loan Nhip Tim', 'Theo doi tim mach 1 tuan/lan, dung thuoc dieu hoa nhip tim.'),
    (2, 4, 'Dau Cot Song', 'Vat ly tri lieu, giam van dong manh.'),
    (4, 5, 'Viêm Da Tiep Xuc', 'Su dung kem boi da, tranh tiep xuc voi chat gay di ung.'),
    (6, 6, 'Thieu Mau', 'Tang cuong thuc pham giau sat, bo sung vitamin.'),
    (7, 7, 'Tieu Duong Type 2', 'Duy tri che do an lanh manh, kiem tra duong huyet thuong xuyen.'),
    (8, 8, 'Hen Suyen', 'Su dung thuoc xit hen hang ngay, tranh tiep xuc bui ban.'),
    (9, 9, 'Gay Xuong', 'Bo bot, kiem tra xuong dinh ky, vat ly tri lieu sau khi thao bot.');
 
 -- 2
 SELECT 
CONCAT(p.fullName, ' (', YEAR(a.appointmentDate) - YEAR(p.dateOfBirth), ') - ', d.fullName) AS `PatientDoctorInfo`,
a.appointmentDate AS `AppointmentDate`,
mr.diagnosis AS `Diagnosis`
FROM Appointments a
JOIN Patients p ON a.patientId = p.patientId
JOIN Doctors d ON a.doctorId = d.doctorId
LEFT JOIN MedicalRecords mr ON a.patientId = mr.patientId AND a.doctorId = mr.doctorId
ORDER BY a.appointmentDate ASC;

-- 3
SELECT 
    p.fullName AS `PatientName`,
    YEAR(a.appointmentDate) - YEAR(p.dateOfBirth) AS `AgeAtAppointment`,
    a.appointmentDate AS `AppointmentDate`,
    CASE 
        WHEN YEAR(a.appointmentDate) - YEAR(p.dateOfBirth) > 50 THEN 'Nguy cơ cao'
        WHEN YEAR(a.appointmentDate) - YEAR(p.dateOfBirth) BETWEEN 30 AND 50 THEN 'Nguy cơ trung bình'
        ELSE 'Nguy cơ thấp'
    END AS `RiskLevel`
FROM Appointments a
JOIN Patients p ON a.patientId = p.patientId
ORDER BY a.appointmentDate;

-- 4
DELETE FROM Appointments 
WHERE 
    (YEAR(appointmentDate) - (SELECT YEAR(dateOfBirth) FROM Patients WHERE Patients.patientId = Appointments.patientId)) > 30
    AND doctorId IN (SELECT doctorId FROM Doctors WHERE specialization IN ('Noi Tong Quat', 'Chan Thuong Chinh Hinh'));

SELECT 
    p.fullName AS `PatientName`,
    d.specialization AS `Specialization`,
    YEAR(a.appointmentDate) - YEAR(p.dateOfBirth) AS `AgeAtAppointment`
FROM Appointments a
JOIN Patients p ON a.patientId = p.patientId
JOIN Doctors d ON a.doctorId = d.doctorId
ORDER BY a.appointmentDate;