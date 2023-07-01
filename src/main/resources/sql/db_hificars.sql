CREATE DATABASE IF NOT EXISTS `db_hificars`;
USE `db_hificars`;

--
-- Table structure for table `listing`
--
DROP TABLE IF EXISTS `listing`;
CREATE TABLE `listing` (
  `listing_id` bigint NOT NULL AUTO_INCREMENT,
  `make` varchar(30) NOT NULL,
  `model` varchar(50) NOT NULL,
  `reg_year` int NOT NULL,
  `image` varchar(64) NOT NULL,
  `mileage` INT NOT NULL,
  `description` text DEFAULT NULL,
  `min_price` DECIMAL(10, 2) NOT NULL,
  `end_time` datetime NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT NOW(),
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`listing_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_listing_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
);

--
-- Table structure for table `bid`
--
DROP TABLE IF EXISTS `bid`;
CREATE TABLE `bid` (
  `bid_id` bigint NOT NULL AUTO_INCREMENT,
  `bid_price` DECIMAL(10, 2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT NOW(),
  `listing_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`bid_id`),
  KEY `listing_id` (`listing_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `listing_bid_fk` FOREIGN KEY (`listing_id`) REFERENCES `listing` (`listing_id`),
  CONSTRAINT `user_bid_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
);

--
-- Table structure for table `role`
--
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
	`role_id` bigint NOT NULL AUTO_INCREMENT,
    `role_name` varchar(50) NOT NULL,
    PRIMARY KEY (`role_id`)
);

--
-- Table structure for table `user`
--
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
	`user_id` bigint NOT NULL AUTO_INCREMENT,
    `user_name` varchar(30) NOT NULL,
    `email` varchar(255) NOT NULL,
    `password` varchar(64) NOT NULL,
    `created_at` datetime NOT NULL DEFAULT NOW(),
    PRIMARY KEY (`user_id`)
);

--
-- Table structure for table `user_role`
--
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
	`user_id` bigint NOT NULL,
    `role_id` bigint NOT NULL,
    KEY `user_fk_idx` (`user_id`),
    KEY `role_fk_idx` (`role_id`),
    CONSTRAINT `role_fk` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
    CONSTRAINT `user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
);