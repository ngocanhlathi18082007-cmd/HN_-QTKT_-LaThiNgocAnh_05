
-- Tạo CSDL mới
CREATE DATABASE ClinicDB;

-- Sử dụng CSDL vừa tạo
USE ClinicDB;

-- 1.1 Tạo bảng Patients (Bệnh nhân)
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15)
);

-- 1.2 Tạo bảng Doctors (Bác sĩ)
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- 1.3 Tạo bảng Appointments (Lịch khám)
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    diagnosis VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Câu 2: Thêm dữ liệu mẫu
-- Thêm dữ liệu vào bảng Patients
INSERT INTO Patients (patient_name, age, gender, phone) VALUES 
('Nguyen Van An', 25, 'Nam', '0901111111'),
('Tran Thi Binh', 30, 'Nu', '0902222222'),
('Le Van Cuong', 45, 'Nam', '0903333333'),
('Pham Thi Dung', 28, 'Nu', '0904444444'),
('Hoang Van Em', 60, 'Nam', '0905555555'),
('Do Thi Hoa', 55, 'Nu', '0906666666'),
('Vu Van Giang', 18, 'Nam', '0907777777'),
('Bui Thi Hang', 22, 'Nu', '0908888888'),
('Ngo Van Hung', 35, 'Nam', '0909999999'),
('Trinh Thi Khoi', 40, 'Nu', '0910000000');

-- Thêm dữ liệu vào bảng Doctors
INSERT INTO Doctors (doctor_name, specialization, salary) VALUES 
('Dr. Le Minh', 'Noi khoa', 20000000),
('Dr. Pham Huong', 'Nhi khoa', 18000000),
('Dr. Tran Duc', 'Ngoai khoa', 25000000),
('Dr. Nguyen Lan', 'Da lieu', 15000000),
('Dr. Hoang Tuan', 'Tim mach', 30000000),
('Dr. Vu Mai', 'Than kinh', 28000000),
('Dr. Do Hung', 'Noi khoa', 19000000),
('Dr. Bui Thao', 'Nhi khoa', 17000000),
('Dr. Ngo Kien', 'Rang Ham Mat', 22000000),
('Dr. Trinh Ly', 'Mat', 16000000);

-- Thêm dữ liệu vào bảng Appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, diagnosis) VALUES 
(1, 1, '2024-01-10 08:30:00', 'Dau da day'),
(2, 2, '2024-01-11 09:00:00', 'Sot virus'),
(3, 3, '2024-01-12 10:15:00', 'Gay xuong tay'),
(4, 4, '2024-01-13 14:00:00', 'Di ung da'),
(5, 5, '2024-01-14 15:30:00', 'Tang huyet ap'),
(6, 6, '2024-01-15 08:00:00', 'Dau dau man tinh'),
(7, 7, '2024-01-16 11:00:00', 'Viem hong'),
(8, 8, '2024-01-17 13:45:00', 'Ho khan'),
(9, 9, '2024-01-18 16:00:00', 'Sau rang'),
(10, 10, '2023-12-20 09:30:00', 'Can thi');


-- 3.1 Cập nhật chuyên khoa của Dr. Le Minh thành 'Noi tiet'
UPDATE Doctors
SET specialization = 'Noi tiet'
WHERE doctor_name = 'Dr. Le Minh';

-- 3.2 Cập nhật chẩn đoán của bệnh nhân có patient_id = 1
UPDATE Appointments
SET diagnosis = 'Viem loet da day'
WHERE patient_id = 1;

-- Câu 4: Xóa dữ liệu
-- 4.1 Xóa các lịch khám trong năm 2023
-- Lưu ý: Cần tắt chế độ Safe Update nếu gặp lỗi (SET SQL_SAFE_UPDATES = 0;)
DELETE FROM Appointments
WHERE YEAR(appointment_date) = 2023;

-- 4.2 Xóa bác sĩ có tên "Dr. Trinh Ly"
-- (Sau khi xóa lịch khám năm 2023 ở trên, Dr. Trinh Ly không còn ràng buộc khóa ngoại nên có thể xóa)
DELETE FROM Doctors
WHERE doctor_name = 'Dr. Trinh Ly';

-- 5.1 Danh sách bác sĩ chuyên khoa 'Noi khoa'
SELECT * FROM Doctors 
WHERE specialization = 'Noi khoa';

-- 5.2 Danh sách bệnh nhân Nam trên 30 tuổi
SELECT * FROM Patients 
WHERE gender = 'Nam' AND age > 30;

-- 5.3 Tìm bác sĩ có tên chứa chữ "Hung"
SELECT * FROM Doctors 
WHERE doctor_name LIKE '%Hung%';

-- 5.4 Danh sách bệnh nhân sắp xếp theo tuổi giảm dần
SELECT * FROM Patients 
ORDER BY age DESC;

-- 5.5 Lấy ra thông tin 3 lịch khám mới nhất
SELECT * FROM Appointments 
ORDER BY appointment_date DESC 
LIMIT 3;

-- Câu 6: Truy vấn nhiều bảng (JOIN)
-- 6.1 Lấy Tên BN, Tên BS, Ngày khám, Chẩn đoán
SELECT 
    p.patient_name, 
    d.doctor_name, 
    a.appointment_date, 
    a.diagnosis
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id;

-- 6.2 Lấy tên bệnh nhân và chuyên khoa bác sĩ họ đã khám
SELECT 
    p.patient_name, 
    d.specialization
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id;

-- 6.3 Tên bác sĩ và chẩn đoán lịch khám tháng 01/2024
SELECT 
    d.doctor_name, 
    a.diagnosis
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE MONTH(a.appointment_date) = 1 AND YEAR(a.appointment_date) = 2024;

-- 6.4 Danh sách bệnh nhân đã khám tại chuyên khoa 'Nhi khoa'
SELECT 
    p.*
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE d.specialization = 'Nhi khoa';

-- Câu 7: Truy vấn gom nhóm (GROUP BY)
-- 7.1 Thống kê số lượng bác sĩ theo từng chuyên khoa
SELECT 
    specialization, 
    COUNT(doctor_id) AS number_of_doctors
FROM Doctors
GROUP BY specialization;

-- 7.2 Tính lương trung bình của tất cả bác sĩ
SELECT AVG(salary) AS average_salary 
FROM Doctors;

-- 7.3 Tìm những chuyên khoa có từ 2 bác sĩ trở lên
SELECT 
    specialization, 
    COUNT(doctor_id) AS doctor_count
FROM Doctors
GROUP BY specialization
HAVING count(doctor_id) >= 2;

-- Câu 8: Truy vấn lồng (Subqueries)
-- 8.1 Tìm bác sĩ có mức lương cao nhất
SELECT doctor_name, salary
FROM Doctors
WHERE salary = (SELECT MAX(salary) FROM Doctors);

-- 8.2 Lấy danh sách bệnh nhân đăng ký khám nhiều lần nhất
-- (Trong dữ liệu mẫu mỗi người chỉ khám 1 lần, câu lệnh này sẽ lấy người có số lần cao nhất bất kỳ)
SELECT p.patient_name, COUNT(a.appointment_id) as visit_count
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.patient_name
HAVING visit_count >= ALL (
SELECT COUNT(appointment_id)
FROM Appointments
GROUP BY patient_id
);