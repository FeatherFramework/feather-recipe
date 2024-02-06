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