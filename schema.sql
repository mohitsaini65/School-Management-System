-- 1. CREATE DATABASE

CREATE DATABASE school_mgmt;
USE school_mgmt;


-- 2. STUDENTS TABLE


CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    gender VARCHAR(10),
    address VARCHAR(255),
    phone VARCHAR(20)
);


-- 3. TEACHERS TABLE


CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    subject_specialization VARCHAR(100),
    phone VARCHAR(20),
    hire_date DATE
);


-- 4. CLASSES TABLE
-- (Simple structure – NO FK to avoid errors)


CREATE TABLE classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    grade INT NOT NULL,
    section VARCHAR(5) NOT NULL
);


-- 5. SUBJECTS TABLE
-- (FK → teachers is OK)


CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);


-- 6. ENROLLMENTS TABLE
-- (FK → students & classes)


CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    class_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);


-- 7. ATTENDANCE TABLE


CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    class_id INT,
    date DATE,
    status ENUM('Present', 'Absent'),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);


-- 8. FEES TABLE


CREATE TABLE fees (
    fee_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    amount DECIMAL(10,2),
    paid_on DATE,
    status ENUM('Paid', 'Pending'),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
CREATE TABLE marks (
    mark_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    exam_type VARCHAR(50),       -- Mid-term, Final, Unit-Test etc.
    marks_obtained INT,
    exam_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);
-- Indexes for faster queries
CREATE INDEX idx_student_name ON students(name);
CREATE INDEX idx_student_class ON enrollments(student_id, class_id);
CREATE INDEX idx_attendance_student ON attendance(student_id);
CREATE INDEX idx_marks_student ON marks(student_id);
CREATE INDEX idx_subject_teacher ON subjects(teacher_id);
CREATE INDEX idx_fees_student ON fees(student_id);

