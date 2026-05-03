-- ============================================================--  Tourism Management System — Database Schema-- ============================================================
CREATE DATABASE IF NOT EXISTS tourism_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE tourism_db;-- USERS
CREATE TABLE users (
  user_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  phone VARCHAR(20) DEFAULT NULL,
  role ENUM('tourist','agency_staff','admin') NOT NULL DEFAULT 'tourist',
  is_verified TINYINT(1) NOT NULL DEFAULT 0,
  profile_pic VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id)
);-- DESTINATIONS
CREATE TABLE destinations (
  destination_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(150) NOT NULL,
  country VARCHAR(100) NOT NULL,
  city VARCHAR(100) NOT NULL,
  description TEXT,
  image_url VARCHAR(255),
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (destination_id)
);-- TOUR PACKAGES
CREATE TABLE tour_packages (
  package_id INT NOT NULL AUTO_INCREMENT,
  destination_id INT NOT NULL,
  title VARCHAR(200) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  duration_days INT NOT NULL,
  inclusions TEXT,
  available_slots INT NOT NULL DEFAULT 0,
  status ENUM('active','inactive','sold_out') NOT NULL DEFAULT 'active',
  image_url VARCHAR(255),
  created_by INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (package_id)
);-- BOOKINGS
CREATE TABLE bookings (
  booking_id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  package_id INT NOT NULL,
  num_travelers INT NOT NULL DEFAULT 1,
  travel_date DATE NOT NULL,
  total_price DECIMAL(10,2) NOT NULL,
  status ENUM('pending','confirmed','cancelled') DEFAULT 'pending',
  special_request TEXT,
  booked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (booking_id)
);-- ADMIN ACTIVITY LOG
CREATE TABLE admin_activity_log (
  log_id INT NOT NULL AUTO_INCREMENT,
  admin_id INT NOT NULL,
  action VARCHAR(100) NOT NULL,
  target_table VARCHAR(50),
  target_id INT,
  details TEXT,
  acted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (log_id)
);-- SAMPLE DATA INCLUDED BELOW (OPTIONAL)