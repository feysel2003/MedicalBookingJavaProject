
Markdown
download
content_copy
expand_less
# 🏥 Medical Appointment Booking System

![Java](https://img.shields.io/badge/Language-Java-orange)
![Tech](https://img.shields.io/badge/Technology-JSP%20%26%20Servlets-red)
![Database](https://img.shields.io/badge/Database-MySQL-blue)
![IDE](https://img.shields.io/badge/IDE-NetBeans-green)

A robust web-based application built using the **MVC (Model-View-Controller)** architecture. This system facilitates seamless interaction between Patients, Doctors, and Administrators for managing medical appointments.

---

## 📖 Table of Contents
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Project Architecture](#-project-architecture)
- [Database Schema](#-database-schema)
- [Installation & Setup](#-installation--setup)
- [Usage](#-usage)
- [Screenshots](#-screenshots)

---

## 🚀 Features

### 👨‍💼 Administrator
- **Secure Login:** Dedicated admin portal.
- **Doctor Management:** Add, update, delete, and view doctor profiles.
- **Patient Management:** View registered patients.
- **System Monitoring:** Overview of system activities.

### 👨‍⚕️ Doctor
- **Dashboard:** View upcoming appointments.
- **Appointment Management:** Approve or reject appointment requests.
- **Profile:** Manage availability and personal details.
- **Schedule:** View daily appointment lists.

### 👤 Patient
- **Registration:** Easy sign-up process.
- **Booking:** Search doctors by specialization and book appointments.
- **History:** View past and future appointment status.
- **Profile:** Update personal information.

---

## 🛠 Tech Stack

| Component | Technology |
|-----------|------------|
| **Frontend** | JSP (JavaServer Pages), HTML5, CSS3, Bootstrap 5, FontAwesome |
| **Backend** | Java Servlets (Controller), Java Beans (Model) |
| **Database** | MySQL |
| **Server** | Apache Tomcat 9.0+ |
| **IDE** | Apache NetBeans |
| **Architecture** | MVC (Model-View-Controller) |

---

## 📂 Project Architecture

The project follows a strict MVC separation:
# MedicalBooking

MedicalBooking/
├── src/java/
│   ├── controller/   # Servlets (e.g., LoginServlet, AppointmentServlet)
│   ├── dao/          # Database Access Objects (SQL Logic)
│   └── model/        # Java Beans (POJOs: Patient, Doctor, Appointment)
└── web/              # JSP Views (Frontend)
    ├── assets/       # CSS, Images, JS
    ├── META-INF/
    └── WEB-INF/

## 🗄 Database Schema

The system requires the following MySQL tables. Run the provided database.sql file (if available) or create these tables:

users (id, name, email, password, role)

doctors (id, user_id, specialization, phone, availability)

patients (id, user_id, address, dob, gender)

appointments (id, patient_id, doctor_id, date, time, status)

## ⚙ Installation & Setup

### Prerequisites

Java JDK 8 or higher

Apache NetBeans IDE

MySQL Server (XAMPP/WAMP recommended)

Apache Tomcat Server

### Steps

#### Clone the Repository

git clone https://github.com/feysel2003/MedicalBookingSystem.git

#### Database Setup

Open phpMyAdmin or MySQL Workbench.

Create a database named medical_booking_db.

Import the sql/schema.sql file provided in this repo.

Note: Update src/java/dao/DBConnection.java with your DB username/password.

#### Open in NetBeans

File > Open Project > Select MedicalBooking.

#### Run the Project

Right-click the project > Run.

The browser will open http://localhost:8080/MedicalBooking.

## 🔑 Usage

### Default Login Credentials (For Testing)

Role    Email                 Password  
Admin   admin@hospital.com    admin123  
Doctor  doctor@hospital.com   doc123  
Patient (Register a new account) (Your password)

## 🤝 Contributing

Fork the project.

Create your feature branch (git checkout -b feature/AmazingFeature).

Commit your changes (git commit -m 'Add some AmazingFeature').

Push to the branch (git push origin feature/AmazingFeature).

Open a Pull Request.

## 📜 License

This project is for educational purposes.

download
content_copy
expand_less
