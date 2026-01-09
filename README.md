# School Management System (MySQL + Python)

This project is a backend-focused school management system built using MySQL and Python.  
It simulates realistic school data such as students, teachers, classes, attendance, marks, and fees.

---

## Project Overview

The goal of this project is to design and populate a relational database that represents how a real school operates.  
Python scripts are used to generate large-scale realistic data and insert it into MySQL tables.

This project helps in understanding database schema design, relationships, and data handling at scale.

---

## Database Structure

The system includes the following main tables:

- Students  
- Teachers  
- Classes  
- Subjects  
- Enrollments  
- Attendance  
- Marks  
- Fees  

Each table is connected using proper foreign key relationships.

---

## Data Generation

- Faker library is used to generate realistic Indian names, addresses, phone numbers, and dates  
- Randomized logic is applied to simulate:
  - Student enrollment into classes  
  - Daily attendance records  
  - Exam marks (Mid-Term and Final)  
  - Fee payment status  

The database contains:
- 3000 students  
- 100 teachers  
- 24 classes  
- 90 days of attendance data  
- Exam and fee records for all students  

---

## Technologies Used

- Python  
- MySQL  
- Faker  
- mysql-connector-python  

---

## How to Run

1. Create a MySQL database named `school_mgmt`  
2. Create required tables using SQL schema  
3. Update database credentials in the connection file  
4. Run Python scripts to populate data  
5. Query the database to analyze school records  

---

## Learning Outcomes

- Practical experience with relational databases  
- Writing Python scripts for bulk data insertion  
- Understanding real-world database relationships  
- Handling large datasets efficiently  

---

## Note

This project is created for learning and practice purposes and does not represent a production-ready system.
