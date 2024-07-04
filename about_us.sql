-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 04, 2024 at 04:27 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `about_us`
--

CREATE TABLE `about_us` (
  `id` int(11) NOT NULL,
  `id_parent` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `background` varchar(255) NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT 1,
  `images` varchar(255) DEFAULT NULL,
  `image_position` varchar(255) DEFAULT 'left',
  `active` int(11) DEFAULT NULL,
  `sorts` int(11) NOT NULL DEFAULT 9999,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_croatian_ci COMMENT='about_us';

--
-- Dumping data for table `about_us`
--

INSERT INTO `about_us` (`id`, `id_parent`, `title`, `subtitle`, `link`, `description`, `background`, `type`, `images`, `image_position`, `active`, `sorts`, `created_at`) VALUES
(72, NULL, 'Reimagining Your Digital Future Together', NULL, NULL, '<p>IT Consultis is an award-winning Digital Transformation Consultancy in China and APAC, empowering the most ambitious Fortune 500 companies with the right strategy &amp; execution playbook leveraging MarTech, e-Commerce, and Omnichannel solutions to grow revenue and build customer loyalty.</p><p><br>&nbsp;</p>', '', 1, '', NULL, NULL, 1, '2024-07-04 16:27:47'),
(73, NULL, '', NULL, NULL, '<p>Our team consists of 60+ highly motivated talents from 14 different nationalities based in 3 countries across Asia, from Shanghai, China, to Saigon, Vietnam, and Singapore.</p>', '#870000', 1, '', '', NULL, 2, '2024-07-04 16:28:25'),
(75, NULL, 'The 4 Pillars to Realize Our Vision for Your Success', NULL, 'https://tailwindui.com/components/application-ui/headings/page-headings', '<p>ITC offers a wide range of strategy consulting and technology development services for various industries worldwide. Ultimately, we help our clients develop the best strategies and playbook set-up along with the right digital enablers to achieve their objectives in China, Asia, and other markets.</p><p>Find your next success path with our combined strategic and technology expertise.</p><p>&nbsp;</p>', '', 2, '', '', NULL, 3, '2024-07-04 17:09:49'),
(76, 75, 'Digital Transformation Audit, Omnichannel, Loyalty, & Go-To-Market Strategy', NULL, NULL, '', '', 1, '/uploads/img.svg', NULL, NULL, 0, '2024-07-04 17:09:49'),
(78, 75, 'Marketing Automation, CRM, CDP, Social CRM, & WeCom Clienteling', NULL, NULL, '', '', 1, '/uploads/img.svg', NULL, NULL, 2, '2024-07-04 17:09:49'),
(79, 75, 'Tailor-Made Digital and Commerce Experiences & System Integration', NULL, NULL, '', '', 1, '/uploads/img.svg', NULL, NULL, 3, '2024-07-04 17:09:49'),
(80, 75, 'Digital Transformation Audit, Omnichannel, Loyalty, & Go-To-Market Strategy', NULL, NULL, '', '', 1, '/uploads/img.svg', NULL, NULL, 4, '2024-07-04 17:09:49'),
(84, NULL, 'TOP DIGITAL STRATEGY AGENCY CHINA 2023', 'TOP DIGITAL STRATEGY AGENCY CHINA 2023', 'https://tailwindui.com/components/application-ui/headings/page-headings', '<p>Problem-solvers at heart, we firmly believe that we can do everything we set our minds to. Challenges are here for us to tackle - Obstacle is the Way. New knowledge and skills are keys to helping service our clients to beat their competitors. Our commitment is to find solutions to any problem we encounter. We never give up until we find the best way forward. “We figure it out” is more than a value we hold, it is a way of life for us.</p>', '', 3, '/uploads/Digital-award.png', 'right', NULL, 4, '2024-07-04 17:12:08'),
(88, NULL, 'Our Core Values', NULL, NULL, '<p>Our core values define ITC, tie us together, and shape our every action. They drive our business growth to help our clients succeed</p>', '', 4, '', 'left', NULL, 5, '2024-07-04 18:01:07'),
(89, 88, 'We Figure It Out', NULL, NULL, '<p>We are set for collective success. We believe in the power of teamwork and support, and we are always willing to lend a hand to help our colleagues and make an unstoppable team. We are a resilient group, always striving for results and motivated by a shared passion and excitement for what we do.</p>', '', 1, '/uploads/Digital-award.png', 'left', NULL, 0, '2024-07-04 18:01:07'),
(90, 88, 'We Own It', NULL, NULL, '<p>We are set for collective success. We believe in the power of teamwork and support, and we are always willing to lend a hand to help our colleagues and make an unstoppable team. We are a resilient group, always striving for results and motivated by a shared passion and excitement for what we do.</p>', '', 1, '/uploads/Digital-award.png', 'left', NULL, 1, '2024-07-04 18:01:07'),
(91, 88, 'We Figure It Out', NULL, NULL, '<p>We are set for collective success. We believe in the power of teamwork and support, and we are always willing to lend a hand to help our colleagues and make an unstoppable team. We are a resilient group, always striving for results and motivated by a shared passion and excitement for what we do.</p>', '', 1, '/uploads/Digital-award.png', 'left', NULL, 2, '2024-07-04 18:01:07'),
(103, NULL, 'Leadership', NULL, NULL, '', '', 5, '', 'left', NULL, 6, '2024-07-04 18:05:53'),
(104, 103, 'Yoan Rigart Lenisa', NULL, NULL, '<p><strong>Co-Founder, CEO</strong></p><p>&nbsp;</p><p>“A natural leader with a strategic vision for the long-term development of the companies. Coordinating all finance, HR, and legal-related operations. Ensuring the companies always go in the right direction and each employee is well taken care of, both at a professional and personal level.”</p>', '', 1, '/uploads/Aurelien-Rigart-IT-Consultis-768x1024.png', 'left', NULL, 0, '2024-07-04 18:05:53'),
(105, 103, 'Yoan Rigart Lenisa', NULL, NULL, '<p><strong>Co-Founder, CEO</strong></p><p>&nbsp;</p><p>“A natural leader with a strategic vision for the long-term development of the companies. Coordinating all finance, HR, and legal-related operations. Ensuring the companies always go in the right direction and each employee is well taken care of, both at a professional and personal level.”</p>', '', 1, '/uploads/Aurelien-Rigart-IT-Consultis-768x1024.png', 'left', NULL, 1, '2024-07-04 18:05:53');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `about_us`
--
ALTER TABLE `about_us`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `about_us`
--
ALTER TABLE `about_us`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
