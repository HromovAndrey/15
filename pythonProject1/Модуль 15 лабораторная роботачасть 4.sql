
-- CREATE TABLE DoctorsSpecializations (
--     Id SERIAL PRIMARY KEY,
--     DoctorId INT NOT NULL,
--     SpecializationId INT NOT NULL,
--     FOREIGN KEY (DoctorId) REFERENCES Doctors(Id),
--     FOREIGN KEY (SpecializationId) REFERENCES Specializations(Id)
-- );


-- CREATE TABLE Vacations (
--     Id SERIAL PRIMARY KEY,
--     StartDate DATE NOT NULL,
--     EndDate DATE NOT NULL CHECK (EndDate > StartDate),
--     DoctorId INT NOT NULL,
--     FOREIGN KEY (DoctorId) REFERENCES Doctors(Id)
-- );

--Виведіть повні імена лікарів та їх спеціалізації
-- SELECT CONCAT(D.Name, ' ', D.Surname) AS Full_Name, S.Name AS Specialization
-- FROM Doctors D
-- JOIN DoctorsSpecializations DS ON D.Id = DS.DoctorId
-- JOIN Specializations S ON DS.SpecializationId = S.Id;

--Виведіть прізвища та зарплати (сума ставки та надбавки) лікарів, які не перебувають у відпустці
-- SELECT Surname, Salary + COALESCE(Premium, 0) AS Total_Salary
-- FROM Doctors
-- WHERE Id NOT IN (SELECT DoctorId FROM Vacations);

-- Виведіть назви палат, які знаходяться у відділенні «Intensive Treatment»
-- SELECT W.Name AS Ward_Name
-- FROM wards
-- JOIN Departments D ON wards.Id = D.Id
-- WHERE D.Name = 'Intensive Treatment';

--Виведіть назви відділень без повторень, 
--які спонсоруються компанією «Umbrella Corporation
-- SELECT DISTINCT D.Name AS Department_Name
-- FROM Departments D
-- JOIN Donations DN ON D.Id = DN.DepartmentId
-- JOIN Sponsors S ON DN.SponsorId = S.Id
-- WHERE S.Name = 'Umbrella Corporation';

--Виведіть усі пожертвування за останній місяць
--у вигляді: відділення, спонсор, сума пожертвування, дата пожертвування
-- SELECT D.Name AS Department_Name, S.Name AS Sponsor_Name, DN.Amount, DN.DonationDate
-- FROM Donations DN
-- JOIN Departments D ON DN.DepartmentId = D.Id
-- JOIN Sponsors S ON DN.SponsorId = S.Id
-- WHERE EXTRACT(MONTH FROM DN.DonationDate) = EXTRACT(MONTH FROM CURRENT_DATE);


-- Виведіть прізвища лікарів із зазначенням відділень, в яких вони проводять обстеження. 
-- Враховуйте обстеження, які проводяться лише у будні дні
-- SELECT DISTINCT D.Surname, DSE.Name AS Department_Name
-- FROM Doctors D
-- JOIN Doctor_Examinations DE ON D.Id = DE.DoctorId
-- JOIN Examinations E ON DE.ExaminationId = E.Id
-- JOIN Departments DSE ON E.DepartmentId = DSE.Id
-- WHERE EXTRACT(DOW FROM E.StartTime) BETWEEN 1 AND 5; -- Понеділок - П'ятниця

--Виведіть назви відділень, які отримували пожертвування у розмірі понад 100000, із зазначенням їх лікарів
-- SELECT DSE.Name AS Department_Name, D.Name AS Doctor_Name
-- FROM Departments DSE
-- JOIN Donations DN ON DSE.Id = DN.DepartmentId
-- JOIN Doctors D ON D.Id = D.DepartmentId
-- WHERE DN.Amount > 100000;

-- CREATE TABLE Departmentss (
--     Id SERIAL PRIMARY KEY,
--     Name VARCHAR(100) NOT NULL UNIQUE
-- );

-- SELECT DSE.Name AS Department_Name, D.Name AS Doctor_Name
-- FROM Departmentss DSE
-- JOIN Donations DN ON DSE.Id = DN.DepartmentId
-- JOIN Doctors D ON D.Id = D.DepartmentId
-- WHERE DN.Amount > 100000;

--ALTER TABLE Doctors ADD COLUMN Department_Id INT
--Виведення назв відділень, в яких лікарі не отримують надбавки
-- SELECT DISTINCT Departments.Name
-- FROM Departments
-- JOIN Doctors ON Departments.Id = Doctors.Department_Id
-- WHERE Doctors.Premium IS NULL OR Doctors.Premium = 0

--ALTER TABLE Examinations ADD COLUMN DiseaseId INT;

--ALTER TABLE Examinations ADD COLUMN DepartmentId INT
--Виведіть назви відділень і назви захворювань, 
--обстеження з яких вони проводили за останній півроку
--SELECT DSE.Name AS Department_Name, D.Name AS Disease_Name
--FROM Departments DSE
--JOIN Examinations E ON DSE.Id = E.DepartmentId
--JOIN Diseases D ON E.DiseaseId = D.Id
--WHERE E.StartTime >= CURRENT_DATE - INTERVAL '6 months'::interval;

