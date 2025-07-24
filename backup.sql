-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: ecomm_db
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts_customer`
--

DROP TABLE IF EXISTS `accounts_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` longtext NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `date_joined` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_customer_email_496ee6f7_uniq` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_customer`
--

LOCK TABLES `accounts_customer` WRITE;
/*!40000 ALTER TABLE `accounts_customer` DISABLE KEYS */;
INSERT INTO `accounts_customer` VALUES (42,'Admin','test@test.com','0000000000','pbkdf2_sha256$600000$lOPxULBLMNebST2RD9DW2S$zKNQ2YQAKQQeZggIiWTdL8BOtQ8qE7cN93PAOrmy4pQ=','Admin Address',1,'2025-07-07 09:15:27.008659','2025-07-01 03:58:46.669877',1,1),(44,'Admin','test1@test.com','0000000000','pbkdf2_sha256$600000$LW9twTT7dhDXJLg9FCz2X3$cXr3UdcWikTIxltU51QNQ6s6cTokoRePEG0uXDgsFTw=','Admin Address',1,'2025-07-03 12:36:51.729870','2025-07-03 12:36:26.322577',1,1),(45,'Mitava','mitava.kapadia@ecosmob.com','9852414784','pbkdf2_sha256$600000$VtWIhoPGIjYtRx7uJuitGU$XWHwE3euQAgLw75l6x+AVsQspeJ51YLlU2nxEqulEhI=','Admin Address',0,'2025-07-04 15:30:16.000000','2025-07-04 14:50:46.000000',1,0),(57,'Mitava Kapadia','mitavakapadia@gmail.com','9852414784','pbkdf2_sha256$600000$VdYLYucb93yzzBWpy0tzUA$4VEqHNb76R6K3eBVRQuajj1iC6wLT2XYlgf72hW2Y14=','',0,'2025-07-07 11:22:17.501756','2025-07-07 05:20:43.141125',1,0);
/*!40000 ALTER TABLE `accounts_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_customer_groups`
--

DROP TABLE IF EXISTS `accounts_customer_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_customer_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_customer_groups_customer_id_group_id_5d65b72b_uniq` (`customer_id`,`group_id`),
  KEY `accounts_customer_groups_group_id_7c230d03_fk_auth_group_id` (`group_id`),
  CONSTRAINT `accounts_customer_gr_customer_id_c2d5e358_fk_accounts_` FOREIGN KEY (`customer_id`) REFERENCES `accounts_customer` (`id`),
  CONSTRAINT `accounts_customer_groups_group_id_7c230d03_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_customer_groups`
--

LOCK TABLES `accounts_customer_groups` WRITE;
/*!40000 ALTER TABLE `accounts_customer_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_customer_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_customer_user_permissions`
--

DROP TABLE IF EXISTS `accounts_customer_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_customer_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_customer_user_p_customer_id_permission_i_927fe894_uniq` (`customer_id`,`permission_id`),
  KEY `accounts_customer_us_permission_id_9c8a5ef6_fk_auth_perm` (`permission_id`),
  CONSTRAINT `accounts_customer_us_customer_id_701aa82b_fk_accounts_` FOREIGN KEY (`customer_id`) REFERENCES `accounts_customer` (`id`),
  CONSTRAINT `accounts_customer_us_permission_id_9c8a5ef6_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_customer_user_permissions`
--

LOCK TABLES `accounts_customer_user_permissions` WRITE;
/*!40000 ALTER TABLE `accounts_customer_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_customer_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_deliveryaddress`
--

DROP TABLE IF EXISTS `accounts_deliveryaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_deliveryaddress` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `street` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `pincode` int NOT NULL,
  `country` varchar(100) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `customer_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accounts_deliveryadd_customer_id_93b5e0ad_fk_accounts_` (`customer_id`),
  CONSTRAINT `accounts_deliveryadd_customer_id_93b5e0ad_fk_accounts_` FOREIGN KEY (`customer_id`) REFERENCES `accounts_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_deliveryaddress`
--

LOCK TABLES `accounts_deliveryaddress` WRITE;
/*!40000 ALTER TABLE `accounts_deliveryaddress` DISABLE KEYS */;
INSERT INTO `accounts_deliveryaddress` VALUES (19,'A-401, Ashray Arise','Ahmedabad','Gujarat',380015,'India',0,45),(20,'41, Safal Heights','Ahmedabad','Gujarat',321026,'India',1,45),(21,'A-401, Ashray Arise','Ahmedabad','Gujarat',380015,'India',1,57),(22,'21, Shivalik Bunglows','Ahmedabad','Gujarat',36021,'India',0,57);
/*!40000 ALTER TABLE `accounts_deliveryaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add category',7,'add_category'),(26,'Can change category',7,'change_category'),(27,'Can delete category',7,'delete_category'),(28,'Can view category',7,'view_category'),(29,'Can add customer',8,'add_customer'),(30,'Can change customer',8,'change_customer'),(31,'Can delete customer',8,'delete_customer'),(32,'Can view customer',8,'view_customer'),(33,'Can add product',9,'add_product'),(34,'Can change product',9,'change_product'),(35,'Can delete product',9,'delete_product'),(36,'Can view product',9,'view_product'),(37,'Can add order',10,'add_order'),(38,'Can change order',10,'change_order'),(39,'Can delete order',10,'delete_order'),(40,'Can view order',10,'view_order'),(41,'Can add customer',11,'add_customer'),(42,'Can change customer',11,'change_customer'),(43,'Can delete customer',11,'delete_customer'),(44,'Can view customer',11,'view_customer'),(45,'Can add brand',12,'add_brand'),(46,'Can change brand',12,'change_brand'),(47,'Can delete brand',12,'delete_brand'),(48,'Can view brand',12,'view_brand'),(49,'Can add category',13,'add_category'),(50,'Can change category',13,'change_category'),(51,'Can delete category',13,'delete_category'),(52,'Can view category',13,'view_category'),(53,'Can add product',14,'add_product'),(54,'Can change product',14,'change_product'),(55,'Can delete product',14,'delete_product'),(56,'Can view product',14,'view_product'),(57,'Can add cart item',15,'add_cartitem'),(58,'Can change cart item',15,'change_cartitem'),(59,'Can delete cart item',15,'delete_cartitem'),(60,'Can view cart item',15,'view_cartitem'),(61,'Can add cart',16,'add_cart'),(62,'Can change cart',16,'change_cart'),(63,'Can delete cart',16,'delete_cart'),(64,'Can view cart',16,'view_cart'),(65,'Can add delivery address',17,'add_deliveryaddress'),(66,'Can change delivery address',17,'change_deliveryaddress'),(67,'Can delete delivery address',17,'delete_deliveryaddress'),(68,'Can view delivery address',17,'view_deliveryaddress'),(69,'Can add order item',18,'add_orderitem'),(70,'Can change order item',18,'change_orderitem'),(71,'Can delete order item',18,'delete_orderitem'),(72,'Can view order item',18,'view_orderitem'),(73,'Can add order',19,'add_order'),(74,'Can change order',19,'change_order'),(75,'Can delete order',19,'delete_order'),(76,'Can view order',19,'view_order'),(77,'Can add PayPal IPN',20,'add_paypalipn'),(78,'Can change PayPal IPN',20,'change_paypalipn'),(79,'Can delete PayPal IPN',20,'delete_paypalipn'),(80,'Can view PayPal IPN',20,'view_paypalipn');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$HeSOdWTNjBn6xUHbFvKyIJ$d1Car3xbF+mkDitfx1s6CUxeGd0JYAJQ8pyjD5zk4zY=','2025-06-23 04:26:24.834427',1,'test','','','test@test.com',1,1,'2025-06-23 04:25:57.067075');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_cart`
--

DROP TABLE IF EXISTS `cart_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_cart` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `customer_id` bigint DEFAULT NULL,
  `ordered` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_cart_customer_id_bbe4c408_fk_accounts_customer_id` (`customer_id`),
  CONSTRAINT `cart_cart_customer_id_bbe4c408_fk_accounts_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `accounts_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_cart`
--

LOCK TABLES `cart_cart` WRITE;
/*!40000 ALTER TABLE `cart_cart` DISABLE KEYS */;
INSERT INTO `cart_cart` VALUES (1,'2025-07-01 06:11:23.884561',NULL,0),(2,'2025-07-01 08:52:23.273123',NULL,0),(3,'2025-07-01 09:01:14.319286',NULL,0),(4,'2025-07-01 09:01:42.731065',NULL,0),(5,'2025-07-01 09:08:46.931751',NULL,0),(6,'2025-07-01 09:12:48.772171',NULL,0),(7,'2025-07-01 09:15:04.999119',NULL,0),(8,'2025-07-01 09:20:24.299958',NULL,0),(9,'2025-07-01 09:21:43.071618',NULL,0),(10,'2025-07-01 09:23:30.384284',NULL,0),(11,'2025-07-01 09:24:04.089519',NULL,0),(12,'2025-07-01 10:07:29.817255',NULL,0),(13,'2025-07-01 13:02:34.116930',NULL,0),(14,'2025-07-01 13:03:17.853720',NULL,0),(15,'2025-07-01 13:06:48.143660',NULL,0),(16,'2025-07-01 13:11:46.622326',NULL,0),(17,'2025-07-01 13:15:59.057055',NULL,0),(18,'2025-07-01 13:18:12.399878',NULL,0),(19,'2025-07-02 04:07:13.082631',NULL,0),(21,'2025-07-02 04:36:43.256010',NULL,0),(22,'2025-07-02 04:51:14.082874',NULL,0),(23,'2025-07-03 13:37:26.568971',44,0),(25,'2025-07-04 14:30:49.662364',42,1),(26,'2025-07-04 14:52:49.173489',45,1),(27,'2025-07-04 14:59:08.377491',NULL,0),(28,'2025-07-04 14:59:08.528669',45,1),(29,'2025-07-04 15:00:37.517120',45,1),(30,'2025-07-04 15:09:43.107053',45,1),(31,'2025-07-07 03:59:25.129672',45,1),(32,'2025-07-07 04:18:36.716900',45,1),(33,'2025-07-07 04:22:46.290052',45,1),(34,'2025-07-07 04:29:05.344886',45,1),(35,'2025-07-07 04:30:47.458200',45,1),(36,'2025-07-07 04:32:07.619784',45,1),(37,'2025-07-07 04:34:23.464770',NULL,0),(38,'2025-07-07 04:34:23.603074',45,1),(39,'2025-07-07 04:44:39.542050',NULL,0),(40,'2025-07-07 04:44:39.697624',45,1),(41,'2025-07-07 04:46:42.560897',45,1),(42,'2025-07-07 04:47:53.113260',45,1),(43,'2025-07-07 04:52:38.194085',45,1),(44,'2025-07-07 05:24:04.875148',57,1),(45,'2025-07-07 05:25:16.537342',57,1),(46,'2025-07-07 05:35:49.370775',NULL,0),(47,'2025-07-07 05:35:49.481720',57,1),(48,'2025-07-07 05:40:48.601642',57,1),(49,'2025-07-07 05:45:49.770548',NULL,0),(50,'2025-07-07 05:45:49.874960',57,1),(51,'2025-07-07 05:49:05.574638',NULL,0),(52,'2025-07-07 05:49:05.733857',57,1),(53,'2025-07-07 05:51:19.408438',NULL,0),(54,'2025-07-07 05:51:19.496894',57,1),(55,'2025-07-07 05:54:12.818605',57,1),(56,'2025-07-07 05:58:07.677350',57,1),(57,'2025-07-07 06:29:24.603612',NULL,0),(58,'2025-07-07 06:29:24.793826',57,1),(59,'2025-07-07 06:42:47.770019',NULL,0),(60,'2025-07-07 06:42:47.977478',57,1),(61,'2025-07-07 06:47:23.637418',NULL,0),(62,'2025-07-07 06:47:23.751168',57,1),(63,'2025-07-07 07:12:10.797365',NULL,0),(64,'2025-07-07 07:12:10.902924',57,1),(65,'2025-07-07 07:44:33.314080',57,1),(66,'2025-07-07 07:45:24.186153',57,1),(67,'2025-07-07 07:47:04.061813',NULL,0),(68,'2025-07-07 07:47:04.161259',57,1),(69,'2025-07-07 11:22:23.098083',NULL,0),(70,'2025-07-07 11:22:23.225178',57,0),(71,'2025-07-07 11:26:51.599108',NULL,0);
/*!40000 ALTER TABLE `cart_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_cartitem`
--

DROP TABLE IF EXISTS `cart_cartitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_cartitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `cart_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_cartitem_cart_id_370ad265_fk_cart_cart_id` (`cart_id`),
  KEY `cart_cartitem_product_id_b24e265a_fk_product_product_id` (`product_id`),
  CONSTRAINT `cart_cartitem_cart_id_370ad265_fk_cart_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart_cart` (`id`),
  CONSTRAINT `cart_cartitem_product_id_b24e265a_fk_product_product_id` FOREIGN KEY (`product_id`) REFERENCES `product_product` (`id`),
  CONSTRAINT `cart_cartitem_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_cartitem`
--

LOCK TABLES `cart_cartitem` WRITE;
/*!40000 ALTER TABLE `cart_cartitem` DISABLE KEYS */;
INSERT INTO `cart_cartitem` VALUES (1,3,1,10),(2,3,1,9),(4,1,11,3),(5,1,11,9),(9,1,12,7),(12,1,14,6),(13,1,14,4),(14,1,15,1),(16,2,16,9),(17,1,17,7),(24,2,18,1),(25,1,19,9),(26,1,19,7),(30,1,21,9),(33,1,22,4),(65,1,25,9),(67,1,26,10),(70,1,28,9),(71,2,29,10),(72,1,29,7),(73,1,30,10),(74,1,30,7),(76,1,31,4),(77,1,32,10),(78,1,32,6),(79,1,33,10),(80,1,33,7),(81,1,34,5),(82,1,34,2),(83,1,35,9),(84,1,35,7),(85,1,36,3),(86,1,36,1),(87,1,37,7),(88,1,38,10),(89,1,38,7),(91,1,40,7),(92,1,40,10),(93,1,41,6),(94,1,41,2),(95,1,42,1),(96,1,42,4),(97,1,43,10),(98,1,43,1),(99,1,44,10),(100,1,44,7),(101,1,45,5),(102,1,45,1),(105,1,47,7),(106,1,48,6),(107,1,48,4),(108,1,49,9),(110,1,50,7),(112,1,51,9),(113,1,52,7),(114,1,52,10),(115,1,53,9),(116,1,54,9),(117,1,55,7),(118,1,56,10),(119,1,56,4),(123,1,58,10),(124,1,58,5),(125,1,59,7),(126,1,60,7),(127,1,60,10),(128,1,61,9),(129,1,62,10),(130,1,62,5),(131,1,63,7),(132,1,64,5),(133,1,64,2),(135,1,66,10),(136,1,67,7),(137,1,68,7),(138,1,25,10),(139,1,69,9),(140,1,70,9),(141,1,71,7);
/*!40000 ALTER TABLE `cart_cartitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-06-23 04:26:49.429225','1','Women\'s Fashion',1,'[{\"added\": {}}]',13,1),(2,'2025-06-23 04:26:58.884988','2','Men\'s Fashion',1,'[{\"added\": {}}]',13,1),(3,'2025-06-23 04:27:15.370077','3','Kitchen Finds',1,'[{\"added\": {}}]',13,1),(4,'2025-06-23 04:27:48.434354','4','Beauty',1,'[{\"added\": {}}]',13,1),(5,'2025-06-23 04:28:58.002347','1','Vero Moda',1,'[{\"added\": {}}]',12,1),(6,'2025-06-23 04:29:14.114992','2','Forever 21',1,'[{\"added\": {}}]',12,1),(7,'2025-06-23 04:29:21.522719','3','Fossil',1,'[{\"added\": {}}]',12,1),(8,'2025-06-23 04:29:42.321735','4','Red Chief',1,'[{\"added\": {}}]',12,1),(9,'2025-06-23 04:30:08.222315','5','U.S. Polo',1,'[{\"added\": {}}]',12,1),(10,'2025-06-23 04:30:18.914621','6','Lee',1,'[{\"added\": {}}]',12,1),(11,'2025-06-23 04:30:37.353996','7','Sugar Cosmetics',1,'[{\"added\": {}}]',12,1),(12,'2025-06-23 04:30:47.892512','8','Maybelline',1,'[{\"added\": {}}]',12,1),(13,'2025-06-23 04:31:03.652759','9','Tupper Wear',1,'[{\"added\": {}}]',12,1),(14,'2025-06-23 04:31:25.889755','10','Milton',1,'[{\"added\": {}}]',12,1),(15,'2025-06-23 04:33:57.920802','1','Womens Regular T-Shirt',1,'[{\"added\": {}}]',14,1),(16,'2025-06-23 04:35:29.899183','2','SUGAR Matte Lipstick',1,'[{\"added\": {}}]',14,1),(17,'2025-06-23 04:36:54.767238','3','Men\'s Cotton Shirt',1,'[{\"added\": {}}]',14,1),(18,'2025-06-23 04:38:11.786980','4','Maybelline New York Concealer',1,'[{\"added\": {}}]',14,1),(19,'2025-06-23 04:41:53.536151','5','Storage Boxes (Pack of 6)',1,'[{\"added\": {}}]',14,1),(20,'2025-06-23 04:43:21.520035','6','Men\'s Formal Office Work Lace-Up Derby Shoes',1,'[{\"added\": {}}]',14,1),(21,'2025-06-23 04:43:34.162996','5','Electronics',1,'[{\"added\": {}}]',13,1),(22,'2025-06-23 04:43:41.978417','11','Boat',1,'[{\"added\": {}}]',12,1),(23,'2025-06-23 04:44:57.527197','7','Boat Headphones',1,'[{\"added\": {}}]',14,1),(24,'2025-06-23 04:45:48.884055','12','Nikon',1,'[{\"added\": {}}]',12,1),(25,'2025-06-23 04:47:02.777328','8','Nikon D850 45.7MP Digital SLR Camera',1,'[{\"added\": {}}]',14,1),(26,'2025-06-23 04:47:15.922069','8','Nikon D850 45.7MP Digital SLR Camera',2,'[{\"changed\": {\"fields\": [\"Review\"]}}]',14,1),(27,'2025-06-23 04:48:47.913275','9','Fossil Eevie Analog Rose Gold Dial Watch',1,'[{\"added\": {}}]',14,1),(28,'2025-06-23 04:50:55.665897','10','Insulated Stainless Steel Coffee Mug with Lid',1,'[{\"added\": {}}]',14,1),(29,'2025-06-23 04:51:52.570487','4','Maybelline New York Concealer',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',14,1),(30,'2025-06-23 05:23:42.660282','1','Womens Regular T Shirt',2,'[{\"changed\": {\"fields\": [\"Prod name\"]}}]',14,1),(31,'2025-06-23 05:24:11.548315','1','Womens Regular TShirt',2,'[{\"changed\": {\"fields\": [\"Prod name\"]}}]',14,1),(47,'2025-07-04 14:43:25.961373','43','mitavakapadia@gmail.com',3,'',11,42),(48,'2025-07-04 15:26:20.275890','46','mitavakapadia@gmail.com',3,'',11,42),(49,'2025-07-04 15:29:57.042299','47','mitavakapadia@gmail.com',3,'',11,42),(50,'2025-07-07 04:59:28.970245','48','mitavakapadia@gmail.com',3,'',11,42),(51,'2025-07-07 05:00:57.364459','49','mitavakapadia@gmail.com',3,'',11,42),(52,'2025-07-07 05:03:20.942952','50','mitavakapadia@gmail.com',3,'',11,42),(53,'2025-07-07 05:05:39.881211','51','mitavakapadia@gmail.com',3,'',11,42),(54,'2025-07-07 05:06:23.232793','52','mitavakapadia@gmail.com',3,'',11,42),(55,'2025-07-07 05:07:56.239989','53','mitavakapadia@gmail.com',3,'',11,42),(56,'2025-07-07 05:14:30.098631','54','mitavakapadia@gmail.com',3,'',11,42),(57,'2025-07-07 05:18:21.563012','55','mitavakapadia@gmail.com',3,'',11,42),(58,'2025-07-07 05:20:23.842532','56','mitavakapadia@gmail.com',3,'',11,42),(59,'2025-07-07 07:57:53.385314','8','Nikon D850 45.7MP Digital SLR Camera',3,'',14,42);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (11,'accounts','customer'),(17,'accounts','deliveryaddress'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(16,'cart','cart'),(15,'cart','cartitem'),(5,'contenttypes','contenttype'),(20,'ipn','paypalipn'),(19,'orders','order'),(18,'orders','orderitem'),(12,'product','brand'),(13,'product','category'),(14,'product','product'),(6,'sessions','session'),(7,'store','category'),(8,'store','customer'),(10,'store','order'),(9,'store','product');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (2,'contenttypes','0001_initial','2025-06-23 04:21:47.935614'),(3,'auth','0001_initial','2025-06-23 04:21:53.745022'),(7,'contenttypes','0002_remove_content_type_name','2025-06-23 04:21:55.938539'),(8,'auth','0002_alter_permission_name_max_length','2025-06-23 04:21:56.515823'),(9,'auth','0003_alter_user_email_max_length','2025-06-23 04:21:56.616745'),(10,'auth','0004_alter_user_username_opts','2025-06-23 04:21:56.646544'),(11,'auth','0005_alter_user_last_login_null','2025-06-23 04:21:57.082261'),(12,'auth','0006_require_contenttypes_0002','2025-06-23 04:21:57.108877'),(13,'auth','0007_alter_validators_add_error_messages','2025-06-23 04:21:57.150158'),(14,'auth','0008_alter_user_username_max_length','2025-06-23 04:21:57.696845'),(15,'auth','0009_alter_user_last_name_max_length','2025-06-23 04:21:58.222288'),(16,'auth','0010_alter_group_name_max_length','2025-06-23 04:21:58.315886'),(17,'auth','0011_update_proxy_permissions','2025-06-23 04:21:58.351354'),(18,'auth','0012_alter_user_first_name_max_length','2025-06-23 04:21:58.891326'),(19,'product','0001_initial','2025-06-23 04:22:00.732876'),(20,'product','0002_alter_category_options_alter_product_options_and_more','2025-06-23 04:22:03.699218'),(21,'product','0003_alter_category_slug_alter_product_slug','2025-06-23 04:22:03.732702'),(22,'product','0004_alter_product_options_alter_category_slug_and_more','2025-06-23 04:22:03.768507'),(23,'sessions','0001_initial','2025-06-23 04:22:04.072764'),(24,'store','0001_initial','2025-06-23 04:22:06.544510'),(25,'store','0002_alter_product_desc','2025-06-23 04:22:06.577939'),(26,'store','0003_alter_category_options','2025-06-23 04:22:06.611304'),(27,'product','0005_category_discount_product_stock','2025-06-23 09:12:40.080108'),(30,'accounts','0001_initial','2025-06-30 05:15:36.854596'),(31,'accounts','0002_customer_groups_customer_is_superuser_and_more','2025-06-30 05:15:36.888474'),(32,'accounts','0003_alter_customer_password','2025-06-30 05:15:36.925626'),(33,'accounts','0004_alter_customer_password','2025-06-30 05:15:36.955509'),(34,'accounts','0005_alter_customer_password','2025-06-30 05:15:36.979427'),(35,'accounts','0006_alter_customer_password','2025-06-30 05:15:37.005538'),(36,'accounts','0007_alter_customer_password','2025-06-30 05:15:37.036673'),(37,'accounts','0008_alter_customer_password','2025-06-30 05:15:37.076324'),(38,'admin','0001_initial','2025-06-30 05:17:04.608255'),(39,'admin','0002_logentry_remove_auto_add','2025-06-30 05:17:04.635419'),(40,'admin','0003_logentry_add_action_flag_choices','2025-06-30 05:17:04.677487'),(41,'accounts','0009_customer_date_joined_customer_is_active_and_more','2025-06-30 05:24:15.482651'),(42,'accounts','0010_alter_customer_is_superuser','2025-07-01 03:58:19.216125'),(43,'cart','0001_initial','2025-07-01 05:39:13.936105'),(44,'cart','0002_cartitem_category','2025-07-01 09:12:29.028663'),(45,'cart','0003_alter_cartitem_category','2025-07-01 09:23:56.850603'),(46,'cart','0004_cart_customer','2025-07-01 12:56:23.917112'),(47,'cart','0005_remove_cartitem_category','2025-07-02 04:01:04.087164'),(48,'product','0006_alter_category_discount','2025-07-02 04:01:04.660683'),(49,'accounts','0011_deliveryaddress','2025-07-02 07:37:09.804285'),(50,'accounts','0012_alter_deliveryaddress_pincode','2025-07-02 07:37:10.494566'),(51,'product','0007_alter_category_discount','2025-07-02 08:22:00.053457'),(52,'product','0008_alter_category_discount','2025-07-02 08:23:17.766726'),(63,'orders','0001_initial','2025-07-04 05:18:56.008067'),(64,'orders','0002_order_ordered','2025-07-04 11:15:40.162783'),(65,'cart','0006_cart_ordered','2025-07-04 11:42:38.050326'),(66,'orders','0003_orderitem_ordered','2025-07-04 11:42:38.246944'),(67,'product','0009_product_low_stock_threshold','2025-07-07 08:42:15.072044'),(68,'product','0010_remove_product_low_stock_threshold','2025-07-07 09:29:19.869673');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('t3g4h5zg1xkt5g45c0ytz7l7tliykx2r','.eJxVjMsOwiAQAP-FsyFQ5LEevfsNzS4LUjWQlPZk_HdD0oNeZybzFjPuW5n3ntZ5YXER1ovTLySMz1SH4QfWe5Ox1W1dSI5EHrbLW-P0uh7t36BgL-PrvLJBKw8TEIPXnjSzdaAn8DkGQykGmzMjcCRjUgBkQ_nMgclZJT5f9NQ4Xg:1uYeI5:JMw_CHjNOlxeIXI-VASwvtQvRfjSxbBSQzXfhioRs8w','2025-07-21 05:21:21.317517'),('wgpltlr4rudukpp68y3mep7ind71zuyu','eyJjYXJ0X2lkIjo3MX0:1uYjzn:hvWhirNvq-Y2zIWqyfruahG-uKgx-NXFatCbZAQaNrA','2025-07-21 11:26:51.674597');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_order`
--

DROP TABLE IF EXISTS `orders_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `status` varchar(20) NOT NULL,
  `address_id` bigint DEFAULT NULL,
  `customer_id` bigint NOT NULL,
  `ordered` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_order_address_id_0daf897b_fk_accounts_deliveryaddress_id` (`address_id`),
  KEY `orders_order_customer_id_0b76f6a4_fk_accounts_customer_id` (`customer_id`),
  CONSTRAINT `orders_order_address_id_0daf897b_fk_accounts_deliveryaddress_id` FOREIGN KEY (`address_id`) REFERENCES `accounts_deliveryaddress` (`id`),
  CONSTRAINT `orders_order_customer_id_0b76f6a4_fk_accounts_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `accounts_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_order`
--

LOCK TABLES `orders_order` WRITE;
/*!40000 ALTER TABLE `orders_order` DISABLE KEYS */;
INSERT INTO `orders_order` VALUES (53,'2025-07-04 14:53:23.491793','pending',NULL,45,1),(54,'2025-07-04 14:59:13.107617','pending',NULL,45,0),(55,'2025-07-04 14:59:27.090634','pending',NULL,45,1),(56,'2025-07-04 15:01:01.534994','pending',NULL,45,1),(57,'2025-07-04 15:10:52.568962','pending',NULL,45,0),(58,'2025-07-04 15:10:59.072095','pending',NULL,45,0),(59,'2025-07-04 15:12:47.787004','pending',NULL,45,0),(60,'2025-07-04 15:12:57.794802','pending',NULL,45,0),(61,'2025-07-04 15:14:00.916165','pending',NULL,45,0),(62,'2025-07-04 15:14:07.815527','pending',NULL,45,0),(63,'2025-07-04 15:14:16.420946','pending',NULL,45,0),(64,'2025-07-04 15:14:31.298624','pending',NULL,45,0),(65,'2025-07-04 15:14:45.910212','pending',NULL,45,0),(66,'2025-07-04 15:16:23.866612','pending',NULL,45,0),(67,'2025-07-04 15:30:22.533695','pending',NULL,45,0),(68,'2025-07-04 15:32:22.857998','pending',NULL,45,0),(69,'2025-07-07 03:38:04.189260','pending',NULL,45,1),(70,'2025-07-07 03:59:38.556392','pending',NULL,45,0),(71,'2025-07-07 04:01:58.724780','pending',NULL,45,0),(72,'2025-07-07 04:03:53.123075','pending',NULL,45,0),(73,'2025-07-07 04:10:02.566762','pending',NULL,45,0),(74,'2025-07-07 04:10:23.108416','pending',NULL,45,0),(75,'2025-07-07 04:10:37.455662','pending',NULL,45,0),(76,'2025-07-07 04:10:41.888002','pending',19,45,0),(77,'2025-07-07 04:12:16.170826','pending',NULL,45,1),(78,'2025-07-07 04:21:23.855325','pending',NULL,45,1),(79,'2025-07-07 04:22:58.472426','pending',NULL,45,0),(80,'2025-07-07 04:27:35.952145','pending',NULL,45,1),(81,'2025-07-07 04:29:27.175485','pending',NULL,45,0),(82,'2025-07-07 04:30:08.818907','pending',NULL,45,1),(83,'2025-07-07 04:30:56.769003','pending',NULL,45,1),(84,'2025-07-07 04:32:26.353375','pending',19,45,1),(85,'2025-07-07 04:43:22.136576','pending',NULL,45,1),(86,'2025-07-07 04:44:55.960148','pending',NULL,45,1),(87,'2025-07-07 04:47:02.378129','pending',19,45,1),(88,'2025-07-07 04:49:38.906957','pending',19,45,1),(89,'2025-07-07 04:53:00.446149','pending',19,45,1),(90,'2025-07-07 05:24:17.689463','pending',NULL,57,0),(91,'2025-07-07 05:24:42.721050','pending',21,57,1),(92,'2025-07-07 05:28:16.205296','pending',21,57,1),(93,'2025-07-07 05:36:09.356133','pending',21,57,1),(94,'2025-07-07 05:41:02.775815','pending',21,57,1),(95,'2025-07-07 05:46:40.963241','pending',NULL,57,0),(96,'2025-07-07 05:47:00.850350','pending',NULL,57,0),(97,'2025-07-07 05:47:18.021561','pending',NULL,57,1),(98,'2025-07-07 05:49:20.600320','pending',NULL,57,1),(99,'2025-07-07 05:51:57.416676','pending',NULL,57,0),(100,'2025-07-07 05:53:45.704570','pending',NULL,57,1),(101,'2025-07-07 05:54:21.697550','pending',NULL,57,1),(102,'2025-07-07 06:27:07.025271','pending',21,57,1),(103,'2025-07-07 06:32:21.540115','pending',NULL,57,1),(104,'2025-07-07 06:42:56.812355','pending',NULL,57,1),(105,'2025-07-07 06:50:23.787078','pending',21,57,0),(106,'2025-07-07 07:01:18.480016','pending',21,57,1),(107,'2025-07-07 07:12:25.003109','pending',21,57,0),(108,'2025-07-07 07:22:57.980119','pending',21,57,0),(109,'2025-07-07 07:26:29.480308','pending',NULL,57,0),(110,'2025-07-07 07:28:10.260737','pending',NULL,57,0),(111,'2025-07-07 07:31:02.132591','pending',NULL,57,0),(112,'2025-07-07 07:36:32.947017','pending',NULL,57,0),(113,'2025-07-07 07:39:33.626417','pending',NULL,57,0),(114,'2025-07-07 07:41:45.225471','pending',NULL,57,0),(115,'2025-07-07 07:42:49.785754','pending',NULL,57,0),(116,'2025-07-07 07:43:42.123030','pending',NULL,57,1),(117,'2025-07-07 07:44:40.023498','pending',NULL,57,1),(118,'2025-07-07 07:45:31.468615','pending',NULL,57,1),(119,'2025-07-07 07:47:11.881915','pending',NULL,57,1),(120,'2025-07-07 07:55:49.184568','pending',NULL,42,0),(121,'2025-07-07 09:32:39.758377','pending',NULL,42,1);
/*!40000 ALTER TABLE `orders_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_orderitem`
--

DROP TABLE IF EXISTS `orders_orderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_orderitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL,
  `quantity` int unsigned NOT NULL,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `ordered` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_orderitem_order_id_fe61a34d_fk_orders_order_id` (`order_id`),
  KEY `orders_orderitem_product_id_afe4254a_fk_product_product_id` (`product_id`),
  CONSTRAINT `orders_orderitem_order_id_fe61a34d_fk_orders_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`id`),
  CONSTRAINT `orders_orderitem_product_id_afe4254a_fk_product_product_id` FOREIGN KEY (`product_id`) REFERENCES `product_product` (`id`),
  CONSTRAINT `orders_orderitem_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_orderitem`
--

LOCK TABLES `orders_orderitem` WRITE;
/*!40000 ALTER TABLE `orders_orderitem` DISABLE KEYS */;
INSERT INTO `orders_orderitem` VALUES (71,150.00,1,53,10,0),(73,5000.00,1,55,9,0),(74,150.00,2,56,10,0),(75,1680.00,1,56,7,0),(76,150.00,2,57,10,0),(77,150.00,1,58,10,0),(78,150.00,1,59,10,0),(79,150.00,1,60,10,0),(80,150.00,1,61,10,0),(81,150.00,1,62,10,0),(82,150.00,1,63,10,0),(83,150.00,1,64,10,0),(84,150.00,1,65,10,0),(85,150.00,1,66,10,0),(86,1680.00,1,66,7,0),(87,150.00,1,67,10,0),(88,1680.00,1,67,7,0),(89,150.00,1,68,10,0),(90,1680.00,1,68,7,0),(91,150.00,1,69,10,0),(92,1680.00,1,69,7,0),(94,600.00,1,70,4,0),(96,600.00,1,71,4,0),(98,600.00,1,72,4,0),(100,600.00,1,73,4,0),(102,600.00,1,74,4,0),(104,600.00,1,75,4,0),(106,600.00,1,76,4,0),(108,600.00,1,77,4,0),(109,150.00,1,78,10,0),(110,1500.00,1,78,6,0),(111,150.00,1,79,10,0),(112,1680.00,1,79,7,0),(113,150.00,1,80,10,0),(114,1680.00,1,80,7,0),(115,400.00,1,81,5,0),(116,700.00,1,81,2,0),(117,400.00,1,82,5,0),(118,700.00,1,82,2,0),(119,5000.00,1,83,9,0),(120,1680.00,1,83,7,0),(121,1000.00,1,84,3,0),(122,600.00,1,84,1,0),(123,150.00,1,85,10,0),(124,1680.00,1,85,7,0),(125,1680.00,1,86,7,0),(126,150.00,1,86,10,0),(127,1500.00,1,87,6,0),(128,700.00,1,87,2,0),(129,600.00,1,88,1,0),(130,600.00,1,88,4,0),(131,150.00,1,89,10,0),(132,600.00,1,89,1,0),(133,150.00,1,90,10,0),(134,1680.00,1,90,7,0),(135,150.00,1,91,10,0),(136,1680.00,1,91,7,0),(137,400.00,1,92,5,0),(138,600.00,1,92,1,0),(140,1680.00,1,93,7,0),(141,1500.00,1,94,6,0),(142,600.00,1,94,4,0),(144,1680.00,1,95,7,0),(146,1680.00,1,96,7,0),(148,1680.00,1,97,7,0),(149,1680.00,1,98,7,0),(150,150.00,1,98,10,0),(151,5000.00,1,99,9,0),(152,5000.00,1,100,9,0),(153,1680.00,1,101,7,0),(154,150.00,1,102,10,0),(155,600.00,1,102,4,0),(156,150.00,1,103,10,0),(157,400.00,1,103,5,0),(158,1680.00,1,104,7,0),(159,150.00,1,104,10,0),(160,150.00,1,105,10,0),(161,400.00,1,105,5,0),(162,150.00,1,106,10,0),(163,400.00,1,106,5,0),(164,400.00,1,107,5,0),(165,700.00,1,107,2,0),(166,400.00,1,108,5,0),(167,700.00,1,108,2,0),(168,400.00,1,109,5,0),(169,700.00,1,109,2,0),(170,400.00,1,110,5,0),(171,700.00,1,110,2,0),(172,400.00,1,111,5,0),(173,700.00,1,111,2,0),(174,400.00,1,112,5,0),(175,700.00,1,112,2,0),(176,400.00,1,113,5,0),(177,700.00,1,113,2,0),(178,400.00,1,114,5,0),(179,700.00,1,114,2,0),(180,400.00,1,115,5,0),(181,700.00,1,115,2,0),(182,400.00,1,116,5,0),(183,700.00,1,116,2,0),(185,150.00,1,118,10,0),(186,1680.00,1,119,7,0),(187,5000.00,1,120,9,0),(188,5000.00,1,121,9,0),(189,150.00,1,121,10,0);
/*!40000 ALTER TABLE `orders_orderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_brand`
--

DROP TABLE IF EXISTS `product_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_brand` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_brand`
--

LOCK TABLES `product_brand` WRITE;
/*!40000 ALTER TABLE `product_brand` DISABLE KEYS */;
INSERT INTO `product_brand` VALUES (1,'Vero Moda'),(2,'Forever 21'),(3,'Fossil'),(4,'Red Chief'),(5,'U.S. Polo'),(6,'Lee'),(7,'Sugar Cosmetics'),(8,'Maybelline'),(9,'Tupper Wear'),(10,'Milton'),(11,'Boat'),(12,'Nikon');
/*!40000 ALTER TABLE `product_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `discount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `product_category_name_905278b8` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (1,'Women\'s Fashion','womens-fashion',10.00),(2,'Men\'s Fashion','mens-fashion',10.00),(3,'Kitchen Finds','kitchen-finds',10.00),(4,'Beauty','beauty',10.00),(5,'Electronics','electronics',10.00);
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_product`
--

DROP TABLE IF EXISTS `product_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `prod_name` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `prod_img` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `rating` int NOT NULL,
  `review` varchar(300) NOT NULL,
  `brand_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  `available` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `description` longtext NOT NULL DEFAULT (_utf8mb3''),
  `stock` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `product_product_brand_id_fcf1b3f3_fk_product_brand_id` (`brand_id`),
  KEY `product_product_category_id_0c725779_fk_product_category_id` (`category_id`),
  KEY `id_slug_index` (`id`,`slug`),
  CONSTRAINT `product_product_brand_id_fcf1b3f3_fk_product_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `product_brand` (`id`),
  CONSTRAINT `product_product_category_id_0c725779_fk_product_category_id` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_product`
--

LOCK TABLES `product_product` WRITE;
/*!40000 ALTER TABLE `product_product` DISABLE KEYS */;
INSERT INTO `product_product` VALUES (1,'Womens Regular TShirt','womens-regular-t-shirt','products/newtshirt.jpg',600.00,3,'Breathable Material',1,1,1,'2025-06-23 04:33:57.919301','Fabric Description: Single Jersey, 100% Cotton Classic, lightweight jersey fabric comprising 100% cotton.\r\nNeck: Round Neck',42),(2,'SUGAR Matte Lipstick','sugar-matte-lipstick','products/suagrlipstick.jpg',700.00,4,'Good for daily wear',7,4,1,'2025-06-23 04:35:29.897838','Lipstick with a velvety matte finish, Lasts up to 16 hours thanks to its elastic ink technology, Available in several shades',22),(3,'Men\'s Cotton Shirt','mens-cotton-shirt','products/men_shirt.jpg',1000.00,2,'Bad Material',5,2,1,'2025-06-23 04:36:54.765916','Material composition 100% Cotton\r\nPattern Solid\r\nFit type Regular Fit\r\nSleeve type Long Sleeve',48),(4,'Maybelline New York Concealer','maybelline-new-york-concealer','products/concealer.jpg',600.00,4,'Good for daily wear',8,4,1,'2025-06-23 04:38:11.785692','Multi-purpose liquid concealer for covering dark circles, Corrects imperfections, Sculpts and illuminates skin, Suitable for concealing wrinkles',36),(5,'Storage Boxes (Pack of 6)','storage-boxes-pack-of-6','products/storagebox.jpg',400.00,4,'Amazing for daily use',9,3,1,'2025-06-23 04:41:53.534346','Multipurpose Storage Solution: Ideal storage box for kitchen to organize food, snacks, vegetables, and groceries efficiently',32),(6,'Men\'s Formal Office Work Lace-Up Derby Shoes','mens-formal-office-work-lace-up-derby-shoes','products/menshoes.jpg',1500.00,1,'Bad Material',4,2,1,'2025-06-23 04:43:21.518540','Material - Synthetic\r\nColor - Black\r\nSole - Synthetic',46),(7,'Boat Headphones','boat-headphones','products/boatheadphones.jpg',1680.00,5,'Good sound quality',11,5,1,'2025-06-23 04:44:57.526070','Brand	boAt\r\nColour	Black Sabre\r\nForm Factor	Over Ear\r\nModel Name	Rockerz',23),(9,'Fossil Eevie Analog Rose Gold Dial Watch','fossil-eevie-analog-rose-gold-dial-watch','products/watchfossil.jpg',5000.00,2,'Good design, looks classy',3,1,1,'2025-06-23 04:48:47.911843','27mm case, 16mm band width, mineral crystal, Quartz movement with 3-hand analog display, imported.',40),(10,'Insulated Stainless Steel Coffee Mug with Lid','insulated-stainless-steel-coffee-mug-with-lid','products/steelmug.jpg',150.00,4,'Worth the money',9,3,1,'2025-06-23 04:50:55.664573','Premium Insulation for Longer Heat Retention: Keep your coffee, tea, or milk hot for hours with the high-quality insulated stainless steel design of this Xmart India mug.\r\nAmazing',4);
/*!40000 ALTER TABLE `product_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_category`
--

DROP TABLE IF EXISTS `store_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_category`
--

LOCK TABLES `store_category` WRITE;
/*!40000 ALTER TABLE `store_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `store_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_customer`
--

DROP TABLE IF EXISTS `store_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `email` varchar(254) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_customer`
--

LOCK TABLES `store_customer` WRITE;
/*!40000 ALTER TABLE `store_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `store_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_order`
--

DROP TABLE IF EXISTS `store_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `qty` int NOT NULL,
  `price` int NOT NULL,
  `status` tinyint(1) NOT NULL,
  `address` varchar(250) NOT NULL,
  `date` date NOT NULL,
  `phone` varchar(10) NOT NULL,
  `customer_id` bigint NOT NULL,
  `product_name_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `store_order_customer_id_13d6d43e_fk_store_customer_id` (`customer_id`),
  KEY `store_order_product_name_id_8dc76c09_fk_store_product_id` (`product_name_id`),
  CONSTRAINT `store_order_customer_id_13d6d43e_fk_store_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `store_customer` (`id`),
  CONSTRAINT `store_order_product_name_id_8dc76c09_fk_store_product_id` FOREIGN KEY (`product_name_id`) REFERENCES `store_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_order`
--

LOCK TABLES `store_order` WRITE;
/*!40000 ALTER TABLE `store_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `store_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_product`
--

DROP TABLE IF EXISTS `store_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) NOT NULL,
  `price` int NOT NULL,
  `desc` varchar(250) DEFAULT NULL,
  `images` varchar(100) NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `store_product_category_id_574bae65_fk_store_category_id` (`category_id`),
  CONSTRAINT `store_product_category_id_574bae65_fk_store_category_id` FOREIGN KEY (`category_id`) REFERENCES `store_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_product`
--

LOCK TABLES `store_product` WRITE;
/*!40000 ALTER TABLE `store_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `store_product` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-07 17:16:41
