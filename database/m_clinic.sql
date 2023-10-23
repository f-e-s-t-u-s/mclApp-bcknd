-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 13, 2023 at 10:29 PM
-- Server version: 8.0.34-0ubuntu0.22.04.1
-- PHP Version: 8.1.2-1ubuntu2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `m_clinic`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_notifications`
--

CREATE TABLE `admin_notifications` (
  `id` bigint UNSIGNED NOT NULL,
  `doctor_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `click_url` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `service_id` bigint NOT NULL,
  `doctor_id` bigint UNSIGNED NOT NULL,
  `site` tinyint(1) NOT NULL DEFAULT '0',
  `physical_virtual` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `appointment_for` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `distance` int NOT NULL,
  `amount` int NOT NULL,
  `latitude` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `longitude` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `nurse_latitude` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nurse_longitude` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_general_ci NOT NULL,
  `age` int NOT NULL,
  `disease` text COLLATE utf8mb4_general_ci,
  `chronic_yn` varchar(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'N',
  `booking_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pending',
  `trx_code` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_complete` int NOT NULL DEFAULT '0',
  `closed_by` bigint DEFAULT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `canceled_by_patient` bigint DEFAULT NULL,
  `canceled_by_doctor` bigint DEFAULT NULL,
  `reactivated_admin` bigint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `user_id`, `service_id`, `doctor_id`, `site`, `physical_virtual`, `appointment_for`, `distance`, `amount`, `latitude`, `longitude`, `nurse_latitude`, `nurse_longitude`, `mobile`, `age`, `disease`, `chronic_yn`, `booking_date`, `payment_status`, `trx_code`, `is_complete`, `closed_by`, `is_delete`, `canceled_by_patient`, `canceled_by_doctor`, `reactivated_admin`, `created_at`, `updated_at`) VALUES
(4, 4, 1, 3, 1, '', 'My son inlaw', 300, 658, '-1.3145613', '36.8073399', NULL, NULL, '0797166804', 35, 'Epilepsy', 'N', '2021-09-20 18:26:00', 'Paid', NULL, 0, NULL, 0, NULL, NULL, NULL, '2023-09-12 17:28:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `assistants`
--

CREATE TABLE `assistants` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `mobile` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'contains full address',
  `image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: Active, 2: Inactive',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `assistant_doctor_tracks`
--

CREATE TABLE `assistant_doctor_tracks` (
  `id` bigint UNSIGNED NOT NULL,
  `assistant_id` bigint UNSIGNED NOT NULL,
  `doctor_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `assistant_logins`
--

CREATE TABLE `assistant_logins` (
  `id` bigint UNSIGNED NOT NULL,
  `assistant_id` bigint UNSIGNED NOT NULL,
  `assistant_ip` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `browser` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `os` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `longitude` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `latitude` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country_code` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `details` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` bigint UNSIGNED NOT NULL,
  `appointment_id` bigint UNSIGNED NOT NULL DEFAULT '0',
  `user_id` bigint UNSIGNED NOT NULL,
  `doctor_id` bigint UNSIGNED NOT NULL,
  `method_code` int NOT NULL DEFAULT '0',
  `amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `method_currency` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `charge` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `rate` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `final_amo` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `detail` text COLLATE utf8mb4_general_ci,
  `trx` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=>success, 2=>pending, 3=>cancel',
  `from_api` tinyint(1) NOT NULL DEFAULT '0',
  `admin_feedback` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `Verified_status` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `mobile` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'contains full address',
  `balance` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `sex` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `qualification` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `speciality` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `dr_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Nurse',
  `about` text COLLATE utf8mb4_general_ci NOT NULL,
  `slot_type` tinyint(1) DEFAULT NULL COMMENT '1: Serial, 2:Time',
  `latitude` decimal(10,6) DEFAULT NULL,
  `longitude` decimal(10,6) DEFAULT NULL,
  `serial_or_slot` text COLLATE utf8mb4_general_ci,
  `start_time` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `end_time` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `serial_day` int NOT NULL DEFAULT '0',
  `max_serial` int NOT NULL DEFAULT '0',
  `duration` int NOT NULL DEFAULT '0',
  `fees` int NOT NULL,
  `department_id` int NOT NULL,
  `location_id` int NOT NULL,
  `featured` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'YES⇾1, NO⇾0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT ' 1: active, Inactive: 0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`id`, `name`, `username`, `email`, `Verified_status`, `password`, `mobile`, `address`, `balance`, `sex`, `qualification`, `speciality`, `dr_type`, `about`, `slot_type`, `latitude`, `longitude`, `serial_or_slot`, `start_time`, `end_time`, `serial_day`, `max_serial`, `duration`, `fees`, `department_id`, `location_id`, `featured`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Daniel Opiyo', 'danopiyo', 'danielopiyo8@gmail.com', 0, '$2a$10$6zF.dIwDgm7cITUcDc/SEOeEiXXuwmOjVL4fA6mozwZi4MfP8PsVu', '0988874774', 'Naivasha-town', '0.00000000', 'M', 'Medical Doctor', 'Peditrician', 'Nurse', 'I love my job', 0, '-0.303099', '36.080025', '2', '10.30qm', '4.30pm', 0, 0, 0, 300, 1, 1, 1, 0, '2023-08-12 14:44:55', NULL),
(2, 'Daniel Sam', 'danopiyo1', 'danielopiyo8gmail.com', 0, '$2a$10$9NaDFhjcv6OuN26e5ixPfeBCIsM4BFNQMbyZRejjqC.K7nS4.JWwW', '0988874774', 'Naivasha-town-center', '0.00000000', 'M', 'Medical Doctor', 'Peditrician', 'Nurse', 'I love my job', 0, '-1.286389', '36.817223', '2', '10.30qm', '4.30pm', 0, 0, 0, 300, 1, 1, 1, 0, '2023-08-12 14:50:23', '2023-08-12 14:54:30'),
(3, 'Alex Metto', 'dan', 'ametto@riara.ac.ke', 0, '$2a$10$HK.6iQdn94blyCUPX5Ekx..kITcNJaxAhS480lx36m6lf/ZS4PKoi', '0988874774', 'Naivasha-town', '0.00000000', 'F', 'Medical Doctor', 'Peditrician', 'Nurse', 'I love my job', 0, '-0.303099', '36.080025', '2', '12.00', '2.00 am', 0, 0, 0, 300, 1, 1, 1, 0, '2023-08-16 14:16:11', '2023-09-13 16:50:30'),
(5, 'Nathan Chebii', 'chebii', 'nchebii@riara.ac.ke', 0, '$2a$10$fBKauho94v7fkFD5FVK0COIeGH22JOGTa3Ky02Fv/movGkyafgkcq', '0988874774', 'Naivasha-town', '0.00000000', 'F', 'Medical Doctor', 'Peditrician', 'Nurse', 'I love my job', 0, '-0.514277', '35.269779', '2', '10.30qm', '4.30pm', 0, 0, 0, 300, 1, 1, 1, 0, '2023-08-16 14:26:54', NULL),
(7, 'Nathan Chebii', 'chebiiN', 'nchebii3@riara.ac.ke', 0, '$2a$10$J9LKzIzxVAYUqWfT7tdyduND.CkCNWxQt1tUaKlQm1aCpyQNjsoQG', '0988874774', 'Naivasha-town', '0.00000000', 'M', 'Medical Doctor', 'Peditrician', 'Clinician', 'I love my job', 0, '-1.254337', '36.681660', '2', '10.30qm', '4.30pm', 0, 0, 0, 300, 1, 1, 1, 0, '2023-08-16 14:33:44', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `doctor_logins`
--

CREATE TABLE `doctor_logins` (
  `id` bigint UNSIGNED NOT NULL,
  `doctor_id` bigint UNSIGNED NOT NULL,
  `doctor_ip` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `browser` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `os` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `longitude` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `latitude` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country_code` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `education`
--

CREATE TABLE `education` (
  `id` bigint UNSIGNED NOT NULL,
  `doctor_id` bigint UNSIGNED NOT NULL,
  `institution` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `discipline` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `period` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `experiences`
--

CREATE TABLE `experiences` (
  `id` bigint UNSIGNED NOT NULL,
  `doctor_id` bigint UNSIGNED NOT NULL,
  `institution` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `discipline` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `period` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` bigint UNSIGNED NOT NULL,
  `site_name` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cur_text` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'currency text',
  `cur_sym` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'currency symbol',
  `email_from` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email_template` text COLLATE utf8mb4_general_ci,
  `sms_body` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sms_from` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `base_color` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country_code` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mail_config` text COLLATE utf8mb4_general_ci COMMENT 'email configuration',
  `sms_config` text COLLATE utf8mb4_general_ci,
  `global_shortcodes` text COLLATE utf8mb4_general_ci,
  `online_payment` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Online_apyment_active->1, Inactive->0',
  `multi_language` tinyint(1) NOT NULL DEFAULT '1',
  `en` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'email notification, 0 - dont send, 1 - send',
  `sn` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'sms notification, 0 - dont send, 1 - send',
  `force_ssl` tinyint(1) NOT NULL DEFAULT '0',
  `maintenance_mode` tinyint(1) NOT NULL DEFAULT '0',
  `active_template` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `system_info` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `site_name`, `cur_text`, `cur_sym`, `email_from`, `email_template`, `sms_body`, `sms_from`, `base_color`, `country_code`, `mail_config`, `sms_config`, `global_shortcodes`, `online_payment`, `multi_language`, `en`, `sn`, `force_ssl`, `maintenance_mode`, `active_template`, `system_info`, `created_at`, `updated_at`) VALUES
(1, 'MyClinic', '$', 'USD', 'info@myclinic.com', NULL, 'Welcome to MyClinic! Your verification code is [CODE].', 'MyClinic', '#007bff', '+1', '', '', '', 0, 1, 0, 0, 0, 0, NULL, NULL, '2023-08-07 08:20:47', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `code` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: not default language, 1: default language',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'English', 'en', 1, '2020-07-06 00:47:55', '2022-04-09 00:47:04'),
(5, 'Swahili', 'hn', 0, '2020-12-28 23:20:07', '2022-04-09 00:47:04'),
(9, 'French', 'bn', 0, '2021-03-14 01:37:41', '2022-03-30 09:31:55');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Langata', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'Upper Hill', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 'Nairobi CBD', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(4, 'Eldoret', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 'name', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(6, 'Mombasa', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(7, 'Kwale', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(8, 'Kilifi', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(9, 'Tana River', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(10, 'Lamu', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(11, 'Taita Taveta', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(12, 'Garissa', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(13, 'Wajir', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(14, 'Mandera', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(15, 'Marsabit', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(16, 'Isiolo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(17, 'Meru', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(18, 'Tharaka-Nithi', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(19, 'Embu', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(20, 'Kitui', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(21, 'Machakos', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(22, 'Nyandarua', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(23, 'Makueni', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(24, 'Makueni', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(25, 'Nyeri', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(26, 'Kirinyaga', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(27, 'Murang’a', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(28, 'Kiambu', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(29, 'Turkana', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(30, 'West Pokot', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(31, 'Samburu', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(32, 'Trans-Nzoia', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(33, 'Uasin Gishu', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(34, 'Elgeyo-Marakwet', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(35, 'Nandi', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(36, 'Baringo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(37, 'Laikipia', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(38, 'Nakuru', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(39, 'Narok', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(40, 'Kajiado', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(41, 'Kericho', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(42, 'Bomet', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(43, 'Kakamega', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(44, 'Vihiga', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(45, 'Bungoma', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(46, 'Busia', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(47, 'Siaya', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(48, 'Kisumu', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(49, 'Homa Bay', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(50, 'Migori', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(51, 'Kisii', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(52, 'Nyamira', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(53, 'Nairobi', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(54, 'Eldoret', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(55, 'Machakos', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(56, 'Thika Road', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(57, 'Kasarani', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(58, 'Pangani', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(59, 'South C', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `notification_logs`
--

CREATE TABLE `notification_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL DEFAULT '0',
  `assistant_id` bigint UNSIGNED NOT NULL DEFAULT '0',
  `doctor_id` bigint UNSIGNED NOT NULL DEFAULT '0',
  `staff_id` bigint UNSIGNED NOT NULL DEFAULT '0',
  `sender` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sent_from` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sent_to` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_general_ci,
  `notification_type` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'The name of the service',
  `detailed_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tag` varchar(6) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci COMMENT 'The description of the service',
  `image_url` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '',
  `nurse_count` int NOT NULL DEFAULT '0',
  `clinician_count` int NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `deleted_yn` varchar(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'N',
  `deleted_by` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `name`, `detailed_name`, `tag`, `description`, `image_url`, `nurse_count`, `clinician_count`, `created_at`, `updated_at`, `updated_by`, `deleted_yn`, `deleted_by`) VALUES
(1, 'M.Home Visit', 'Medical Home Visit', 'mhv', 'This is mobile healthcare, with doctors or nurses coming to your home for assessment, diagnosis, treatment, and monitoring. It\'s for those with mobility challenges or limited access to traditional facilities, ensuring convenient care.', 'https://mclinic.co.ke/assets/images/home-visit.jpg', 30, 7, '2023-08-16 08:14:40', NULL, NULL, 'N', NULL),
(2, 'M.Consultation', 'Medical Consultation (Physical/Virtual)', 'mc', 'This is a consultation where a patient discusses health concerns, history, and symptoms with a healthcare provider, like a doctor or specialist. The provider advises, examines, and may suggest additional tests or treatments.', 'https://mclinic.co.ke/assets/images/mediacl-consultation.jpg', 0, 12, '2023-08-16 08:14:40', NULL, NULL, 'N', NULL),
(3, 'M.Emergency & Ambulance', 'Medical Emergency & Ambulance Services', 'mea', 'A medical emergency is a sudden, critical health situation like heart attacks, injuries, or respiratory distress, needing immediate attention to prevent harm or save lives. Ambulances, with trained staff and equipment, provide on-site care and transport patients to hospitals for further treatment.', 'https://mclinic.co.ke/assets/images/medical-emargency.jpg', 5, 7, '2023-08-16 08:14:40', NULL, NULL, 'N', NULL),
(4, 'M.Concierge', 'Medical Concierge', 'mcc', 'Medical concierge services provide personalized healthcare support, including appointment scheduling, medical record organization, coordinating specialist visits, and arranging travel for treatment if needed, going beyond traditional healthcare.', 'https://mclinic.co.ke/assets/images/medical-concierge.jpg', 8, 12, '2023-08-16 08:14:40', NULL, NULL, 'N', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `mobile` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0: inactive, 1: active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff_logins`
--

CREATE TABLE `staff_logins` (
  `id` bigint UNSIGNED NOT NULL,
  `staff_id` bigint UNSIGNED NOT NULL,
  `staff_ip` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `browser` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `os` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `longitude` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `latitude` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country_code` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_attachments`
--

CREATE TABLE `support_attachments` (
  `id` bigint UNSIGNED NOT NULL,
  `support_message_id` bigint UNSIGNED DEFAULT NULL,
  `attachment` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_messages`
--

CREATE TABLE `support_messages` (
  `id` bigint UNSIGNED NOT NULL,
  `support_ticket_id` bigint UNSIGNED NOT NULL DEFAULT '0',
  `admin_id` bigint UNSIGNED NOT NULL DEFAULT '0',
  `message` longtext COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT '0',
  `name` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ticket` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: Open, 1: Answered, 2: Replied, 3: Closed',
  `priority` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = Low, 2 = medium, 3 = high',
  `last_reply` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL DEFAULT '0',
  `doctor_id` bigint UNSIGNED NOT NULL DEFAULT '0',
  `amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `charge` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `post_balance` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `trx_type` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `trx` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `details` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `remark` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `reg_code` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'contains full address',
  `location_id` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT ' 1: active, Inactive: 0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `reg_code`, `password`, `mobile`, `address`, `location_id`, `status`, `created_at`, `updated_at`) VALUES
(2, 'Pamela Mwangi', 'danielopiyo8@gmail.com', '', '$2a$10$Id6LKBZB2Daq1toimhlwxO6L1LjaIWMvLKWlfVEUYD5mm1MXKhg9G', '+254797166804', 'Naivasha - Town area', 3, 1, '2023-08-11 14:41:28', '2023-08-18 07:11:48'),
(3, 'Pamela Osoro', 'danielopiyo2@gmail.com', '59YO6Y', '$2a$10$yBoeUhn1.l4nzGlXsx4eguucXxtC6375qgIOfRok7lSrY2k2bR9ga', '+254797166804', 'Naivasha - Town area', 2, 1, '2023-08-11 14:45:15', '2023-08-18 07:03:22'),
(4, 'Daniel Opiyo', 'danielopiyo@gmail.com', '6TD823', '$2a$10$6daCCwZZbD4vgnKrWp3uyePhZc/0P3znBJaT0tKuEsXsW.BP77Tfq', '+254797166804', 'Naivasha - Town area', 2, 1, '2023-08-11 14:49:54', NULL),
(5, 'Daniel Opiyo', 'danielopiyo3@gmail.com', '8T4QQ0', '$2a$10$t8w9gdoIWo/ret.QbhCle.JQFf1CcGdFtpB6nSL0unOXGAYbVXi92', '+254797166804', 'Naivasha - Town area', 2, 1, '2023-08-11 14:50:24', '2023-08-11 15:13:25'),
(6, 'Sylvanus Osoro', 'danielopiyo7@gmail.com', '46Q939', '$2a$10$Ziib8C4K3JjQjxcAsQ37iO4X15b0jONeksPAVdD69UAre8Cv/BTkK', '+254797166804', 'Naivasha - Town area', 2, 1, '2023-08-18 05:32:44', '2023-08-18 06:51:20'),
(7, NULL, 'dopiyo@riarauniversity.ce.ke', '28CYC5', NULL, NULL, NULL, NULL, 0, '2023-08-18 07:55:08', NULL),
(8, NULL, 'nchebii@riara.com', '0Q67QY', NULL, NULL, NULL, NULL, 0, '2023-08-18 08:45:56', NULL),
(9, NULL, 'nchebii@riarauni.com', 'TQ9841', NULL, NULL, NULL, NULL, 0, '2023-08-18 08:49:05', NULL),
(10, 'Alex Metto', 'ametto@riarauniversity.ac.ke', '1TQQ67', '$2a$10$wewkDM3vbWg3hN61x.llEuh5tqAgh57jgv/JEw01GsUuqiH9skaTy', '078767773', 'Nairobi westlanda', 3, 1, '2023-08-18 08:59:32', '2023-08-18 09:02:16'),
(11, 'Christopher Kamau', 'ckamau@riara.com', '59O8CT', '$2a$10$AYGQ2dgD4xgRRcZWQQrrhuukQIk69jxMeOz9W/B27y722rnIyHtvi', '0789989955', 'Kiambu Kenya', 3, 1, '2023-08-18 09:58:11', '2023-08-18 10:00:14'),
(12, 'Simon Kamau', 'skamu@riarauniversity.ac.ke', 'G00YCT', '$2a$10$7LlTYPoDbDXr9scomRmkduDVWQ6bW0DBin.WwARrNxHzJEhEMppQq', '098988888', 'Mombasa', 17, 1, '2023-08-18 10:38:01', '2023-08-18 10:38:48'),
(13, 'Duncan Simiyu', 'dan@zyptech.co.ke', 'D67T63', '$2a$10$HLDxUtcV7VrUNN4L2ivB6eXCmQPd1uRa6fhsfdfIDOUCPaSdMQ.bi', '989848484999', 'Nyamira town', 52, 1, '2023-08-18 10:43:38', '2023-08-18 10:44:55');

-- --------------------------------------------------------

--
-- Table structure for table `users_reg`
--

CREATE TABLE `users_reg` (
  `id` bigint UNSIGNED NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT '0' COMMENT ' 1: active, Inactive: 0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_logins`
--

CREATE TABLE `user_logins` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `user_ip` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `browser` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `os` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `longitude` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `latitude` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country_code` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_bookings`
-- (See below for the actual view)
--
CREATE TABLE `vw_bookings` (
`id` bigint unsigned
,`service_id` bigint
,`service` varchar(150)
,`age` int
,`user_id` bigint unsigned
,`patient` varchar(40)
,`doctor` varchar(40)
,`distance` int
,`amount` int
,`contact` varchar(191)
,`is_complete` int
,`createdDate` timestamp
,`bookTime` timestamp
,`place` varchar(50)
,`hasChronic` varchar(1)
,`description` text
,`PaymentStatus` varchar(20)
,`transactionCode` varchar(191)
);

-- --------------------------------------------------------

--
-- Structure for view `vw_bookings`
--
DROP TABLE IF EXISTS `vw_bookings`;

CREATE ALGORITHM=UNDEFINED DEFINER=`m-cl-app`@`localhost` SQL SECURITY DEFINER VIEW `vw_bookings`  AS SELECT `Ap`.`id` AS `id`, `Ap`.`service_id` AS `service_id`, `Sr`.`name` AS `service`, `Ap`.`age` AS `age`, `Ap`.`user_id` AS `user_id`, `Us`.`name` AS `patient`, `Dr`.`name` AS `doctor`, `Ap`.`distance` AS `distance`, `Ap`.`amount` AS `amount`, `Ap`.`mobile` AS `contact`, `Ap`.`is_complete` AS `is_complete`, `Ap`.`created_at` AS `createdDate`, `Ap`.`booking_date` AS `bookTime`, `Ap`.`physical_virtual` AS `place`, `Ap`.`chronic_yn` AS `hasChronic`, `Ap`.`disease` AS `description`, `Ap`.`payment_status` AS `PaymentStatus`, `Ap`.`trx_code` AS `transactionCode` FROM (((`appointments` `Ap` join `doctors` `Dr` on((`Ap`.`doctor_id` = `Dr`.`id`))) join `services` `Sr` on((`Ap`.`service_id` = `Sr`.`id`))) join `users` `Us` on((`Ap`.`user_id` = `Us`.`id`))) ORDER BY `Ap`.`created_at` DESC ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`,`username`);

--
-- Indexes for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `assistants`
--
ALTER TABLE `assistants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `assistants_username_unique` (`username`),
  ADD UNIQUE KEY `assistants_email_unique` (`email`);

--
-- Indexes for table `assistant_doctor_tracks`
--
ALTER TABLE `assistant_doctor_tracks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assistant_id` (`assistant_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `assistant_logins`
--
ALTER TABLE `assistant_logins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assistant_id` (`assistant_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `appointment_id` (`appointment_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `doctors_username_unique` (`username`),
  ADD UNIQUE KEY `doctors_email_unique` (`email`);

--
-- Indexes for table `doctor_logins`
--
ALTER TABLE `doctor_logins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `education`
--
ALTER TABLE `education`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `experiences`
--
ALTER TABLE `experiences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `general_settings`
--
ALTER TABLE `general_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification_logs`
--
ALTER TABLE `notification_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `assistant_id` (`assistant_id`),
  ADD KEY `doctor_id` (`doctor_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ser_name` (`name`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff_logins`
--
ALTER TABLE `staff_logins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `support_attachments`
--
ALTER TABLE `support_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `support_message_id` (`support_message_id`);

--
-- Indexes for table `support_messages`
--
ALTER TABLE `support_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `support_ticket_id` (`support_ticket_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_support_tickets_user_id` (`user_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_transactions_user_id` (`user_id`),
  ADD KEY `fk_transactions_doctor_id` (`doctor_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `users_reg`
--
ALTER TABLE `users_reg`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_reg_email_unique` (`email`);

--
-- Indexes for table `user_logins`
--
ALTER TABLE `user_logins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `assistants`
--
ALTER TABLE `assistants`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assistant_doctor_tracks`
--
ALTER TABLE `assistant_doctor_tracks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assistant_logins`
--
ALTER TABLE `assistant_logins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `doctor_logins`
--
ALTER TABLE `doctor_logins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `education`
--
ALTER TABLE `education`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `experiences`
--
ALTER TABLE `experiences`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users_reg`
--
ALTER TABLE `users_reg`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_logins`
--
ALTER TABLE `user_logins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  ADD CONSTRAINT `admin_notifications_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`),
  ADD CONSTRAINT `admin_notifications_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`);

--
-- Constraints for table `assistant_doctor_tracks`
--
ALTER TABLE `assistant_doctor_tracks`
  ADD CONSTRAINT `assistant_doctor_tracks_ibfk_1` FOREIGN KEY (`assistant_id`) REFERENCES `assistants` (`id`),
  ADD CONSTRAINT `assistant_doctor_tracks_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`);

--
-- Constraints for table `assistant_logins`
--
ALTER TABLE `assistant_logins`
  ADD CONSTRAINT `assistant_logins_ibfk_1` FOREIGN KEY (`assistant_id`) REFERENCES `assistants` (`id`);

--
-- Constraints for table `deposits`
--
ALTER TABLE `deposits`
  ADD CONSTRAINT `deposits_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `deposits_ibfk_2` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`),
  ADD CONSTRAINT `deposits_ibfk_3` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`);

--
-- Constraints for table `doctor_logins`
--
ALTER TABLE `doctor_logins`
  ADD CONSTRAINT `doctor_logins_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`);

--
-- Constraints for table `education`
--
ALTER TABLE `education`
  ADD CONSTRAINT `education_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`);

--
-- Constraints for table `experiences`
--
ALTER TABLE `experiences`
  ADD CONSTRAINT `experiences_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`);

--
-- Constraints for table `notification_logs`
--
ALTER TABLE `notification_logs`
  ADD CONSTRAINT `notification_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `notification_logs_ibfk_2` FOREIGN KEY (`assistant_id`) REFERENCES `assistants` (`id`),
  ADD CONSTRAINT `notification_logs_ibfk_3` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`),
  ADD CONSTRAINT `notification_logs_ibfk_4` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`);

--
-- Constraints for table `staff_logins`
--
ALTER TABLE `staff_logins`
  ADD CONSTRAINT `staff_logins_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`);

--
-- Constraints for table `support_attachments`
--
ALTER TABLE `support_attachments`
  ADD CONSTRAINT `support_attachments_ibfk_1` FOREIGN KEY (`support_message_id`) REFERENCES `support_messages` (`id`);

--
-- Constraints for table `support_messages`
--
ALTER TABLE `support_messages`
  ADD CONSTRAINT `support_messages_ibfk_1` FOREIGN KEY (`support_ticket_id`) REFERENCES `support_tickets` (`id`),
  ADD CONSTRAINT `support_messages_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`);

--
-- Constraints for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD CONSTRAINT `fk_support_tickets_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_transactions_doctor_id` FOREIGN KEY (`doctor_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_transactions_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`);

--
-- Constraints for table `user_logins`
--
ALTER TABLE `user_logins`
  ADD CONSTRAINT `user_logins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
