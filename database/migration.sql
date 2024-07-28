CREATE TABLE `roles` (
    `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `level` int NOT NULL,
    `created_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE INDEX `role_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `users` (
    `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `username` varchar(255) NOT NULL,
    `license` varchar(255) NOT NULL,
    `created_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE INDEX `user_license` (`license`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `characters` (
    `id` BIGINT UNSIGNED  NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED  NOT NULL,
    `role_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
    `first_name` varchar(255) NOT NULL,
    `last_name` varchar(255) NOT NULL,
    `dob` varchar(255) NOT NULL,
    `dollars` decimal(15,2) NOT NULL,
    `gold` decimal(15,2) NOT NULL,
    `tokens` BIGINT NOT NULL,
    `xp` float NOT NULL,
    `x` decimal(15,10) NOT NULL,
    `y` decimal(15,10) NOT NULL,
    `z` decimal(15,10) NOT NULL,
    `lang` varchar(255) NOT NULL,
    `dead` tinyint DEFAULT 0,
    `model` varchar(255) NOT NULL,
    `img` varchar(255) DEFAULT NULL,
    `description` varchar(255) DEFAULT NULL,
    `created_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `FK_User` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_Role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `character_appearance` (
  `id` bigint(20) unsigned NOT NULL,
  `attributes` text DEFAULT '{}',
  `clothing` text DEFAULT '{}',
  `overlays` text DEFAULT '{}',
  `clothingtints` text DEFAULT '{}',
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_character_appearance_characters` FOREIGN KEY (`id`) REFERENCES `characters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `ground` (
    `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `x` decimal(15,10) NOT NULL,
    `y` decimal(15,10) NOT NULL,
    `z` decimal(15,10) NOT NULL,
    `created_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `inventory` (
    `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `uuid` UUID NOT NULL DEFAULT UUID(),
    `name` varchar(255) NULL,
    `max_weight` INT UNSIGNED NULL,
    `location` varchar(255) NULL,
    `ignore_item_limit` tinyint DEFAULT 0,
    `character_id` BIGINT UNSIGNED NULL,
    `created_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `FK_InventoryCharacter` FOREIGN KEY (`character_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `categories` (
    `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `created_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE TABLE `items` (
  `id` bigint UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `description` varchar(255) NULL,
  `max_quantity` int(11) DEFAULT 0,
  `max_stack_size` int(11) NOT NULL DEFAULT 10,
  `weight` int(11) NOT NULL DEFAULT 0,
  `usable` tinyint(1) DEFAULT 0,
  `category_id` bigint(20) unsigned NOT NULL,
  `type` ENUM('item_item', 'item_weapon', 'item_ammo') DEFAULT 'item_item',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `FK_Category` (`category_id`) USING BTREE,
  KEY `item_name` (`name`) USING BTREE,
  CONSTRAINT `FK_Category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `inventory_items` (
    `id` BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `inventory_id` BIGINT UNSIGNED NOT NULL,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `FK_Inventory` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_InventoryItem` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE TABLE `item_metadata` (
    `inventory_items_id` BIGINT UNSIGNED NOT NULL,
    `key` VARCHAR(50) NOT NULL,
    `value` VARCHAR(100) NOT NULL,
    `created_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `FK_InventoryItemsMetadata` FOREIGN KEY (`inventory_items_id`) REFERENCES `inventory_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(`inventory_items_id`, `key`)
)ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE TABLE `inventory_blacklist` (
    `inventory_id` BIGINT UNSIGNED NOT NULL,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `FK_InventoryBlacklist` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_InventoryItemBlacklist` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (`inventory_id`, `item_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

/*Weapons SQL*/
INSERT INTO categories (name) VALUES ("weapons");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("knife_jawbone", 'Jawbone Knife', "A Jawbone Knife", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("machete", 'Machete', "A Machete", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("torch", 'Torch', "A Torch", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("knife", 'Knife', "A Knife", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("machete_horror", 'Horror Machete', "A Horror Machete", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("knife_trader", 'Trader Knife', "A Trader Knife", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("machete_collector", 'Collector Machete', "A Collector Machete", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("knife_horror", 'Horror Knife', "A Horror Knife", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("knife_rustic", 'Rustic Knife', "A Rustic Knife", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("volcanic_pistol", 'Volcanic Pistol', "A Volcanic Pistol", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("m1899_pistol", 'M1899 Pistol', "An M1899 Pistol", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("semiauto_pistol", 'Semi-Auto Pistol', "A Semi-Auto Pistol", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("mauser_pistol", 'Mauser Pistol', "A Mauser Pistol", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("doubleaction_revolver", 'Double-Action Revolver', "A Double-Action Revolver", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("cattleman_revolver", 'Cattleman Revolver', "A Cattleman Revolver", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("mexican_cattleman_revolver", 'Mexican Cattleman Revolver', "A Mexican Cattleman Revolver", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("lemat_revolver", 'LeMat Revolver', "A LeMat Revolver", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("schofield_revolver", 'Schofield Revolver', "A Schofield Revolver", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("doubleaction_gambler_revolver", 'Gambler Double-Action Revolver', "A Gambler Double-Action Revolver", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("navy_revolver", 'Navy Revolver', "A Navy Revolver", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("crossover_navy_revolver", 'Crossover Navy Revolver', "A Crossover Navy Revolver", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("sawedoff_shotgun", 'Sawed-Off Shotgun', "A Sawed-Off Shotgun", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("evans_repeater", 'Evans Repeater', "An Evans Repeater", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("henry_repeater", 'Henry Repeater', "A Henry Repeater", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("winchester_repeater", 'Winchester Repeater', "A Winchester Repeater", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("carbine_repeater", 'Carbine Repeater', "A Carbine Repeater", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("springfield_rifle", 'Springfield Rifle', "A Springfield Rifle", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("boltaction_rifle", 'Bolt-Action Rifle', "A Bolt-Action Rifle", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("varmint_rifle", 'Varmint Rifle', "A Varmint Rifle", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("elephant_rifle", 'Elephant Rifle', "An Elephant Rifle", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("exotic_doublebarrel_shotgun", 'Exotic Double-Barrel Shotgun', "An Exotic Double-Barrel Shotgun", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("pump_shotgun", 'Pump Shotgun', "A Pump Shotgun", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("repeating_shotgun", 'Repeating Shotgun', "A Repeating Shotgun", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("semiauto_shotgun", 'Semi-Auto Shotgun', "A Semi-Auto Shotgun", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("doublebarrel_shotgun", 'Double-Barrel Shotgun', "A Double-Barrel Shotgun", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("carcano_sniper", 'Carcano Sniper Rifle', "A Carcano Sniper Rifle", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("rollingblock_sniper", 'Rolling Block Sniper Rifle', "A Rolling Block Sniper Rifle", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("bow", 'Bow', "A Bow", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("improved_bow", 'Improved Bow', "An Improved Bow", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("hatchet", 'Hatchet', "A Hatchet", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("hunter_hatchet", 'Hunter Hatchet', "A Hunter Hatchet", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("molotov", 'Molotov', "A Molotov", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("ancient_tomahawk", 'Ancient Tomahawk', "An Ancient Tomahawk", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("tomahawk", 'Tomahawk', "A Tomahawk", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("dynamite", 'Dynamite', "A Dynamite", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("double_bit_hatchet", 'Double Bit Hatchet', "A Double Bit Hatchet", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("throwing_knives", 'Throwing Knives', "Throwing Knives", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("cleaver", 'Cleaver', "A Cleaver", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("bolas", 'Bolas', "Bolas", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("poison_bottle", 'Poison Bottle', "A Poison Bottle", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("hawkmoth_bolas", 'Hawkmoth Bolas', "Hawkmoth Bolas", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("ironspiked_bolas", 'Iron-Spiked Bolas', "Iron-Spiked Bolas", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("intertwined_bolas", 'Intertwined Bolas', "Intertwined Bolas", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("davy_lantern", 'Davy Lantern', "A Davy Lantern", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("binoculars", 'Binoculars', "Binoculars", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("camera", 'Camera', "A Camera", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("advanced_camera", 'Advanced Camera', "An Advanced Camera", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("improved_binoculars", 'Improved Binoculars', "Improved Binoculars", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("metal_detector", 'Metal Detector', "A Metal Detector", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("halloween_lantern", 'Halloween Lantern', "A Halloween Lantern", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("fishing_rod", 'Fishing Rod', "A Fishing Rod", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("lasso", 'Lasso', "A Lasso", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("reinforced_lasso", 'Reinforced Lasso', "A Reinforced Lasso", 1, 1, 1, 1, 4, "item_item");
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ("moonshine_jug", 'Moonshine Jug', "A Moonshine Jug", 1, 1, 1, 1, 4, "item_item");


CREATE TABLE IF NOT EXISTS ammo (
    char_id BIGINT UNSIGNED NOT NULL,
    ammo_22 INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_22_tranquilizer INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_arrow INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_arrow_confusion INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_arrow_disorient INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_arrow_drain INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_arrow_dynamite INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_arrow_fire INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_arrow_improved INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_arrow_poison INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_arrow_small_game INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_arrow_tracking INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_arrow_trail INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_arrow_wound INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_bolas INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_bolas_hawkmoth INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_bolas_intertwined INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_bolas_ironspiked INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_cannon INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_dynamite INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_dynamite_volatile INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_hatchet INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_hatchet_ancient INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_hatchet_cleaver INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_hatchet_double_bit INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_hatchet_double_bit_rusted INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_hatchet_hewing INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_hatchet_hunter INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_hatchet_hunter_rusted INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_hatchet_viking INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_lasso INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_lasso_reinforced INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_molotov INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_molotov_volatile INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_moonshinejug INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_moonshinejug_mp INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_pistol INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_pistol_express INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_pistol_express_explosive INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_pistol_high_velocity INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_pistol_split_point INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_poisonbottle INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_repeater INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_repeater_express INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_repeater_express_explosive INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_repeater_high_velocity INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_repeater_split_point INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_revolver INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_revolver_express INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_revolver_express_explosive INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_revolver_high_velocity INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_revolver_split_point INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_rifle INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_rifle_elephant INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_rifle_express INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_rifle_express_explosive INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_rifle_high_velocity INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_rifle_split_point INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_shotgun INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_shotgun_buckshot_incendiary INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_shotgun_slug INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_shotgun_slug_explosive INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_throwing_knives INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_throwing_knives_confuse INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_throwing_knives_disorient INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_throwing_knives_drain INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_throwing_knives_improved INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_throwing_knives_javier INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_throwing_knives_poison INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_throwing_knives_trail INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_throwing_knives_wound INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_thrown_item INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_tomahawk INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_tomahawk_ancient INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_tomahawk_homing INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_tomahawk_improved INT UNSIGNED NOT NULL DEFAULT 0,
    ammo_turret INT UNSIGNED NOT NULL DEFAULT 0,

    FOREIGN KEY (char_id) REFERENCES characters(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;