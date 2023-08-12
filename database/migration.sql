CREATE TABLE `roles` (
    `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `level` int NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX role_name (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `users` (
    `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
    `username` varchar(255) NOT NULL,
    `license` varchar(255) NOT NULL,
    `created_at` TimeStamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TimeStamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `characters` (
    `id` bigint UNSIGNED  NOT NULL AUTO_INCREMENT,
    `user_id` bigint UNSIGNED  NOT NULL,
    `role_id` bigint UNSIGNED NOT NULL,
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
    `updated_at` TimeStamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `FK_User` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_Role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `inventory` (
    `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
    `entity_id` bigint UNSIGNED NOT NULL,
    `entity_type` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `items` (
    `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `max_quantity` int DEFAULT 0,
    `model_name` varchar(255) NOT NULL,
    `usable` boolean DEFAULT false,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE TABLE `InventoryItems` (
    `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
    `inventory_id` bigint UNSIGNED NOT NULL,
    `item_id` bigint UNSIGNED NOT NULL,
    `name` varchar(255) NOT NULL,
    `quantity` int NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `FK_Inventory` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_InventoryItem` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE TABLE `InventoryAllowList` (
    `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
    `inventory_id` bigint UNSIGNED NOT NULL,
    `entity_id` bigint UNSIGNED NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;
