-- MySQL dump 10.13  Distrib 9.3.0, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: enterprise_ragi
-- ------------------------------------------------------
-- Server version	9.3.0

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
-- Table structure for table `accounts_user`
--

DROP TABLE IF EXISTS `accounts_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user`
--

LOCK TABLES `accounts_user` WRITE;
/*!40000 ALTER TABLE `accounts_user` DISABLE KEYS */;
INSERT INTO `accounts_user` VALUES (1,'pbkdf2_sha256$1500000$AiRcTplk8LwYxSYD6xynMR$RvnNrxycvTwJY4a2ZxOIEPiPUx8g58fiREjlIQtAaGA=','2026-09-26 16:20:59.480285',1,'haskel','','',1,'2026-09-26 16:19:28.586308','haskel@example.com','USER','',1,'2026-09-26 16:19:29.498679','2026-09-26 16:19:29.498691'),(2,'pbkdf2_sha256$1500000$qgOB5I0yv8rrEsYb9FM2l5$iF8uUMPo7VkLo+GjN+HMNHi/LBRy+NXtWPu7xg35+GY=',NULL,0,'milton','Milton','Hossain',0,'2026-09-26 16:25:08.667743','milton@example.com','USER','Engineering',1,'2026-09-26 16:25:16.933085','2026-09-26 16:25:16.933125'),(3,'pbkdf2_sha256$1500000$2x9E0D0BXW2iqkRcF28N0i$MQ4wn2vtYkOblhLHCWzWjKdOwhX0KY9b+bhovuqyraw=',NULL,0,'karim_analyst','Karim','Hasan',0,'2026-09-26 16:35:14.357870','karim.analyst2026@example.com','ANALYST','Engineering',1,'2026-09-26 16:35:15.824247','2026-09-26 16:35:15.824261'),(4,'pbkdf2_sha256$1500000$cEFyxQOiHgAZJwub2YCV5b$jgws5SGqLxXwRNiQVuvA1wVauVV1zXB8Civva9oFjoI=',NULL,0,'finance_user','Finance','User',0,'2026-09-26 17:05:47.463524','finance.user2026@example.com','USER','Finance',1,'2026-09-26 17:05:48.741277','2026-09-26 17:05:48.741289'),(5,'pbkdf2_sha256$1500000$skG30sGbR976nKili5kfEP$eZrP/uhcRcziau2GpTxAfdA1S5Jl/KyJQY+UepJ24gI=',NULL,0,'finance_analyst','Finance','Analyst',0,'2026-09-27 13:49:05.179783','finance.analyst2026@example.com','ANALYST','Finance',1,'2026-09-27 13:49:06.591691','2026-09-27 13:49:06.591700');
/*!40000 ALTER TABLE `accounts_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_user_groups`
--

DROP TABLE IF EXISTS `accounts_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_user_groups_user_id_group_id_59c0b32f_uniq` (`user_id`,`group_id`),
  KEY `accounts_user_groups_group_id_bd11a704_fk_auth_group_id` (`group_id`),
  CONSTRAINT `accounts_user_groups_group_id_bd11a704_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `accounts_user_groups_user_id_52b62117_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user_groups`
--

LOCK TABLES `accounts_user_groups` WRITE;
/*!40000 ALTER TABLE `accounts_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_user_user_permissions`
--

DROP TABLE IF EXISTS `accounts_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq` (`user_id`,`permission_id`),
  KEY `accounts_user_user_p_permission_id_113bb443_fk_auth_perm` (`permission_id`),
  CONSTRAINT `accounts_user_user_p_permission_id_113bb443_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `accounts_user_user_p_user_id_e4f0a161_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user_user_permissions`
--

LOCK TABLES `accounts_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `accounts_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',3,'add_permission'),(6,'Can change permission',3,'change_permission'),(7,'Can delete permission',3,'delete_permission'),(8,'Can view permission',3,'view_permission'),(9,'Can add group',2,'add_group'),(10,'Can change group',2,'change_group'),(11,'Can delete group',2,'delete_group'),(12,'Can view group',2,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add Blacklisted Token',6,'add_blacklistedtoken'),(22,'Can change Blacklisted Token',6,'change_blacklistedtoken'),(23,'Can delete Blacklisted Token',6,'delete_blacklistedtoken'),(24,'Can view Blacklisted Token',6,'view_blacklistedtoken'),(25,'Can add Outstanding Token',7,'add_outstandingtoken'),(26,'Can change Outstanding Token',7,'change_outstandingtoken'),(27,'Can delete Outstanding Token',7,'delete_outstandingtoken'),(28,'Can view Outstanding Token',7,'view_outstandingtoken'),(29,'Can add user',8,'add_user'),(30,'Can change user',8,'change_user'),(31,'Can delete user',8,'delete_user'),(32,'Can view user',8,'view_user'),(33,'Can add document',9,'add_document'),(34,'Can change document',9,'change_document'),(35,'Can delete document',9,'delete_document'),(36,'Can view document',9,'view_document'),(37,'Can add document chunk',10,'add_documentchunk'),(38,'Can change document chunk',10,'change_documentchunk'),(39,'Can delete document chunk',10,'delete_documentchunk'),(40,'Can view document chunk',10,'view_documentchunk'),(41,'Can add entity',11,'add_entity'),(42,'Can change entity',11,'change_entity'),(43,'Can delete entity',11,'delete_entity'),(44,'Can view entity',11,'view_entity'),(45,'Can add relationship',12,'add_relationship'),(46,'Can change relationship',12,'change_relationship'),(47,'Can delete relationship',12,'delete_relationship'),(48,'Can view relationship',12,'view_relationship');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
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
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_accounts_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
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
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (8,'accounts','user'),(1,'admin','logentry'),(2,'auth','group'),(3,'auth','permission'),(4,'contenttypes','contenttype'),(9,'documents','document'),(10,'documents','documentchunk'),(11,'knowledge_graph','entity'),(12,'knowledge_graph','relationship'),(5,'sessions','session'),(6,'token_blacklist','blacklistedtoken'),(7,'token_blacklist','outstandingtoken');
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
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-09-26 16:18:39.615904'),(2,'contenttypes','0002_remove_content_type_name','2026-09-26 16:18:39.889130'),(3,'auth','0001_initial','2026-09-26 16:18:40.759996'),(4,'auth','0002_alter_permission_name_max_length','2026-09-26 16:18:40.918874'),(5,'auth','0003_alter_user_email_max_length','2026-09-26 16:18:40.931721'),(6,'auth','0004_alter_user_username_opts','2026-09-26 16:18:40.945030'),(7,'auth','0005_alter_user_last_login_null','2026-09-26 16:18:40.960445'),(8,'auth','0006_require_contenttypes_0002','2026-09-26 16:18:40.967039'),(9,'auth','0007_alter_validators_add_error_messages','2026-09-26 16:18:40.978272'),(10,'auth','0008_alter_user_username_max_length','2026-09-26 16:18:40.994668'),(11,'auth','0009_alter_user_last_name_max_length','2026-09-26 16:18:41.009093'),(12,'auth','0010_alter_group_name_max_length','2026-09-26 16:18:41.041736'),(13,'auth','0011_update_proxy_permissions','2026-09-26 16:18:41.053558'),(14,'auth','0012_alter_user_first_name_max_length','2026-09-26 16:18:41.065910'),(15,'accounts','0001_initial','2026-09-26 16:18:41.824178'),(16,'admin','0001_initial','2026-09-26 16:18:42.106455'),(17,'admin','0002_logentry_remove_auto_add','2026-09-26 16:18:42.118685'),(18,'admin','0003_logentry_add_action_flag_choices','2026-09-26 16:18:42.140167'),(19,'documents','0001_initial','2026-09-26 16:18:42.483818'),(20,'knowledge_graph','0001_initial','2026-09-26 16:18:43.035772'),(21,'sessions','0001_initial','2026-09-26 16:18:43.104423'),(22,'token_blacklist','0001_initial','2026-09-26 16:18:43.474796'),(23,'token_blacklist','0002_outstandingtoken_jti_hex','2026-09-26 16:18:43.589145'),(24,'token_blacklist','0003_auto_20171017_2007','2026-09-26 16:18:43.612863'),(25,'token_blacklist','0004_auto_20171017_2013','2026-09-26 16:18:43.773455'),(26,'token_blacklist','0005_remove_outstandingtoken_jti','2026-09-26 16:18:43.915272'),(27,'token_blacklist','0006_auto_20171017_2113','2026-09-26 16:18:43.955628'),(28,'token_blacklist','0007_auto_20171017_2214','2026-09-26 16:18:44.432319'),(29,'token_blacklist','0008_migrate_to_bigautofield','2026-09-26 16:18:44.873678'),(30,'token_blacklist','0010_fix_migrate_to_bigautofield','2026-09-26 16:18:44.910861'),(31,'token_blacklist','0011_linearizes_history','2026-09-26 16:18:44.930654'),(32,'token_blacklist','0012_alter_outstandingtoken_user','2026-09-26 16:18:44.955334'),(33,'token_blacklist','0013_alter_blacklistedtoken_options_and_more','2026-09-26 16:18:44.985292');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('p2u0odosveic3x70cavlnr9zi63gyw1i','.eJxVjMEOwiAQRP-FsyHAUlg8evcbyG5BqRpISnsy_rtt0oMeZ96beYtI61Li2vMcpyTOQovTb8c0PnPdQXpQvTc5trrME8tdkQft8tpSfl0O9--gUC_bGo1X6DVZdDZzNsDIxA48sQpbvAG7AInNACloyMzowuAwoNVKexCfL83_Nu0:1xAV91:AlfbIjfbP8T-O54LhGXtX1QiuJXVm0X3RBb9dJW7oyk','2026-10-10 16:20:59.520895');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents_document`
--

DROP TABLE IF EXISTS `documents_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents_document` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `department` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `uploaded_by_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `documents_document_uploaded_by_id_cc1ba81a_fk_accounts_user_id` (`uploaded_by_id`),
  CONSTRAINT `documents_document_uploaded_by_id_cc1ba81a_fk_accounts_user_id` FOREIGN KEY (`uploaded_by_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents_document`
--

LOCK TABLES `documents_document` WRITE;
/*!40000 ALTER TABLE `documents_document` DISABLE KEYS */;
INSERT INTO `documents_document` VALUES (1,'Engineering Security Policy','Enterprise API security policy','POLICY','All enterprise APIs must use JWT authentication. Administrative operations require appropriate role-based authorization. Sensitive information must not be exposed to unauthorized users.','Engineering',1,'2026-09-26 16:36:22.237726','2026-09-26 16:36:22.237833',3),(2,'Python Programming Guide','Introduction to Python programming','MANUAL','Python is a high-level, general-purpose programming language. Python supports object-oriented programming, functional programming, modules, exceptions, decorators, and asynchronous programming. Python is widely used for web development, data science, automation, machine learning, and backend API development.','Engineering',1,'2026-09-26 16:51:27.046295','2026-09-26 16:51:27.047035',3),(3,'Finance Policy','Finance department policy','POLICY','Only finance employees can access financial information.','Engineering',1,'2026-09-26 17:03:24.121424','2026-09-26 17:03:24.123786',3),(4,'Finance Department Security Policy','Finance department security rules','POLICY','Finance employees must protect financial reports and confidential financial information.','Finance',1,'2026-09-27 13:49:42.561409','2026-09-27 13:49:42.561429',5);
/*!40000 ALTER TABLE `documents_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents_documentchunk`
--

DROP TABLE IF EXISTS `documents_documentchunk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents_documentchunk` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `chunk_index` int unsigned NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `document_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_document_chunk` (`document_id`,`chunk_index`),
  CONSTRAINT `documents_documentch_document_id_13a40b60_fk_documents` FOREIGN KEY (`document_id`) REFERENCES `documents_document` (`id`),
  CONSTRAINT `documents_documentchunk_chk_1` CHECK ((`chunk_index` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents_documentchunk`
--

LOCK TABLES `documents_documentchunk` WRITE;
/*!40000 ALTER TABLE `documents_documentchunk` DISABLE KEYS */;
INSERT INTO `documents_documentchunk` VALUES (1,0,'All enterprise APIs must use JWT authentication. Administrative operations require appropriate role-based authorization. Sensitive information must not be exposed to unauthorized users.','2026-09-26 16:36:22.282370',1),(2,0,'Python is a high-level, general-purpose programming language. Python supports object-oriented programming, functional programming, modules, exceptions, decorators, and asynchronous programming. Python is widely used for web development, data science, automation, machine learning, and backend API development.','2026-09-26 16:51:27.123814',2),(3,0,'Only finance employees can access financial information.','2026-09-26 17:03:24.177078',3),(4,0,'Finance employees must protect financial reports and confidential financial information.','2026-09-27 13:49:42.584159',4);
/*!40000 ALTER TABLE `documents_documentchunk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `knowledge_graph_entity`
--

DROP TABLE IF EXISTS `knowledge_graph_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_graph_entity` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_type_name` (`name`,`entity_type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_graph_entity`
--

LOCK TABLES `knowledge_graph_entity` WRITE;
/*!40000 ALTER TABLE `knowledge_graph_entity` DISABLE KEYS */;
INSERT INTO `knowledge_graph_entity` VALUES (1,'JWT','TECHNOLOGY','JSON Web Token authentication technology','2026-09-26 16:40:00.629216'),(2,'Engineering Department','ORGANIZATION','Enterprise engineering department','2026-09-26 16:40:16.419134'),(3,'Python','TECHNOLOGY','A high-level general-purpose programming language used for web development, data science, automation, machine learning, and backend development.','2026-09-26 16:53:21.451657');
/*!40000 ALTER TABLE `knowledge_graph_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `knowledge_graph_relationship`
--

DROP TABLE IF EXISTS `knowledge_graph_relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_graph_relationship` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `relation_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `source_id` bigint NOT NULL,
  `source_chunk_id` bigint DEFAULT NULL,
  `source_document_id` bigint DEFAULT NULL,
  `target_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_relationship` (`source_id`,`target_id`,`relation_type`),
  KEY `knowledge_graph_rela_source_chunk_id_5841e231_fk_documents` (`source_chunk_id`),
  KEY `knowledge_graph_rela_source_document_id_25621c02_fk_documents` (`source_document_id`),
  KEY `knowledge_graph_rela_target_id_b0357110_fk_knowledge` (`target_id`),
  CONSTRAINT `knowledge_graph_rela_source_chunk_id_5841e231_fk_documents` FOREIGN KEY (`source_chunk_id`) REFERENCES `documents_documentchunk` (`id`),
  CONSTRAINT `knowledge_graph_rela_source_document_id_25621c02_fk_documents` FOREIGN KEY (`source_document_id`) REFERENCES `documents_document` (`id`),
  CONSTRAINT `knowledge_graph_rela_source_id_6bd24125_fk_knowledge` FOREIGN KEY (`source_id`) REFERENCES `knowledge_graph_entity` (`id`),
  CONSTRAINT `knowledge_graph_rela_target_id_b0357110_fk_knowledge` FOREIGN KEY (`target_id`) REFERENCES `knowledge_graph_entity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_graph_relationship`
--

LOCK TABLES `knowledge_graph_relationship` WRITE;
/*!40000 ALTER TABLE `knowledge_graph_relationship` DISABLE KEYS */;
INSERT INTO `knowledge_graph_relationship` VALUES (1,'USES','Engineering Department uses JWT for API authentication.','2026-09-26 16:42:50.508707',2,1,1,1);
/*!40000 ALTER TABLE `knowledge_graph_relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_blacklistedtoken`
--

DROP TABLE IF EXISTS `token_blacklist_blacklistedtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_blacklist_blacklistedtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `blacklisted_at` datetime(6) NOT NULL,
  `token_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_id` (`token_id`),
  CONSTRAINT `token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk` FOREIGN KEY (`token_id`) REFERENCES `token_blacklist_outstandingtoken` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_blacklistedtoken`
--

LOCK TABLES `token_blacklist_blacklistedtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_outstandingtoken`
--

DROP TABLE IF EXISTS `token_blacklist_outstandingtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_blacklist_outstandingtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `expires_at` datetime(6) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `jti` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq` (`jti`),
  KEY `token_blacklist_outs_user_id_83bc629a_fk_accounts_` (`user_id`),
  CONSTRAINT `token_blacklist_outs_user_id_83bc629a_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_outstandingtoken`
--

LOCK TABLES `token_blacklist_outstandingtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` DISABLE KEYS */;
INSERT INTO `token_blacklist_outstandingtoken` VALUES (1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTA0NDgzNSwiaWF0IjoxNzkwNDQwMDM1LCJqdGkiOiI1ODZlYmQxNTBiYzI0MGU4OTQxYjUxYzUxYzU0ZDQxMiIsInVzZXJfaWQiOiIyIn0.JH0GoyAuYeJ2uzwwRf7qMvBQQWp3Awq5yui1RYi9erw','2026-09-26 16:27:15.944663','2026-10-03 16:27:15.000000',2,'586ebd150bc240e8941b51c51c54d412'),(2,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTA0NTM1NywiaWF0IjoxNzkwNDQwNTU3LCJqdGkiOiI4NTY3MDFkMTY2ZTc0ZmUzYWE0ZmUxNDZkMGIyMWMwNSIsInVzZXJfaWQiOiIzIn0.dg-K3BosdHfnxNkZ30W_38OUk4lgvUELJgdqcU65HhY','2026-09-26 16:35:57.223979','2026-10-03 16:35:57.000000',3,'856701d166e74fe3aa4fe146d0b21c05'),(3,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTA0NzE3NSwiaWF0IjoxNzkwNDQyMzc1LCJqdGkiOiJkMDhiZDc3ODdlYWY0OWI5YmQ0ZmFjNjJjYjgyZGExZCIsInVzZXJfaWQiOiI0In0.ECFxeX73pGCgPeRU1Ti2dX8dLUmDcrVvKbBV-uAy0Qg','2026-09-26 17:06:15.961051','2026-10-03 17:06:15.000000',4,'d08bd7787eaf49b9bd4fac62cb82da1d'),(4,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTEyMDA5NywiaWF0IjoxNzkwNTE1Mjk3LCJqdGkiOiJkNWFkYzAzNTczY2I0ODg3YTY3NTkwNWUwZTJlODAwMSIsInVzZXJfaWQiOiI0In0.PRXkHFZ7fhcox3Ok4kuswq1PwUlkg9P2HawlL_hdgvI','2026-09-27 13:21:37.135302','2026-10-04 13:21:37.000000',4,'d5adc03573cb4887a675905e0e2e8001'),(5,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTEyMTQ0MywiaWF0IjoxNzkwNTE2NjQzLCJqdGkiOiIyMmIyYjFkYjhjZDU0YmZkODExMGI5MzUyYzVjOGZjNCIsInVzZXJfaWQiOiIzIn0.ZyLxH2MuJletptSi84s3U7utHfiXGpXcDrpGgTBW1p4','2026-09-27 13:44:03.574124','2026-10-04 13:44:03.000000',3,'22b2b1db8cd54bfd8110b9352c5c8fc4'),(6,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTEyMTY0MiwiaWF0IjoxNzkwNTE2ODQyLCJqdGkiOiI5M2ViNmM2ZmQyNzM0MDM0YTkxNjMxOTg5ZTMzODNjYiIsInVzZXJfaWQiOiI0In0.lVQRS0Up7jswnNVxLxA-5IUnznkfonACUySArOy89fc','2026-09-27 13:47:22.291028','2026-10-04 13:47:22.000000',4,'93eb6c6fd2734034a91631989e3383cb'),(7,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTEyMTc2MiwiaWF0IjoxNzkwNTE2OTYyLCJqdGkiOiI2YzQ5NTZiM2JkMTc0ZWQ1OWUzMDgxYjA3MDQzY2JjNyIsInVzZXJfaWQiOiI1In0.q8NhQINkiQBP3NQWm4JU_-qWFNgCOMIEMpOr-SpIUtg','2026-09-27 13:49:22.582735','2026-10-04 13:49:22.000000',5,'6c4956b3bd174ed59e3081b07043cbc7'),(8,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTEyMTg3MiwiaWF0IjoxNzkwNTE3MDcyLCJqdGkiOiIxMDNmNmYzYzk0MjU0NGViYTBhM2U0OTVjNDFiOTZkZiIsInVzZXJfaWQiOiIzIn0.rXlKK-Q1QzC3yOCLhvDdwSFzXBV-_Ry2f-8dzChGDQE','2026-09-27 13:51:12.290104','2026-10-04 13:51:12.000000',3,'103f6f3c942544eba0a3e495c41b96df');
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-27 22:59:28
