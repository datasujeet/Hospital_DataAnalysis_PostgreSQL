--Create Database
CREATE DATABASE Hospitals;

--Switch to the Database
\c Hospitals

--Create Tables
DROP TABLE IF EXISTS Hospitals;      --create Hospital table
CREATE TABLE Hospitals(
    "Hospital Name" VARCHAR(100),
    Location VARCHAR(100),
    Department VARCHAR(100),
    "Doctors Count" INT,          
	"Patients Count" INT,
	"Admission Date" DATE,
	"Discharge Date" DATE,
    "Medical Expenses" NUMERIC(10,2)         -- Fixed syntax for NUMERIC (added precision & scale)
); 

-- View all records in the Hospitals table
SELECT *FROM Hospitals;

--Import the Hospitals database
COPY Hospitals("Hospital Name", Location, Department, "Doctors Count", "Patients Count","Admission Date","Discharge Date","Medical Expenses")
FROM 'D:\DS Training\PGPDS_AI\PostgreSQL\SQL_Hospital_Assignment\Hospital_Data.csv'
CSV HEADER;

--Some Queries
--1. Total Number of Patients
--Write an SQL query to find the total number of patients across all hospitals.
SELECT SUM("Patients Count") AS Total_Number_Of_Patients FROM Hospitals;

--2. Average Number of Doctors per Hospital
--Retrieve the average count of doctors available in each hospital.
SELECT AVG("Doctors Count") AS Average_Doctors_Per_Hospital FROM Hospitals;

--3.Top 3 Departments with the Highest Number of Patients
--Find the top 3 hospital departments that have the highest number of patients.

SELECT Department, SUM("Patients Count") AS Total_Patients 
FROM Hospitals 
GROUP BY Department
ORDER BY Total_Patients DESC LIMIT 3;

--4.Hospital with the Maximum Medical Expenses
--Identify the hospital that recorded the highest medical expenses.

SELECT "Hospital Name", "Medical Expenses" FROM Hospitals
ORDER BY "Medical Expenses"
DESC LIMIT 1;

--5.Daily Average Medical Expenses
--Calculate the average medical expenses per day for each hospital.

SELECT "Hospital Name", AVG("Medical Expenses") AS Daily_Avg_Expenses
FROM Hospitals
GROUP BY "Hospital Name";

--6.Longest Hospital Stay
--Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date.

SELECT "Hospital Name", "Admission Date", "Discharge Date",
("Discharge Date"-"Admission Date") AS Longest_Hospital_Stay
FROM Hospitals
ORDER BY Longest_Hospital_Stay DESC LIMIT 1;


--7.Total Patients Treated Per City
--Count the total number of patients treated in each city.
SELECT Location, SUM("Patients Count") AS Total_Patients 
FROM Hospitals
GROUP BY Location
ORDER BY Total_Patients DESC;

--8.Average Length of Stay Per Department
--Calculate the average number of days patients spend in each department.

SELECT Department, AVG("Discharge Date" - "Admission Date") AS Avg_Stay_Days
FROM Hospitals
GROUP BY Department;

--9.Identify the Department with the Lowest Number of Patients
--Find the department with the least number of patients.

SELECT Department, SUM("Patients Count") AS Total_Patients 
FROM Hospitals
GROUP BY Department
ORDER BY Total_Patients ASC LIMIT 1;

--10.Monthly Medical Expenses Report
--Group the data by month and calculate the total medical expenses for each month.

SELECT DATE_TRUNC('month', "Admission Date") AS Month, 
       SUM("Medical Expenses") AS Total_Expenses
FROM Hospitals
GROUP BY Month
ORDER BY Month;

