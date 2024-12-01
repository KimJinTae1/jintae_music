-- MySQL dump 10.13  Distrib 9.0.1, for Linux (aarch64)
--
-- Host: localhost    Database: jintae_music
-- ------------------------------------------------------
-- Server version	9.0.1

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
-- Table structure for table `Admin`
--

DROP TABLE IF EXISTS `Admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Admin` (
  `admin_id` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `admin_name` varchar(50) NOT NULL COMMENT 'Admin Name',
  `admin_password` varchar(50) NOT NULL COMMENT 'Admin Password',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='ADMIN Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admin`
--

LOCK TABLES `Admin` WRITE;
/*!40000 ALTER TABLE `Admin` DISABLE KEYS */;
INSERT INTO `Admin` VALUES (1,'jintae','1111'),(2,'rrr','1234');
/*!40000 ALTER TABLE `Admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Comments`
--

DROP TABLE IF EXISTS `Comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Comments` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `music_id` int NOT NULL,
  `content` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `reported` int NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `is_blocked` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'is_blocked',
  PRIMARY KEY (`comment_id`),
  KEY `FK_Comments_User` (`user_id`),
  KEY `FK_Comments_Music` (`music_id`),
  CONSTRAINT `FK_Comments_Music` FOREIGN KEY (`music_id`) REFERENCES `Music` (`music_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Comments_User` FOREIGN KEY (`user_id`) REFERENCES `Users` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Comments`
--

LOCK TABLES `Comments` WRITE;
/*!40000 ALTER TABLE `Comments` DISABLE KEYS */;
INSERT INTO `Comments` VALUES (13,1,16,'그시절 기억이 떠오르네요... 너무 좋습니다...','2024-11-21 17:04:11',0,'2024-11-21 17:04:11','2024-11-21 17:04:11',0),(14,5,32,'캐롤이다 대박~','2024-11-22 11:10:22',0,'2024-11-22 11:10:22','2024-11-22 11:10:22',0),(15,1,32,'그러게요 이제 크리스마스에요','2024-11-22 11:12:50',0,'2024-11-22 11:12:50','2024-11-22 11:12:50',0),(17,5,32,'맞아요, 올해 크리스마스에는 눈사람을 만들꺼에요!','2024-11-23 07:12:15',0,'2024-11-23 07:12:15','2024-11-23 07:12:15',0);
/*!40000 ALTER TABLE `Comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Genres`
--

DROP TABLE IF EXISTS `Genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Genres` (
  `id` int NOT NULL AUTO_INCREMENT,
  `music_id` int NOT NULL,
  `genre_name` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Genres_Music` (`music_id`),
  CONSTRAINT `FK_Genres_Music` FOREIGN KEY (`music_id`) REFERENCES `Music` (`music_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Genres`
--

LOCK TABLES `Genres` WRITE;
/*!40000 ALTER TABLE `Genres` DISABLE KEYS */;
INSERT INTO `Genres` VALUES (1,11,'애니','2024-11-21 16:14:25','2024-11-21 16:14:25'),(2,11,'J-POP','2024-11-21 16:14:25','2024-11-21 16:14:25'),(3,12,'애니','2024-11-21 16:19:23','2024-11-21 16:19:23'),(4,12,'J-POP','2024-11-21 16:19:23','2024-11-21 16:19:23'),(5,13,'애니','2024-11-21 16:21:26','2024-11-21 16:21:26'),(6,13,'활기참','2024-11-21 16:21:26','2024-11-21 16:21:26'),(7,14,'게임','2024-11-21 16:49:12','2024-11-21 16:49:12'),(8,14,'오프닝','2024-11-21 16:49:12','2024-11-21 16:49:12'),(9,14,'웅장함','2024-11-21 16:49:12','2024-11-21 16:49:12'),(10,15,'애니','2024-11-21 16:49:52','2024-11-21 16:49:52'),(11,15,'활기참','2024-11-21 16:49:52','2024-11-21 16:49:52'),(12,16,'애니','2024-11-21 16:50:17','2024-11-21 16:50:17'),(13,16,'활기참','2024-11-21 16:50:17','2024-11-21 16:50:17'),(14,17,'애니','2024-11-21 16:50:42','2024-11-21 16:50:42'),(15,17,'활기참','2024-11-21 16:50:42','2024-11-21 16:50:42'),(16,18,'따뜻함','2024-11-21 16:51:17','2024-11-21 16:51:17'),(17,18,'흥겨움','2024-11-21 16:51:17','2024-11-21 16:51:17'),(18,18,'사랑','2024-11-21 16:51:17','2024-11-21 16:51:17'),(19,19,'비트','2024-11-21 16:51:52','2024-11-21 16:51:52'),(20,20,'따뜻함','2024-11-21 16:52:14','2024-11-21 16:52:14'),(21,21,'신남','2024-11-21 16:52:33','2024-11-21 16:52:33'),(22,22,'신남','2024-11-21 16:52:53','2024-11-21 16:52:53'),(23,23,'사랑','2024-11-21 16:53:21','2024-11-21 16:53:21'),(24,24,'아련함','2024-11-21 16:53:46','2024-11-21 16:53:46'),(25,24,'졸업','2024-11-21 16:53:46','2024-11-21 16:53:46'),(26,25,'웅장함','2024-11-21 16:54:20','2024-11-21 16:54:20'),(27,25,'애니','2024-11-21 16:54:20','2024-11-21 16:54:20'),(28,26,'경쾌','2024-11-21 16:54:58','2024-11-21 16:54:58'),(29,26,'신남','2024-11-21 16:54:58','2024-11-21 16:54:58'),(30,26,'활기','2024-11-21 16:54:58','2024-11-21 16:54:58'),(31,26,'게임','2024-11-21 16:54:58','2024-11-21 16:54:58'),(32,27,'추억','2024-11-21 16:55:21','2024-11-21 16:55:21'),(33,27,'게임','2024-11-21 16:55:21','2024-11-21 16:55:21'),(34,28,'힘찬','2024-11-21 16:56:02','2024-11-21 16:56:02'),(35,28,'희망찬','2024-11-21 16:56:02','2024-11-21 16:56:02'),(36,28,'흥겨움','2024-11-21 16:56:02','2024-11-21 16:56:02'),(37,29,'캐롤','2024-11-21 16:56:33','2024-11-21 16:56:33'),(38,29,'재즈','2024-11-21 16:56:33','2024-11-21 16:56:33'),(39,30,'신남','2024-11-21 16:56:58','2024-11-21 16:56:58'),(40,30,'덥스텝','2024-11-21 16:56:58','2024-11-21 16:56:58'),(41,30,'믹스','2024-11-21 16:56:58','2024-11-21 16:56:58'),(42,30,'클럽','2024-11-21 16:56:58','2024-11-21 16:56:58'),(43,30,'흥겨움','2024-11-21 16:56:58','2024-11-21 16:56:58'),(44,31,'캐롤','2024-11-21 16:57:23','2024-11-21 16:57:23'),(45,31,'신남','2024-11-21 16:57:23','2024-11-21 16:57:23'),(46,32,'캐롤','2024-11-21 16:57:58','2024-11-21 16:57:58'),(47,32,'즐거움','2024-11-21 16:57:58','2024-11-21 16:57:58'),(48,32,'크리스마스','2024-11-21 16:57:58','2024-11-21 16:57:58');
/*!40000 ALTER TABLE `Genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Music`
--

DROP TABLE IF EXISTS `Music`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Music` (
  `music_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `composer` varchar(255) NOT NULL,
  `albumName` varchar(255) NOT NULL,
  `artist` varchar(255) NOT NULL,
  `recommendation` int NOT NULL DEFAULT '0',
  `total_play_count` int NOT NULL DEFAULT '0',
  `monthly_play_count` int NOT NULL DEFAULT '0',
  `release_date` datetime NOT NULL,
  `lyrics` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `make_admin_id` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`music_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Music`
--

LOCK TABLES `Music` WRITE;
/*!40000 ALTER TABLE `Music` DISABLE KEYS */;
INSERT INTO `Music` VALUES (9,'_J_POP_あいみょん_아이묭_満月の夜なら','아이묭','미정','아이묭',1,0,0,'2024-11-21 16:06:39','.','/Users/jintea/workSpace/music_database/uploads/1732205199770-_J_POP_ããã¿ãã_áá¡ááµáá­á¼_æºæã®å¤ãªã.mp3',1,'2024-11-21 16:06:39','2024-12-01 14:57:18'),(11,'君の名は_너의_이름은_주제가_前前前世_전전전세_RADWIMPS_','노다 요지로','너의이름은','RADWIMPS',0,0,0,'2024-11-21 16:14:25','At last, \"Hello!\" You\'ve opened your eyes. 마침내 \"안녕!\" 하고 눈을 떴구나.  But why won\'t you even look me in the eyes, what\'s wrong with you? 하지만 넌 왜 내 눈조차 보지 않니? 무슨 일이야?  You angrily tell me that I\'m late... Well, I\'m sorry, but I did my best and running at my fastest pace 늦었다고 화내는구나... 음... 미안하지만, 난 최선을 다해 나의 가장 빠른 속도로 뛰어왔어.  My heart overtook my body as it flew to find you in this place 여기 있는 너를 찾기 위해 마음이 몸을 앞질러 왔단 말이야.  Seeing your hair flowing, and your eyes glowing aches my very core 너의 머리가 찰랑거리는 것도, 너의 눈이 빛나는 것도 내 가장 깊은 곳을 아프게 해.  Wish I could breathe in the same dimension... I don\'t wanna let it go! 같은 차원에서 숨쉬고 싶어... 가게 놔두고 싶지 않아!  Now that I am finally faced with the voice I\'ve known for so long 마침내 지금 내가 예전부터 알아왔던 목소리와 마주했어.  I don\'t know what the words should be... The very first I say to you 나는 무슨 말을 해야 할지 모르겠어, 너에게 처음으로 하는 말 말이야.  Back in the Zenzenzense \'til this day, been looking everywhere for you! 전, 전, 전, 전생부터 지금까지 널 모든 곳에서 찾아왔어!  I follow the sound of your innocent laughter and it guided me in the right way 너의 순수한 웃음소리를 따라왔더니 날 올바른 곳으로 이끌어줬지.  Even if every piece of you disappeared, and if it scattered everywhere 만약 너의 모든 부분이 사라져 여기저기 흩어지더라도  No, I wouldn\'t waver. I\'ll start back at one, look for you all over again... 아니, 난 흔들리지 않아. 난 처음부터 다시 널 찾기 시작할 거야.  Or maybe instead I\'ll take the whole universe right back to zero again. 아니면 대신에 모든 우주를 아예 원점으로 되돌릴 거야.  Where should I start? How should I explain? 어디서부터 시작할까? 어떻게 설명해야 할까?  Wanna tell you everything that happened while you were in a long, long dream 네가 기나긴 꿈을 꾸는 동안 일어난 모든 일들을 말하고 싶어.  I flew through dozens of skies to tell you the adventures I\'ve been through in hundreds of millions of light-years\' worth... 난 수백만 광년 동안의 모험을 너에게 말해주기 위해 수십개의 하늘을 가로질러 왔어.  But now I\'m here, finally seeing you reflected in my eyes 하지만 난 지금 여기서, 마침내 내 눈에 비친 너를 보고 있어.  I just want to know you, play around and show you who it is that you can be 난 그저 너에 대해 알고, 같이 놀고, 네가 무엇이 될 수 있는지 보여주고 싶어.  I just want to love you, every fragment of you, right down to the pain you feel 난 그저 너를, 너의 모든 조각을, 너를 사랑하고 싶어, 네가 겪는 고통까지 말이야.  Now that we have finally met at many galaxies\' end 수많은 은하의 끝에서 드디어 우리가 만났네.  I don\'t know how to hold your hand so that I don\'t break it 너의 손이 부서지지 않게 잡으려면 난 어떻게 해야할지 모르겠어.  Back in the Zenzenzense \'til this day, been looking everywhere for you! 전, 전, 전생부터 지금까지 널 모든 곳에서 찾아 왔어!  Oh, I love the sound of your unfettered voice and the shedding of tears lead me this way 아, 난 너의 자유로운 목소리와, 날 여기로 이끈 흐르는 눈물조차도 사랑해.  So tell me: Who will ever gonna stop us on this \"The Eve of Revolution\"? 그러니까 나에게 말해줘, \"누가 이 \'혁명 전날밤\'의 우리를 막을 수 있을까?\"  No more hesitation, I will put up a fight! Just put my claim on your heart tonight 더 이상 망설이지 않아, 난 한 번 맞서 볼 거야! 오늘 밤 내 이야기를 네 마음에 놓아두어줘.  \'Cause you took away from me the way to give up, so clearly and awkwardly 넌 완전히, 그리고 어설프게, 나에게서 포기하는 법을 빼앗아 버렸으니까.  I wonder if we can push our way 우리의 길을 개척할 있을지 궁금해.  through the countless barrier that\'s waiting in the future just beyond our view 우리의 시야 바로 너머 미래에 셀 수 없이 많은 장애물들을 통과해서 말이야.  Side by side, no way we can lose. 서로 옆에 있다면, 우린 절대 질 수 없어.  We\'ll beat destiny at its own game and make it follow our rules 우린 운명의 게임을 부서뜨리고, 우리의 규칙에 운명이 따르게 만들 거니까.  And there isn\'t any weapon besides you that I need to use 그리고 나의 무기는 너 말고는 아무것도 없어.  Zenzenzense \'til this day, been looking everywhere for you! 전, 전, 전생부터 지금까지 널 모든 곳에서 찾아 왔어!  I follow the sound of your innocent laughter and it guided me in the right way 너의 순수한 웃음소리를 따라왔더니, 날 올바른 곳으로 이끌어줬지.  Even if every piece of you disappeared, and if it scattered everywhere... 너의 모든 부분이 사라져 여기저기 흩어지더라도  No, I wouldn\'t waver. I will start back at one, look for you all over again 아니, 난 흔들리지 않아. 처음부터 다시 널 찾기 시작할거야.  Took millions of light-years to come up with a verse so my lips that will never end 수백만 광년을 걸려서 만든 이 가사는 내 입술에서 끝나지 않을 거야.','/Users/jintea/workSpace/music_database/uploads/1732205665380-åã®åã¯_áá¥áá´_ááµáá³á·áá³á«_áá®áá¦áá¡_åååä¸_áá¥á«áá¥á«áá¥á«áá¦_RADWIMPS_.mp3',1,'2024-11-21 16:14:25','2024-12-01 14:57:18'),(12,'아무것도 아니야','노다 요지로','너의이름은','RADWIMPS',0,0,0,'2024-11-21 16:19:23','ふたりの間あいだ 通とおり過すぎた風かぜは どこから寂さびしさを運はこんできたの 후타리노 아이다 토-리 스기타 카제와 도코카라 사비시사오 하콘데 키타노 두 사람의 사이를 스쳐 지나가는 바람은 어디서부터 쓸쓸함을 실어온 걸까?  泣ないたりしたそのあとの空そらは やけに透すき通とおおっていたりしたんだ 나이타리시타 소노 아토노 소라와 야케니 스키토-옷테 이타리시탄다 울고 난 뒤에 올려다본 하늘은 유난히 더욱 더 맑아 보이는 것 같아.  いつもは尖とがってた父ちちの言葉ことばが 今日きょうは暖あたたかく感かんじました 이츠모와 토갓테타 치치노 코토바가 쿄-와 아타타카쿠 칸지마시타 언제나 날카롭던 아버지의 말씀이 오늘은 따뜻하게 느껴졌어.  優やさしさも笑顔えがおも夢ゆめの語かたり方かたも 知しらなくて全部ぜんぶ 君きみを真似まねたよ 야사시사모 에가오모 유메노 카타리카타모 시라나쿠테 젠부 키미오 마네타요 상냥함도 미소도 꿈을 이야기하는 방법도 모르니까, 전부 너를 흉내낸 거야.  もう少すこしだけでいい あと少すこしだけでいい もう少すこしだけでいいから 모오 스코시다케데 이이 아토 스코시다케데 이이 모오 스코시다케데 이이카라 정말 조금이라도 좋아, 조금 뒤라도 좋아, 정말 조금이라도 좋으니까  もう少すこしだけでいい あと少すこしだけでいい もう少すこしだけ くっついていようか 모오 스코시다케데 이이 아토 스코시다케데 이이 모오 스코시다케 쿳츠이테이요오카 정말 조금이라도 좋아, 조금 뒤라도 좋으니까, 조금만 더 우리 꼭 붙어 있을까?  僕ぼくらタイムフライヤー 時ときを駆かけ上あがるクライマー 보쿠라 타이무 후라이야아 토키오 카케아가루 쿠라이마아 우리는 시간의 비행자(time flier), 시간을 거슬러가는 등반자(climber).  時ときのかくれんぼ　はぐれっこはもういやなんだ 토키노 카쿠렌보 하구렛코와 모오 이야난다 시간의 숨바꼭질, 놓쳐버리는 건 이젠 싫어.  嬉うれしくて泣なくのは　悲かなしくて　笑わらうのは 우레시쿠테 나쿠노와 카나시쿠테 와라우노와 기쁜데 우는 건, 슬픈 데도 웃는 건  君きみの心こころが 君きみを追おい越こしたんだよ 키미노 코코로가 키미오 오이코시탄다요 네 마음이 너를 앞질렀기 때문이야.   星ほしにまで願ねがって 手てにいれたオモチャも 部屋へやの隅すみいっこに今いま 転ころがってる 호시니마데 네갓테 테니 이레타 오모챠모 헤야노 스밋코니 이마 코로갓테루 별에 소원을 빌어 손에 넣은 장난감도 지금 방 한구석에 굴러다니고 있어.  叶かなえたい夢ゆめも 今日きょうで100個こできたよ たった一ひとつといつか 交換こうかんこしよう 카나에타이 유메모 쿄-데 햣코데키타요 탓타 히토츠토 이츠카 코-칸코시요- 이루고 싶은 꿈도 오늘로 백 개가 되었어. 단 하나를 언젠가 서로 바꾸자.  いつもは喋しゃべらないあの子こに今日きょうは 放課後ほうかご「また明日あした」と声こえをかけた 이츠모와 샤베라나이 아노코니 쿄-와 호-카고 마타 아시타토 코에오 카케타 언제나 말이 없는 그 애에게 오늘은 방과후에 \"내일 보자\"라고 말을 걸었어.  慣なれないこともたまにならいいね 特とくにあなたが 隣となりにいたら 나레나이 코토모 타마니나라 이이네 토쿠니 아나타가 토나리니 이타라 익숙하지 않은 일도 가끔은 괜찮네. 특히 네가 곁에 있다면.  もう少すこしだけでいい あと少すこしだけでいい もう少すこしだけでいいから 모오 스코시다케데 이이 아토 스코시다케데 이이 모오 스코시다케데 이이카라 정말 조금이라도 좋아, 조금 뒤라도 좋아, 정말 조금이라도 좋으니까  もう少すこしだけでいい あと少すこしだけでいい もう少すこしだけ くっついていようよ 모오 스코시다케데 이이 아토 스코시다케데 이이 모오 스코시다케 쿳츠이테이요오요 정말 조금이라도 좋아, 조금 뒤라도 좋으니까, 조금만 더 우리 꼭 붙어 있자.   僕ぼくらタイムフライヤー 君きみを知しいっていたんだ 보쿠라 타이무 후라이야-(time flier) 키미오 싯테이탄다 우리는 시간의 비행자, 너를 알고 있었어.  僕ぼくが 僕ぼくの名前なまえを 覚おぼえるよりずっと前まえに 보쿠가 보쿠노 나마에오 오보에루요리 즛토 마에니 내가 내 이름을 기억하기보다 훨씬 전부터.  君きみのいない 世界せかいにも 何なにかの意味いみはきっとあって 키미노 이나이 세카이니모 나니카노 이미와 킷토 앗테 네가 없는 세상이라도 무언가 의미는 분명 있어.  でも君きみのいない 世界せかいなど 夏休なつやすみのない 八月はちがつのよう 데모 키미노 이나이 세카이나도 나츠야스미노나이 하치가츠노요- 그래도 네가 없는 세계는 여름방학이 없는 8월 같아.  君きみのいない 世界せかいなど 笑わらうことない サンタのよう 키미노 이나이 세카이나도 와라우 코토나이 산타노요- 네가 없는 세계는 웃지 않는 산타 같아.  君きみのいない 世界せかいなど 키미노 이나이 세카이나도 네가 없는 세계 따위.','/Users/jintea/workSpace/music_database/uploads/1732205963371-áá¡áá®áá¥áºáá©_áá¡ááµáá£_.mp3',1,'2024-11-21 16:19:23','2024-12-01 14:57:18'),(13,'butter fly','전영호','Butter-Fly (디지몬 어드벤처)','전영호',0,0,0,'2024-11-21 16:21:26','그래 그리 쉽지는 않겠지 나를 허락해준 세상이란 손쉽게 다가오는 편하고도 감미로운 공간이 아냐 그래도 날아오를거야 작은 날개짓에 꿈을 담아 조금만 기다려봐 Oh my 그래 그리 쉽지는 않겠지 나를 허락해준 세상이란 손쉽게 다가오는 편하고도 감미로운 공간이 아냐 그래도 날아오를거야 작은 날개짓에 꿈을 담아 조금만 기다려봐 Oh my love     나비처럼 날아가 볼까 일렁거리는 바람에 실려 이런 느낌을 언제나 느낄 수 있을까 마음 속의 좁혀 오는 사소한 일은 신경쓰지마 지금 이대로 날아가 모두 잊으면 돼 어떻게 WOW WOW WOW WOW WOW 하늘 끝까지 닿을 수 있을까 이렇게 WOW WOW WOW WOW WOW 여린 날개가 힘을 낼 수 있을까 그래 그리 쉽지는 않겠지 나를 허락해준 세상이란 손쉽게 다가오는 편하고도 감미로운 공간이 아냐 그래도 날아오를거야 작은 날개 밑에 꿈을 담아 조금만 기다려봐 Oh my love','/Users/jintea/workSpace/music_database/uploads/1732206086709-ááµááµáá©á«áá¥áá³áá¦á«áá¥_OST_Butter_fly.mp3',1,'2024-11-21 16:21:26','2024-12-01 14:57:18'),(14,'모두의마블 오프닝 오케스트라','ㅋ','모두의마블','ㅋ',0,0,0,'2024-11-21 16:49:12','ㅋ','/Users/jintea/workSpace/music_database/uploads/1732207752033-áá©áá®áá´_áá¡áá³á¯_áá©áá¦áá³áá³áá¡.mp3',1,'2024-11-21 16:49:12','2024-12-01 14:57:18'),(15,'시간을달리는소녀 변하지않는것 인트로','T-pistonz','ㅋ','심규한',0,0,0,'2024-11-21 16:49:52','ㅋ','/Users/jintea/workSpace/music_database/uploads/1732207792783-ááµáá¡á«áá³á¯_áá¡á¯ááµáá³á«_áá©áá§_áá§á«áá¡ááµ_áá¡á­áá³á«_áá¥áº_inst_ver_áá®á¯áá¥áá¥á«_ááµáá§á¯_.mp3',1,'2024-11-21 16:49:52','2024-12-01 14:57:18'),(16,'썬더일레븐 1기 OP','T-pistonz','썬더일레븐','심규한',1,7,1,'2024-11-21 16:50:17','Stand up Stand up 모두 일어나  썬더 일레븐     눈물은 날려버려 펀치  머리를 쓰란말야 슬라이딩  반짝반짝 씩씩하게 빛나는 천둥의 얼굴들  나가자 도전하자 Go Go  Don﻿`﻿cry 울지말고 파이팅  꾸물꾸물한 기분 힘차게 날려버려     눈물콧물 흘려가며 꿈을 키웠지  새빨간 불꽃을 마음속에 품고  온통 상처뿐인 잡초 죽지않아  초라한 겉모습 맘속엔 강한의지     Stand up Stand up 모두 일어나  용기의 상징은 번쩍번쩍번쩍  Stand up Stand up 모두 일어나  하늘을 향해 높이 들어 붉은 깃발  Stand up Stand up 모두 일어나  썬더 일레븐  썬더 파이팅 썬더 히어로','/Users/jintea/workSpace/music_database/uploads/1732207817606-áá¥á«áá¥ááµá¯áá¦áá³á«_1ááµ_OP.mp3',1,'2024-11-21 16:50:17','2024-12-01 15:10:22'),(17,'썬더일레븐 2기 OP','z','썬더일레븐','ㅋ',0,2,1,'2024-11-21 16:50:42','ㅋ','/Users/jintea/workSpace/music_database/uploads/1732207842282-áá¥á«áá¥ááµá¯áá¦áá³á«_2ááµ_áá©áá³ááµá¼.mp3',1,'2024-11-21 16:50:42','2024-12-01 15:18:27'),(18,'금요일에 만나요','ㅋ','ㅋ','아이유',0,0,0,'2024-11-21 16:51:17','ㅋ','/Users/jintea/workSpace/music_database/uploads/1732207877009-áá¡ááµáá²_áá³á·áá­ááµá¯áá¦_áá¡á«áá¡áá­.mp3',1,'2024-11-21 16:51:17','2024-12-01 14:57:18'),(19,'레옹','박명수','무한도전','아이유, 박명수',0,0,0,'2024-11-21 16:51:52','ㅋ','/Users/jintea/workSpace/music_database/uploads/1732207912950-áá¡ááµáá²_áá¡á¨áá§á¼áá®_áá¦áá©á¼_áá¡ááµáá²_áá©áá¥áá³áá®áá®á«_áá¡á¼áá©_ver_.mp3',1,'2024-11-21 16:51:52','2024-12-01 14:57:18'),(20,'복숭아','아이유','아이유','아이유',0,0,0,'2024-11-21 16:52:14','ㅋㅋ','/Users/jintea/workSpace/music_database/uploads/1732207934141-áá¡ááµáá²_áá©á¨áá®á¼áá¡_áá¡ááµáá²_áá¢áá®á¯áá¥á¼áá¢_ááµá«áá©á¨_.mp3',1,'2024-11-21 16:52:14','2024-12-01 14:57:18'),(21,'분홍신','아이유','아ㅣㅇ유','아이유',0,0,0,'2024-11-21 16:52:33','아ㅣ융','/Users/jintea/workSpace/music_database/uploads/1732207953830-áá¡ááµáá²_áá®á«áá©á¼ááµá«_ááµá«áá¡á·_.mp3',1,'2024-11-21 16:52:33','2024-12-01 14:57:18'),(22,'좋은날','아이유','아이유','아이유',0,0,0,'2024-11-21 16:52:53','아이유','/Users/jintea/workSpace/music_database/uploads/1732207973349-áá¡ááµáá²_áá¡ááµáá²_áá©ááá³á«áá¡á¯.mp3',1,'2024-11-21 16:52:53','2024-12-01 14:57:18'),(23,'여름밤의꿈','아ㅣㅇ유','아ㅣㅇ유','아이유',0,0,0,'2024-11-21 16:53:21','아ㅣㅇ유','/Users/jintea/workSpace/music_database/uploads/1732208001976-áá¡ááµáá²_áá§áá³á·áá¡á·áá´áá®á·.mp3',1,'2024-11-21 16:53:21','2024-12-01 14:57:18'),(24,'졸업','올티','올티','올티',0,0,0,'2024-11-21 16:53:46','올티','/Users/jintea/workSpace/music_database/uploads/1732208026212-áá©á¯ááµ_olltii_áá©á¯áá¥á¸_ááµáá¦á«áá¡á«áá§á¼_.mp3',1,'2024-11-21 16:53:46','2024-12-01 14:57:18'),(25,'원피스 삼대장','원피스','원피스','원피스',0,0,0,'2024-11-21 16:54:20','삼 대 장 삼삼대장','/Users/jintea/workSpace/music_database/uploads/1732208060900-áá¯á«ááµáá³_áá¡á·áá¢áá¡á¼_áá³áá³á·_áá©ááµááµáá¥á¯_.mp3',1,'2024-11-21 16:54:20','2024-12-01 14:57:18'),(26,'포켓몬고 야생포켓몬 조우','포켓몬','포켓몬','포켓몬',0,0,0,'2024-11-21 16:54:58','포켓몬','/Users/jintea/workSpace/music_database/uploads/1732208098355-áá©áá¦áºáá©á«_GO_áá£áá¢á¼_áá©áá¦áºáá©á«_áá¡á½_ááµá«áá¡á·_ááªá¯ááµ_áá³á¼áá¡á·_áá§á¼áá«_áá¦ááµá·_.mp3',1,'2024-11-21 16:54:58','2024-12-01 14:57:18'),(27,'포켓몬스터 DP OP','포켓몬','포켓몬','포켓몬',0,0,0,'2024-11-21 16:55:21','포켓몬','/Users/jintea/workSpace/music_database/uploads/1732208121683-áá©áá¦áºáá©á«áá³áá¥_DP_1ááµ_áá©áá³ááµá¼_Together_2006_.mp3',1,'2024-11-21 16:55:21','2024-12-01 14:57:18'),(28,'always awake','재지팩트','24/26','재지팩트',0,0,0,'2024-11-21 16:56:02','','/Users/jintea/workSpace/music_database/uploads/1732208162508-Always_Awake.mp3',1,'2024-11-21 16:56:02','2024-12-01 14:57:18'),(29,'Doris_day_Winter_wonderland','ㅋ','캐롤','ㅋ',0,0,0,'2024-11-21 16:56:33','ㅋ','/Users/jintea/workSpace/music_database/uploads/1732208193455-Doris_day_Winter_wonderland_áá¢áá©á¯_áá¢áá³_.mp3',1,'2024-11-21 16:56:33','2024-12-01 14:57:18'),(30,'JunTankrillex_Here_To_Stay_vs_Come_And_Get_It','ㅋ','ㅋ','ㅋ',0,0,0,'2024-11-21 16:56:58','ㅋ','/Users/jintea/workSpace/music_database/uploads/1732208218498-JunTankrillex_Here_To_Stay_vs_Come_And_Get_It_ááµá«áá¡á·_áá¥á¸áá³áá¦á¸_ááµá¨áá³_áá³á¯áá¥á¸_áá³á¼áá§áá®á·_.mp3',1,'2024-11-21 16:56:58','2024-12-01 14:57:18'),(31,'Mariah_Carey_All_I_Want_For_Christmas_Is_You_캐롤_','Mariah_Carey','Mariah_Carey','Mariah_Carey',0,0,0,'2024-11-21 16:57:23','Mariah_Carey','/Users/jintea/workSpace/music_database/uploads/1732208243336-Mariah_Carey_All_I_Want_For_Christmas_Is_You_áá¢áá©á¯_.mp3',1,'2024-11-21 16:57:23','2024-12-01 14:57:18'),(32,'Mariah_Carey_Santa_Clause_Is_Coming_To_Town','Mariah_Carey','Mariah_Carey','Mariah_Carey',0,4,0,'2024-11-21 16:57:58','Mariah_Carey','/Users/jintea/workSpace/music_database/uploads/1732208278907-Mariah_Carey_Santa_Clause_Is_Coming_To_Town_áá³ááµáá³áá¡áá³_áá³á¯áá¥áá®á·_áá¢áá©á¯_.mp3',1,'2024-11-21 16:57:58','2024-12-01 14:57:18');
/*!40000 ALTER TABLE `Music` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PlayListSets`
--

DROP TABLE IF EXISTS `PlayListSets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PlayListSets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `playlist_id` int NOT NULL,
  `music_id` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_PlayListSets_PlayList` (`playlist_id`),
  KEY `FK_PlayListSets_Music` (`music_id`),
  CONSTRAINT `FK_PlayListSets_Music` FOREIGN KEY (`music_id`) REFERENCES `Music` (`music_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PlayListSets_PlayList` FOREIGN KEY (`playlist_id`) REFERENCES `PlayLists` (`playlist_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PlayListSets`
--

LOCK TABLES `PlayListSets` WRITE;
/*!40000 ALTER TABLE `PlayListSets` DISABLE KEYS */;
INSERT INTO `PlayListSets` VALUES (8,18,27,'2024-11-21 17:01:28','2024-11-21 17:01:28'),(9,18,25,'2024-11-21 17:01:49','2024-11-21 17:01:49'),(10,18,17,'2024-11-21 17:02:02','2024-11-21 17:02:02'),(11,18,16,'2024-11-21 17:02:09','2024-11-21 17:02:09'),(12,18,15,'2024-11-21 17:02:16','2024-11-21 17:02:16'),(13,18,14,'2024-11-21 17:02:21','2024-11-21 17:02:21'),(14,18,13,'2024-11-21 17:02:26','2024-11-21 17:02:26'),(15,18,12,'2024-11-21 17:02:34','2024-11-21 17:02:34'),(16,18,11,'2024-11-21 17:02:41','2024-11-21 17:02:41'),(17,19,26,'2024-11-22 11:10:30','2024-11-22 11:10:30'),(18,19,27,'2024-11-22 11:10:38','2024-11-22 11:10:38'),(19,19,25,'2024-11-22 11:10:45','2024-11-22 11:10:45');
/*!40000 ALTER TABLE `PlayListSets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PlayLists`
--

DROP TABLE IF EXISTS `PlayLists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PlayLists` (
  `playlist_id` int NOT NULL AUTO_INCREMENT,
  `playlist_name` varchar(255) NOT NULL,
  `playlist_description` varchar(255) NOT NULL,
  `playlist_created_at` datetime NOT NULL,
  `is_open` tinyint(1) NOT NULL DEFAULT '1',
  `maker_id` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`playlist_id`),
  KEY `FK_PlayLists_User` (`maker_id`),
  CONSTRAINT `FK_PlayLists_User` FOREIGN KEY (`maker_id`) REFERENCES `Users` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PlayLists`
--

LOCK TABLES `PlayLists` WRITE;
/*!40000 ALTER TABLE `PlayLists` DISABLE KEYS */;
INSERT INTO `PlayLists` VALUES (5,'2진태플리2ㅣㅣㅣㅣ','테스트용입니다222','2024-11-09 04:36:04',1,1,'2024-11-09 04:36:04','2024-11-09 04:36:04'),(6,'진태플리3','아이유 노래 모음집','2024-11-10 11:19:20',1,1,'2024-11-10 11:19:20','2024-11-10 11:19:20'),(18,'내가들으려고만든 애니노래 모음집','진태가 들으려고 만든 애니노래 모음집 입니다.','2024-11-21 17:01:09',1,1,'2024-11-21 17:01:09','2024-11-21 17:01:09'),(19,'1234의 플레이리스트','게임 노래 모음집','2024-11-22 11:10:10',1,5,'2024-11-22 11:10:10','2024-11-22 11:10:10'),(20,'연말에 듣기 좋은 노래 모음집','데베시 final project 설명용 공개 플레이리스트 입니다.','2024-12-01 14:37:53',1,1,'2024-12-01 14:37:53','2024-12-01 14:37:53'),(21,'나만 볼수 있는 플레이리스트','데베시 final project 설명용 비공개로 만들어보았습니다.','2024-12-01 14:42:54',0,1,'2024-12-01 14:42:54','2024-12-01 14:42:54');
/*!40000 ALTER TABLE `PlayLists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Recommendeds`
--

DROP TABLE IF EXISTS `Recommendeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Recommendeds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `UID` int NOT NULL,
  `music_id` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `UID` (`UID`),
  KEY `Recommendeds_ibfk_2` (`music_id`),
  CONSTRAINT `Recommendeds_ibfk_1` FOREIGN KEY (`UID`) REFERENCES `Users` (`UID`) ON UPDATE CASCADE,
  CONSTRAINT `Recommendeds_ibfk_2` FOREIGN KEY (`music_id`) REFERENCES `Music` (`music_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recommendeds`
--

LOCK TABLES `Recommendeds` WRITE;
/*!40000 ALTER TABLE `Recommendeds` DISABLE KEYS */;
INSERT INTO `Recommendeds` VALUES (16,1,9,'2024-11-21 16:06:57','2024-11-21 16:06:57'),(17,1,16,'2024-11-22 11:00:59','2024-11-22 11:00:59');
/*!40000 ALTER TABLE `Recommendeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `UID` int NOT NULL AUTO_INCREMENT,
  `id` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `register_date` datetime NOT NULL,
  `is_banned` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'is_admin',
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'jintea','$2b$12$wkk8g1GQ7Lru.4bxyf4xt.O3yQIRzTc0jjGU778V.xjM9fhLiXb9y','김진태','2024-11-04 09:37:48',0,'2024-11-04 09:37:48','2024-11-04 09:37:48',1),(2,'hanyang','$2b$12$nnV39MF7/EQY7MsaUVmZdeBwPUHpMmZsR1Do3rzvwZ0VRfqE..8ii','하이리온','2024-11-04 11:06:15',0,'2024-11-04 11:06:15','2024-11-04 11:06:15',0),(3,'sexsexpussypuff','$2b$12$nje72.b6Eut1pY1MTA5S3eoDPnb0O/0ccpzV39WgBod0RFqL8OE7S','구건모','2024-11-04 12:19:49',1,'2024-11-04 12:19:49','2024-11-11 11:37:53',0),(4,'test','$2b$12$nh4YtjaAxJslEoyn2qa4QeQiF8VOWKXVjAnXSd/PNn9iKJ9WkcBqC','테스트용','2024-11-11 08:36:01',1,'2024-11-11 08:36:01','2024-11-11 08:36:01',0),(5,'1234','$2b$12$Jxow2b3QDFFI1KJF8UPUb.ocKSMd4Zml.o4eZ5T6G3o3Sw2Ev0K5a','1234','2024-11-21 10:54:55',0,'2024-11-21 10:54:55','2024-11-21 10:54:55',0),(6,'park2000','$2b$12$S6Qg5ucy8Bwez.c5djyKb.iP2.JIImTSp80TUX9g4gEmFP8AcfVq.','박호연','2024-11-22 02:06:19',0,'2024-11-22 02:06:19','2024-11-22 02:06:19',0);
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-01 16:42:54
