-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 14, 2025 at 01:46 PM
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
-- Database: `mylgroup`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `telegramId` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT 'admin',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`telegramId`, `username`, `fullName`, `role`, `createdAt`, `updatedAt`) VALUES
('6105157221', 'liyu0970', 'Liyuwork kebede', 'admin', '2025-02-14 12:00:07', '2025-02-14 12:00:07'),
('939330930', 'ednamb', 'Ednam Bizuwork', 'superadmin', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` int(11) NOT NULL,
  `description` varchar(50) NOT NULL,
  `document` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `description`, `document`) VALUES
(14, 'guid2', '1737380780187-payslip8753090093.pdf.pdf'),
(15, 'cost sharing', '1738152081707-cost sharing0001.pdf'),
(16, 'ITexamanswers.net – CCNA 1 (v5.1 + v6.0) Chapter 1', '1738217937279-ITexamanswers.net â CCNA 1 (v5.1 + v6.0) Chapter 1 Exam Answers Full.pdf'),
(17, 'ITexamanswers.net – CCNA 1 (v5.1 + v6.0) Chapter 4', '1738217956865-ITexamanswers.net â CCNA 1 (v5.1 + v6.0) Chapter 4 Exam Answers Full.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `JOB_ID` int(11) NOT NULL,
  `COMPANY` varchar(50) NOT NULL,
  `DESCRIPTION` varchar(200) NOT NULL,
  `JOB_TITLE` varchar(50) NOT NULL,
  `LOCATION` varchar(50) NOT NULL,
  `SALARY` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`JOB_ID`, `COMPANY`, `DESCRIPTION`, `JOB_TITLE`, `LOCATION`, `SALARY`) VALUES
(1, 'CBE', 'IS  customer support ', 'IS officer III', 'Robe', 24000),
(2, 'cisco', 'router configeration', 'Network administrator I', 'Addis ababa', 5000);

-- --------------------------------------------------------

--
-- Table structure for table `new_users`
--

CREATE TABLE `new_users` (
  `userid` int(11) NOT NULL,
  `username` varchar(25) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `Role` varchar(20) NOT NULL,
  `status` int(11) NOT NULL,
  `FirstName` varchar(25) NOT NULL,
  `LastName` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `new_users`
--

INSERT INTO `new_users` (`userid`, `username`, `password`, `Role`, `status`, `FirstName`, `LastName`, `email`, `timestamp`) VALUES
(3, 'mb123456', '$2b$10$wh353e8N3UsI5xxAEJ8D3.oJmmMtQALbfOSu11u7TH.Ls3NsvS.s.', 'admin', 0, 'mandefro', 'bizuwork', 'mandeb717@gmail.com', '2025-01-17 16:39:23'),
(4, 'blen123456', '$2b$10$47irmlWRrh55zqnSrqJy9ewRDGMIP/iSLQR77Q.eYwZr5q8jtCwl.', 'customer', 0, 'Blen', 'Kebede', 'blen@gmail.com', '2025-01-17 16:40:12'),
(6, '123456', '$2b$10$pSOsHRA6fz0GgPSb.ec1LuPlDje45S6pgMY2jTX9W.rnAoR/SdjI.', 'customer', 0, 'kitaw', 'Kitaw', 'Josy@gmail.com', '2025-01-20 17:40:44'),
(7, 'user@example.com', '$2b$10$gvMn1q4VGZ7WZlO2fhqRH.QRe7KDTNRU8xz5gbqi8n2eHdL0uwVPm', '', 0, 'jhg', 'vc', 'nkg', '2025-01-29 16:16:02'),
(8, '1fffsfddddddd', '$2b$10$ZHFH0C118/7CIuzMANdgUOtoPF9Jh3.5C4/7yR62M4Yzn2VJ8LqEC', '', 0, 'mmmmm', 'ghgfhf', 'email222@gmail.com', '2025-01-30 15:15:00'),
(9, 'fdgfgfgfgfdg', '$2b$10$gY6./EbjDaHvSzLFvpF41eMtvXrAJzTCW46Hr4JM1vxu44GD1fx9i', '', 0, 'mandefro', 'Kebede', 'mandeb71f7@gmail.com', '2025-01-30 15:26:01');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `Product_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `Product_id` int(11) NOT NULL,
  `product_url` varchar(300) DEFAULT NULL,
  `product_name` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`Product_id`, `product_url`, `product_name`) VALUES
(4, ' https://www.apple.com/in/iphone-se/', 'iPhone SE'),
(5, 'https://www.apple.com/in/iphone-11/', 'iPhone 11');

-- --------------------------------------------------------

--
-- Table structure for table `productsdescription`
--

CREATE TABLE `productsdescription` (
  `Description_id` int(11) NOT NULL,
  `Product_id` int(11) DEFAULT NULL,
  `Product_description` text DEFAULT NULL,
  `Product_brief_description` varchar(400) DEFAULT NULL,
  `Product_img` blob DEFAULT NULL,
  `Product_link` varchar(400) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_price`
--

CREATE TABLE `product_price` (
  `Price_id` int(11) NOT NULL,
  `Product_id` int(11) DEFAULT NULL,
  `Starting_price` varchar(25) DEFAULT NULL,
  `Price_range` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_ID` int(11) NOT NULL,
  `First_name` varchar(255) DEFAULT NULL,
  `Last_name` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `telegramId` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`telegramId`, `username`, `fullName`, `email`, `phone`, `createdAt`, `updatedAt`) VALUES
('6105157221', 'liyu0970', 'Liyuwork kebede', 'Liyuwork@gmail.com', '0970655833', '2025-02-14 10:00:59', '2025-02-14 10:00:59'),
('7105157223', 'Mande0970', 'Mandefro Bizuwork', 'Mandeb717@gmail.com', '0930244513', '2025-02-14 08:20:39', '2025-02-14 08:20:39'),
('939330930', 'ednamb', 'Ednam Bizuwork', 'Ednam@gmail.com', '0986988186', '2025-02-14 12:45:12', '2025-02-14 12:45:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`telegramId`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`JOB_ID`);

--
-- Indexes for table `new_users`
--
ALTER TABLE `new_users`
  ADD PRIMARY KEY (`userid`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `Product_id` (`Product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`Product_id`);

--
-- Indexes for table `productsdescription`
--
ALTER TABLE `productsdescription`
  ADD PRIMARY KEY (`Description_id`),
  ADD KEY `Product_id` (`Product_id`);

--
-- Indexes for table `product_price`
--
ALTER TABLE `product_price`
  ADD PRIMARY KEY (`Price_id`),
  ADD KEY `Product_id` (`Product_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`telegramId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `JOB_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `new_users`
--
ALTER TABLE `new_users`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `Product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `productsdescription`
--
ALTER TABLE `productsdescription`
  MODIFY `Description_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_price`
--
ALTER TABLE `product_price`
  MODIFY `Price_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`Product_id`) REFERENCES `products` (`Product_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `new_users` (`userid`);

--
-- Constraints for table `productsdescription`
--
ALTER TABLE `productsdescription`
  ADD CONSTRAINT `productsdescription_ibfk_1` FOREIGN KEY (`Product_id`) REFERENCES `products` (`Product_id`);

--
-- Constraints for table `product_price`
--
ALTER TABLE `product_price`
  ADD CONSTRAINT `product_price_ibfk_1` FOREIGN KEY (`Product_id`) REFERENCES `products` (`Product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
