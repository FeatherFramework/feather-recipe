CREATE TABLE `roles` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `level` int NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX role_name (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `users` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `username` varchar(255) NOT NULL,
    `license` varchar(255) NOT NULL,
    `created_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `characters` (
    `id` BIGINT UNSIGNED  NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED  NOT NULL,
    `role_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
    `first_name` varchar(255) NOT NULL,
    `last_name` varchar(255) NOT NULL,
    `dob` varchar(255) NOT NULL,
    `dollars` decimal(15,3) NOT NULL,
    `gold` decimal(15,3) NOT NULL,
    `xp` float NOT NULL,
    `x` decimal(15,10) NOT NULL,
    `y` decimal(15,10) NOT NULL,
    `z` decimal(15,10) NOT NULL,
    `lang` varchar(255) NOT NULL,
    `created_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `FK_User` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_Role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `inventory` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uuid` UUID NOT NULL DEFAULT UUID(),
    `character_id` BIGINT UNSIGNED NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `FK_InventoryCharacter` FOREIGN KEY (`character_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `categories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE TABLE `items` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `max_quantity` int DEFAULT 0,
    `model_name` varchar(255) NOT NULL,
    `usable` boolean DEFAULT false,
    `category_id` BIGINT UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`),
    CONSTRAINT `FK_Category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE TABLE `inventory_items` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `inventory_id` BIGINT UNSIGNED NOT NULL,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `quantity` int NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `FK_Inventory` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_InventoryItem` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE TABLE `item_metadata` (
    `inventory_id` BIGINT UNSIGNED NOT NULL,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `key` VARCHAR(50) NOT NULL,
    `value` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`inventory_id`, `item_id`),
    INDEX `Inventory_Item` USING BTREE (`inventory_id`, `item_id`)
)ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE TABLE `inventory_allowList` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `inventory_id` BIGINT UNSIGNED NOT NULL,
    `entity_id` BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;
