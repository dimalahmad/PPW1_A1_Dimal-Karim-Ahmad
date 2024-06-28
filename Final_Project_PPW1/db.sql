-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 28 Jun 2024 pada 10.07
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ocean_adventure`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateQuizOptions` ()   BEGIN
    DECLARE quiz_id INT;
    DECLARE correct_answer VARCHAR(255);
    DECLARE finished INT DEFAULT 0;
    DECLARE option_id INT;
    DECLARE offset INT;

    -- Cursor to select all quiz ids and their correct answers
    DECLARE quiz_cursor CURSOR FOR
        SELECT quiz_id, quiz_correct_answer
        FROM quizzes;

    -- Declare continue handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

    -- Open the cursor
    OPEN quiz_cursor;

    quiz_loop: LOOP
        FETCH quiz_cursor INTO quiz_id, correct_answer;

        IF finished THEN
            LEAVE quiz_loop;
        END IF;

        -- Check if correct answer exists in options
        IF NOT EXISTS (
            SELECT 1
            FROM quiz_options
            WHERE quiz_id = quiz_id
              AND option_text = correct_answer
        ) THEN
            -- Randomly select an offset between 0 and 4
            SET offset = FLOOR(RAND() * 5);

            -- Get the ID of the option to be replaced
            SELECT option_id AS id INTO option_id
            FROM quiz_options
            WHERE quiz_id = quiz_id
            ORDER BY id
            LIMIT offset, 1;

            -- Replace the selected option with the correct answer
            UPDATE quiz_options
            SET option_text = correct_answer
            WHERE option_id = option_id;
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE quiz_cursor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user_progress` (IN `user_id` INT, IN `progress` FLOAT)   BEGIN
    UPDATE users u
    SET user_progress = progress
    WHERE u.user_id = user_id;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_average_score` (`user_id` INT) RETURNS FLOAT  BEGIN
    DECLARE avg_score FLOAT;
    SELECT AVG(quiz_score) INTO avg_score
    FROM user_quiz_scores
    WHERE user_id = user_id;
    RETURN avg_score;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `biota_view`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `biota_view` (
`biota_id` int(11)
,`biota_name` varchar(255)
,`biota_description` text
,`depth_zone_name` varchar(255)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `depth_zones`
--

CREATE TABLE `depth_zones` (
  `depth_zone_id` int(11) NOT NULL,
  `depth_zone_name` varchar(255) NOT NULL,
  `depth_zone_description` text DEFAULT NULL,
  `min_depth` float NOT NULL,
  `max_depth` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `depth_zones`
--

INSERT INTO `depth_zones` (`depth_zone_id`, `depth_zone_name`, `depth_zone_description`, `min_depth`, `max_depth`) VALUES
(1, 'Epipelagic Zone', 'Epipelagic zone, also known as the sunlight or euphotic zone, is the uppermost layer of the ocean where there is enough sunlight for photosynthesis to occur. It ranges from the surface down to approximately 200 meters deep. This zone is home to a diverse range of marine life, including phytoplankton, zooplankton, small fish, and marine mammals.', 0, 200),
(2, 'Mesopelagic Zone', 'Mesopelagic zone, also known as the twilight or disphotic zone, extends from the bottom of the epipelagic zone down to about 1000 meters deep. In this zone, sunlight is very limited, resulting in a dimly lit environment. Marine life here includes species adapted to low light conditions, such as lanternfish, hatchetfish, and some squid and jellyfish species.', 200, 1000),
(3, 'Bathypelagic Zone', 'Bathypelagic zone, also known as the midnight or aphotic zone, begins below the mesopelagic zone and extends to about 4000 meters deep. It is characterized by complete darkness and very cold temperatures. The animals living here are adapted to extreme conditions, including high pressure and scarce food supply. Deep-sea fish, squid, and some types of octopus are found in this zone.', 1000, 4000),
(4, 'Abyssopelagic Zone', 'Abyssopelagic zone, also known as the abyssal zone, starts at depths of around 4000 meters and extends to about 6000 meters deep. The environment here is pitch black, with temperatures just above freezing. Marine life includes deep-sea creatures like giant squid, anglerfish, and deep-sea anemones adapted to survive in this harsh environment.', 4000, 6000),
(5, 'Hadalpelagic Zone', 'Hadalpelagic zone, also known as the hadal zone, is the deepest part of the ocean, found in oceanic trenches which can reach depths exceeding 6000 meters. This zone is characterized by extreme pressures, cold temperatures, and complete darkness. Few organisms can survive here, including deep-sea amphipods, snailfish, and microbial life adapted to extreme conditions.', 6000, 11000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `marine_biota`
--

CREATE TABLE `marine_biota` (
  `biota_id` int(11) NOT NULL,
  `biota_name` varchar(255) NOT NULL,
  `biota_description` text DEFAULT NULL,
  `depth_zone_id` int(11) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `conservation_status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `marine_biota`
--

INSERT INTO `marine_biota` (`biota_id`, `biota_name`, `biota_description`, `depth_zone_id`, `image_path`, `conservation_status`) VALUES
(1, 'Blue Whale', 'The blue whale (Balaenoptera musculus) is the largest animal known to have ever existed. It can reach lengths of over 100 feet and weigh up to 200 tons. Blue whales are filter feeders, primarily consuming krill and small fish in the epipelagic zone.', 1, 'images/blue_whale.jpg', 'Endangered'),
(2, 'Great White Shark', 'The great white shark (Carcharodon carcharias) is a large predatory fish known for its powerful jaws and sharp teeth. It inhabits the epipelagic zone and feeds on marine mammals and fish.', 1, 'images/great_white_shark.jpg', 'Vulnerable'),
(3, 'Swordfish', 'The swordfish (Xiphias gladius) is a large, predatory fish known for its long, flat bill resembling a sword. It inhabits the epipelagic zone and preys on smaller fish and squid.', 1, 'images/swordfish.jpg', 'Vulnerable'),
(4, 'Dolphin', 'Dolphins are highly intelligent marine mammals that inhabit the epipelagic zone. They are known for their playful behavior and social interactions.', 1, 'images/dolphin.jpg', 'Data Deficient'),
(5, 'Tuna', 'Tunas are large, fast-swimming fish found in the epipelagic zone. They are highly migratory and commercially valuable for fisheries.', 1, 'images/tuna.jpg', 'Vulnerable'),
(6, 'Jellyfish', 'Jellyfish are gelatinous, umbrella-shaped creatures found in the epipelagic zone. They are composed of more than 95% water and can vary greatly in size and color.', 1, 'images/jellyfish.jpg', 'Not Evaluated'),
(7, 'Sea Turtle', 'Sea turtles are reptiles adapted for life in the ocean. They inhabit the epipelagic zone and are known for their long migrations between feeding and nesting grounds.', 1, 'images/sea_turtle.jpg', 'Vulnerable'),
(8, 'Flying Fish', 'Flying fish are known for their ability to glide above the water surface using their enlarged pectoral fins. They inhabit the epipelagic zone and use this adaptation to evade predators.', 1, 'images/flying_fish.jpg', 'Not Evaluated'),
(9, 'Pelican', 'Pelicans are large water birds found in the epipelagic zone. They are known for their long beaks and large throat pouches used for catching fish.', 1, 'images/pelican.jpg', 'Least Concern'),
(10, 'Sailfish', 'Sailfish are large predatory fish known for their elongated bill and incredible speed. They inhabit the epipelagic zone and are prized by sport fishermen.', 1, 'images/sailfish.jpg', 'Vulnerable'),
(11, 'Lanternfish', 'Lanternfish are small, deep-sea fish known for their bioluminescent organs that help them camouflage and communicate in the dimly lit mesopelagic zone.', 2, 'images/lanternfish.jpg', 'Not Evaluated'),
(12, 'Dragonfish', 'Dragonfish are deep-sea fish known for their long, fang-like teeth and bioluminescent capabilities. They inhabit the mesopelagic zone and are adapted to low light conditions.', 2, 'images/dragonfish.jpg', 'Not Evaluated'),
(13, 'Giant Squid', 'Giant squids are large, elusive cephalopods that inhabit the mesopelagic and deeper zones of the ocean. They are known for their size and mysterious behavior.', 2, 'images/giant_squid.jpg', 'Not Evaluated'),
(14, 'Hatchetfish', 'Hatchetfish are small, deep-sea fish with flattened bodies and bioluminescent organs. They inhabit the mesopelagic zone and use their light organs for communication and camouflage.', 2, 'images/hatchetfish.jpg', 'Least Concern'),
(15, 'Barreleye Fish', 'Barreleye fish, also known as spookfish, are small deep-sea fish with transparent heads and tubular eyes. They inhabit the mesopelagic zone and are adapted for deep-sea vision.', 2, 'images/barreleye_fish.jpg', 'Not Evaluated'),
(16, 'Squid', 'Squids are cephalopods with elongated bodies and tentacles equipped with suckers. They inhabit various zones, including the mesopelagic zone, where they are important predators.', 2, 'images/squid.jpg', 'Not Evaluated'),
(17, 'Viperfish', 'Viperfish are deep-sea fish known for their long, needle-like teeth and large mouths. They inhabit the mesopelagic zone and use their sharp teeth to capture prey.', 2, 'images/viperfish.jpg', 'Least Concern'),
(18, 'Black Swallower', 'The black swallower is a deep-sea fish known for its ability to swallow prey much larger than itself due to its expandable stomach. It inhabits the mesopelagic zone.', 2, 'images/black_swallow.jpg', 'Not Evaluated'),
(19, 'Gulper Eel', 'Gulper eels, also known as pelican eels, are deep-sea fish with large mouths and elongated bodies. They inhabit the mesopelagic zone and use their large jaws to swallow prey.', 2, 'images/gulper_eel.jpg', 'Not Evaluated'),
(20, 'Deep-sea Anglerfish', 'Deep-sea anglerfish are carnivorous fish known for their bioluminescent lure used to attract prey. They inhabit the mesopelagic and deeper zones.', 2, 'images/anglerfish.jpg', 'Not Evaluated'),
(21, 'Fangtooth Fish', 'Fangtooth fish are deep-sea fish known for their large, fang-like teeth and ferocious appearance. They inhabit the bathypelagic zone and feed on smaller fish and crustaceans.', 3, 'images/fangtooth_fish.jpg', 'Least Concern'),
(22, 'Giant Isopod', 'Giant isopods are large crustaceans found in the deep sea, including the bathypelagic zone. They are scavengers, feeding on carrion that sinks from above.', 3, 'images/giant_isopod.jpg', 'Not Evaluated'),
(23, 'Deep-sea Dragonfish', 'Deep-sea dragonfish are predatory fish known for their long, needle-like teeth and bioluminescent capabilities. They inhabit the bathypelagic zone.', 3, 'images/deep_sea_dragonfish.jpg', 'Not Evaluated'),
(24, 'Blobfish', 'The blobfish is a deep-sea fish known for its gelatinous appearance and lack of buoyancy in shallow waters. It inhabits the bathypelagic zone where pressures are extreme.', 3, 'images/blobfish.jpg', 'Vulnerable'),
(25, 'Barrel-eye Fish', 'Barrel-eye fish are deep-sea fish with tubular eyes and transparent heads. They inhabit the bathypelagic zone and are adapted for deep-sea vision and detection of bioluminescence.', 3, 'images/barrel_eye_fish.jpg', 'Not Evaluated'),
(26, 'Deep-sea Octopus', 'Deep-sea octopuses are cephalopods adapted to life in the bathypelagic and abyssopelagic zones. They are known for their intelligence and ability to camouflage in their environment.', 3, 'images/deep_sea_octopus.jpg', 'Not Evaluated'),
(27, 'Giant Tube Worms', 'Giant tube worms are marine invertebrates found near hydrothermal vents in the bathypelagic zone. They rely on chemosynthetic bacteria for energy.', 3, 'images/giant_tube_worm.jpg', 'Least Concern'),
(28, 'Deep-sea Siphonophore', 'Deep-sea siphonophores are colonial organisms related to jellyfish. They inhabit the bathypelagic zone and are known for their bioluminescent displays.', 3, 'images/siphonophore.jpg', 'Not Evaluated'),
(29, 'Deep-sea Hatchetfish', 'Deep-sea hatchetfish are small, silvery fish with flattened bodies and bioluminescent organs. They inhabit the bathypelagic zone and use their light organs for communication and camouflage.', 3, 'images/deep_sea_hatchetfish.jpg', 'Not Evaluated'),
(30, 'Gulper Shark', 'Gulper sharks, also known as sleeper sharks, are large, slow-moving sharks found in the bathypelagic zone. They feed on a variety of deep-sea fish and invertebrates.', 3, 'images/gulper_shark.jpg', 'Not Evaluated'),
(31, 'Giant Spider Crab', 'Giant spider crabs are large marine arthropods found in the abyssopelagic zone. They have long legs and are scavengers, feeding on organic matter that sinks from above.', 4, 'images/giant_spider_crab.jpg', 'Not Evaluated'),
(32, 'Deep-sea Anemone', 'Deep-sea anemones are marine animals related to corals and jellyfish. They inhabit the abyssopelagic zone and use their tentacles to capture prey.', 4, 'images/deep_sea_anemone.jpg', 'Not Evaluated'),
(33, 'Barreleye Fish', 'Barreleye fish, also known as spookfish, are small deep-sea fish with transparent heads and tubular eyes. They inhabit the abyssopelagic zone and are adapted for deep-sea vision.', 4, 'images/barreleye_fish_abyssopelagic.jpg', 'Not Evaluated'),
(34, 'Deep-sea Anglerfish', 'Deep-sea anglerfish are carnivorous fish known for their bioluminescent lure used to attract prey. They inhabit the abyssopelagic and deeper zones.', 4, 'images/anglerfish_abyssopelagic.jpg', 'Not Evaluated'),
(35, 'Giant Tube Worms', 'Giant tube worms are marine invertebrates found near hydrothermal vents in the abyssopelagic zone. They rely on chemosynthetic bacteria for energy.', 4, 'images/giant_tube_worm_abyssopelagic.jpg', 'Least Concern'),
(36, 'Squat Lobster', 'Squat lobsters are small crustaceans found in the abyssopelagic zone. They are scavengers, feeding on organic material that sinks from above.', 4, 'images/squat_lobster.jpg', 'Not Evaluated'),
(37, 'Deep-sea Dragonfish', 'Deep-sea dragonfish are predatory fish known for their long, needle-like teeth and bioluminescent capabilities. They inhabit the abyssopelagic zone.', 4, 'images/deep_sea_dragonfish_abyssopelagic.jpg', 'Not Evaluated'),
(38, 'Deep-sea Jellyfish', 'Deep-sea jellyfish are gelatinous creatures found in the abyssopelagic zone. They are adapted to survive in the extreme conditions of the deep sea.', 4, 'images/deep_sea_jellyfish.jpg', 'Not Evaluated'),
(39, 'Deep-sea Squid', 'Deep-sea squids are cephalopods adapted to life in the abyssopelagic and deeper zones. They are agile predators with tentacles equipped with powerful suckers.', 4, 'images/deep_sea_squid.jpg', 'Not Evaluated'),
(40, 'Deep-sea Worms', 'Deep-sea worms are marine invertebrates found in the abyssopelagic zone. They play a crucial role in recycling nutrients on the ocean floor.', 4, 'images/deep_sea_worms.jpg', 'Not Evaluated'),
(41, 'Giant Isopod', 'Giant isopods are large crustaceans found in the deep sea, including the hadalpelagic zone. They are scavengers, feeding on carrion that sinks from above.', 5, 'images/giant_isopod_hadalpelagic.jpg', 'Not Evaluated'),
(42, 'Deep-sea Amphipods', 'Deep-sea amphipods are small crustaceans adapted to life in the hadalpelagic zone. They are important scavengers, feeding on organic material that sinks from above.', 5, 'images/deep_sea_amphipods.jpg', 'Not Evaluated'),
(43, 'Snailfish', 'Snailfish are small, scaleless fish found in the hadalpelagic zone. They are adapted to withstand the extreme pressures and cold temperatures of the deep sea.', 5, 'images/snailfish.jpg', 'Not Evaluated'),
(44, 'Deep-sea Jellyfish', 'Deep-sea jellyfish are gelatinous creatures found in the hadalpelagic zone. They are adapted to survive in the extreme conditions of the deep sea.', 5, 'images/deep_sea_jellyfish_hadalpelagic.jpg', 'Not Evaluated'),
(45, 'Deep-sea Anglerfish', 'Deep-sea anglerfish are carnivorous fish known for their bioluminescent lure used to attract prey. They inhabit the hadalpelagic and deeper zones.', 5, 'images/anglerfish_hadalpelagic.jpg', 'Not Evaluated'),
(46, 'Mariana Trench Shrimp', 'Mariana trench shrimps are small crustaceans found in the hadalpelagic zone, particularly in ocean trenches such as the Mariana Trench. They are scavengers, feeding on detritus and small organisms.', 5, 'images/mariana_trench_shrimp.jpg', 'Not Evaluated'),
(47, 'Hadal Snailfish', 'Hadal snailfish are small fish adapted to life in the hadalpelagic zone. They are among the deepest dwelling fish species, found in ocean trenches.', 5, 'images/hadal_snailfish.jpg', 'Not Evaluated'),
(48, 'Deep-sea Eels', 'Deep-sea eels are elongated fish found in the hadalpelagic zone. They are adapted to dark, cold environments and are often found in deep-sea trenches.', 5, 'images/deep_sea_eels.jpg', 'Not Evaluated'),
(49, 'Giant Sea Spiders', 'Giant sea spiders are marine arthropods found in the hadalpelagic zone. They have long, thin bodies and are scavengers, feeding on small marine organisms.', 5, 'images/giant_sea_spiders.jpg', 'Not Evaluated'),
(50, 'Deep-sea Amphipods', 'Deep-sea amphipods are small crustaceans adapted to life in the hadalpelagic zone. They are important scavengers, feeding on organic material that sinks from above.', 5, 'images/deep_sea_amphipods_hadalpelagic.jpg', 'Not Evaluated');

-- --------------------------------------------------------

--
-- Struktur dari tabel `quizzes`
--

CREATE TABLE `quizzes` (
  `quiz_id` int(11) NOT NULL,
  `quiz_question` text DEFAULT NULL,
  `quiz_correct_answer` text DEFAULT NULL,
  `depth_zone_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `quizzes`
--

INSERT INTO `quizzes` (`quiz_id`, `quiz_question`, `quiz_correct_answer`, `depth_zone_id`) VALUES
(1, 'Which marine mammal is known for its long migrations and filter feeding habits?', 'Blue Whale', 1),
(2, 'What is the largest predatory fish that inhabits the Epipelagic Zone?', 'Great White Shark', 1),
(3, 'Which fish is known for its long, flat bill resembling a sword?', 'Swordfish', 1),
(4, 'Which marine reptile is known for its ability to migrate long distances?', 'Sea Turtle', 1),
(5, 'Which group of animals includes species like dolphins and whales?', 'Cetaceans', 1),
(6, 'Which deep-sea fish is known for its bioluminescent organs and camouflage ability?', 'Lanternfish', 2),
(7, 'What type of fish has a transparent head and tubular eyes?', 'Barreleye Fish', 2),
(8, 'Which deep-sea creature is known for its large size and elusive behavior?', 'Giant Squid', 2),
(9, 'Which fish has an elongated bill and is known for its speed?', 'Sailfish', 2),
(10, 'Which group of animals includes species adapted for low light conditions?', 'Deep-sea Fish', 2),
(11, 'Which deep-sea fish is known for its large, fang-like teeth and ferocious appearance?', 'Fangtooth Fish', 3),
(12, 'What is the name of the deep-sea fish with a gelatinous appearance and lack of buoyancy?', 'Blobfish', 3),
(13, 'Which deep-sea creature has transparent heads and tubular eyes?', 'Barrel-eye Fish', 3),
(14, 'Which deep-sea animal has a bioluminescent lure to attract prey?', 'Deep-sea Anglerfish', 3),
(15, 'Which group of marine animals includes species found near hydrothermal vents?', 'Vent Fauna', 3),
(16, 'Which marine creature is known for its long, needle-like teeth and bioluminescent capabilities?', 'Deep-sea Dragonfish', 4),
(17, 'What is the name of the large marine arthropod found in the abyssopelagic zone?', 'Giant Spider Crab', 4),
(18, 'Which deep-sea invertebrate relies on chemosynthetic bacteria for energy?', 'Giant Tube Worms', 4),
(19, 'Which marine animal is related to corals and jellyfish and uses tentacles to capture prey?', 'Deep-sea Anemone', 4),
(20, 'Which group of animals includes species adapted to extreme pressure and darkness?', 'Deep-sea Fauna', 4),
(21, 'Which crustacean is known for its scavenging behavior in the deepest parts of the ocean?', 'Giant Isopod', 5),
(22, 'What is the name of the small crustacean found in ocean trenches like the Mariana Trench?', 'Mariana Trench Shrimp', 5),
(23, 'Which deep-sea fish is adapted to dark, cold environments and is found in ocean trenches?', 'Snailfish', 5),
(24, 'Which marine animal has elongated bodies and is known for scavenging on the ocean floor?', 'Deep-sea Eels', 5),
(25, 'Which group of animals includes species adapted to the extreme pressures of the hadalpelagic zone?', 'Deep-sea Creatures', 5);

-- --------------------------------------------------------

--
-- Struktur dari tabel `quiz_options`
--

CREATE TABLE `quiz_options` (
  `option_id` int(11) NOT NULL,
  `quiz_id` int(11) DEFAULT NULL,
  `option_text` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `quiz_options`
--

INSERT INTO `quiz_options` (`option_id`, `quiz_id`, `option_text`) VALUES
(126, 1, 'Blue Whale'),
(127, 1, 'Humpback Whale'),
(128, 1, 'Grey Whale'),
(129, 1, 'Orca'),
(131, 2, 'Great White Shark'),
(132, 2, 'Tiger Shark'),
(133, 2, 'Hammerhead Shark'),
(134, 2, 'Mako Shark'),
(136, 3, 'Swordfish'),
(137, 3, 'Marlin'),
(138, 3, 'Sailfish'),
(139, 3, 'Bluefish'),
(141, 4, 'Sea Turtle'),
(142, 4, 'Green Turtle'),
(143, 4, 'Hawksbill Turtle'),
(144, 4, 'Leatherback Turtle'),
(146, 5, 'Cetaceans'),
(147, 5, 'Pinnipeds'),
(148, 5, 'Sirenians'),
(149, 5, 'Fissipeds'),
(151, 6, 'Lanternfish'),
(152, 6, 'Anglerfish'),
(153, 6, 'Viperfish'),
(154, 6, 'Hatchetfish'),
(156, 7, 'Barreleye Fish'),
(157, 7, 'Blobfish'),
(158, 7, 'Stargazer Fish'),
(159, 7, 'Gulper Eel'),
(161, 8, 'Giant Squid'),
(162, 8, 'Colossal Squid'),
(163, 8, 'Humboldt Squid'),
(164, 8, 'Arrow Squid'),
(166, 9, 'Sailfish'),
(167, 9, 'Marlin'),
(168, 9, 'Bluefish'),
(169, 9, 'Barracuda'),
(171, 10, 'Deep-sea Fish'),
(172, 10, 'Pelagic Fish'),
(173, 10, 'Reef Fish'),
(174, 10, 'Benthic Fish'),
(176, 11, 'Fangtooth Fish'),
(177, 11, 'Gulper Eel'),
(178, 11, 'Hatchetfish'),
(179, 11, 'Dragonfish'),
(181, 12, 'Blobfish'),
(182, 12, 'Barreleye Fish'),
(183, 12, 'Stargazer Fish'),
(184, 12, 'Gulper Eel'),
(186, 13, 'Barrel-eye Fish'),
(187, 13, 'Blobfish'),
(188, 13, 'Stargazer Fish'),
(189, 13, 'Gulper Eel'),
(191, 14, 'Deep-sea Anglerfish'),
(192, 14, 'Lanternfish'),
(193, 14, 'Viperfish'),
(194, 14, 'Hatchetfish'),
(196, 15, 'Vent Fauna'),
(197, 15, 'Reef Fauna'),
(198, 15, 'Pelagic Fauna'),
(199, 15, 'Benthic Fauna'),
(201, 16, 'Deep-sea Dragonfish'),
(202, 16, 'Lanternfish'),
(203, 16, 'Viperfish'),
(204, 16, 'Hatchetfish'),
(206, 17, 'Giant Spider Crab'),
(207, 17, 'King Crab'),
(208, 17, 'Snow Crab'),
(209, 17, 'Dungeness Crab'),
(211, 18, 'Giant Tube Worms'),
(212, 18, 'Hydrothermal Worms'),
(213, 18, 'Vestimentiferan Worms'),
(214, 18, 'Polychaete Worms'),
(216, 19, 'Deep-sea Anemone'),
(217, 19, 'Coral Anemone'),
(218, 19, 'Tube Anemone'),
(219, 19, 'Sea Anemone'),
(221, 20, 'Deep-sea Fauna'),
(222, 20, 'Reef Fauna'),
(223, 20, 'Pelagic Fauna'),
(224, 20, 'Benthic Fauna'),
(226, 21, 'Giant Isopod'),
(227, 21, 'Horseshoe Crab'),
(228, 21, 'Amphipod'),
(229, 21, 'Deep-sea Crab'),
(231, 22, 'Mariana Trench Shrimp'),
(232, 22, 'Hydrothermal Vent Shrimp'),
(233, 22, 'Deep-sea Shrimp'),
(234, 22, 'Pelagic Shrimp'),
(236, 23, 'Snailfish'),
(237, 23, 'Deep-sea Fish'),
(238, 23, 'Pelagic Fish'),
(239, 23, 'Benthic Fish'),
(241, 24, 'Deep-sea Eels'),
(242, 24, 'Conger Eel'),
(243, 24, 'Moray Eel'),
(244, 24, 'Garden Eel'),
(246, 25, 'Deep-sea Creatures'),
(247, 25, 'Reef Creatures'),
(248, 25, 'Pelagic Creatures'),
(249, 25, 'Benthic Creatures');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `quiz_view`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `quiz_view` (
`quiz_id` int(11)
,`quiz_question` text
,`depth_zone_name` varchar(255)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_progress` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`user_id`, `username`, `user_email`, `user_progress`) VALUES
(1, 'john_doe', 'john.doe@example.com', 0.733333),
(2, 'jane_smith', 'jane.smith@example.com', 0),
(3, 'michael_jackson', 'michael.jackson@example.com', 0),
(4, 'sarah_brown', 'sarah.brown@example.com', 0),
(5, 'david_green', 'david.green@example.com', 0),
(10, 'd.arsya_', 'kamaluddin.arsyad17@gmail.com', 0.933333),
(11, 'd.arsya_', 'kamaluddinarsyadfadllillah@mail.ugm.ac.id', 0);

--
-- Trigger `users`
--
DELIMITER $$
CREATE TRIGGER `before_user_insert` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
    IF NEW.user_progress IS NULL THEN
        SET NEW.user_progress = 0;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_user_insert_email` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
    IF NEW.user_email NOT LIKE '%@%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid email format';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_quiz_scores`
--

CREATE TABLE `user_quiz_scores` (
  `user_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `quiz_score` float DEFAULT NULL,
  `completion_date` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `user_quiz_scores`
--

INSERT INTO `user_quiz_scores` (`user_id`, `quiz_id`, `quiz_score`, `completion_date`) VALUES
(1, 1, 1, '2024-06-28'),
(1, 2, 1, '2024-06-28'),
(1, 3, 0.2, '2024-06-28'),
(10, 1, 0.2, '2024-06-28'),
(10, 3, 0.8, '2024-06-28'),
(10, 4, 1, '2024-06-28');

--
-- Trigger `user_quiz_scores`
--
DELIMITER $$
CREATE TRIGGER `after_quiz_completion` AFTER INSERT ON `user_quiz_scores` FOR EACH ROW BEGIN
    DECLARE user_progress FLOAT;
    SET user_progress = (SELECT AVG(quiz_score) FROM user_quiz_scores WHERE user_id=NEW.user_id);
    CALL update_user_progress(NEW.user_id, user_progress);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur untuk view `biota_view`
--
DROP TABLE IF EXISTS `biota_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `biota_view`  AS SELECT `b`.`biota_id` AS `biota_id`, `b`.`biota_name` AS `biota_name`, `b`.`biota_description` AS `biota_description`, `d`.`depth_zone_name` AS `depth_zone_name` FROM (`marine_biota` `b` join `depth_zones` `d` on(`b`.`depth_zone_id` = `d`.`depth_zone_id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `quiz_view`
--
DROP TABLE IF EXISTS `quiz_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quiz_view`  AS SELECT `q`.`quiz_id` AS `quiz_id`, `q`.`quiz_question` AS `quiz_question`, `d`.`depth_zone_name` AS `depth_zone_name` FROM (`quizzes` `q` join `depth_zones` `d` on(`q`.`depth_zone_id` = `d`.`depth_zone_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `depth_zones`
--
ALTER TABLE `depth_zones`
  ADD PRIMARY KEY (`depth_zone_id`);

--
-- Indeks untuk tabel `marine_biota`
--
ALTER TABLE `marine_biota`
  ADD PRIMARY KEY (`biota_id`),
  ADD KEY `depth_zone_id` (`depth_zone_id`);

--
-- Indeks untuk tabel `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`quiz_id`),
  ADD KEY `depth_zone_id` (`depth_zone_id`);

--
-- Indeks untuk tabel `quiz_options`
--
ALTER TABLE `quiz_options`
  ADD PRIMARY KEY (`option_id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`,`user_email`);

--
-- Indeks untuk tabel `user_quiz_scores`
--
ALTER TABLE `user_quiz_scores`
  ADD PRIMARY KEY (`user_id`,`quiz_id`),
  ADD KEY `user_quiz_scores_ibfk_2` (`quiz_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `depth_zones`
--
ALTER TABLE `depth_zones`
  MODIFY `depth_zone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `marine_biota`
--
ALTER TABLE `marine_biota`
  MODIFY `biota_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT untuk tabel `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `quiz_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `quiz_options`
--
ALTER TABLE `quiz_options`
  MODIFY `option_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=251;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `marine_biota`
--
ALTER TABLE `marine_biota`
  ADD CONSTRAINT `marine_biota_ibfk_1` FOREIGN KEY (`depth_zone_id`) REFERENCES `depth_zones` (`depth_zone_id`);

--
-- Ketidakleluasaan untuk tabel `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quizzes_ibfk_1` FOREIGN KEY (`depth_zone_id`) REFERENCES `depth_zones` (`depth_zone_id`);

--
-- Ketidakleluasaan untuk tabel `user_quiz_scores`
--
ALTER TABLE `user_quiz_scores`
  ADD CONSTRAINT `user_quiz_scores_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `user_quiz_scores_ibfk_2` FOREIGN KEY (`quiz_id`) REFERENCES `depth_zones` (`depth_zone_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
