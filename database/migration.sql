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
    UNIQUE INDEX `user_license` (`license`) USING BTREE,
    INDEX `user_username` (`username`) USING BTREE
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
    INDEX `character_first_name` (`first_name`) USING BTREE,
    INDEX `character_last_name` (`last_name`) USING BTREE,
    INDEX `character_full_name` (`first_name`, `last_name`) USING BTREE,
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

CREATE TABLE IF NOT EXISTS `feather_admin_bans` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `license` VARCHAR(100) NOT NULL,
    `player_name` VARCHAR(100) NULL,
    `character_id` INT NULL,
    `character_name` VARCHAR(150) NULL,
    `reason` VARCHAR(200) NOT NULL,
    `expires_at` DATETIME NULL,
    `active` TINYINT(1) NOT NULL DEFAULT 1,
    `admin_license` VARCHAR(100) NULL,
    `admin_name` VARCHAR(100) NOT NULL,
    `admin_character_id` INT NULL,
    `admin_character_name` VARCHAR(150) NULL,
    `revoked_by` VARCHAR(100) NULL,
    `revoked_by_character_id` INT NULL,
    `revoked_by_character_name` VARCHAR(150) NULL,
    `revoked_at` DATETIME NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_fa_bans_license_active` (`license`, `active`),
    INDEX `idx_fa_bans_expires` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `feather_admin_warnings` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `license` VARCHAR(100) NOT NULL,
    `player_name` VARCHAR(100) NULL,
    `character_id` INT NULL,
    `character_name` VARCHAR(150) NULL,
    `reason` VARCHAR(200) NOT NULL,
    `admin_license` VARCHAR(100) NULL,
    `admin_name` VARCHAR(100) NOT NULL,
    `admin_character_id` INT NULL,
    `admin_character_name` VARCHAR(150) NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_fa_warnings_license` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `feather_admin_kicks` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `license` VARCHAR(100) NOT NULL,
    `player_name` VARCHAR(100) NULL,
    `character_id` INT NULL,
    `character_name` VARCHAR(150) NULL,
    `reason` VARCHAR(200) NOT NULL,
    `admin_license` VARCHAR(100) NULL,
    `admin_name` VARCHAR(100) NOT NULL,
    `admin_character_id` INT NULL,
    `admin_character_name` VARCHAR(150) NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_fa_kicks_license` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `feather_admin_actions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `admin_license` VARCHAR(100) NULL,
    `admin_name` VARCHAR(100) NULL,
    `admin_character_id` INT NULL,
    `admin_character_name` VARCHAR(150) NULL,
    `action` VARCHAR(100) NOT NULL,
    `target_license` VARCHAR(100) NULL,
    `target_name` VARCHAR(100) NULL,
    `target_character_id` INT NULL,
    `target_character_name` VARCHAR(150) NULL,
    `details` VARCHAR(500) NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_fa_actions_admin_license` (`admin_license`),
    INDEX `idx_fa_actions_target_license` (`target_license`),
    INDEX `idx_fa_actions_action` (`action`),
    INDEX `idx_fa_actions_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
