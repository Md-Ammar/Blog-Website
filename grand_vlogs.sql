-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2024 at 01:16 PM
-- Server version: 8.0.35
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `grand vlogs`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int NOT NULL,
  `name` text NOT NULL,
  `phone_num` varchar(15) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `phone_num`, `msg`, `date`, `email`) VALUES
(1, 'simamm', '123456789', 'test value', '2024-10-30 16:27:55', 'test@gmail.com'),
(2, 'Mohammad Ammar', '07365993869', 'dgas', NULL, 'ammaratif559@gmail.com'),
(5, 'Simran', '7007654569', 'hola gola', NULL, 'simranyadav6119@gmail.com'),
(16, 'Mohammad Ammar', '07365993869', 'dsad', NULL, 'mohammadammar2022@vitbhopal.ac.in'),
(17, '', '', '', NULL, ''),
(18, 'Simran', '7007654569', 'hey gola', NULL, 'simranyadav6119@gmail.com'),
(19, 'A-S', '8303093869', 'Holaaaaaaaaaa 😘😘😘😘', NULL, 'simranyadav6119@gmail.com'),
(20, 'A-S', '8303093869', 'Holaaaaaaaaaa 😘😘😘😘', NULL, 'simranyadav6119@gmail.com'),
(21, 'A-S', '07365993869', 'Holaaaaaaaaaa 😘😘😘😘', NULL, 'simranyadav6119@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `Sno` int NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'home-bg.jpg',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`Sno`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'This is my first blog - Title', 'This is my first post', 'first-post', 'I am learning flask micro web framework, building fully functional websites using HTML/JS with boostrap and python flask for backend.', 'post-bg.jpg', '2024-11-02 17:42:18'),
(2, 'Second post title', 'this is my second post', 'second_post', 'Random text', 'about-bg.jpg', '2024-11-10 11:35:56'),
(4, 'Mastering Asynchronous JavaScript in Depth', 'Go beyond callbacks to truly own async in JS', 'mastering-async-js', 'Dive into the intricacies of asynchronous JavaScript with Promises, async/await, and beyond. Understand the call stack, event loop, and microtasks in a way that helps you tackle real-world async code like a pro. Includes practical code examples and performance insights.', 'about-bg.jpg', '2024-11-10 16:03:34'),
(6, 'Implementing Zero-Downtime CI/CD Pipelines', 'Achieve the holy grail of uninterrupted updates', 'zero-downtime-ci-cd', 'Learn how to build CI/CD pipelines that allow for zero-downtime deployments. This guide explores blue-green deployments, canary releases, feature toggles, and best practices to ensure flawless continuous delivery without interrupting user experience.', 'home-bg.jpg', '2024-11-19 15:33:52'),
(7, 'Advanced Techniques in Natural Language Processing', 'Push the boundaries of what\'s possible in NLP', 'advanced-nlp-techniques', 'Discover the cutting-edge methods in NLP, from transformer-based models to embeddings and transfer learning. See how to leverage the latest models like BERT, GPT, and T5 for high-performance applications in text classification, summarization, and sentiment analysis.', 'home-bg.jpg', '2024-11-10 12:01:11'),
(8, 'Memory Management Deep Dive: From Stack to Heap', 'Master memory management for better performance', 'memory-management-deep-dive', 'A deep exploration of memory management, focusing on the stack vs. heap, garbage collection, and manual memory handling in languages like C/C++ and Rust. Includes performance benchmarks, debugging techniques, and tips for avoiding memory leaks.', 'home-bg.jpg', '2024-11-19 15:36:12'),
(9, 'Building Real-Time Applications with WebSockets', 'Go real-time and never look back', 'real-time-apps-websockets', 'Learn how to create real-time applications using WebSockets. This blog explains the protocol, implementation patterns, and security considerations for building chat applications, live notifications, and collaborative tools that need instant data updates.', 'home-bg.jpg', '2024-11-10 12:01:11'),
(10, 'Introduction to Quantum Computing for Programmers', 'A programmer\'s guide to the next computing frontier', 'intro-quantum-computing', 'An introduction to quantum computing tailored for experienced programmers. Covers qubits, quantum gates, superposition, and entanglement with practical examples on how quantum algorithms like Grover\'s and Shor\'s work. Also touches on available tools like Qiskit and IBM\'s Quantum Lab.', 'home-bg.jpg', '2024-11-10 12:01:11'),
(11, 'Design Patterns for Machine Learning Engineers', 'Apply design principles to machine learning', 'design-patterns-ml', 'Explore best practices and design patterns specifically for machine learning. Topics include model deployment strategies, data pipeline architecture, monitoring, and reproducibility. Aimed at helping ML engineers design maintainable and scalable solutions.', 'home-bg.jpg', '2024-11-10 12:01:11'),
(12, 'Advanced Debugging Techniques in Modern IDEs', 'Debug like a pro with the right IDE features', 'advanced-debugging-ides', 'Master advanced debugging tools and techniques available in modern IDEs like Visual Studio, IntelliJ, and VS Code. Learn how to use breakpoints, log points, conditional debugging, and profiling to optimize your code and squash even the most elusive bugs.', 'home-bg.jpg', '2024-11-10 12:01:11'),
(13, 'Cybersecurity for Developers: Advanced Practices', 'Protect your code from cyber threats', 'advanced-cybersecurity-developers', 'A guide to cybersecurity for advanced developers, covering topics like secure coding practices, cryptography, threat modeling, and vulnerability scanning. Practical advice on protecting applications from common attack vectors and ensuring compliance with security standards.', 'home-bg.jpg', '2024-11-10 12:01:11'),
(14, 'test1', 'test1', 'test1', 'test1', 'test1', '2024-11-19 15:36:23'),
(15, 'test', 't', '', '', '', '2024-11-10 15:24:31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`Sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `Sno` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
