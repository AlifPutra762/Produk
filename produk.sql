-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 07, 2025 at 09:09 AM
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
-- Database: `produk`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_sale_transaction` (IN `in_sales_reference` VARCHAR(255), IN `in_product_code` VARCHAR(255), IN `in_quantity` INT)   BEGIN
    DECLARE product_price DECIMAL(10, 2);

    START TRANSACTION;

    -- Ambil harga, paksa collation saat membandingkan
    SELECT price INTO product_price FROM products 
    WHERE product_code = in_product_code COLLATE utf8mb4_unicode_ci;

    INSERT INTO sales (sales_reference, sales_date, product_code, quantity, price, subtotal)
    VALUES (in_sales_reference, NOW(), in_product_code, in_quantity, product_price, (product_price * in_quantity));

    -- Kurangi stok, paksa collation saat membandingkan
    UPDATE products
    SET stock = stock - in_quantity
    WHERE product_code = in_product_code COLLATE utf8mb4_unicode_ci;

    COMMIT;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_product` ()   BEGIN
    SELECT
        p.product_name,
        SUM(s.quantity) AS total_sales
    FROM
        sales s
    JOIN
        products p ON s.product_code = p.product_code
    GROUP BY
        p.product_name
    ORDER BY
        total_sales DESC
    LIMIT 5;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-iuYVwAQ5IAIchjtP', 's:7:\"forever\";', 2075128100),
('laravel-cache-PHscvERLdhJztOYH', 's:7:\"forever\";', 2075127580);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_10_06_091816_create_products_table', 1),
(5, '2025_10_06_091825_create_sales_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_code` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product_code`, `product_name`, `price`, `stock`, `created_at`, `updated_at`) VALUES
(1, 'PROD-6181', 'Pensil 2B Faber-Castell', 20000.00, 236, '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(2, 'PROD-2288', 'Sandal Jepit Swallow', 100000.00, 277, '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(3, 'PROD-9098', 'Sambal Bawang Pedas', 2000.00, 89, '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(4, 'PROD-3794', 'Sabun Mandi Lifebuoy', 150000.00, 278, '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(5, 'PROD-0127', 'Sambal Bawang Pedas', 100000.00, 181, '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(6, 'PROD-3408', 'Pensil 2B Faber-Castell', 20000.00, 300, '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(7, 'PROD-3705', 'Beras Pandan Wangi Cianjur', 300000.00, 236, '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(8, 'PROD-3676', 'Sambal Bawang Pedas', 150000.00, 111, '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(9, 'PROD-3632', 'Kopi Robusta Lampung', 150000.00, 84, '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(10, 'PROD-3072', 'Gula Merah Kelapa Asli', 5000.00, 276, '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(11, 'PROD-3490', 'Sarung Tenun Gajah Duduk', 300000.00, 102, '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(12, 'PROD-6793', 'Kecap Manis No. 1', 200000.00, 213, '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(13, 'PROD-1775', 'Beras Pandan Wangi Cianjur', 150000.00, 94, '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(14, 'PROD-3481', 'Minyak Goreng Sawit Premium', 50000.00, 153, '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(15, 'PROD-8811', 'Teh Melati Pilihan', 10000.00, 230, '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(17, 'PROD-1234', 'Kipas Angin', 100000.00, 8, '2025-10-06 21:21:15', '2025-10-06 21:21:15');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sales_reference` varchar(255) NOT NULL,
  `sales_date` datetime NOT NULL,
  `product_code` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `sales_reference`, `sales_date`, `product_code`, `quantity`, `price`, `subtotal`, `created_at`, `updated_at`) VALUES
(1, 'INV-20251007-001', '2025-10-06 23:43:59', 'PROD-6181', 10, 20000.00, 200000.00, NULL, NULL),
(2, 'INV-20251007-002', '2025-10-06 23:43:59', 'PROD-2288', 5, 100000.00, 500000.00, NULL, NULL),
(3, 'INV-20251007-003', '2025-10-06 23:43:59', 'PROD-3705', 2, 300000.00, 600000.00, NULL, NULL),
(4, 'INV-20251007-004', '2025-10-06 23:43:59', 'PROD-9098', 25, 2000.00, 50000.00, NULL, NULL),
(5, 'INV-20251007-005', '2025-10-06 23:43:59', 'PROD-3481', 15, 50000.00, 750000.00, NULL, NULL),
(6, 'INV-20251007-006', '2025-10-06 23:43:59', 'PROD-6181', 8, 20000.00, 160000.00, NULL, NULL),
(7, 'INV-20251007-007', '2025-10-06 23:43:59', 'PROD-3705', 3, 300000.00, 900000.00, NULL, NULL),
(8, 'INV-20251007-008', '2025-10-07 07:40:39', 'PROD-2288', 3, 100000.00, 300000.00, NULL, NULL),
(9, 'INV-20251007-NSU6', '2025-10-07 11:23:45', 'PROD-1234', 2, 100000.00, 200000.00, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('2u4U5Qpe6nburLe2VVVlt74zxPJZ2gHjyeHVLaDW', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSnpaNUdnU2g5bEJySjBVTkY1dHRyNjNjSG5nR0lsb01VakljdlVuNiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fX0=', 1759820600),
('79l4MZAeTc2hbYvtxArY5VnRnSXFQipEMb533Bop', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWFhWaWE0Z2JjUUFZeEJpTVA4UDlIcGVlbzg2eTRwTjBuMlpQNUFuMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MzoidXJsIjthOjE6e3M6ODoiaW50ZW5kZWQiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fX0=', 1759806948),
('7njaB8qfxYe71r27xGdoVZSYY1USQqXRS4mLiWsd', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSUVna3RDZWhQeHNQWGhBMjhHZ09acHh3cFI1Y1o4b21nVmlZOEo3TyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1759806514),
('HPoQmaVhYT3m5UU1WFEfSFcHc5iAbY2dgIEYbNCg', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiSzhNSlVvWE00bGdzUWlNeWlPVkdJZUtTVFQ0VWFxMlgxMFY3SVhxZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MzoidXJsIjthOjE6e3M6ODoiaW50ZW5kZWQiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fX0=', 1759807059),
('KukH55ATb2QO8xjONPEezzJa4DhpGpAA6lUWXUMu', NULL, '127.0.0.1', 'PostmanRuntime/7.48.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVkVXZmpEVHU0dWs0UXRTWkJFSXhYMFRzQmV2TGtDcFNlSmtEVkJpUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1759820901),
('LSjeqe9Cwny2rX0AZzZwwwQevQ0Bju3LzXFMJZgB', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRXBGRnFDdmd3SDlna09oRHpDMENHM3g0b3YxSTlHM3k2STdXWk5HWCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9zYWxlcy9jcmVhdGUiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1759811247);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Alif Rahmat Yudha Putra', 'alif@example.com', '2025-10-06 09:09:57', '$2y$12$/d1yEcqJnXapCrf6ddIGZOGAyTiDIqJCf4yssGink5gDUmTMOVp/W', 'JkuXMUdmgKnORm6YkAYWTjAv3vBmVlGgtwWTPrfpSutSSdjNUVQ9cI21qc3H', '2025-10-06 09:09:57', '2025-10-06 09:09:57'),
(2, 'Maulana', 'maul@example.com', NULL, '$2y$12$o5/FnTRWO9k9TTAZHpsZ8enJW03mlAVSIzBhMpk/2mrhfXIGzsVpO', NULL, '2025-10-06 09:24:13', '2025-10-06 09:24:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_product_code_unique` (`product_code`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sales_sales_reference_unique` (`sales_reference`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
