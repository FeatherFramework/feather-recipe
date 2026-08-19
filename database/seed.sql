-- Seed roles
INSERT INTO roles (name, level) VALUES ('general', 0);
INSERT INTO roles (name, level) VALUES ('admin', 99);

-- Add Categories
INSERT INTO categories (name) VALUES ('uncategorized');
INSERT INTO categories (name) VALUES ('food');
INSERT INTO categories (name) VALUES ('drinks');

-- Add Items
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ('consumable_apple', 'Apple', 'A yummy apple to eat', 100, 20, 1, true, 1, 'item_item');
INSERT INTO items (name, display_name, description, max_quantity, max_stack_size, weight, usable, category_id, type) VALUES ('water_bottle_small', 'Small Water', 'A small water bottle to quench your thirst', 100, 10, 2, true, 1, 'item_item');

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