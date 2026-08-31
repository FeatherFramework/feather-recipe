-- Feather Framework clean-install catalog seed.

INSERT INTO `categories` (`id`, `name`) VALUES
    (1, 'uncategorized'),
    (2, 'ammunition'),
    (3, 'weapons'),
    (4, 'provisions'),
    (5, 'medicine'),
    (6, 'materials'),
    (7, 'valuables'),
    (8, 'tools'),
    (9, 'clothing'),
    (10, 'documents')
ON DUPLICATE KEY UPDATE `name` = VALUES(`name`);

INSERT INTO `items`
    (`name`, `display_name`, `description`, `max_quantity`, `max_stack_size`,
     `weight`, `usable`, `category_id`, `type`, `instance_mode`)
VALUES
    ('consumable_apple', 'Apple', 'A tasty apple.', 100, 20, 1.00, 1, 4, 'item_item', 'stack'),
    ('water_bottle_small', 'Small Water', 'A small bottle of water.', 100, 10, 2.00, 1, 4, 'item_item', 'stack'),
    ('cattleman_revolver', 'Cattleman Revolver', 'A standard single-action revolver.', 20, 1, 2.00, 1, 3, 'item_weapon', 'unique'),
    ('revolver_standard', 'Revolver Ammunition', 'Standard ammunition for revolvers.', 200, 50, 0.00, 1, 2, 'item_ammo', 'stack'),
    ('weapon_repair_kit', 'Weapon Repair Kit', 'Materials used to repair a damaged weapon.', 20, 10, 1.00, 1, 8, 'item_item', 'stack'),
    ('cattleman_long_barrel', 'Cattleman Long Barrel', 'A long barrel made for the Cattleman Revolver.', 20, 10, 1.00, 0, 3, 'item_item', 'stack')
ON DUPLICATE KEY UPDATE
    `display_name` = VALUES(`display_name`),
    `description` = VALUES(`description`),
    `max_quantity` = VALUES(`max_quantity`),
    `max_stack_size` = VALUES(`max_stack_size`),
    `weight` = VALUES(`weight`),
    `usable` = VALUES(`usable`),
    `category_id` = VALUES(`category_id`),
    `type` = VALUES(`type`),
    `instance_mode` = VALUES(`instance_mode`);
