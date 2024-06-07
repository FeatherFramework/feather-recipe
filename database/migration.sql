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
