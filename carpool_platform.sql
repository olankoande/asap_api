-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Mer 11 Mars 2026 à 04:56
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `carpool_platform`
--

-- --------------------------------------------------------

--
-- Structure de la table `admin_audit_logs`
--

CREATE TABLE IF NOT EXISTS `admin_audit_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) unsigned NOT NULL,
  `action` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `entity_type` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `entity_id` bigint(20) unsigned DEFAULT NULL,
  `details_json` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_admin_audit_logs_admin` (`admin_id`,`created_at`),
  KEY `idx_admin_audit_logs_entity` (`entity_type`,`entity_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

--
-- Contenu de la table `admin_audit_logs`
--

INSERT INTO `admin_audit_logs` (`id`, `admin_id`, `action`, `entity_type`, `entity_id`, `details_json`, `created_at`) VALUES
(2, 4, 'ban_user', 'user', 15, '{"reason":"Comportement inapproprié répété","banned_at":"2026-02-27T13:00:00.000Z"}', '2026-02-27 13:00:00'),
(3, 4, 'resolve_report', 'report', 1, '{"resolution":"Utilisateur banni suite au signalement"}', '2026-02-27 13:00:00'),
(4, 4, 'create_policy', 'cancellation_policy', 3, '{"policy_name":"Politique standard — Réservations"}', '2026-01-29 13:00:00'),
(5, 4, 'create_policy', 'cancellation_policy', 4, '{"policy_name":"Politique standard — Livraisons"}', '2026-01-29 13:00:00'),
(6, 4, 'approve_payout_batch', 'payout_batch', 1, '{"total_amount":135,"payouts_count":1}', '2026-02-26 13:00:00'),
(7, 4, 'update_setting', 'setting', NULL, '{"key":"platform_fee_percent","old_value":"15","new_value":"10"}', '2026-02-13 13:00:00'),
(8, 16, 'USER_CREATED', 'user', 18, '{"email":"olankoande@yahoo.fr","first_name":"ousmane","last_name":"lankoande","role":"admin"}', '2026-03-01 07:16:50'),
(9, 18, 'DISPUTE_RESOLVED', 'dispute', 1, '{"outcome":"refund_customer","note":"c''est ok remboursé"}', '2026-03-08 09:08:49');

-- --------------------------------------------------------

--
-- Structure de la table `bookings`
--

CREATE TABLE IF NOT EXISTS `bookings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `trip_id` bigint(20) unsigned NOT NULL,
  `passenger_id` bigint(20) unsigned NOT NULL,
  `seats_requested` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `status` enum('pending','accepted','rejected','paid','cancelled','completed','expired','disputed') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `cancel_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount_total` decimal(12,2) DEFAULT NULL,
  `currency` char(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CAD',
  `cancellation_policy_id` bigint(20) unsigned DEFAULT NULL,
  `cancellation_rule_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_bookings_trip` (`trip_id`,`status`),
  KEY `idx_bookings_passenger` (`passenger_id`,`created_at`),
  KEY `idx_bookings_status` (`status`,`created_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=64 ;

--
-- Contenu de la table `bookings`
--

INSERT INTO `bookings` (`id`, `trip_id`, `passenger_id`, `seats_requested`, `status`, `cancel_reason`, `amount_total`, `currency`, `cancellation_policy_id`, `cancellation_rule_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 10, 1, 'paid', NULL, '35.00', 'CAD', NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(2, 1, 11, 1, 'paid', NULL, '35.00', 'CAD', NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(3, 2, 12, 1, 'pending', NULL, '30.00', 'CAD', NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(4, 3, 11, 1, 'accepted', NULL, '45.00', 'CAD', NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(5, 10, 13, 2, 'paid', NULL, '40.00', 'CAD', NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(6, 7, 10, 1, 'completed', NULL, '45.00', 'CAD', NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(7, 7, 11, 2, 'completed', NULL, '90.00', 'CAD', NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(8, 8, 12, 2, 'completed', NULL, '40.00', 'CAD', NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(9, 8, 13, 1, 'completed', NULL, '20.00', 'CAD', NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(10, 5, 10, 1, 'cancelled', 'Changement de plans, je ne peux plus voyager ce jour-là.', '25.00', 'CAD', NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(11, 5, 12, 1, 'accepted', NULL, '25.00', 'CAD', NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(12, 11, 6, 1, 'paid', NULL, '35.00', 'CAD', NULL, NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(13, 11, 7, 1, 'paid', NULL, '35.00', 'CAD', NULL, NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(14, 12, 8, 2, 'pending', NULL, '60.00', 'CAD', NULL, NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(15, 15, 6, 1, 'completed', NULL, '35.00', 'CAD', NULL, NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(16, 15, 7, 1, 'completed', NULL, '35.00', 'CAD', NULL, NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(17, 15, 8, 1, 'completed', NULL, '35.00', 'CAD', NULL, NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(18, 16, 9, 2, 'completed', NULL, '60.00', 'CAD', NULL, NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(19, 16, 10, 2, 'completed', NULL, '60.00', 'CAD', NULL, NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(20, 1, 16, 1, 'paid', NULL, '35.00', 'CAD', NULL, NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(21, 2, 16, 1, 'paid', NULL, '30.00', 'CAD', NULL, NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(22, 3, 16, 2, 'pending', NULL, '90.00', 'CAD', NULL, NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(23, 4, 16, 1, 'pending', NULL, '15.00', 'CAD', NULL, NULL, '2026-03-01 03:58:05', '2026-03-01 03:58:05', NULL),
(24, 4, 16, 1, 'pending', NULL, '15.00', 'CAD', NULL, NULL, '2026-03-01 04:45:14', '2026-03-01 04:45:14', NULL),
(25, 4, 17, 1, 'pending', NULL, '15.00', 'CAD', NULL, NULL, '2026-03-01 06:59:33', '2026-03-01 06:59:33', NULL),
(26, 2, 17, 1, 'pending', NULL, '30.00', 'CAD', NULL, NULL, '2026-03-01 16:19:31', '2026-03-01 16:19:31', NULL),
(27, 10, 17, 1, 'pending', NULL, '20.00', 'CAD', NULL, NULL, '2026-03-03 02:33:26', '2026-03-03 02:33:26', NULL),
(28, 5, 17, 1, 'pending', NULL, '25.00', 'CAD', NULL, NULL, '2026-03-03 02:47:55', '2026-03-03 02:47:55', NULL),
(29, 5, 19, 1, 'pending', NULL, '25.00', 'CAD', NULL, NULL, '2026-03-03 03:05:15', '2026-03-03 03:05:15', NULL),
(30, 5, 19, 1, 'pending', NULL, '25.00', 'CAD', NULL, NULL, '2026-03-03 03:05:48', '2026-03-03 03:05:48', NULL),
(31, 23, 19, 2, 'pending', NULL, '752.46', 'CAD', NULL, NULL, '2026-03-03 03:09:23', '2026-03-03 03:09:23', NULL),
(32, 13, 17, 2, 'cancelled', 'Payment initialization failed', '90.00', 'CAD', NULL, NULL, '2026-03-03 03:26:48', '2026-03-03 03:26:48', NULL),
(33, 13, 17, 2, 'cancelled', 'Payment initialization failed', '90.00', 'CAD', NULL, NULL, '2026-03-03 03:29:44', '2026-03-03 03:29:44', NULL),
(34, 13, 17, 2, 'cancelled', 'Payment initialization failed', '90.00', 'CAD', NULL, NULL, '2026-03-03 03:29:46', '2026-03-03 03:29:46', NULL),
(35, 13, 17, 1, 'cancelled', 'Payment initialization failed', '45.00', 'CAD', NULL, NULL, '2026-03-03 03:29:50', '2026-03-03 03:29:50', NULL),
(36, 2, 17, 2, 'cancelled', 'Payment initialization failed', '60.00', 'CAD', NULL, NULL, '2026-03-03 03:31:24', '2026-03-03 03:31:24', NULL),
(37, 13, 17, 1, 'pending', NULL, '45.00', 'CAD', NULL, NULL, '2026-03-03 03:39:10', '2026-03-03 03:39:10', NULL),
(38, 1, 17, 1, 'pending', NULL, '35.00', 'CAD', NULL, NULL, '2026-03-03 03:39:51', '2026-03-03 03:39:51', NULL),
(39, 10, 17, 1, 'pending', NULL, '20.00', 'CAD', NULL, NULL, '2026-03-03 04:00:57', '2026-03-03 04:00:57', NULL),
(40, 12, 17, 1, 'pending', NULL, '30.00', 'CAD', NULL, NULL, '2026-03-03 04:01:29', '2026-03-03 04:01:29', NULL),
(41, 12, 17, 2, 'pending', NULL, '60.00', 'CAD', NULL, NULL, '2026-03-03 04:01:59', '2026-03-03 04:01:59', NULL),
(42, 2, 17, 1, 'pending', NULL, '30.00', 'CAD', NULL, NULL, '2026-03-03 04:05:46', '2026-03-03 04:05:46', NULL),
(43, 13, 17, 1, 'pending', NULL, '45.00', 'CAD', NULL, NULL, '2026-03-03 04:11:05', '2026-03-03 04:11:05', NULL),
(44, 13, 17, 1, 'pending', NULL, '45.00', 'CAD', NULL, NULL, '2026-03-03 04:12:51', '2026-03-03 04:12:51', NULL),
(45, 2, 17, 1, 'pending', NULL, '30.00', 'CAD', NULL, NULL, '2026-03-03 04:21:04', '2026-03-03 04:21:04', NULL),
(46, 24, 19, 1, 'paid', NULL, '24.03', 'CAD', NULL, NULL, '2026-03-03 05:01:35', '2026-03-03 05:01:58', NULL),
(47, 24, 19, 1, 'paid', NULL, '24.03', 'CAD', NULL, NULL, '2026-03-03 05:25:45', '2026-03-03 05:26:13', NULL),
(48, 26, 19, 1, 'pending', NULL, '7.00', 'CAD', NULL, NULL, '2026-03-04 14:51:12', '2026-03-04 14:51:12', NULL),
(49, 22, 19, 1, 'paid', NULL, '1043.10', 'CAD', NULL, NULL, '2026-03-04 16:23:22', '2026-03-04 16:23:45', NULL),
(50, 22, 19, 2, 'pending', NULL, '2086.20', 'CAD', NULL, NULL, '2026-03-04 16:51:16', '2026-03-04 16:51:16', NULL),
(51, 22, 19, 1, 'paid', NULL, '1043.10', 'CAD', NULL, NULL, '2026-03-04 16:51:43', '2026-03-04 16:52:06', NULL),
(52, 25, 17, 1, 'paid', NULL, '46.67', 'CAD', NULL, NULL, '2026-03-04 18:33:45', '2026-03-04 18:34:09', NULL),
(53, 25, 17, 1, 'paid', NULL, '46.67', 'CAD', NULL, NULL, '2026-03-04 19:19:35', '2026-03-04 19:19:51', NULL),
(54, 25, 17, 1, 'paid', NULL, '46.67', 'CAD', NULL, NULL, '2026-03-04 19:33:22', '2026-03-04 19:33:35', NULL),
(55, 25, 17, 1, 'paid', NULL, '51.34', 'CAD', NULL, NULL, '2026-03-04 20:21:46', '2026-03-04 20:22:02', NULL),
(56, 26, 19, 1, 'paid', NULL, '7.70', 'CAD', NULL, NULL, '2026-03-04 21:18:33', '2026-03-04 21:18:46', NULL),
(57, 26, 19, 1, 'pending', NULL, '7.70', 'CAD', NULL, NULL, '2026-03-04 21:19:36', '2026-03-04 21:19:36', NULL),
(58, 25, 17, 1, 'disputed', NULL, '51.34', 'CAD', NULL, NULL, '2026-03-04 21:20:09', '2026-03-08 09:03:26', NULL),
(59, 26, 19, 1, 'paid', NULL, '7.70', 'CAD', NULL, NULL, '2026-03-05 14:22:00', '2026-03-05 14:22:14', NULL),
(60, 27, 19, 2, 'paid', NULL, '220.00', 'CAD', NULL, NULL, '2026-03-05 14:30:44', '2026-03-05 14:31:06', NULL),
(61, 27, 19, 1, 'paid', NULL, '110.00', 'CAD', NULL, NULL, '2026-03-05 15:23:17', '2026-03-05 15:23:30', NULL),
(62, 29, 19, 1, 'cancelled', NULL, '88.08', 'CAD', NULL, NULL, '2026-03-08 07:00:47', '2026-03-09 02:12:35', NULL),
(63, 29, 19, 1, 'paid', NULL, '88.08', 'CAD', NULL, NULL, '2026-03-09 02:15:06', '2026-03-09 02:15:20', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `cancellation_policies`
--

CREATE TABLE IF NOT EXISTS `cancellation_policies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `scope` enum('booking','delivery') COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_by_admin_id` bigint(20) unsigned DEFAULT NULL,
  `updated_by_admin_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_cancellation_policies_scope_active` (`scope`,`active`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Contenu de la table `cancellation_policies`
--

INSERT INTO `cancellation_policies` (`id`, `name`, `scope`, `active`, `created_by_admin_id`, `updated_by_admin_id`, `created_at`, `updated_at`) VALUES
(3, 'Politique standard — Réservations', 'booking', 1, 4, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15'),
(4, 'Politique standard — Livraisons', 'delivery', 1, 4, NULL, '2026-02-28 20:22:16', '2026-02-28 20:22:16');

-- --------------------------------------------------------

--
-- Structure de la table `cancellation_policy_rules`
--

CREATE TABLE IF NOT EXISTS `cancellation_policy_rules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `policy_id` bigint(20) unsigned NOT NULL,
  `min_hours_before_departure` int(11) NOT NULL,
  `cancellation_fee_fixed` decimal(12,2) NOT NULL DEFAULT '0.00',
  `cancellation_fee_percent` decimal(5,2) NOT NULL DEFAULT '0.00',
  `refund_percent_to_payer` decimal(5,2) NOT NULL DEFAULT '100.00',
  `debit_driver_percent` decimal(5,2) NOT NULL DEFAULT '0.00',
  `apply_after_min_delay_hours` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_policy_rules_policy` (`policy_id`),
  KEY `idx_policy_rules_window` (`policy_id`,`min_hours_before_departure`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

--
-- Contenu de la table `cancellation_policy_rules`
--

INSERT INTO `cancellation_policy_rules` (`id`, `policy_id`, `min_hours_before_departure`, `cancellation_fee_fixed`, `cancellation_fee_percent`, `refund_percent_to_payer`, `debit_driver_percent`, `apply_after_min_delay_hours`, `created_at`, `updated_at`) VALUES
(7, 3, 48, '0.00', '0.00', '100.00', '0.00', 0, '2026-02-28 20:22:16', '2026-02-28 20:22:16'),
(8, 3, 24, '0.00', '25.00', '75.00', '0.00', 0, '2026-02-28 20:22:16', '2026-02-28 20:22:16'),
(9, 3, 0, '5.00', '50.00', '50.00', '0.00', 0, '2026-02-28 20:22:16', '2026-02-28 20:22:16'),
(10, 4, 24, '0.00', '0.00', '100.00', '0.00', 0, '2026-02-28 20:22:16', '2026-02-28 20:22:16'),
(11, 4, 0, '3.00', '30.00', '70.00', '0.00', 0, '2026-02-28 20:22:16', '2026-02-28 20:22:16');

-- --------------------------------------------------------

--
-- Structure de la table `cancellation_requests`
--

CREATE TABLE IF NOT EXISTS `cancellation_requests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` enum('booking','delivery') NOT NULL,
  `resource_id` bigint(20) unsigned NOT NULL,
  `actor_user_id` bigint(20) unsigned NOT NULL,
  `actor_role` enum('passenger','sender','driver','admin') NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `original_amount_cents` int(11) NOT NULL DEFAULT '0',
  `calculated_refund_cents` int(11) NOT NULL DEFAULT '0',
  `calculated_fee_cents` int(11) NOT NULL DEFAULT '0',
  `driver_reversal_cents` int(11) NOT NULL DEFAULT '0',
  `commission_reversal_cents` int(11) NOT NULL DEFAULT '0',
  `driver_compensation_cents` int(11) NOT NULL DEFAULT '0',
  `policy_id` bigint(20) unsigned DEFAULT NULL,
  `policy_snapshot` text,
  `status` enum('requested','approved','rejected','refunded','closed') NOT NULL DEFAULT 'requested',
  `stripe_refund_id` varchar(255) DEFAULT NULL,
  `refund_id` bigint(20) unsigned DEFAULT NULL,
  `is_admin_override` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `processed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cancellation_req_resource` (`resource_type`,`resource_id`),
  KEY `idx_cancellation_req_actor` (`actor_user_id`),
  KEY `idx_cancellation_req_status` (`status`,`created_at`),
  KEY `idx_cancellation_req_policy` (`policy_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `cancellation_requests`
--

INSERT INTO `cancellation_requests` (`id`, `resource_type`, `resource_id`, `actor_user_id`, `actor_role`, `reason`, `original_amount_cents`, `calculated_refund_cents`, `calculated_fee_cents`, `driver_reversal_cents`, `commission_reversal_cents`, `driver_compensation_cents`, `policy_id`, `policy_snapshot`, `status`, `stripe_refund_id`, `refund_id`, `is_admin_override`, `created_at`, `processed_at`) VALUES
(1, 'booking', 62, 17, 'driver', NULL, 8808, 8808, 0, 8007, 801, 0, 4, '{"gross_amount_cents":8808,"platform_fee_cents":801,"driver_net_cents":8007,"policy_id":"4","policy_name":"Conducteur annule booking","actor_role":"driver","resource_type":"booking","refund_percent_to_customer":100,"cancellation_fee_fixed_cents":0,"cancellation_fee_percent":0,"driver_compensation_percent":0,"calculated_refund_cents":8808,"calculated_fee_cents":0,"driver_reversal_cents":8007,"commission_reversal_cents":801,"driver_compensation_cents":0,"computed_at":"2026-03-09T02:12:33.543Z"}', 'refunded', 're_3T8bKTDwdNKzEorh2XiVQW7O', 3, 0, '2026-03-08 22:12:34', '2026-03-09 02:12:35');

-- --------------------------------------------------------

--
-- Structure de la table `conversations`
--

CREATE TABLE IF NOT EXISTS `conversations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('booking','delivery') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'booking',
  `booking_id` bigint(20) unsigned DEFAULT NULL,
  `delivery_id` bigint(20) unsigned DEFAULT NULL,
  `status` enum('open','closed','archived') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'open',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `last_message_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_conversation_booking` (`booking_id`),
  UNIQUE KEY `uq_conversation_delivery` (`delivery_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=42 ;

--
-- Contenu de la table `conversations`
--

INSERT INTO `conversations` (`id`, `type`, `booking_id`, `delivery_id`, `status`, `created_by`, `last_message_at`, `created_at`, `updated_at`) VALUES
(1, 'booking', 1, NULL, 'open', NULL, '2026-02-28 01:00:00', '2026-02-28 20:22:16', '2026-03-03 15:13:34'),
(2, 'booking', 4, NULL, 'open', NULL, '2026-02-28 16:00:00', '2026-02-28 20:22:16', '2026-03-03 15:13:34'),
(3, 'delivery', NULL, 1, 'open', NULL, '2026-02-28 15:00:00', '2026-02-28 20:22:16', '2026-03-03 15:13:34'),
(4, 'booking', 12, NULL, 'open', NULL, '2026-02-27 22:00:00', '2026-02-28 20:35:44', '2026-03-03 15:13:34'),
(5, 'booking', 15, NULL, 'open', NULL, '2026-02-23 00:00:00', '2026-02-28 20:35:44', '2026-03-03 15:13:34'),
(6, 'delivery', NULL, 5, 'open', NULL, '2026-02-28 16:00:00', '2026-02-28 20:35:44', '2026-03-03 15:13:34'),
(7, 'booking', 47, NULL, 'open', NULL, '2026-03-03 19:16:35', '2026-03-03 05:26:13', '2026-03-03 15:13:34'),
(8, 'booking', 36, NULL, 'open', 17, '2026-03-04 14:23:37', '2026-03-04 14:22:34', '2026-03-04 09:23:37'),
(10, 'booking', 45, NULL, 'open', 17, NULL, '2026-03-04 14:39:38', '2026-03-04 14:39:38'),
(12, 'delivery', NULL, 13, 'open', 19, '2026-03-04 14:48:09', '2026-03-04 14:48:09', '2026-03-04 09:48:08'),
(13, 'delivery', NULL, 14, 'open', 19, '2026-03-04 14:50:55', '2026-03-04 14:50:55', '2026-03-04 09:50:54'),
(14, 'booking', 48, NULL, 'open', 19, '2026-03-04 14:51:13', '2026-03-04 14:51:13', '2026-03-04 09:51:12'),
(15, 'delivery', NULL, 15, 'open', 19, '2026-03-04 14:55:20', '2026-03-04 14:55:20', '2026-03-04 09:55:19'),
(16, 'delivery', NULL, 16, 'open', 19, '2026-03-04 15:10:57', '2026-03-04 15:10:57', '2026-03-04 10:10:57'),
(17, 'delivery', NULL, 17, 'open', 19, '2026-03-04 15:36:29', '2026-03-04 15:36:29', '2026-03-04 10:36:29'),
(18, 'booking', 49, NULL, 'open', 19, '2026-03-04 16:23:23', '2026-03-04 16:23:23', '2026-03-04 11:23:22'),
(19, 'booking', 50, NULL, 'open', 19, '2026-03-04 16:51:16', '2026-03-04 16:51:16', '2026-03-04 11:51:16'),
(20, 'booking', 51, NULL, 'open', 19, '2026-03-04 16:51:43', '2026-03-04 16:51:43', '2026-03-04 11:51:42'),
(21, 'booking', 52, NULL, 'open', 17, '2026-03-04 18:33:46', '2026-03-04 18:33:46', '2026-03-04 13:33:46'),
(22, 'delivery', NULL, 18, 'open', 17, '2026-03-04 18:35:04', '2026-03-04 18:35:04', '2026-03-04 13:35:03'),
(23, 'booking', 53, NULL, 'open', 17, '2026-03-04 19:19:36', '2026-03-04 19:19:36', '2026-03-04 14:19:35'),
(24, 'booking', 54, NULL, 'open', 17, '2026-03-04 19:33:23', '2026-03-04 19:33:23', '2026-03-04 14:33:22'),
(25, 'booking', 55, NULL, 'open', 17, '2026-03-04 20:21:46', '2026-03-04 20:21:46', '2026-03-04 15:21:46'),
(26, 'delivery', NULL, 19, 'open', 17, '2026-03-04 20:23:19', '2026-03-04 20:23:19', '2026-03-04 15:23:18'),
(27, 'delivery', NULL, 20, 'open', 17, '2026-03-04 20:40:49', '2026-03-04 20:40:49', '2026-03-04 15:40:49'),
(28, 'delivery', NULL, 21, 'open', 17, '2026-03-04 21:22:28', '2026-03-04 21:00:34', '2026-03-04 16:22:28'),
(29, 'booking', 56, NULL, 'open', 19, '2026-03-04 21:18:34', '2026-03-04 21:18:34', '2026-03-04 16:18:34'),
(30, 'booking', 57, NULL, 'open', 19, '2026-03-04 21:19:36', '2026-03-04 21:19:36', '2026-03-04 16:19:36'),
(31, 'booking', 58, NULL, 'open', 17, '2026-03-04 21:20:09', '2026-03-04 21:20:09', '2026-03-04 16:20:08'),
(32, 'delivery', NULL, 22, 'open', 17, '2026-03-04 21:23:54', '2026-03-04 21:21:04', '2026-03-04 16:23:54'),
(33, 'booking', 59, NULL, 'open', 19, '2026-03-05 14:22:01', '2026-03-05 14:22:01', '2026-03-05 09:22:00'),
(34, 'delivery', NULL, 23, 'open', 19, '2026-03-05 14:25:13', '2026-03-05 14:25:13', '2026-03-05 09:25:13'),
(35, 'booking', 60, NULL, 'open', 19, '2026-03-08 08:58:54', '2026-03-05 14:30:44', '2026-03-08 04:58:53'),
(36, 'delivery', NULL, 24, 'open', 19, '2026-03-05 14:32:00', '2026-03-05 14:32:00', '2026-03-05 09:32:00'),
(37, 'booking', 61, NULL, 'open', 19, '2026-03-05 15:23:17', '2026-03-05 15:23:17', '2026-03-05 10:23:16'),
(38, 'booking', 62, NULL, 'open', 19, '2026-03-08 07:00:48', '2026-03-08 07:00:48', '2026-03-08 03:00:47'),
(39, 'delivery', NULL, 25, 'open', 19, '2026-03-08 07:02:22', '2026-03-08 07:02:22', '2026-03-08 03:02:21'),
(40, 'booking', 63, NULL, 'open', 19, '2026-03-09 02:15:07', '2026-03-09 02:15:07', '2026-03-08 22:15:06'),
(41, 'delivery', NULL, 26, 'open', 19, '2026-03-09 02:16:12', '2026-03-09 02:16:12', '2026-03-08 22:16:11');

-- --------------------------------------------------------

--
-- Structure de la table `conversation_participants`
--

CREATE TABLE IF NOT EXISTS `conversation_participants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `role` enum('driver','passenger','sender','recipient','admin_viewer') NOT NULL DEFAULT 'passenger',
  `last_read_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_cp_conv_user` (`conversation_id`,`user_id`),
  KEY `idx_cp_conversation` (`conversation_id`),
  KEY `idx_cp_user` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=85 ;

--
-- Contenu de la table `conversation_participants`
--

INSERT INTO `conversation_participants` (`id`, `conversation_id`, `user_id`, `role`, `last_read_at`, `created_at`) VALUES
(1, 1, 10, 'passenger', NULL, '2026-02-28 20:22:16'),
(2, 2, 11, 'passenger', NULL, '2026-02-28 20:22:16'),
(3, 4, 6, 'passenger', NULL, '2026-02-28 20:35:44'),
(4, 5, 6, 'passenger', NULL, '2026-02-28 20:35:44'),
(5, 7, 19, 'passenger', NULL, '2026-03-03 05:26:13'),
(8, 1, 6, 'driver', NULL, '2026-02-28 20:22:16'),
(9, 2, 8, 'driver', NULL, '2026-02-28 20:22:16'),
(10, 4, 16, 'driver', NULL, '2026-02-28 20:35:44'),
(11, 5, 16, 'driver', NULL, '2026-02-28 20:35:44'),
(12, 7, 17, 'driver', NULL, '2026-03-03 05:26:13'),
(15, 3, 14, 'sender', NULL, '2026-02-28 20:22:16'),
(16, 6, 10, 'sender', NULL, '2026-02-28 20:35:44'),
(18, 3, 6, 'driver', NULL, '2026-02-28 20:22:16'),
(19, 6, 16, 'driver', NULL, '2026-02-28 20:35:44'),
(21, 8, 7, 'driver', NULL, '2026-03-04 14:22:34'),
(22, 8, 17, 'passenger', '2026-03-04 14:23:37', '2026-03-04 14:22:34'),
(23, 10, 7, 'driver', NULL, '2026-03-04 14:39:38'),
(24, 10, 17, 'passenger', NULL, '2026-03-04 14:39:38'),
(25, 12, 17, 'driver', NULL, '2026-03-04 14:48:09'),
(26, 12, 19, 'sender', NULL, '2026-03-04 14:48:09'),
(27, 13, 17, 'driver', NULL, '2026-03-04 14:50:55'),
(28, 13, 19, 'sender', NULL, '2026-03-04 14:50:55'),
(29, 14, 17, 'driver', NULL, '2026-03-04 14:51:13'),
(30, 14, 19, 'passenger', NULL, '2026-03-04 14:51:13'),
(31, 15, 17, 'driver', NULL, '2026-03-04 14:55:20'),
(32, 15, 19, 'sender', NULL, '2026-03-04 14:55:20'),
(33, 16, 17, 'driver', NULL, '2026-03-04 15:10:57'),
(34, 16, 19, 'sender', NULL, '2026-03-04 15:10:57'),
(35, 17, 17, 'driver', NULL, '2026-03-04 15:36:29'),
(36, 17, 19, 'sender', NULL, '2026-03-04 15:36:29'),
(37, 18, 17, 'driver', NULL, '2026-03-04 16:23:23'),
(38, 18, 19, 'passenger', NULL, '2026-03-04 16:23:23'),
(39, 19, 17, 'driver', NULL, '2026-03-04 16:51:16'),
(40, 19, 19, 'passenger', NULL, '2026-03-04 16:51:16'),
(41, 20, 17, 'driver', NULL, '2026-03-04 16:51:43'),
(42, 20, 19, 'passenger', NULL, '2026-03-04 16:51:43'),
(43, 21, 19, 'driver', NULL, '2026-03-04 18:33:46'),
(44, 21, 17, 'passenger', NULL, '2026-03-04 18:33:46'),
(45, 22, 19, 'driver', NULL, '2026-03-04 18:35:04'),
(46, 22, 17, 'sender', NULL, '2026-03-04 18:35:04'),
(47, 23, 19, 'driver', NULL, '2026-03-04 19:19:36'),
(48, 23, 17, 'passenger', NULL, '2026-03-04 19:19:36'),
(49, 24, 19, 'driver', NULL, '2026-03-04 19:33:23'),
(50, 24, 17, 'passenger', NULL, '2026-03-04 19:33:23'),
(51, 25, 19, 'driver', NULL, '2026-03-04 20:21:46'),
(52, 25, 17, 'passenger', NULL, '2026-03-04 20:21:46'),
(53, 26, 19, 'driver', NULL, '2026-03-04 20:23:19'),
(54, 26, 17, 'sender', NULL, '2026-03-04 20:23:19'),
(55, 27, 19, 'driver', NULL, '2026-03-04 20:40:49'),
(56, 27, 17, 'sender', NULL, '2026-03-04 20:40:49'),
(57, 28, 19, 'driver', NULL, '2026-03-04 21:00:34'),
(58, 28, 17, 'sender', '2026-03-04 21:22:28', '2026-03-04 21:00:34'),
(59, 29, 17, 'driver', NULL, '2026-03-04 21:18:34'),
(60, 29, 19, 'passenger', NULL, '2026-03-04 21:18:34'),
(61, 30, 17, 'driver', NULL, '2026-03-04 21:19:36'),
(62, 30, 19, 'passenger', NULL, '2026-03-04 21:19:36'),
(63, 31, 19, 'driver', NULL, '2026-03-04 21:20:09'),
(64, 31, 17, 'passenger', NULL, '2026-03-04 21:20:09'),
(65, 32, 19, 'driver', '2026-03-04 21:23:54', '2026-03-04 21:21:04'),
(66, 32, 17, 'sender', NULL, '2026-03-04 21:21:04'),
(67, 33, 17, 'driver', NULL, '2026-03-05 14:22:01'),
(68, 33, 19, 'passenger', NULL, '2026-03-05 14:22:01'),
(69, 34, 17, 'driver', NULL, '2026-03-05 14:25:13'),
(70, 34, 19, 'sender', NULL, '2026-03-05 14:25:13'),
(71, 35, 17, 'driver', '2026-03-08 08:58:54', '2026-03-05 14:30:44'),
(72, 35, 19, 'passenger', NULL, '2026-03-05 14:30:44'),
(73, 36, 17, 'driver', NULL, '2026-03-05 14:32:00'),
(74, 36, 19, 'sender', NULL, '2026-03-05 14:32:00'),
(75, 37, 17, 'driver', NULL, '2026-03-05 15:23:17'),
(76, 37, 19, 'passenger', NULL, '2026-03-05 15:23:17'),
(77, 38, 17, 'driver', NULL, '2026-03-08 07:00:48'),
(78, 38, 19, 'passenger', NULL, '2026-03-08 07:00:48'),
(79, 39, 17, 'driver', NULL, '2026-03-08 07:02:22'),
(80, 39, 19, 'sender', NULL, '2026-03-08 07:02:22'),
(81, 40, 17, 'driver', NULL, '2026-03-09 02:15:07'),
(82, 40, 19, 'passenger', NULL, '2026-03-09 02:15:07'),
(83, 41, 17, 'driver', NULL, '2026-03-09 02:16:12'),
(84, 41, 19, 'sender', NULL, '2026-03-09 02:16:12');

-- --------------------------------------------------------

--
-- Structure de la table `deliveries`
--

CREATE TABLE IF NOT EXISTS `deliveries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `trip_id` bigint(20) unsigned NOT NULL,
  `sender_id` bigint(20) unsigned NOT NULL,
  `recipient_user_id` bigint(20) unsigned DEFAULT NULL,
  `parcel_id` bigint(20) unsigned NOT NULL,
  `pickup_notes` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dropoff_notes` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('pending','accepted','rejected','paid','in_transit','delivered','cancelled','disputed','received') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `cancel_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `received_at` datetime DEFAULT NULL,
  `delivery_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount_total` decimal(12,2) DEFAULT NULL,
  `currency` char(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CAD',
  `cancellation_policy_id` bigint(20) unsigned DEFAULT NULL,
  `cancellation_rule_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  `accepted_at` datetime DEFAULT NULL,
  `in_transit_at` datetime DEFAULT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_deliveries_trip` (`trip_id`,`status`),
  KEY `idx_deliveries_sender` (`sender_id`,`created_at`),
  KEY `idx_deliveries_status` (`status`,`created_at`),
  KEY `fk_deliveries_parcel` (`parcel_id`),
  KEY `idx_deliveries_recipient` (`recipient_user_id`,`status`,`created_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=27 ;

--
-- Contenu de la table `deliveries`
--

INSERT INTO `deliveries` (`id`, `trip_id`, `sender_id`, `recipient_user_id`, `parcel_id`, `pickup_notes`, `dropoff_notes`, `status`, `cancel_reason`, `received_at`, `delivery_code`, `amount_total`, `currency`, `cancellation_policy_id`, `cancellation_rule_id`, `created_at`, `updated_at`, `deleted_at`, `accepted_at`, `in_transit_at`, `delivered_at`) VALUES
(1, 1, 14, NULL, 1, 'Récupérer au 1000 Rue Sherbrooke, hall d''entrée.', 'Déposer chez Céramiques Québec, 45 Rue Saint-Paul.', 'accepted', NULL, NULL, 'DEL-MTL-QC-001', '15.00', 'CAD', NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, NULL, NULL),
(2, 2, 14, NULL, 2, 'Librairie Pantoute, 1100 Rue Saint-Jean, Québec.', 'Librairie Le Port de tête, 262 Avenue du Mont-Royal E, Montréal.', 'pending', NULL, NULL, 'DEL-QC-MTL-002', '10.00', 'CAD', NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, NULL, NULL),
(3, 3, 12, NULL, 3, 'Bureau de poste, 59 Sparks St, Ottawa.', 'Bureau 401, 100 King St W, Toronto.', 'paid', NULL, NULL, 'DEL-OTT-TOR-003', '20.00', 'CAD', NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, NULL, NULL),
(4, 8, 14, NULL, 4, 'Aréna de Québec, entrée arrière.', 'Aréna de Trois-Rivières, vestiaire visiteurs.', 'delivered', NULL, NULL, 'DEL-QC-TR-004', '8.00', 'CAD', NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, NULL, NULL),
(5, 11, 10, NULL, 5, 'Récupérer au 1001 Boul. de Maisonneuve, lobby.', 'Déposer au 150 Elgin St, réception.', 'accepted', NULL, NULL, 'DEL-OLNK-001', '15.00', 'CAD', NULL, NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL, NULL, NULL, NULL),
(6, 15, 8, NULL, 6, 'Bureau du notaire, 500 Place d''Armes, Montréal.', 'Bureau 302, 150 Elgin St, Ottawa.', 'delivered', NULL, NULL, 'DEL-OLNK-002', '12.00', 'CAD', NULL, NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL, NULL, NULL, NULL),
(7, 12, 17, NULL, 9, NULL, NULL, 'cancelled', NULL, NULL, NULL, '10.00', 'CAD', NULL, NULL, '2026-03-03 04:02:47', '2026-03-03 04:03:26', NULL, NULL, NULL, NULL),
(8, 2, 17, NULL, 10, '140 avenue de navarre ,saint lambert', '375 ch gauvin,dieppe', 'pending', NULL, NULL, NULL, '10.00', 'CAD', NULL, NULL, '2026-03-03 04:07:18', '2026-03-03 04:07:18', NULL, NULL, NULL, NULL),
(9, 25, 17, NULL, 11, '5890 saint hubert', '375 ch gauvin ,dieppe', 'accepted', NULL, NULL, NULL, '25.00', 'CAD', NULL, NULL, '2026-03-03 17:28:55', '2026-03-04 09:02:47', NULL, '2026-03-04 14:02:47', NULL, NULL),
(10, 25, 17, NULL, 12, '225 rue taggart', '375 ch gauvin', 'accepted', NULL, NULL, NULL, '25.00', 'CAD', NULL, NULL, '2026-03-03 18:16:25', '2026-03-04 09:02:35', NULL, '2026-03-04 14:02:35', NULL, NULL),
(11, 25, 17, NULL, 13, '160 avenue de navarre', '1786 rue rosemont', 'paid', NULL, NULL, NULL, '25.00', 'CAD', NULL, NULL, '2026-03-03 19:14:08', '2026-03-03 19:14:08', NULL, NULL, NULL, NULL),
(12, 25, 17, 19, 14, '225 rue taggart', '375 ch gauvin', 'paid', NULL, NULL, NULL, '25.00', 'CAD', NULL, NULL, '2026-03-03 19:30:38', '2026-03-03 19:30:38', NULL, NULL, NULL, NULL),
(13, 26, 19, 17, 15, '7582 tyuhr', '14582 gjt', 'pending', NULL, NULL, NULL, '0.00', 'CAD', NULL, NULL, '2026-03-04 14:48:09', '2026-03-04 14:48:09', NULL, NULL, NULL, NULL),
(14, 26, 19, NULL, 16, '1245fgh', '451289frt', 'pending', NULL, NULL, NULL, '0.00', 'CAD', NULL, NULL, '2026-03-04 14:50:55', '2026-03-04 14:50:55', NULL, NULL, NULL, NULL),
(15, 26, 19, NULL, 17, '123 fgh', '145 fgt', 'pending', NULL, NULL, NULL, '0.00', 'CAD', NULL, NULL, '2026-03-04 14:55:20', '2026-03-04 14:55:20', NULL, NULL, NULL, NULL),
(16, 26, 19, 17, 18, '123 ghj', '254 njr', 'cancelled', NULL, NULL, NULL, '0.00', 'CAD', NULL, NULL, '2026-03-04 15:10:57', '2026-03-08 06:56:49', NULL, NULL, NULL, NULL),
(17, 22, 19, 17, 19, '140 avenue de navarre', '675 che dieppe', 'paid', NULL, NULL, NULL, '411.92', 'CAD', NULL, NULL, '2026-03-04 15:36:29', '2026-03-04 15:36:29', NULL, NULL, NULL, NULL),
(18, 25, 17, NULL, 20, '140 avenue de navarre', '675 rue edmond', 'paid', NULL, NULL, NULL, '25.00', 'CAD', NULL, NULL, '2026-03-04 18:35:04', '2026-03-04 18:35:04', NULL, NULL, NULL, NULL),
(19, 25, 17, NULL, 21, '140 avenue de navarre', '5890 saint hubert', 'paid', NULL, NULL, NULL, '25.00', 'CAD', NULL, NULL, '2026-03-04 20:23:19', '2026-03-04 20:23:19', NULL, NULL, NULL, NULL),
(20, 25, 17, NULL, 22, '452 st hubert', '225 rue taggart', 'paid', NULL, NULL, NULL, '25.00', 'CAD', NULL, NULL, '2026-03-04 20:40:49', '2026-03-04 20:40:49', NULL, NULL, NULL, NULL),
(21, 25, 17, NULL, 23, '5890 saint hubert', '140 avenue navarre', 'paid', NULL, NULL, NULL, '25.00', 'CAD', NULL, NULL, '2026-03-04 21:00:33', '2026-03-04 21:00:33', NULL, NULL, NULL, NULL),
(22, 25, 17, NULL, 24, NULL, NULL, 'delivered', NULL, NULL, NULL, '25.00', 'CAD', NULL, NULL, '2026-03-04 21:21:04', '2026-03-08 03:04:00', NULL, NULL, '2026-03-08 07:03:46', '2026-03-08 07:04:00'),
(23, 22, 19, 17, 25, '225 rue taggart', '140 avenue de navarre', 'paid', NULL, NULL, NULL, '411.92', 'CAD', NULL, NULL, '2026-03-05 14:25:13', '2026-03-05 14:25:13', NULL, NULL, NULL, NULL),
(24, 27, 19, NULL, 26, '225 rue taggart', '375 ch gauvin', 'paid', NULL, NULL, NULL, '45.00', 'CAD', NULL, NULL, '2026-03-05 14:32:00', '2026-03-05 14:32:00', NULL, NULL, NULL, NULL),
(25, 29, 19, NULL, 27, '123 rue marchal', '675 rue blac', 'paid', NULL, NULL, NULL, '35.08', 'CAD', NULL, NULL, '2026-03-08 07:02:22', '2026-03-08 07:02:22', NULL, NULL, NULL, NULL),
(26, 29, 19, NULL, 28, '140 avenue de navarre', '375 ch gauvin', 'paid', NULL, NULL, NULL, '35.08', 'CAD', NULL, NULL, '2026-03-09 02:16:12', '2026-03-09 02:16:12', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `disputes`
--

CREATE TABLE IF NOT EXISTS `disputes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `kind` enum('booking','delivery') NOT NULL,
  `reference_id` bigint(20) unsigned NOT NULL,
  `opened_by` bigint(20) unsigned NOT NULL,
  `reason` varchar(500) NOT NULL,
  `status` enum('open','investigating','resolved_refund','resolved_release','resolved_split','closed') NOT NULL DEFAULT 'open',
  `hold_amount_cents` bigint(20) NOT NULL DEFAULT '0',
  `resolution_note` text,
  `resolved_by` bigint(20) unsigned DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_disputes_kind_ref` (`kind`,`reference_id`),
  KEY `idx_disputes_status` (`status`,`created_at`),
  KEY `idx_disputes_opened_by` (`opened_by`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `disputes`
--

INSERT INTO `disputes` (`id`, `kind`, `reference_id`, `opened_by`, `reason`, `status`, `hold_amount_cents`, `resolution_note`, `resolved_by`, `resolved_at`, `created_at`, `updated_at`) VALUES
(1, 'booking', 58, 19, 'Autre — test', 'resolved_refund', 5134, 'c''est ok remboursé', 18, '2026-03-08 05:08:49', '2026-03-08 05:03:26', '2026-03-08 05:08:49');

-- --------------------------------------------------------

--
-- Structure de la table `dispute_replies`
--

CREATE TABLE IF NOT EXISTS `dispute_replies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dispute_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `user_role` enum('user','admin','support','system') NOT NULL DEFAULT 'user',
  `message` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_dr_dispute` (`dispute_id`,`created_at`),
  KEY `idx_dr_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

CREATE TABLE IF NOT EXISTS `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` bigint(20) unsigned NOT NULL,
  `sender_id` bigint(20) unsigned DEFAULT NULL,
  `message_type` enum('text','system') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `message_text` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_messages_conversation` (`conversation_id`,`created_at`),
  KEY `idx_messages_sender` (`sender_id`,`created_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=54 ;

--
-- Contenu de la table `messages`
--

INSERT INTO `messages` (`id`, `conversation_id`, `sender_id`, `message_type`, `message_text`, `created_at`, `deleted_at`) VALUES
(1, 1, 10, 'text', 'Bonjour Jean! Je serai au point de rendez-vous à 7h45. Est-ce que ça vous convient?', '2026-02-27 23:00:00', NULL),
(2, 1, 17, 'text', 'Salut Lucas! Parfait, je serai là à 8h pile. Cherche une Honda Civic bleue.', '2026-02-28 00:00:00', NULL),
(3, 1, 10, 'text', 'Super, merci! J''aurai un sac à dos et une petite valise.', '2026-02-28 01:00:00', NULL),
(4, 2, 11, 'text', 'Hi David! Can we stop in Kingston for 5 minutes? I need to drop something off.', '2026-02-28 15:00:00', NULL),
(5, 2, 8, 'text', 'Sure Emma, Kingston is already a planned stop. No problem at all!', '2026-02-28 16:00:00', NULL),
(6, 3, 14, 'text', 'Bonjour Jean, le colis sera prêt à récupérer dès 7h30 au hall d''entrée.', '2026-02-28 13:00:00', NULL),
(7, 3, 6, 'text', 'Parfait Maxime! Je passerai le prendre avant de partir. C''est bien un carton moyen?', '2026-02-28 14:00:00', NULL),
(8, 3, 14, 'text', 'Oui, environ 40x30x25 cm. Merci beaucoup!', '2026-02-28 15:00:00', NULL),
(9, 4, 6, 'text', 'Salut Olank! Super, j''ai réservé pour le trajet Montréal-Ottawa. On se retrouve où exactement?', '2026-02-27 19:00:00', NULL),
(10, 4, 16, 'text', 'Hey! Je serai devant le 1001 Maisonneuve, côté nord. Tesla Model 3 noire, tu ne peux pas la manquer ?', '2026-02-27 20:00:00', NULL),
(11, 4, 6, 'text', 'Parfait! J''aurai juste un sac à dos. À bientôt!', '2026-02-27 21:00:00', NULL),
(12, 4, 16, 'text', 'Super, à bientôt! On fera un arrêt café à Hawkesbury si ça te dit ☕', '2026-02-27 22:00:00', NULL),
(13, 5, 6, 'text', 'Merci pour le trajet Olank! C''était vraiment agréable, la Tesla est super silencieuse.', '2026-02-22 23:00:00', NULL),
(14, 5, 16, 'text', 'Merci à toi! C''était un plaisir. N''hésite pas à réserver à nouveau ?', '2026-02-23 00:00:00', NULL),
(15, 6, 10, 'text', 'Bonjour Olank, le colis de sirop d''érable sera au lobby à 6h45. Merci!', '2026-02-28 14:00:00', NULL),
(16, 6, 16, 'text', 'Pas de souci, je le récupère en partant. C''est bien une boîte avec un ruban rouge?', '2026-02-28 15:00:00', NULL),
(17, 6, 17, 'text', 'Exactement! Boîte en carton avec ruban rouge. Merci beaucoup! ?', '2026-02-28 16:00:00', NULL),
(18, 7, 19, 'text', 'salu a quel heure est prevu le depart', '2026-03-03 19:15:54', NULL),
(19, 7, 17, 'text', 'pour 08h heur de montreal', '2026-03-03 19:16:35', NULL),
(20, 8, 17, 'text', 'slt', '2026-03-04 14:23:37', NULL),
(21, 12, NULL, 'system', 'Nouvelle demande de livraison créée.', '2026-03-04 14:48:09', NULL),
(22, 13, NULL, 'system', 'Nouvelle demande de livraison créée.', '2026-03-04 14:50:55', NULL),
(23, 14, NULL, 'system', 'Nouvelle réservation de 1 place(s) créée.', '2026-03-04 14:51:13', NULL),
(24, 15, NULL, 'system', 'Nouvelle demande de livraison créée.', '2026-03-04 14:55:20', NULL),
(25, 16, NULL, 'system', 'Nouvelle demande de livraison créée.', '2026-03-04 15:10:57', NULL),
(26, 17, NULL, 'system', 'Nouvelle demande de livraison créée.', '2026-03-04 15:36:29', NULL),
(27, 18, NULL, 'system', 'Nouvelle réservation de 1 place(s) créée.', '2026-03-04 16:23:23', NULL),
(28, 19, NULL, 'system', 'Nouvelle réservation de 2 place(s) créée.', '2026-03-04 16:51:16', NULL),
(29, 20, NULL, 'system', 'Nouvelle réservation de 1 place(s) créée.', '2026-03-04 16:51:43', NULL),
(30, 21, NULL, 'system', 'Nouvelle réservation de 1 place(s) créée.', '2026-03-04 18:33:46', NULL),
(31, 22, NULL, 'system', 'Nouvelle demande de livraison créée.', '2026-03-04 18:35:04', NULL),
(32, 23, NULL, 'system', 'Nouvelle réservation de 1 place(s) créée.', '2026-03-04 19:19:36', NULL),
(33, 24, NULL, 'system', 'Nouvelle réservation de 1 place(s) créée.', '2026-03-04 19:33:23', NULL),
(34, 25, NULL, 'system', 'Nouvelle réservation de 1 place(s) créée.', '2026-03-04 20:21:46', NULL),
(35, 26, NULL, 'system', 'Nouvelle demande de livraison créée.', '2026-03-04 20:23:19', NULL),
(36, 27, NULL, 'system', 'Nouvelle demande de livraison créée.', '2026-03-04 20:40:49', NULL),
(37, 28, NULL, 'system', 'Nouvelle demande de livraison créée.', '2026-03-04 21:00:34', NULL),
(38, 29, NULL, 'system', 'Nouvelle réservation de 1 place(s) créée.', '2026-03-04 21:18:34', NULL),
(39, 30, NULL, 'system', 'Nouvelle réservation de 1 place(s) créée.', '2026-03-04 21:19:36', NULL),
(40, 31, NULL, 'system', 'Nouvelle réservation de 1 place(s) créée.', '2026-03-04 21:20:09', NULL),
(41, 32, NULL, 'system', 'Nouvelle demande de livraison créée.', '2026-03-04 21:21:04', NULL),
(42, 28, 17, 'text', 'salut merci de m,informer a la transmission', '2026-03-04 21:22:28', NULL),
(43, 32, 19, 'text', 'merci', '2026-03-04 21:23:54', NULL),
(44, 33, NULL, 'system', 'Nouvelle réservation de 1 place(s) créée.', '2026-03-05 14:22:01', NULL),
(45, 34, NULL, 'system', 'Nouvelle demande de livraison créée.', '2026-03-05 14:25:13', NULL),
(46, 35, NULL, 'system', 'Nouvelle réservation de 2 place(s) créée.', '2026-03-05 14:30:44', NULL),
(47, 36, NULL, 'system', 'Nouvelle demande de livraison créée.', '2026-03-05 14:32:00', NULL),
(48, 37, NULL, 'system', 'Nouvelle réservation de 1 place(s) créée.', '2026-03-05 15:23:17', NULL),
(49, 38, NULL, 'system', 'Nouvelle réservation de 1 place(s) créée.', '2026-03-08 07:00:48', NULL),
(50, 39, NULL, 'system', 'Nouvelle demande de livraison créée.', '2026-03-08 07:02:22', NULL),
(51, 35, 17, 'text', 'salut comment allez vous', '2026-03-08 08:58:54', NULL),
(52, 40, NULL, 'system', 'Nouvelle réservation de 1 place(s) créée.', '2026-03-09 02:15:07', NULL),
(53, 41, NULL, 'system', 'Nouvelle demande de livraison créée.', '2026-03-09 02:16:12', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `parcels`
--

CREATE TABLE IF NOT EXISTS `parcels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `size_category` enum('XS','S','M','L') COLLATE utf8_unicode_ci NOT NULL,
  `weight_kg` decimal(8,2) DEFAULT NULL,
  `declared_value` decimal(12,2) DEFAULT NULL,
  `currency` char(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CAD',
  `instructions` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photos_json` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=29 ;

--
-- Contenu de la table `parcels`
--

INSERT INTO `parcels` (`id`, `size_category`, `weight_kg`, `declared_value`, `currency`, `instructions`, `photos_json`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'M', '5.50', '75.00', 'CAD', 'Fragile — contient de la vaisselle artisanale du Vieux-Québec.', NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(2, 'S', '2.00', '150.00', 'CAD', 'Livres rares, garder au sec.', NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(3, 'XS', '0.50', '30.00', 'CAD', 'Enveloppe de documents importants.', NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(4, 'L', '15.00', '200.00', 'CAD', 'Équipement de hockey. Sac volumineux mais pas fragile.', NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(5, 'S', '3.00', '120.00', 'CAD', 'Boîte de sirop d''érable du Québec. Fragile, garder à plat.', NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(6, 'XS', '0.80', '50.00', 'CAD', 'Documents notariés. Ne pas plier.', NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(7, 'S', '1.00', '15.00', 'CAD', NULL, NULL, '2026-03-01 16:34:51', '2026-03-01 16:34:51', NULL),
(8, 'S', '1.00', '15.00', 'CAD', NULL, NULL, '2026-03-01 16:35:16', '2026-03-01 16:35:16', NULL),
(9, 'S', '1.00', '25.00', 'CAD', NULL, NULL, '2026-03-03 04:02:47', '2026-03-03 04:02:47', NULL),
(10, 'XS', '0.50', '10.00', 'CAD', NULL, NULL, '2026-03-03 04:07:17', '2026-03-03 04:07:17', NULL),
(11, 'S', '0.50', '25.00', 'CAD', NULL, NULL, '2026-03-03 17:28:55', '2026-03-03 17:28:55', NULL),
(12, 'S', '1.00', '25.00', 'CAD', NULL, NULL, '2026-03-03 18:16:25', '2026-03-03 18:16:25', NULL),
(13, 'XS', '1.00', '25.00', 'CAD', NULL, NULL, '2026-03-03 19:14:08', '2026-03-03 19:14:08', NULL),
(14, 'XS', '1.00', '25.00', 'CAD', NULL, NULL, '2026-03-03 19:30:38', '2026-03-03 19:30:38', NULL),
(15, 'XS', '0.50', '1.00', 'CAD', NULL, NULL, '2026-03-04 14:48:09', '2026-03-04 14:48:09', NULL),
(16, 'XS', '1.00', '10.00', 'CAD', NULL, NULL, '2026-03-04 14:50:55', '2026-03-04 14:50:55', NULL),
(17, 'S', '1.00', '10.00', 'CAD', NULL, NULL, '2026-03-04 14:55:20', '2026-03-04 14:55:20', NULL),
(18, 'XS', '1.00', '10.00', 'CAD', NULL, NULL, '2026-03-04 15:10:57', '2026-03-04 15:10:57', NULL),
(19, 'S', '1.00', '500.00', 'CAD', NULL, NULL, '2026-03-04 15:36:29', '2026-03-04 15:36:29', NULL),
(20, 'S', '1.00', '25.00', 'CAD', NULL, NULL, '2026-03-04 18:35:04', '2026-03-04 18:35:04', NULL),
(21, 'XS', '1.00', '25.00', 'CAD', NULL, NULL, '2026-03-04 20:23:19', '2026-03-04 20:23:19', NULL),
(22, 'XS', '1.00', '25.00', 'CAD', NULL, NULL, '2026-03-04 20:40:49', '2026-03-04 20:40:49', NULL),
(23, 'XS', '1.00', '25.00', 'CAD', NULL, NULL, '2026-03-04 21:00:33', '2026-03-04 21:00:33', NULL),
(24, 'XS', '0.50', '25.00', 'CAD', NULL, NULL, '2026-03-04 21:21:04', '2026-03-04 21:21:04', NULL),
(25, 'S', '1.00', '500.00', 'CAD', NULL, NULL, '2026-03-05 14:25:13', '2026-03-05 14:25:13', NULL),
(26, 'XS', '0.50', '45.00', 'CAD', NULL, NULL, '2026-03-05 14:32:00', '2026-03-05 14:32:00', NULL),
(27, 'XS', '0.50', '25.00', 'CAD', NULL, NULL, '2026-03-08 07:02:22', '2026-03-08 07:02:22', NULL),
(28, 'S', '1.00', '20.00', 'CAD', NULL, NULL, '2026-03-09 02:16:12', '2026-03-09 02:16:12', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `payments`
--

CREATE TABLE IF NOT EXISTS `payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `kind` enum('booking','delivery') COLLATE utf8_unicode_ci DEFAULT NULL,
  `booking_id` bigint(20) unsigned DEFAULT NULL,
  `delivery_id` bigint(20) unsigned DEFAULT NULL,
  `payer_id` bigint(20) unsigned NOT NULL,
  `payee_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `amount_cents` bigint(20) NOT NULL DEFAULT '0',
  `currency` char(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CAD',
  `provider` enum('stripe') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'stripe',
  `status` enum('requires_payment','processing','succeeded','failed','refunded','cancelled') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'requires_payment',
  `stripe_payment_intent_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stripe_charge_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_payments_stripe_intent` (`stripe_payment_intent_id`),
  KEY `idx_payments_status` (`status`,`created_at`),
  KEY `idx_payments_booking` (`booking_id`),
  KEY `idx_payments_delivery` (`delivery_id`),
  KEY `fk_payments_payer` (`payer_id`),
  KEY `fk_payments_payee` (`payee_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=60 ;

--
-- Contenu de la table `payments`
--

INSERT INTO `payments` (`id`, `kind`, `booking_id`, `delivery_id`, `payer_id`, `payee_id`, `amount`, `amount_cents`, `currency`, `provider`, `status`, `stripe_payment_intent_id`, `stripe_charge_id`, `created_at`, `updated_at`) VALUES
(1, 'booking', 1, NULL, 10, 6, '35.00', 3500, 'CAD', 'stripe', 'succeeded', 'pi_fake_seed_001', 'ch_fake_seed_001', '2026-02-28 20:22:15', '2026-03-08 05:00:32'),
(2, 'booking', 2, NULL, 11, 6, '35.00', 3500, 'CAD', 'stripe', 'succeeded', 'pi_fake_seed_002', 'ch_fake_seed_002', '2026-02-28 20:22:15', '2026-03-08 05:00:32'),
(3, 'booking', 5, NULL, 13, 9, '40.00', 4000, 'CAD', 'stripe', 'succeeded', 'pi_fake_seed_003', 'ch_fake_seed_003', '2026-02-28 20:22:15', '2026-03-08 05:00:32'),
(4, 'booking', 6, NULL, 10, 8, '45.00', 4500, 'CAD', 'stripe', 'succeeded', 'pi_fake_seed_004', 'ch_fake_seed_004', '2026-02-28 20:22:15', '2026-03-08 05:00:32'),
(5, 'booking', 7, NULL, 11, 8, '90.00', 9000, 'CAD', 'stripe', 'succeeded', 'pi_fake_seed_005', 'ch_fake_seed_005', '2026-02-28 20:22:15', '2026-03-08 05:00:32'),
(6, 'booking', 8, NULL, 12, 7, '40.00', 4000, 'CAD', 'stripe', 'succeeded', 'pi_fake_seed_006', 'ch_fake_seed_006', '2026-02-28 20:22:15', '2026-03-08 05:00:32'),
(7, 'booking', 9, NULL, 13, 7, '20.00', 2000, 'CAD', 'stripe', 'succeeded', 'pi_fake_seed_007', 'ch_fake_seed_007', '2026-02-28 20:22:15', '2026-03-08 05:00:32'),
(8, 'delivery', NULL, 3, 12, 8, '20.00', 2000, 'CAD', 'stripe', 'succeeded', 'pi_fake_seed_008', 'ch_fake_seed_008', '2026-02-28 20:22:15', '2026-03-08 05:00:32'),
(9, 'delivery', NULL, 4, 14, 7, '8.00', 800, 'CAD', 'stripe', 'succeeded', 'pi_fake_seed_009', 'ch_fake_seed_009', '2026-02-28 20:22:15', '2026-03-08 05:00:32'),
(10, 'booking', 10, NULL, 10, 6, '25.00', 2500, 'CAD', 'stripe', 'refunded', 'pi_fake_seed_010', 'ch_fake_seed_010', '2026-02-28 20:22:15', '2026-03-08 05:00:32'),
(11, 'booking', 12, NULL, 6, 16, '35.00', 3500, 'CAD', 'stripe', 'succeeded', 'pi_olank_recv_001', 'ch_olank_recv_001', '2026-02-28 20:35:43', '2026-03-08 05:00:32'),
(12, 'booking', 13, NULL, 7, 16, '35.00', 3500, 'CAD', 'stripe', 'succeeded', 'pi_olank_recv_002', 'ch_olank_recv_002', '2026-02-28 20:35:43', '2026-03-08 05:00:32'),
(13, 'booking', 15, NULL, 6, 16, '35.00', 3500, 'CAD', 'stripe', 'succeeded', 'pi_olank_recv_003', 'ch_olank_recv_003', '2026-02-28 20:35:43', '2026-03-08 05:00:32'),
(14, 'booking', 16, NULL, 7, 16, '35.00', 3500, 'CAD', 'stripe', 'succeeded', 'pi_olank_recv_004', 'ch_olank_recv_004', '2026-02-28 20:35:43', '2026-03-08 05:00:32'),
(15, 'booking', 17, NULL, 8, 16, '35.00', 3500, 'CAD', 'stripe', 'succeeded', 'pi_olank_recv_005', 'ch_olank_recv_005', '2026-02-28 20:35:43', '2026-03-08 05:00:32'),
(16, 'booking', 18, NULL, 9, 16, '60.00', 6000, 'CAD', 'stripe', 'succeeded', 'pi_olank_recv_006', 'ch_olank_recv_006', '2026-02-28 20:35:43', '2026-03-08 05:00:32'),
(17, 'booking', 19, NULL, 10, 16, '60.00', 6000, 'CAD', 'stripe', 'succeeded', 'pi_olank_recv_007', 'ch_olank_recv_007', '2026-02-28 20:35:44', '2026-03-08 05:00:32'),
(18, 'delivery', NULL, 6, 8, 16, '12.00', 1200, 'CAD', 'stripe', 'succeeded', 'pi_olank_recv_008', 'ch_olank_recv_008', '2026-02-28 20:35:44', '2026-03-08 05:00:32'),
(19, 'booking', 20, NULL, 16, 6, '35.00', 3500, 'CAD', 'stripe', 'succeeded', 'pi_olank_sent_001', 'ch_olank_sent_001', '2026-02-28 20:35:44', '2026-03-08 05:00:32'),
(20, 'booking', 21, NULL, 16, 7, '30.00', 3000, 'CAD', 'stripe', 'succeeded', 'pi_olank_sent_002', 'ch_olank_sent_002', '2026-02-28 20:35:44', '2026-03-08 05:00:32'),
(21, 'booking', 37, NULL, 17, 16, '45.00', 4500, 'CAD', 'stripe', 'requires_payment', 'pi_3T6jndDwdNKzEorh2qAzYEoq', NULL, '2026-03-03 03:39:10', '2026-03-08 05:00:32'),
(22, 'booking', 38, NULL, 17, 6, '35.00', 3500, 'CAD', 'stripe', 'requires_payment', 'pi_3T6joIDwdNKzEorh2azc91AT', NULL, '2026-03-03 03:39:52', '2026-03-08 05:00:32'),
(23, 'booking', 39, NULL, 17, 9, '20.00', 2000, 'CAD', 'stripe', 'requires_payment', 'pi_3T6k8iDwdNKzEorh2i6VVJAb', NULL, '2026-03-03 04:00:58', '2026-03-08 05:00:32'),
(24, 'booking', 40, NULL, 17, 16, '30.00', 3000, 'CAD', 'stripe', 'requires_payment', 'pi_3T6k9EDwdNKzEorh0wnJy4uV', NULL, '2026-03-03 04:01:29', '2026-03-08 05:00:32'),
(25, 'booking', 41, NULL, 17, 16, '60.00', 6000, 'CAD', 'stripe', 'requires_payment', 'pi_3T6k9iDwdNKzEorh0QwNPDer', NULL, '2026-03-03 04:01:59', '2026-03-08 05:00:32'),
(26, 'booking', 42, NULL, 17, 7, '30.00', 3000, 'CAD', 'stripe', 'requires_payment', 'pi_3T6kDNDwdNKzEorh11Tn0J56', NULL, '2026-03-03 04:05:47', '2026-03-08 05:00:32'),
(27, 'booking', 43, NULL, 17, 16, '45.00', 4500, 'CAD', 'stripe', 'requires_payment', 'pi_3T6kIXDwdNKzEorh2h5C34Rh', NULL, '2026-03-03 04:11:06', '2026-03-08 05:00:32'),
(28, 'booking', 44, NULL, 17, 16, '45.00', 4500, 'CAD', 'stripe', 'requires_payment', 'pi_3T6kKFDwdNKzEorh0hAkJqgb', NULL, '2026-03-03 04:12:52', '2026-03-08 05:00:32'),
(29, 'booking', 45, NULL, 17, 7, '30.00', 3000, 'CAD', 'stripe', 'requires_payment', 'pi_3T6kSBDwdNKzEorh10hLXs1D', NULL, '2026-03-03 04:21:04', '2026-03-08 05:00:32'),
(30, 'booking', 46, NULL, 19, 17, '24.03', 2403, 'CAD', 'stripe', 'succeeded', 'pi_3T6l5ODwdNKzEorh2drPwkGJ', NULL, '2026-03-03 05:01:35', '2026-03-08 05:00:32'),
(31, 'booking', 47, NULL, 19, 17, '24.03', 2403, 'CAD', 'stripe', 'succeeded', 'pi_3T6lSnDwdNKzEorh274TsjJc', NULL, '2026-03-03 05:25:46', '2026-03-08 05:00:32'),
(32, 'delivery', NULL, 11, 17, 19, '25.00', 2500, 'CAD', 'stripe', 'succeeded', 'pi_3T6yO0DwdNKzEorh2EiP7hvM', NULL, '2026-03-03 19:14:08', '2026-03-08 05:00:32'),
(33, 'delivery', NULL, 12, 17, 19, '25.00', 2500, 'CAD', 'stripe', 'succeeded', 'pi_3T6ydXDwdNKzEorh2dOExD2b', NULL, '2026-03-03 19:30:38', '2026-03-08 05:00:32'),
(34, 'booking', 48, NULL, 19, 17, '7.00', 700, 'CAD', 'stripe', 'requires_payment', 'pi_3T7GlYDwdNKzEorh1fFkvFq5', NULL, '2026-03-04 14:51:13', '2026-03-08 05:00:32'),
(35, 'delivery', NULL, 17, 19, 17, '411.92', 41192, 'CAD', 'stripe', 'succeeded', 'pi_3T7HSrDwdNKzEorh0xoZB19C', NULL, '2026-03-04 15:36:29', '2026-03-08 05:00:32'),
(36, 'booking', 49, NULL, 19, 17, '1043.10', 104310, 'CAD', 'stripe', 'succeeded', 'pi_3T7ICkDwdNKzEorh1QWGMIhW', NULL, '2026-03-04 16:23:23', '2026-03-08 05:00:32'),
(37, 'booking', 50, NULL, 19, 17, '2086.20', 208620, 'CAD', 'stripe', 'requires_payment', 'pi_3T7IdkDwdNKzEorh0lBy30ZJ', NULL, '2026-03-04 16:51:16', '2026-03-08 05:00:32'),
(38, 'booking', 51, NULL, 19, 17, '1043.10', 104310, 'CAD', 'stripe', 'succeeded', 'pi_3T7IeADwdNKzEorh0zKAJk4C', NULL, '2026-03-04 16:51:43', '2026-03-08 05:00:32'),
(39, 'booking', 52, NULL, 17, 19, '46.67', 4667, 'CAD', 'stripe', 'succeeded', 'pi_3T7KEwDwdNKzEorh0AoRHoHK', NULL, '2026-03-04 18:33:46', '2026-03-08 05:00:32'),
(40, 'delivery', NULL, 18, 17, 19, '25.00', 2500, 'CAD', 'stripe', 'succeeded', 'pi_3T7KFyDwdNKzEorh2n5HfFGq', NULL, '2026-03-04 18:35:04', '2026-03-08 05:00:32'),
(41, 'booking', 53, NULL, 17, 19, '46.67', 4667, 'CAD', 'stripe', 'succeeded', 'pi_3T7KxHDwdNKzEorh1LCRHUDi', NULL, '2026-03-04 19:19:36', '2026-03-08 05:00:32'),
(42, 'booking', 54, NULL, 17, 19, '46.67', 4667, 'CAD', 'stripe', 'succeeded', 'pi_3T7LAcDwdNKzEorh2K6ZTHS7', NULL, '2026-03-04 19:33:23', '2026-03-08 05:00:32'),
(43, 'booking', 55, NULL, 17, 19, '51.34', 5134, 'CAD', 'stripe', 'succeeded', 'pi_3T7LvRDwdNKzEorh1y5ib4iC', NULL, '2026-03-04 20:21:46', '2026-03-08 05:00:32'),
(44, 'delivery', NULL, 19, 17, 19, '25.00', 2500, 'CAD', 'stripe', 'succeeded', 'pi_3T7LwcDwdNKzEorh1S4FtASM', NULL, '2026-03-04 20:23:19', '2026-03-08 05:00:32'),
(45, 'delivery', NULL, 20, 17, 19, '25.00', 2500, 'CAD', 'stripe', 'succeeded', 'pi_3T7MDgDwdNKzEorh1PhhUTAV', NULL, '2026-03-04 20:40:49', '2026-03-08 05:00:32'),
(46, 'delivery', NULL, 21, 17, 19, '25.00', 2500, 'CAD', 'stripe', 'succeeded', 'pi_3T7MWnDwdNKzEorh15tG4GvO', NULL, '2026-03-04 21:00:34', '2026-03-08 05:00:32'),
(47, 'booking', 56, NULL, 19, 17, '7.70', 770, 'CAD', 'stripe', 'succeeded', 'pi_3T7MoPDwdNKzEorh18os7toF', NULL, '2026-03-04 21:18:34', '2026-03-08 05:00:32'),
(48, 'booking', 57, NULL, 19, 17, '7.70', 770, 'CAD', 'stripe', 'requires_payment', 'pi_3T7MpPDwdNKzEorh1mdtJD9R', NULL, '2026-03-04 21:19:36', '2026-03-08 05:00:32'),
(49, 'booking', 58, NULL, 17, 19, '51.34', 5134, 'CAD', 'stripe', 'succeeded', 'pi_3T7MpwDwdNKzEorh2pIcoXgp', NULL, '2026-03-04 21:20:09', '2026-03-08 05:00:32'),
(50, 'delivery', NULL, 22, 17, 19, '25.00', 2500, 'CAD', 'stripe', 'succeeded', 'pi_3T7MqdDwdNKzEorh2XzT3pcK', NULL, '2026-03-04 21:21:04', '2026-03-08 05:00:32'),
(51, 'booking', 59, NULL, 19, 17, '7.70', 770, 'CAD', 'stripe', 'succeeded', 'pi_3T7cmoDwdNKzEorh1uvvJ7gD', NULL, '2026-03-05 14:22:01', '2026-03-08 05:00:32'),
(52, 'delivery', NULL, 23, 19, 17, '411.92', 41192, 'CAD', 'stripe', 'succeeded', 'pi_3T7cpiDwdNKzEorh2E1WJdzA', NULL, '2026-03-05 14:25:13', '2026-03-08 05:00:32'),
(53, 'booking', 60, NULL, 19, 17, '220.00', 22000, 'CAD', 'stripe', 'succeeded', 'pi_3T7cvGDwdNKzEorh023GIvev', NULL, '2026-03-05 14:30:44', '2026-03-08 05:00:32'),
(54, 'delivery', NULL, 24, 19, 17, '45.00', 4500, 'CAD', 'stripe', 'succeeded', 'pi_3T7cwGDwdNKzEorh1gy04zUX', NULL, '2026-03-05 14:32:00', '2026-03-08 05:00:32'),
(55, 'booking', 61, NULL, 19, 17, '110.00', 11000, 'CAD', 'stripe', 'succeeded', 'pi_3T7dk7DwdNKzEorh07axwmg5', NULL, '2026-03-05 15:23:17', '2026-03-08 05:00:32'),
(56, 'booking', 62, NULL, 19, 17, '88.08', 8808, 'CAD', 'stripe', 'refunded', 'pi_3T8bKTDwdNKzEorh2N0BnqUJ', NULL, '2026-03-08 07:00:48', '2026-03-09 02:12:35'),
(57, 'delivery', NULL, 25, 19, 17, '35.08', 3508, 'CAD', 'stripe', 'succeeded', 'pi_3T8bLmDwdNKzEorh1FMfCWt4', NULL, '2026-03-08 07:02:22', '2026-03-08 05:00:32'),
(58, NULL, 63, NULL, 19, 17, '88.08', 0, 'CAD', 'stripe', 'succeeded', 'pi_3T8tLaDwdNKzEorh1yMXKC8K', NULL, '2026-03-09 02:15:07', '2026-03-09 02:15:20'),
(59, NULL, NULL, 26, 19, 17, '35.08', 0, 'CAD', 'stripe', 'succeeded', 'pi_3T8tMRDwdNKzEorh1fso9G9W', NULL, '2026-03-09 02:16:12', '2026-03-09 02:16:12');

-- --------------------------------------------------------

--
-- Structure de la table `payouts`
--

CREATE TABLE IF NOT EXISTS `payouts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `batch_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `currency` char(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CAD',
  `status` enum('queued','sent','paid','failed') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'queued',
  `payout_method` enum('manual','stripe_connect') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'manual',
  `destination` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payout_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payout_phone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provider_reference` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `failure_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `paid_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_payouts_batch` (`batch_id`),
  KEY `idx_payouts_user` (`user_id`,`created_at`),
  KEY `idx_payouts_status` (`status`,`created_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Contenu de la table `payouts`
--

INSERT INTO `payouts` (`id`, `batch_id`, `user_id`, `amount`, `currency`, `status`, `payout_method`, `destination`, `payout_email`, `payout_phone`, `provider_reference`, `failure_reason`, `created_at`, `updated_at`, `paid_at`) VALUES
(1, 1, 8, '135.00', 'CAD', 'paid', 'manual', 'david.chen@gmail.com', NULL, NULL, NULL, NULL, '2026-02-28 20:22:16', '2026-02-28 20:22:16', NULL),
(2, 2, 7, '68.00', 'CAD', 'queued', 'manual', 'amelie.roy@outlook.com', NULL, NULL, NULL, NULL, '2026-02-28 20:22:16', '2026-02-28 20:22:16', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `payout_batches`
--

CREATE TABLE IF NOT EXISTS `payout_batches` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `scheduled_for_date` date NOT NULL,
  `status` enum('draft','ready','processing','paid','failed','cancelled') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'draft',
  `provider` enum('interac','bank_transfer','wise','manual') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'manual',
  `created_by_admin_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notes` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `idx_payout_batches_date` (`scheduled_for_date`,`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Contenu de la table `payout_batches`
--

INSERT INTO `payout_batches` (`id`, `scheduled_for_date`, `status`, `provider`, `created_by_admin_id`, `created_at`, `updated_at`, `notes`) VALUES
(1, '2026-02-26', 'paid', 'manual', 4, '2026-02-28 20:22:16', '2026-02-28 20:22:16', NULL),
(2, '2026-03-05', 'draft', 'manual', 4, '2026-02-28 20:22:16', '2026-02-28 20:22:16', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `platform_fee_settings`
--

CREATE TABLE IF NOT EXISTS `platform_fee_settings` (
  `id` int(10) unsigned NOT NULL DEFAULT '1',
  `booking_fee_pct` decimal(5,2) NOT NULL DEFAULT '10.00',
  `booking_fee_fixed_cents` int(11) NOT NULL DEFAULT '0',
  `delivery_fee_pct` decimal(5,2) NOT NULL DEFAULT '10.00',
  `delivery_fee_fixed_cents` int(11) NOT NULL DEFAULT '0',
  `hold_days_before_available` int(11) NOT NULL DEFAULT '7',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Contenu de la table `platform_fee_settings`
--

INSERT INTO `platform_fee_settings` (`id`, `booking_fee_pct`, `booking_fee_fixed_cents`, `delivery_fee_pct`, `delivery_fee_fixed_cents`, `hold_days_before_available`, `created_at`, `updated_at`) VALUES
(1, '10.00', 0, '10.00', 0, 7, '2026-03-08 05:00:32', '2026-03-08 05:00:32');

-- --------------------------------------------------------

--
-- Structure de la table `platform_settings`
--

CREATE TABLE IF NOT EXISTS `platform_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deliveries_min_hours_before_departure` int(11) NOT NULL DEFAULT '2',
  `deliveries_min_minutes_before_departure` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `platform_settings`
--

INSERT INTO `platform_settings` (`id`, `deliveries_min_hours_before_departure`, `deliveries_min_minutes_before_departure`, `created_at`, `updated_at`) VALUES
(1, 2, 0, '2026-03-03 11:52:38', '2026-03-03 11:52:38');

-- --------------------------------------------------------

--
-- Structure de la table `refunds`
--

CREATE TABLE IF NOT EXISTS `refunds` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `payment_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `amount_cents` bigint(20) NOT NULL DEFAULT '0',
  `currency` char(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CAD',
  `status` enum('pending','succeeded','failed') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stripe_refund_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_refunds_stripe` (`stripe_refund_id`),
  KEY `idx_refunds_payment` (`payment_id`),
  KEY `idx_refunds_status` (`status`,`created_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Contenu de la table `refunds`
--

INSERT INTO `refunds` (`id`, `payment_id`, `amount`, `amount_cents`, `currency`, `status`, `reason`, `stripe_refund_id`, `created_at`, `updated_at`) VALUES
(1, 10, '25.00', 2500, 'CAD', 'succeeded', 'Annulation par le passager — remboursement intégral.', 'rf_fake_seed_001', '2026-02-28 20:22:15', '2026-03-08 05:00:33'),
(2, 49, '51.34', 0, 'CAD', 'succeeded', 'Dispute resolved: refund to customer. c''est ok remboursé', 're_3T7MpwDwdNKzEorh2ErBjEWN', '2026-03-08 09:08:49', '2026-03-08 09:08:49'),
(3, 56, '88.08', 0, 'CAD', 'succeeded', 'Cancelled by driver', 're_3T8bKTDwdNKzEorh2XiVQW7O', '2026-03-09 02:12:35', '2026-03-09 02:12:35');

-- --------------------------------------------------------

--
-- Structure de la table `refund_policies`
--

CREATE TABLE IF NOT EXISTS `refund_policies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` enum('booking','delivery') COLLATE utf8mb4_unicode_ci NOT NULL,
  `actor_role` enum('passenger','sender','driver','admin') COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `min_hours_before_departure` smallint(5) unsigned NOT NULL DEFAULT '0',
  `refund_request_deadline_hours` smallint(5) unsigned NOT NULL DEFAULT '0',
  `cancellation_fee_fixed_cents` int(10) unsigned NOT NULL DEFAULT '0',
  `cancellation_fee_percent` decimal(5,2) NOT NULL DEFAULT '0.00',
  `refund_percent_to_customer` decimal(5,2) NOT NULL DEFAULT '100.00',
  `driver_compensation_percent` decimal(5,2) NOT NULL DEFAULT '0.00',
  `applies_when_statuses` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` smallint(6) NOT NULL DEFAULT '0',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_refund_policies_lookup` (`resource_type`,`actor_role`,`active`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=10 ;

--
-- Contenu de la table `refund_policies`
--

INSERT INTO `refund_policies` (`id`, `resource_type`, `actor_role`, `name`, `active`, `min_hours_before_departure`, `refund_request_deadline_hours`, `cancellation_fee_fixed_cents`, `cancellation_fee_percent`, `refund_percent_to_customer`, `driver_compensation_percent`, `applies_when_statuses`, `priority`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'booking', 'passenger', 'Passager >24h avant départ', 1, 24, 48, 0, '0.00', '100.00', '0.00', 'pending,accepted,paid', 30, 'Remboursement total si annulation >24h avant départ', '2026-03-08 04:55:48', '2026-03-08 04:55:48'),
(2, 'booking', 'passenger', 'Passager 6-24h avant départ', 1, 6, 48, 0, '0.00', '50.00', '25.00', 'pending,accepted,paid', 20, 'Remboursement 50% si annulation 6-24h avant départ', '2026-03-08 04:55:48', '2026-03-08 04:55:48'),
(3, 'booking', 'passenger', 'Passager <6h avant départ', 1, 0, 48, 0, '0.00', '0.00', '50.00', 'pending,accepted,paid', 10, 'Aucun remboursement si annulation <6h avant départ', '2026-03-08 04:55:48', '2026-03-08 04:55:48'),
(4, 'booking', 'driver', 'Conducteur annule booking', 1, 0, 0, 0, '0.00', '100.00', '0.00', 'pending,accepted,paid', 10, 'Remboursement total passager si conducteur annule', '2026-03-08 04:55:48', '2026-03-08 04:55:48'),
(5, 'delivery', 'sender', 'Expéditeur >12h avant départ', 1, 12, 24, 0, '0.00', '100.00', '0.00', 'pending,accepted,paid', 20, 'Remboursement total si annulation >12h avant départ', '2026-03-08 04:55:48', '2026-03-08 04:55:48'),
(6, 'delivery', 'sender', 'Expéditeur <12h avant départ', 1, 0, 24, 0, '0.00', '50.00', '25.00', 'pending,accepted,paid', 10, 'Remboursement 50% si annulation <12h avant départ', '2026-03-08 04:55:48', '2026-03-08 04:55:48'),
(7, 'delivery', 'driver', 'Conducteur annule delivery', 1, 0, 0, 0, '0.00', '100.00', '0.00', 'pending,accepted,paid', 10, 'Remboursement total expéditeur si conducteur annule', '2026-03-08 04:55:48', '2026-03-08 04:55:48'),
(8, 'booking', 'admin', 'Admin override booking', 1, 0, 0, 0, '0.00', '100.00', '0.00', 'pending,accepted,paid,completed', 100, 'Admin peut toujours annuler/rembourser', '2026-03-08 04:55:48', '2026-03-08 04:55:48'),
(9, 'delivery', 'admin', 'Admin override delivery', 1, 0, 0, 0, '0.00', '100.00', '0.00', 'pending,accepted,paid,in_transit,delivered', 100, 'Admin peut toujours annuler/rembourser', '2026-03-08 04:55:48', '2026-03-08 04:55:48');

-- --------------------------------------------------------

--
-- Structure de la table `reports`
--

CREATE TABLE IF NOT EXISTS `reports` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reporter_id` bigint(20) unsigned NOT NULL,
  `target_type` enum('user','trip','booking','delivery','message','review') COLLATE utf8_unicode_ci NOT NULL,
  `target_id` bigint(20) unsigned NOT NULL,
  `reason` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `details` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('open','resolved','rejected') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'open',
  `resolved_by_admin_id` bigint(20) unsigned DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_reports_status` (`status`,`created_at`),
  KEY `idx_reports_target` (`target_type`,`target_id`),
  KEY `fk_reports_reporter` (`reporter_id`),
  KEY `fk_reports_resolver` (`resolved_by_admin_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Contenu de la table `reports`
--

INSERT INTO `reports` (`id`, `reporter_id`, `target_type`, `target_id`, `reason`, `details`, `status`, `resolved_by_admin_id`, `resolved_at`, `created_at`) VALUES
(1, 10, 'user', 15, 'Comportement inapproprié', 'Cet utilisateur a envoyé des messages offensants lors d''un trajet précédent.', 'resolved', 4, '2026-02-27 13:00:00', '2026-02-28 20:22:16'),
(2, 11, 'trip', 9, 'Trajet suspect', 'Le prix semblait anormalement bas et le conducteur ne répondait pas aux messages.', 'open', NULL, NULL, '2026-02-28 20:22:16');

-- --------------------------------------------------------

--
-- Structure de la table `reviews`
--

CREATE TABLE IF NOT EXISTS `reviews` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `booking_id` bigint(20) unsigned DEFAULT NULL,
  `delivery_id` bigint(20) unsigned DEFAULT NULL,
  `rating` tinyint(3) unsigned NOT NULL,
  `comment` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_reviews_target` (`target_user_id`,`created_at`),
  KEY `idx_reviews_author` (`author_id`,`created_at`),
  KEY `fk_reviews_booking` (`booking_id`),
  KEY `fk_reviews_delivery` (`delivery_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=18 ;

--
-- Contenu de la table `reviews`
--

INSERT INTO `reviews` (`id`, `author_id`, `target_user_id`, `booking_id`, `delivery_id`, `rating`, `comment`, `created_at`) VALUES
(1, 10, 8, 6, NULL, 5, 'Excellent trajet! David est très ponctuel et sa voiture est super confortable. Je recommande!', '2026-02-19 13:00:00'),
(2, 11, 8, 7, NULL, 4, 'Great ride from Toronto to Ottawa. Smooth driving, nice conversation. Would ride again!', '2026-02-19 13:00:00'),
(3, 8, 10, 6, NULL, 5, 'Lucas est un passager idéal. Ponctuel, poli et agréable. Bienvenu à tout moment!', '2026-02-19 13:00:00'),
(4, 8, 11, 7, NULL, 5, 'Emma is a wonderful passenger. Very respectful and great to chat with.', '2026-02-19 13:00:00'),
(5, 12, 7, 8, NULL, 5, 'Amélie est super! Son RAV4 est spacieux et elle conduit prudemment. Merci!', '2026-02-24 13:00:00'),
(6, 13, 7, 9, NULL, 4, 'Bon trajet, voiture propre. Un peu de retard au départ mais rien de grave.', '2026-02-24 13:00:00'),
(7, 7, 12, 8, NULL, 5, 'Olivier est très sympathique et respectueux. Passager 5 étoiles!', '2026-02-24 13:00:00'),
(8, 14, 7, NULL, 4, 5, 'Colis livré en parfait état et dans les temps. Merci Amélie!', '2026-02-24 13:00:00'),
(9, 6, 16, 15, NULL, 5, 'Olank est un conducteur exceptionnel! Tesla impeccable, conduite douce, et super conversation. 10/10!', '2026-02-22 13:00:00'),
(10, 7, 16, 16, NULL, 5, 'Meilleur covoiturage de ma vie. La voiture électrique c''est le futur! Merci Olank.', '2026-02-22 13:00:00'),
(11, 8, 16, 17, NULL, 4, 'Très bon trajet, ponctuel et agréable. L''arrêt café à Hawkesbury était une bonne idée!', '2026-02-22 13:00:00'),
(12, 9, 16, 18, NULL, 5, 'Olank est super sympa et son Highlander est très confortable pour les longs trajets.', '2026-02-15 13:00:00'),
(13, 10, 16, 19, NULL, 5, 'Excellent conducteur, très professionnel. Le trajet Québec-Montréal était parfait.', '2026-02-15 13:00:00'),
(14, 8, 16, NULL, 6, 5, 'Documents livrés en parfait état et dans les temps. Service impeccable!', '2026-02-22 13:00:00'),
(15, 16, 6, 15, NULL, 5, 'Passager idéal, ponctuel et très agréable. Bienvenu à tout moment!', '2026-02-22 13:00:00'),
(16, 16, 7, 16, NULL, 5, 'Super passager, conversation intéressante pendant tout le trajet!', '2026-02-22 13:00:00'),
(17, 16, 8, 17, NULL, 4, 'Bon passager, un peu en retard au départ mais sinon parfait.', '2026-02-22 13:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `setting_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updated_by_admin_id` bigint(20) unsigned DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_settings_key` (`setting_key`),
  KEY `fk_settings_admin` (`updated_by_admin_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

--
-- Contenu de la table `settings`
--

INSERT INTO `settings` (`id`, `setting_key`, `setting_value`, `updated_by_admin_id`, `updated_at`) VALUES
(4, 'platform_fee_percent', '10', 4, '2026-02-28 20:22:16'),
(5, 'min_payout_amount', '10.00', 4, '2026-02-28 20:22:16'),
(6, 'hold_delay_days', '7', 4, '2026-02-28 20:22:16'),
(7, 'payout_frequency_days', '7', 4, '2026-02-28 20:22:16'),
(8, 'max_seats_per_booking', '4', 4, '2026-02-28 20:22:16'),
(9, 'default_currency', 'CAD', 4, '2026-02-28 20:22:16'),
(10, 'support_email', 'support@asapjoin.ca', 4, '2026-02-28 20:22:16'),
(11, 'maintenance_mode', 'false', 4, '2026-02-28 20:22:16');

-- --------------------------------------------------------

--
-- Structure de la table `stripe_events`
--

CREATE TABLE IF NOT EXISTS `stripe_events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `stripe_event_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `processed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `payload_json` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_stripe_events_event` (`stripe_event_id`),
  KEY `idx_stripe_events_type` (`type`,`processed_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Contenu de la table `stripe_events`
--

INSERT INTO `stripe_events` (`id`, `stripe_event_id`, `type`, `processed_at`, `payload_json`) VALUES
(1, 'evt_fake_seed_001', 'payment_intent.succeeded', '2026-02-18 13:00:00', '{"id":"pi_fake_seed_004","amount":4500,"currency":"cad"}'),
(2, 'evt_fake_seed_002', 'payment_intent.succeeded', '2026-02-18 13:00:00', '{"id":"pi_fake_seed_005","amount":9000,"currency":"cad"}'),
(3, 'evt_fake_seed_003', 'charge.refunded', '2026-02-26 13:00:00', '{"id":"ch_fake_seed_010","amount_refunded":2500,"currency":"cad"}');

-- --------------------------------------------------------

--
-- Structure de la table `trips`
--

CREATE TABLE IF NOT EXISTS `trips` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `driver_id` bigint(20) unsigned NOT NULL,
  `vehicle_id` bigint(20) unsigned NOT NULL,
  `from_city` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `to_city` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `from_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `to_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `departure_at` datetime NOT NULL,
  `price_per_seat` decimal(12,2) NOT NULL DEFAULT '0.00',
  `currency` char(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CAD',
  `seats_total` tinyint(3) unsigned NOT NULL,
  `seats_available` tinyint(3) unsigned NOT NULL,
  `booking_mode` enum('instant','manual') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'manual',
  `status` enum('draft','published','unpublished','cancelled','completed') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'draft',
  `rules_json` text COLLATE utf8_unicode_ci,
  `accepts_parcels` tinyint(1) NOT NULL DEFAULT '0',
  `parcel_max_size` enum('XS','S','M','L') COLLATE utf8_unicode_ci DEFAULT NULL,
  `parcel_max_weight_kg` decimal(8,2) DEFAULT NULL,
  `parcel_prohibited_items` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parcel_price_mode` enum('fixed','by_size','by_distance') COLLATE utf8_unicode_ci DEFAULT NULL,
  `parcel_base_price` decimal(12,2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  `delivery_mode` enum('manual','instant') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'manual',
  PRIMARY KEY (`id`),
  KEY `idx_trips_search` (`from_city`,`to_city`,`departure_at`),
  KEY `idx_trips_driver` (`driver_id`),
  KEY `idx_trips_published` (`status`,`departure_at`),
  KEY `idx_trips_accepts_parcels` (`accepts_parcels`,`departure_at`),
  KEY `fk_trips_vehicle` (`vehicle_id`),
  KEY `idx_trips_delivery_mode` (`delivery_mode`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=30 ;

--
-- Contenu de la table `trips`
--

INSERT INTO `trips` (`id`, `driver_id`, `vehicle_id`, `from_city`, `to_city`, `from_address`, `to_address`, `departure_at`, `price_per_seat`, `currency`, `seats_total`, `seats_available`, `booking_mode`, `status`, `rules_json`, `accepts_parcels`, `parcel_max_size`, `parcel_max_weight_kg`, `parcel_prohibited_items`, `parcel_price_mode`, `parcel_base_price`, `created_at`, `updated_at`, `deleted_at`, `delivery_mode`) VALUES
(1, 6, 1, 'Montréal', 'Québec', '1000 Rue Sherbrooke O, Montréal, QC H3A 3G4', '900 Boulevard René-Lévesque E, Québec, QC G1R 2B5', '2026-03-03 13:00:00', '35.00', 'CAD', 3, 0, 'instant', 'published', '["Pas de nourriture odorante","Musique à volume modéré"]', 1, 'M', '10.00', NULL, 'fixed', '15.00', '2026-02-28 20:22:15', '2026-03-02 22:39:51', NULL, 'manual'),
(2, 7, 2, 'Québec', 'Montréal', '2700 Boulevard Laurier, Québec, QC G1V 2L8', '1500 Rue Peel, Montréal, QC H3A 1S9', '2026-03-05 19:00:00', '30.00', 'CAD', 4, 0, 'manual', 'published', '["Animaux acceptés","Bagages dans le coffre SVP"]', 1, 'L', '20.00', NULL, 'by_size', '10.00', '2026-02-28 20:22:15', '2026-03-02 23:21:03', NULL, 'manual'),
(3, 8, 3, 'Ottawa', 'Toronto', '111 Wellington St, Ottawa, ON K1A 0A6', '100 Queen St W, Toronto, ON M5H 2N2', '2026-03-02 12:00:00', '45.00', 'CAD', 3, 2, 'instant', 'published', '["Pas de fumée","Ponctualité appréciée"]', 1, 'S', '5.00', NULL, 'fixed', '20.00', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, 'manual'),
(4, 9, 4, 'Toronto', 'Hamilton', '1 Dundas St W, Toronto, ON M5G 1Z3', '71 Main St W, Hamilton, ON L8P 4Y5', '2026-03-01 22:00:00', '15.00', 'CAD', 4, 1, 'instant', 'published', '["Pas de bagages volumineux"]', 0, NULL, NULL, NULL, NULL, NULL, '2026-02-28 20:22:15', '2026-03-01 01:59:32', NULL, 'manual'),
(5, 6, 5, 'Montréal', 'Sherbrooke', '800 Rue de la Gauchetière O, Montréal, QC H5A 1K6', '191 Rue du Palais, Sherbrooke, QC J1H 5C5', '2026-03-07 14:00:00', '25.00', 'CAD', 4, 0, 'manual', 'published', NULL, 1, 'M', '15.00', NULL, 'fixed', '12.00', '2026-02-28 20:22:15', '2026-03-02 22:05:48', NULL, 'manual'),
(6, 6, 1, 'Montréal', 'Ottawa', '1000 Rue Sherbrooke O, Montréal, QC H3A 3G4', '111 Wellington St, Ottawa, ON K1A 0A6', '2026-03-10 10:00:00', '40.00', 'CAD', 3, 3, 'instant', 'draft', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, 'manual'),
(7, 8, 3, 'Toronto', 'Ottawa', '100 Queen St W, Toronto, ON M5H 2N2', '111 Wellington St, Ottawa, ON K1A 0A6', '2026-02-18 13:00:00', '45.00', 'CAD', 3, 0, 'instant', 'completed', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, 'manual'),
(8, 7, 2, 'Québec', 'Trois-Rivières', '2700 Boulevard Laurier, Québec, QC G1V 2L8', '1325 Place de l''Hôtel-de-Ville, Trois-Rivières, QC G9A 5L3', '2026-02-23 15:00:00', '20.00', 'CAD', 4, 1, 'manual', 'completed', NULL, 1, 'S', '5.00', NULL, 'fixed', '8.00', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, 'manual'),
(9, 6, 1, 'Montréal', 'Québec', '1000 Rue Sherbrooke O, Montréal, QC H3A 3G4', '900 Boulevard René-Lévesque E, Québec, QC G1R 2B5', '2026-02-25 12:00:00', '35.00', 'CAD', 3, 3, 'instant', 'cancelled', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, 'manual'),
(10, 9, 4, 'Toronto', 'Niagara Falls', '1 Dundas St W, Toronto, ON M5G 1Z3', '6650 Niagara Pkwy, Niagara Falls, ON L2E 6X8', '2026-03-04 15:00:00', '20.00', 'CAD', 4, 0, 'instant', 'published', '["Excursion touristique, bonne humeur obligatoire! ?"]', 0, NULL, NULL, NULL, NULL, NULL, '2026-02-28 20:22:15', '2026-03-02 23:00:57', NULL, 'manual'),
(11, 16, 6, 'Montréal', 'Ottawa', '1001 Boulevard de Maisonneuve O, Montréal, QC H3A 3C8', '150 Elgin St, Ottawa, ON K2P 1L4', '2026-03-02 12:00:00', '35.00', 'CAD', 3, 1, 'instant', 'published', '["Voiture électrique — pas de fumée","Musique lo-fi pendant le trajet ?","Ponctualité SVP"]', 1, 'M', '10.00', NULL, 'fixed', '15.00', '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL, 'manual'),
(12, 16, 7, 'Montréal', 'Québec', '800 Rue de la Gauchetière O, Montréal, QC H5A 1K6', '900 Boulevard René-Lévesque E, Québec, QC G1R 2B5', '2026-03-06 14:00:00', '30.00', 'CAD', 5, 0, 'manual', 'published', '["Animaux acceptés ?","Gros coffre disponible pour bagages"]', 1, 'L', '25.00', NULL, 'by_size', '10.00', '2026-02-28 20:35:43', '2026-03-02 23:01:58', NULL, 'manual'),
(13, 16, 6, 'Ottawa', 'Toronto', '111 Wellington St, Ottawa, ON K1A 0A6', '1 Dundas St W, Toronto, ON M5G 1Z3', '2026-03-09 10:00:00', '45.00', 'CAD', 3, 0, 'instant', 'published', '["Départ tôt le matin","Arrêt café à Kingston"]', 0, NULL, NULL, NULL, NULL, NULL, '2026-02-28 20:35:43', '2026-03-02 23:12:51', NULL, 'manual'),
(14, 16, 6, 'Montréal', 'Sherbrooke', '1001 Boulevard de Maisonneuve O, Montréal, QC H3A 3C8', '191 Rue du Palais, Sherbrooke, QC J1H 5C5', '2026-03-14 14:00:00', '25.00', 'CAD', 3, 3, 'instant', 'draft', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL, 'manual'),
(15, 16, 6, 'Montréal', 'Ottawa', '1001 Boulevard de Maisonneuve O, Montréal, QC H3A 3C8', '150 Elgin St, Ottawa, ON K2P 1L4', '2026-02-21 13:00:00', '35.00', 'CAD', 3, 0, 'instant', 'completed', NULL, 1, 'S', '5.00', NULL, 'fixed', '12.00', '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL, 'manual'),
(16, 16, 7, 'Québec', 'Montréal', '2700 Boulevard Laurier, Québec, QC G1V 2L8', '1500 Rue Peel, Montréal, QC H3A 1S9', '2026-02-14 20:00:00', '30.00', 'CAD', 5, 1, 'manual', 'completed', NULL, 1, 'M', '10.00', NULL, 'fixed', '10.00', '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL, 'manual'),
(17, 16, 6, 'Montréal', 'Toronto', '1001 Boulevard de Maisonneuve O, Montréal, QC H3A 3C8', '100 Queen St W, Toronto, ON M5H 2N2', '2026-02-25 11:00:00', '55.00', 'CAD', 3, 3, 'instant', 'cancelled', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL, 'manual'),
(18, 16, 7, 'Montréal, QC', 'Moncton, NB', 'Montréal, QC', 'Moncton, NB', '2026-03-01 15:00:00', '35.00', 'CAD', 4, 4, 'manual', 'published', NULL, 1, NULL, NULL, NULL, NULL, NULL, '2026-03-01 03:37:02', '2026-03-02 08:53:55', NULL, 'manual'),
(19, 16, 7, 'Québec, QC', 'Montréal, QC', 'Québec, QC', 'Montréal, QC', '2026-03-02 13:00:00', '150.00', 'CAD', 4, 4, 'manual', 'published', NULL, 1, NULL, NULL, NULL, NULL, '2500.00', '2026-03-01 03:59:45', '2026-03-02 08:53:41', NULL, 'manual'),
(20, 17, 8, 'Montréal, QC', 'Moncton, NB', 'Montréal, QC', 'Moncton, NB', '2026-03-03 12:00:00', '95.00', 'CAD', 4, 4, 'manual', 'published', NULL, 1, NULL, NULL, NULL, NULL, '4129.00', '2026-03-01 06:59:10', '2026-03-02 08:54:11', NULL, 'manual'),
(21, 17, 9, 'Montréal, QC', 'quebec', 'Montréal, QC', 'quebec', '2026-03-03 16:00:00', '30.00', 'CAD', 4, 4, 'manual', 'published', NULL, 0, NULL, NULL, NULL, NULL, NULL, '2026-03-01 07:08:36', '2026-03-02 08:54:24', NULL, 'manual'),
(22, 17, 10, 'Montréal, QC', 'Edmonton, AB', 'Montréal, QC', 'Edmonton, AB', '2026-03-11 10:00:00', '1043.10', 'CAD', 4, 0, 'manual', 'published', NULL, 1, NULL, NULL, NULL, NULL, '411.92', '2026-03-03 02:34:30', '2026-03-04 11:51:42', NULL, 'manual'),
(23, 17, 10, 'Edmonton, AB', 'Montréal, QC', 'Edmonton, AB', 'Montréal, QC', '2026-03-04 15:00:00', '376.23', 'CAD', 4, 2, 'manual', 'published', NULL, 1, NULL, NULL, NULL, NULL, '150.97', '2026-03-03 03:08:24', '2026-03-02 22:09:23', NULL, 'manual'),
(24, 17, 8, 'Montréal, QC', 'Ottawa, ON', 'Montréal, QC', 'Ottawa, ON', '2026-03-04 13:00:00', '24.03', 'CAD', 12, 10, 'manual', 'published', NULL, 1, NULL, NULL, NULL, NULL, '13.15', '2026-03-03 05:00:37', '2026-03-03 00:25:45', NULL, 'manual'),
(25, 19, 11, 'Ottawa, ON', 'Québec, QC', 'Ottawa, ON', 'Québec, QC', '2026-03-05 12:00:00', '46.67', 'CAD', 8, 3, 'manual', 'published', NULL, 1, NULL, NULL, NULL, NULL, '25.00', '2026-03-03 05:28:50', '2026-03-04 16:20:08', NULL, 'manual'),
(26, 17, 10, 'ottawa', 'Gatineau, QC', 'ottawa', 'Gatineau, QC', '2026-03-05 20:00:00', '7.00', 'CAD', 4, 0, 'manual', 'published', NULL, 1, NULL, NULL, NULL, NULL, NULL, '2026-03-04 14:46:24', '2026-03-05 09:21:59', NULL, 'manual'),
(27, 17, 8, 'Montréal, QC', 'Moncton, NB', 'Montréal, QC', 'Moncton, NB', '2026-03-06 13:00:00', '100.00', 'CAD', 4, 1, 'manual', 'published', NULL, 1, NULL, NULL, NULL, NULL, '45.00', '2026-03-05 14:30:01', '2026-03-05 10:23:16', NULL, 'manual'),
(28, 19, 11, 'Longueuil, QC', 'Moncton, NB', 'Longueuil, QC', 'Moncton, NB', '2026-03-10 11:00:00', '95.30', 'CAD', 5, 5, 'manual', 'published', NULL, 1, NULL, NULL, NULL, NULL, NULL, '2026-03-08 06:58:14', '2026-03-08 06:58:14', NULL, 'manual'),
(29, 17, 10, 'Québec, QC', 'Toronto, ON', 'Québec, QC', 'Toronto, ON', '2026-03-13 11:00:00', '80.07', 'CAD', 5, 4, 'manual', 'published', NULL, 1, NULL, NULL, NULL, NULL, '35.08', '2026-03-08 07:00:06', '2026-03-08 22:15:06', NULL, 'manual');

-- --------------------------------------------------------

--
-- Structure de la table `trip_stops`
--

CREATE TABLE IF NOT EXISTS `trip_stops` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `trip_id` bigint(20) unsigned NOT NULL,
  `stop_order` int(11) NOT NULL,
  `city` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `eta_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_trip_stop_order` (`trip_id`,`stop_order`),
  KEY `idx_trip_stops_trip` (`trip_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Contenu de la table `trip_stops`
--

INSERT INTO `trip_stops` (`id`, `trip_id`, `stop_order`, `city`, `address`, `eta_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 'Trois-Rivières', '1325 Place de l''Hôtel-de-Ville, Trois-Rivières, QC G9A 5L3', '2026-03-03 15:00:00', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(2, 3, 1, 'Kingston', '216 Ontario St, Kingston, ON K7L 2Z3', '2026-03-02 14:00:00', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(3, 5, 1, 'Granby', '87 Rue Principale, Granby, QC J2G 2T8', '2026-03-07 15:00:00', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(4, 7, 1, 'Kingston', '216 Ontario St, Kingston, ON K7L 2Z3', '2026-02-18 16:00:00', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(5, 7, 2, 'Brockville', '1 King St W, Brockville, ON K6V 3P7', '2026-02-18 17:00:00', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(6, 11, 1, 'Hawkesbury', '600 Rue McGill, Hawkesbury, ON K6A 1R5', '2026-03-02 14:00:00', '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(7, 12, 1, 'Trois-Rivières', '1325 Place de l''Hôtel-de-Ville, Trois-Rivières, QC G9A 5L3', '2026-03-06 16:00:00', '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(8, 12, 2, 'Drummondville', '415 Rue Lindsay, Drummondville, QC J2B 1G4', '2026-03-06 15:00:00', '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(9, 13, 1, 'Kingston', '216 Ontario St, Kingston, ON K7L 2Z3', '2026-03-09 13:00:00', '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(10, 15, 1, 'Hawkesbury', '600 Rue McGill, Hawkesbury, ON K6A 1R5', '2026-02-21 15:00:00', '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_url` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payout_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payout_phone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bio` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive','banned') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `role` enum('user','support','admin') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'user',
  `default_mode` enum('passenger','driver','sender') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'passenger',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  `avatar_url` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_banned` tinyint(1) NOT NULL DEFAULT '0',
  `last_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `refresh_token` text COLLATE utf8_unicode_ci,
  `reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_token_expiry` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=20 ;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`id`, `email`, `password_hash`, `display_name`, `photo_url`, `phone_number`, `payout_email`, `payout_phone`, `bio`, `status`, `role`, `default_mode`, `created_at`, `updated_at`, `deleted_at`, `avatar_url`, `email_verified`, `first_name`, `is_banned`, `last_name`, `refresh_token`, `reset_token`, `reset_token_expiry`) VALUES
(4, 'admin@asapjoin.ca', '$2b$12$CEF2Fob6aPyc7sMnWsyFw.EQElnxHQ/GkbR7R2DCJez06EJcQk2cS', 'Admin Sophie', NULL, '+1-514-555-0100', NULL, NULL, 'Administratrice de la plateforme AsapJoin.', 'active', 'admin', 'passenger', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, 1, 'Sophie', 0, 'Tremblay', NULL, NULL, NULL),
(5, 'support@asapjoin.ca', '$2b$12$CEF2Fob6aPyc7sMnWsyFw.EQElnxHQ/GkbR7R2DCJez06EJcQk2cS', 'Support Marc', NULL, '+1-514-555-0101', NULL, NULL, 'Agent de support AsapJoin.', 'active', 'support', 'passenger', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, 1, 'Marc', 0, 'Gagnon', NULL, NULL, NULL),
(6, 'jean.lavoie@gmail.com', '$2b$12$CEF2Fob6aPyc7sMnWsyFw.EQElnxHQ/GkbR7R2DCJez06EJcQk2cS', 'Jean L.', NULL, '+1-514-555-0201', 'jean.lavoie@gmail.com', NULL, 'Conducteur régulier Montréal-Québec. Voiture confortable, musique chill.', 'active', 'user', 'driver', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, 1, 'Jean', 0, 'Lavoie', NULL, NULL, NULL),
(7, 'amelie.roy@outlook.com', '$2b$12$CEF2Fob6aPyc7sMnWsyFw.EQElnxHQ/GkbR7R2DCJez06EJcQk2cS', 'Amélie R.', NULL, '+1-418-555-0202', 'amelie.roy@outlook.com', NULL, 'Je fais le trajet Québec-Montréal chaque semaine. Animaux bienvenus! ?', 'active', 'user', 'driver', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, 1, 'Amélie', 0, 'Roy', NULL, NULL, NULL),
(8, 'david.chen@gmail.com', '$2b$12$CEF2Fob6aPyc7sMnWsyFw.EQElnxHQ/GkbR7R2DCJez06EJcQk2cS', 'David C.', NULL, '+1-613-555-0203', 'david.chen@gmail.com', NULL, 'Trajet Ottawa-Toronto fréquent. SUV spacieux, idéal pour les colis aussi.', 'active', 'user', 'driver', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, 1, 'David', 0, 'Chen', NULL, NULL, NULL),
(9, 'fatima.benali@yahoo.ca', '$2b$12$CEF2Fob6aPyc7sMnWsyFw.EQElnxHQ/GkbR7R2DCJez06EJcQk2cS', 'Fatima B.', NULL, '+1-416-555-0204', 'fatima.benali@yahoo.ca', NULL, 'Conductrice Toronto-Hamilton et GTA. Ponctuelle et sympathique.', 'active', 'user', 'driver', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, 1, 'Fatima', 0, 'Benali', NULL, NULL, NULL),
(10, 'lucas.bergeron@gmail.com', '$2b$12$CEF2Fob6aPyc7sMnWsyFw.EQElnxHQ/GkbR7R2DCJez06EJcQk2cS', 'Lucas B.', NULL, '+1-514-555-0301', NULL, NULL, 'Étudiant à l''Université de Montréal. Je voyage souvent le weekend.', 'active', 'user', 'passenger', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, 1, 'Lucas', 0, 'Bergeron', NULL, NULL, NULL),
(11, 'emma.wilson@hotmail.com', '$2b$12$CEF2Fob6aPyc7sMnWsyFw.EQElnxHQ/GkbR7R2DCJez06EJcQk2cS', 'Emma W.', NULL, '+1-416-555-0302', NULL, NULL, 'Professionnelle à Toronto. Covoiturage pour réduire mon empreinte carbone.', 'active', 'user', 'passenger', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, 1, 'Emma', 0, 'Wilson', NULL, NULL, NULL),
(12, 'olivier.cote@gmail.com', '$2b$12$CEF2Fob6aPyc7sMnWsyFw.EQElnxHQ/GkbR7R2DCJez06EJcQk2cS', 'Olivier C.', NULL, '+1-819-555-0303', NULL, NULL, 'Basé à Sherbrooke, je me déplace souvent vers Montréal.', 'active', 'user', 'passenger', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, 1, 'Olivier', 0, 'Côté', NULL, NULL, NULL),
(13, 'sarah.nguyen@gmail.com', '$2b$12$CEF2Fob6aPyc7sMnWsyFw.EQElnxHQ/GkbR7R2DCJez06EJcQk2cS', 'Sarah N.', NULL, '+1-604-555-0304', NULL, NULL, 'Nouvelle à Vancouver, j''explore le Canada en covoiturage!', 'active', 'user', 'passenger', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, 1, 'Sarah', 0, 'Nguyen', NULL, NULL, NULL),
(14, 'maxime.pelletier@outlook.com', '$2b$12$CEF2Fob6aPyc7sMnWsyFw.EQElnxHQ/GkbR7R2DCJez06EJcQk2cS', 'Maxime P.', NULL, '+1-450-555-0305', NULL, NULL, 'Expéditeur de colis fréquent entre Montréal et Québec.', 'active', 'user', 'sender', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, 1, 'Maxime', 0, 'Pelletier', NULL, NULL, NULL),
(15, 'banned.user@test.com', '$2b$12$CEF2Fob6aPyc7sMnWsyFw.EQElnxHQ/GkbR7R2DCJez06EJcQk2cS', 'Pierre D.', NULL, '+1-514-555-0999', NULL, NULL, 'Compte suspendu.', 'banned', 'user', 'passenger', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL, NULL, 1, 'Pierre', 1, 'Dubois', NULL, NULL, NULL),
(16, 'olank@gmail.com', '$2b$12$uAbT3W5xWGfDmFjEYL6ehO0w/ij1a9DqhXM0SMzHrdFkDEmskAv62', 'Olank', NULL, '+1-514-555-7777', 'olank@gmail.com', NULL, 'Passionné de covoiturage et de voyages à travers le Canada. Conducteur et passager régulier sur la route Montréal-Ottawa. ?', 'active', 'admin', 'sender', '2026-02-28 20:35:43', '2026-03-01 07:15:38', NULL, NULL, 1, 'Olivier', 0, 'Lankoandé', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxNiIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc3MjM0OTMzNywiZXhwIjoxNzcyOTU0MTM3fQ.E-xIKGFsL9gueFn1z9MVG9eDRhM8SvSiHerUuqLTwrk', NULL, NULL),
(17, 'ioued@gmail.com', '$2b$12$e2JBIYYWkoBPf8OBKwdh4uhuyiSbztUO9UsIRJcVK63NeAxR.Fpim', 'isaac ouedraogo', NULL, '4384830515', 'olankoande@gmail.com', NULL, NULL, 'active', 'user', 'passenger', '2026-03-01 06:11:21', '2026-03-09 03:50:06', NULL, NULL, 0, 'ousmane', 0, 'lankoande', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxNyIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzczMDI4MjA2LCJleHAiOjE3NzM2MzMwMDZ9.shoFK66DOKygcMoZggck7-6PApWFZf3bLmD9_dLicYA', NULL, NULL),
(18, 'olankoande@yahoo.fr', '$2b$12$UgKzQE148lBt8KeCx.42gOBioGFR3sHgQRZU.QgYngX1Kj.fmom/6', 'ousmane lankoande', NULL, '4384830515', NULL, NULL, NULL, 'active', 'admin', 'passenger', '2026-03-01 07:16:50', '2026-03-09 03:58:50', NULL, NULL, 0, 'ousmane', 0, 'lankoande', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxOCIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc3MzAyODczMCwiZXhwIjoxNzczNjMzNTMwfQ.qNVhK8YN6W2FNG3PcHZVKGgPYoCtCxM27x5QaDfAa-A', NULL, NULL),
(19, 'osmlankoande@gmail.com', '$2b$12$0NfJhnH2.MX/lI7haxvMnO7tlYfgnZyMo5OT.nTtgsWUH2YO3KbrG', 'ismael lankoande', NULL, '4384830515', NULL, NULL, NULL, 'active', 'user', 'passenger', '2026-03-03 02:52:44', '2026-03-09 04:01:40', NULL, NULL, 0, 'ismael', 0, 'lankoande', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxOSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzczMDI4ODk5LCJleHAiOjE3NzM2MzM2OTl9.F6_nxL81-Mfjb2TFDgz2-O8JoIril33gXnVsh6_jQJs', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `vehicles`
--

CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `make` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `year` smallint(5) unsigned DEFAULT NULL,
  `color` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `plate` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seats_count` tinyint(3) unsigned NOT NULL DEFAULT '4',
  `has_ac` tinyint(1) NOT NULL DEFAULT '0',
  `notes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_vehicles_user` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

--
-- Contenu de la table `vehicles`
--

INSERT INTO `vehicles` (`id`, `user_id`, `make`, `model`, `year`, `color`, `plate`, `seats_count`, `has_ac`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 6, 'Honda', 'Civic', 2022, 'Bleu', 'ABC 1234', 4, 1, 'Très propre, chargeur USB disponible.', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(2, 7, 'Toyota', 'RAV4', 2023, 'Blanc', 'QC 5678', 4, 1, 'SUV spacieux, coffre grand pour les bagages.', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(3, 8, 'Hyundai', 'Tucson', 2021, 'Gris', 'ON 9012', 4, 1, 'Hybride, conduite douce. Accepte les colis.', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(4, 9, 'Mazda', 'CX-5', 2024, 'Rouge', 'ON 3456', 4, 1, 'Neuf, sièges chauffants.', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(5, 6, 'Subaru', 'Outback', 2020, 'Vert forêt', 'QC 7890', 4, 1, 'AWD, parfait pour l''hiver canadien.', '2026-02-28 20:22:15', '2026-02-28 20:22:15', NULL),
(6, 16, 'Tesla', 'Model 3', 2024, 'Noir', 'QC OLNK', 4, 1, 'Électrique, silencieuse, chargeur USB-C pour tous. Autopilot activé.', '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(7, 16, 'Toyota', 'Highlander', 2022, 'Gris métallique', 'QC 4521', 6, 1, 'SUV familial, idéal pour les groupes et les colis volumineux. AWD.', '2026-02-28 20:35:43', '2026-02-28 20:35:43', NULL),
(8, 17, 'kia', 'sorento', 2026, 'rouge', 'AMH 12L', 4, 0, NULL, '2026-03-01 06:57:45', '2026-03-01 06:57:45', NULL),
(9, 17, 'toyota', 'yaris', 2020, 'noir', 'ABC 456', 4, 0, NULL, '2026-03-01 07:07:47', '2026-03-01 07:30:09', '2026-03-01 07:30:09'),
(10, 17, 'toyota ', 'Camry', 2024, 'vert', 'AHK 14A', 4, 1, NULL, '2026-03-02 13:55:53', '2026-03-02 13:55:53', NULL),
(11, 19, 'hyunday', 'versa', 2019, 'noir', 'ase 125', 6, 1, NULL, '2026-03-03 05:28:46', '2026-03-03 05:28:46', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `wallets`
--

CREATE TABLE IF NOT EXISTS `wallets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `currency` char(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CAD',
  `pending_cents` bigint(20) NOT NULL DEFAULT '0',
  `available_cents` bigint(20) NOT NULL DEFAULT '0',
  `pending_balance` decimal(12,2) NOT NULL DEFAULT '0.00',
  `available_balance` decimal(12,2) NOT NULL DEFAULT '0.00',
  `status` enum('active','blocked') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_wallets_user` (`user_id`),
  KEY `idx_wallets_user` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Contenu de la table `wallets`
--

INSERT INTO `wallets` (`id`, `user_id`, `currency`, `pending_cents`, `available_cents`, `pending_balance`, `available_balance`, `status`, `created_at`, `updated_at`) VALUES
(3, 6, 'CAD', 7000, 0, '70.00', '0.00', 'active', '2026-02-28 20:22:15', '2026-03-08 05:00:32'),
(4, 7, 'CAD', 0, 6800, '0.00', '68.00', 'active', '2026-02-28 20:22:15', '2026-03-08 05:00:32'),
(5, 8, 'CAD', 2000, 13500, '20.00', '135.00', 'active', '2026-02-28 20:22:15', '2026-03-08 05:00:32'),
(6, 9, 'CAD', 4000, 0, '40.00', '0.00', 'active', '2026-02-28 20:22:15', '2026-03-08 05:00:32'),
(7, 16, 'CAD', 7000, 27200, '70.00', '272.00', 'active', '2026-02-28 20:35:44', '2026-03-08 05:00:32'),
(8, 17, 'CAD', 49506, 0, '495.06', '0.00', 'active', '2026-03-01 06:11:21', '2026-03-08 22:16:11'),
(9, 18, 'CAD', 0, 0, '0.00', '0.00', 'active', '2026-03-01 07:16:50', '2026-03-01 07:16:50'),
(10, 19, 'CAD', -4242, 0, '-42.42', '0.00', 'active', '2026-03-03 02:52:44', '2026-03-08 05:08:49');

-- --------------------------------------------------------

--
-- Structure de la table `wallet_transactions`
--

CREATE TABLE IF NOT EXISTS `wallet_transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `wallet_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `direction` enum('credit','debit') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'credit',
  `amount_cents` bigint(20) NOT NULL DEFAULT '0',
  `status` enum('pending','posted','reversed') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'posted',
  `txn_type` varchar(60) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'adjustment',
  `type` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `currency` char(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CAD',
  `reason_code` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reference_type` enum('booking','delivery','refund','payout','adjustment','payment','payout_batch','dispute','system') COLLATE utf8_unicode_ci NOT NULL,
  `reference_id` bigint(20) unsigned DEFAULT NULL,
  `snapshot_json` text COLLATE utf8_unicode_ci,
  `balance_bucket` enum('pending','available') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_wallet_tx_wallet` (`wallet_id`,`created_at`),
  KEY `idx_wallet_tx_reference` (`reference_type`,`reference_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=36 ;

--
-- Contenu de la table `wallet_transactions`
--

INSERT INTO `wallet_transactions` (`id`, `wallet_id`, `user_id`, `direction`, `amount_cents`, `status`, `txn_type`, `type`, `amount`, `currency`, `reason_code`, `reference_type`, `reference_id`, `snapshot_json`, `balance_bucket`, `created_at`) VALUES
(1, 3, NULL, 'credit', 3500, 'posted', 'adjustment', 'credit', '35.00', 'CAD', 'booking_payment', 'booking', 1, NULL, 'pending', '2026-02-28 20:22:15'),
(2, 3, NULL, 'credit', 3500, 'posted', 'adjustment', 'credit', '35.00', 'CAD', 'booking_payment', 'booking', 2, NULL, 'pending', '2026-02-28 20:22:15'),
(3, 4, NULL, 'credit', 4000, 'posted', 'adjustment', 'credit', '40.00', 'CAD', 'booking_payment', 'booking', 8, NULL, 'available', '2026-02-24 13:00:00'),
(4, 4, NULL, 'credit', 2000, 'posted', 'adjustment', 'credit', '20.00', 'CAD', 'booking_payment', 'booking', 9, NULL, 'available', '2026-02-24 13:00:00'),
(5, 4, NULL, 'credit', 800, 'posted', 'adjustment', 'credit', '8.00', 'CAD', 'delivery_payment', 'delivery', 4, NULL, 'available', '2026-02-24 13:00:00'),
(6, 5, NULL, 'credit', 4500, 'posted', 'adjustment', 'credit', '45.00', 'CAD', 'booking_payment', 'booking', 6, NULL, 'available', '2026-02-19 13:00:00'),
(7, 5, NULL, 'credit', 9000, 'posted', 'adjustment', 'credit', '90.00', 'CAD', 'booking_payment', 'booking', 7, NULL, 'available', '2026-02-19 13:00:00'),
(8, 5, NULL, 'credit', 2000, 'posted', 'adjustment', 'credit', '20.00', 'CAD', 'delivery_payment', 'delivery', 3, NULL, 'pending', '2026-02-28 20:22:15'),
(9, 6, NULL, 'credit', 4000, 'posted', 'adjustment', 'credit', '40.00', 'CAD', 'booking_payment', 'booking', 5, NULL, 'pending', '2026-02-28 20:22:15'),
(10, 7, NULL, 'credit', 3500, 'posted', 'adjustment', 'credit', '35.00', 'CAD', 'booking_payment', 'booking', 12, NULL, 'pending', '2026-02-28 20:35:44'),
(11, 7, NULL, 'credit', 3500, 'posted', 'adjustment', 'credit', '35.00', 'CAD', 'booking_payment', 'booking', 13, NULL, 'pending', '2026-02-28 20:35:44'),
(12, 7, NULL, 'credit', 3500, 'posted', 'adjustment', 'credit', '35.00', 'CAD', 'booking_payment', 'booking', 15, NULL, 'available', '2026-02-22 13:00:00'),
(13, 7, NULL, 'credit', 3500, 'posted', 'adjustment', 'credit', '35.00', 'CAD', 'booking_payment', 'booking', 16, NULL, 'available', '2026-02-22 13:00:00'),
(14, 7, NULL, 'credit', 3500, 'posted', 'adjustment', 'credit', '35.00', 'CAD', 'booking_payment', 'booking', 17, NULL, 'available', '2026-02-22 13:00:00'),
(15, 7, NULL, 'credit', 6000, 'posted', 'adjustment', 'credit', '60.00', 'CAD', 'booking_payment', 'booking', 18, NULL, 'available', '2026-02-15 13:00:00'),
(16, 7, NULL, 'credit', 6000, 'posted', 'adjustment', 'credit', '60.00', 'CAD', 'booking_payment', 'booking', 19, NULL, 'available', '2026-02-15 13:00:00'),
(17, 7, NULL, 'credit', 1200, 'posted', 'adjustment', 'credit', '12.00', 'CAD', 'delivery_payment', 'delivery', 6, NULL, 'available', '2026-02-22 13:00:00'),
(18, 8, NULL, 'credit', 2403, 'posted', 'adjustment', 'TRIP_CREDIT', '24.03', 'CAD', NULL, 'payment', 30, NULL, 'pending', '2026-03-03 05:01:58'),
(19, 8, NULL, 'credit', 2403, 'posted', 'adjustment', 'TRIP_CREDIT', '24.03', 'CAD', NULL, 'payment', 31, NULL, 'pending', '2026-03-03 05:26:13'),
(20, 10, NULL, 'credit', 2500, 'posted', 'adjustment', 'DELIVERY_CREDIT', '25.00', 'CAD', NULL, 'payment', 11, NULL, 'pending', '2026-03-03 19:14:08'),
(21, 10, NULL, 'credit', 2500, 'posted', 'adjustment', 'DELIVERY_CREDIT', '25.00', 'CAD', NULL, 'payment', 12, NULL, 'pending', '2026-03-03 19:30:38'),
(22, 8, NULL, 'credit', 41192, 'posted', 'adjustment', 'DELIVERY_CREDIT', '411.92', 'CAD', NULL, 'payment', 17, NULL, 'pending', '2026-03-04 15:36:29'),
(23, 10, 19, 'debit', 4621, 'posted', 'dispute_hold', 'dispute_hold', '46.21', 'CAD', NULL, 'dispute', 1, NULL, 'available', '2026-03-08 05:03:26'),
(24, 10, 0, 'debit', 5134, 'posted', 'refund', 'refund', '51.34', 'CAD', NULL, 'refund', 2, '{"refund_amount_cents":5134,"original_fees":{"fee_pct":10,"fee_fixed_cents":0,"gross_cents":5134,"platform_fee_cents":513,"driver_net_cents":4621,"kind":"booking","computed_at":"2026-03-08T09:08:48.004Z"},"is_already_available":false}', 'available', '2026-03-08 05:08:49'),
(25, 10, 0, 'credit', 513, 'posted', 'refund_commission_reversal', 'refund_commission_reversal', '5.13', 'CAD', NULL, 'refund', 2, '{"refund_amount_cents":5134,"original_fees":{"fee_pct":10,"fee_fixed_cents":0,"gross_cents":5134,"platform_fee_cents":513,"driver_net_cents":4621,"kind":"booking","computed_at":"2026-03-08T09:08:48.004Z"},"is_already_available":false}', 'pending', '2026-03-08 05:08:49'),
(26, 10, 19, 'debit', 4621, 'posted', 'refund_driver_debit', 'refund_driver_debit', '46.21', 'CAD', NULL, 'refund', 2, '{"refund_amount_cents":5134,"original_fees":{"fee_pct":10,"fee_fixed_cents":0,"gross_cents":5134,"platform_fee_cents":513,"driver_net_cents":4621,"kind":"booking","computed_at":"2026-03-08T09:08:48.004Z"},"is_already_available":false}', 'available', '2026-03-08 05:08:49'),
(27, 8, 0, 'debit', 8808, 'posted', 'refund', 'refund', '88.08', 'CAD', NULL, 'refund', 3, '{"gross_amount_cents":8808,"platform_fee_cents":801,"driver_net_cents":8007,"policy_id":"4","policy_name":"Conducteur annule booking","actor_role":"driver","resource_type":"booking","refund_percent_to_customer":100,"cancellation_fee_fixed_cents":0,"cancellation_fee_percent":0,"driver_compensation_percent":0,"calculated_refund_cents":8808,"calculated_fee_cents":0,"driver_reversal_cents":8007,"commission_reversal_cents":801,"driver_compensation_cents":0,"computed_at":"2026-03-09T02:12:33.543Z"}', 'available', '2026-03-08 22:12:34'),
(28, 8, 0, 'credit', 801, 'posted', 'refund_commission_reversal', 'refund_commission_reversal', '8.01', 'CAD', NULL, 'refund', 3, '{"gross_amount_cents":8808,"platform_fee_cents":801,"driver_net_cents":8007,"policy_id":"4","policy_name":"Conducteur annule booking","actor_role":"driver","resource_type":"booking","refund_percent_to_customer":100,"cancellation_fee_fixed_cents":0,"cancellation_fee_percent":0,"driver_compensation_percent":0,"calculated_refund_cents":8808,"calculated_fee_cents":0,"driver_reversal_cents":8007,"commission_reversal_cents":801,"driver_compensation_cents":0,"computed_at":"2026-03-09T02:12:33.543Z"}', 'pending', '2026-03-08 22:12:34'),
(29, 8, 17, 'debit', 8007, 'posted', 'refund_driver_debit', 'refund_driver_debit', '80.07', 'CAD', NULL, 'refund', 3, '{"gross_amount_cents":8808,"platform_fee_cents":801,"driver_net_cents":8007,"policy_id":"4","policy_name":"Conducteur annule booking","actor_role":"driver","resource_type":"booking","refund_percent_to_customer":100,"cancellation_fee_fixed_cents":0,"cancellation_fee_percent":0,"driver_compensation_percent":0,"calculated_refund_cents":8808,"calculated_fee_cents":0,"driver_reversal_cents":8007,"commission_reversal_cents":801,"driver_compensation_cents":0,"computed_at":"2026-03-09T02:12:33.543Z"}', 'available', '2026-03-08 22:12:34'),
(30, 8, 0, 'credit', 8808, 'posted', 'booking_payment', 'booking_payment', '88.08', 'CAD', NULL, 'booking', 63, '{"fee_pct":10,"fee_fixed_cents":0,"gross_cents":8808,"platform_fee_cents":801,"driver_net_cents":8007,"kind":"booking","computed_at":"2026-03-09T02:15:20.278Z"}', 'pending', '2026-03-08 22:15:20'),
(31, 8, 0, 'debit', 801, 'posted', 'platform_commission', 'platform_commission', '8.01', 'CAD', NULL, 'booking', 63, '{"fee_pct":10,"fee_fixed_cents":0,"gross_cents":8808,"platform_fee_cents":801,"driver_net_cents":8007,"kind":"booking","computed_at":"2026-03-09T02:15:20.278Z"}', 'available', '2026-03-08 22:15:20'),
(32, 8, 17, 'credit', 8007, 'posted', 'driver_credit_pending', 'driver_credit_pending', '80.07', 'CAD', NULL, 'booking', 63, '{"fee_pct":10,"fee_fixed_cents":0,"gross_cents":8808,"platform_fee_cents":801,"driver_net_cents":8007,"kind":"booking","computed_at":"2026-03-09T02:15:20.278Z"}', 'pending', '2026-03-08 22:15:20'),
(33, 8, 0, 'credit', 3859, 'posted', 'delivery_payment', 'delivery_payment', '38.59', 'CAD', NULL, 'delivery', 26, '{"fee_pct":10,"fee_fixed_cents":0,"gross_cents":3859,"platform_fee_cents":351,"driver_net_cents":3508,"kind":"delivery","computed_at":"2026-03-09T02:16:11.972Z"}', 'pending', '2026-03-08 22:16:11'),
(34, 8, 0, 'debit', 351, 'posted', 'platform_commission', 'platform_commission', '3.51', 'CAD', NULL, 'delivery', 26, '{"fee_pct":10,"fee_fixed_cents":0,"gross_cents":3859,"platform_fee_cents":351,"driver_net_cents":3508,"kind":"delivery","computed_at":"2026-03-09T02:16:11.972Z"}', 'available', '2026-03-08 22:16:11'),
(35, 8, 17, 'credit', 3508, 'posted', 'driver_credit_pending', 'driver_credit_pending', '35.08', 'CAD', NULL, 'delivery', 26, '{"fee_pct":10,"fee_fixed_cents":0,"gross_cents":3859,"platform_fee_cents":351,"driver_net_cents":3508,"kind":"delivery","computed_at":"2026-03-09T02:16:11.972Z"}', 'pending', '2026-03-08 22:16:11');

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `admin_audit_logs`
--
ALTER TABLE `admin_audit_logs`
  ADD CONSTRAINT `fk_admin_audit_logs_admin` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `fk_bookings_passenger` FOREIGN KEY (`passenger_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_bookings_trip` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`);

--
-- Contraintes pour la table `cancellation_policy_rules`
--
ALTER TABLE `cancellation_policy_rules`
  ADD CONSTRAINT `fk_policy_rules_policy` FOREIGN KEY (`policy_id`) REFERENCES `cancellation_policies` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `conversations`
--
ALTER TABLE `conversations`
  ADD CONSTRAINT `fk_conversations_booking` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_conversations_delivery` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `conversation_participants`
--
ALTER TABLE `conversation_participants`
  ADD CONSTRAINT `fk_cp_conversation` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cp_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `deliveries`
--
ALTER TABLE `deliveries`
  ADD CONSTRAINT `fk_deliveries_parcel` FOREIGN KEY (`parcel_id`) REFERENCES `parcels` (`id`),
  ADD CONSTRAINT `fk_deliveries_recipient` FOREIGN KEY (`recipient_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_deliveries_sender` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_deliveries_trip` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`);

--
-- Contraintes pour la table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `fk_messages_conversation` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_messages_sender` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_booking` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`),
  ADD CONSTRAINT `fk_payments_delivery` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`),
  ADD CONSTRAINT `fk_payments_payee` FOREIGN KEY (`payee_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_payments_payer` FOREIGN KEY (`payer_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `payouts`
--
ALTER TABLE `payouts`
  ADD CONSTRAINT `fk_payouts_batch` FOREIGN KEY (`batch_id`) REFERENCES `payout_batches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_payouts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `refunds`
--
ALTER TABLE `refunds`
  ADD CONSTRAINT `fk_refunds_payment` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`);

--
-- Contraintes pour la table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `fk_reports_reporter` FOREIGN KEY (`reporter_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_reports_resolver` FOREIGN KEY (`resolved_by_admin_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_reviews_booking` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_reviews_delivery` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_reviews_target` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `settings`
--
ALTER TABLE `settings`
  ADD CONSTRAINT `fk_settings_admin` FOREIGN KEY (`updated_by_admin_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `trips`
--
ALTER TABLE `trips`
  ADD CONSTRAINT `fk_trips_driver` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_trips_vehicle` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`);

--
-- Contraintes pour la table `trip_stops`
--
ALTER TABLE `trip_stops`
  ADD CONSTRAINT `fk_trip_stops_trip` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `vehicles`
--
ALTER TABLE `vehicles`
  ADD CONSTRAINT `fk_vehicles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `wallets`
--
ALTER TABLE `wallets`
  ADD CONSTRAINT `fk_wallets_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  ADD CONSTRAINT `fk_wallet_transactions_wallet` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
