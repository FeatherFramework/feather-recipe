-- Feather Framework clean-install bootstrap.
-- Core, Character, and Admin own and migrate their own schemas at startup.
-- Inventory still requires its base catalog and instance tables before the
-- recipe seed runs, so only that domain is bootstrapped here.

CREATE TABLE IF NOT EXISTS `ground` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `x` DECIMAL(15,10) NOT NULL,
    `y` DECIMAL(15,10) NOT NULL,
    `z` DECIMAL(15,10) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `inventory` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uuid` CHAR(36) NOT NULL,
    `name` VARCHAR(255) NULL,
    `max_weight` DECIMAL(8,2) NULL,
    `location` VARCHAR(255) NULL,
    `ignore_item_limit` TINYINT NOT NULL DEFAULT 0,
    `character_id` CHAR(36) NULL,
    `owner_character_id` CHAR(36) NULL,
    `is_public` TINYINT(1) NOT NULL DEFAULT 0,
    `max_slots` SMALLINT UNSIGNED NULL,
    `ground_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `UQ_InventoryUuid` (`uuid`),
    UNIQUE KEY `UQ_InventoryCharacter` (`character_id`),
    CONSTRAINT `FK_InventoryGround`
        FOREIGN KEY (`ground_id`) REFERENCES `ground` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `categories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `UQ_CategoryName` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `items` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `display_name` VARCHAR(255) NOT NULL,
    `description` VARCHAR(255) NULL,
    `max_quantity` INT NOT NULL DEFAULT 0,
    `max_stack_size` INT NOT NULL DEFAULT 10,
    `weight` DECIMAL(6,2) NOT NULL DEFAULT 0,
    `usable` TINYINT(1) NOT NULL DEFAULT 0,
    `category_id` BIGINT UNSIGNED NOT NULL,
    `type` ENUM('item_item','item_weapon','item_ammo') NOT NULL DEFAULT 'item_item',
    `instance_mode` ENUM('stack','unique') NOT NULL DEFAULT 'stack',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `UQ_ItemName` (`name`),
    KEY `FK_Category` (`category_id`),
    CONSTRAINT `FK_Category`
        FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `inventory_items` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `inventory_id` BIGINT UNSIGNED NOT NULL,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `slot_index` SMALLINT NULL,
    `metadata` JSON NULL,
    `metadata_revision` INT UNSIGNED NOT NULL DEFAULT 0,
    `row_revision` INT UNSIGNED NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_inventory_items_inventory` (`inventory_id`),
    KEY `idx_inventory_items_definition` (`item_id`),
    CONSTRAINT `FK_Inventory`
        FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_InventoryItem`
        FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Retained for compatibility with older Inventory consumers. Current
-- Inventory state is stored in inventory_items.metadata.
CREATE TABLE IF NOT EXISTS `item_metadata` (
    `inventory_items_id` BIGINT UNSIGNED NOT NULL,
    `key` VARCHAR(50) NOT NULL,
    `value` VARCHAR(100) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`inventory_items_id`, `key`),
    CONSTRAINT `FK_InventoryItemsMetadata`
        FOREIGN KEY (`inventory_items_id`) REFERENCES `inventory_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `inventory_blacklist` (
    `inventory_id` BIGINT UNSIGNED NOT NULL,
    `item_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`inventory_id`, `item_id`),
    CONSTRAINT `FK_InventoryBlacklist`
        FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_InventoryItemBlacklist`
        FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `inventory_access` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `inventory_id` BIGINT UNSIGNED NOT NULL,
    `character_id` CHAR(36) NOT NULL,
    `granted_by_character_id` CHAR(36) NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `UQ_InventoryAccess` (`inventory_id`, `character_id`),
    CONSTRAINT `FK_InventoryAccessInventory`
        FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `character_equipment` (
    `character_id` CHAR(36) NOT NULL,
    `slot` VARCHAR(50) NOT NULL,
    `inventory_items_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`character_id`, `slot`),
    UNIQUE KEY `UQ_EquipmentInstance` (`inventory_items_id`),
    CONSTRAINT `FK_EquipmentInstance`
        FOREIGN KEY (`inventory_items_id`) REFERENCES `inventory_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
