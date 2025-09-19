-- =============================================================================
-- Small-Scale ERP System for Manufacturing & Inventory Management
-- This script creates a database to manage a simple manufacturing process,
-- including raw materials, finished products, production orders, and inventory.
-- =============================================================================

-- Drop the database if it exists to allow for a clean run
DROP DATABASE IF EXISTS erp_db;
CREATE DATABASE erp_db;
USE erp_db;

-- =============================================================================
-- 1. Table Creation
-- =============================================================================

-- Table for Raw Materials
CREATE TABLE RawMaterials (
    material_id INT AUTO_INCREMENT PRIMARY KEY,
    material_name VARCHAR(255) NOT NULL UNIQUE,
    unit_of_measure VARCHAR(50) NOT NULL
);

-- Table for Finished Products
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    selling_price DECIMAL(10, 2) NOT NULL
);

-- Table for the Bill of Materials (BOM)
-- This defines what raw materials are needed to create each product.
CREATE TABLE BillOfMaterials (
    bom_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    material_id INT NOT NULL,
    quantity_required DECIMAL(10, 2) NOT NULL CHECK (quantity_required > 0),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (material_id) REFERENCES RawMaterials(material_id),
    UNIQUE (product_id, material_id)
);

-- Table for Inventory (tracks both raw materials and finished products)
CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    item_type ENUM('product', 'raw_material') NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    UNIQUE (item_id, item_type)
);

-- Table for Production Orders
CREATE TABLE ProductionOrders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity_to_produce INT NOT NULL CHECK (quantity_to_produce > 0),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'in_progress', 'completed', 'cancelled') DEFAULT 'pending',
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- =============================================================================
-- 2. Data Population (50+ rows each)
-- =============================================================================

-- Populating RawMaterials (50+ items)
INSERT INTO RawMaterials (material_name, unit_of_measure) VALUES
('Steel Sheet (1mm)', 'sq. meter'), ('Aluminum Rod (5mm)', 'meter'), ('Plastic Pellets (ABS)', 'kg'),
('Copper Wire (1mm)', 'meter'), ('Silicon Chip (A1)', 'unit'), ('Lithium-Ion Battery (5000mAh)', 'unit'),
('LED Panel (10 inch)', 'unit'), ('LCD Display (5 inch)', 'unit'), ('Microcontroller (ESP32)', 'unit'),
('Resistors (10k ohm)', 'unit'), ('Capacitors (10uF)', 'unit'), ('Diode (1N4001)', 'unit'),
('Screws (M3x10mm)', 'unit'), ('Nuts (M3)', 'unit'), ('Washers (M3)', 'unit'),
('Carbon Fiber Sheet', 'sq. meter'), ('Rubber Gasket (10cm)', 'unit'), ('Glass Panel (1mm)', 'sq. meter'),
('Leather Fabric', 'sq. meter'), ('Polyester Thread', 'meter'), ('Cotton Fabric', 'sq. meter'),
('Wood Plank (Pine)', 'meter'), ('Wood Panel (Oak)', 'sq. meter'), ('Solder Wire (60/40)', 'kg'),
('Speaker Cone (3 inch)', 'unit'), ('Magnet (Neodymium)', 'unit'), ('Glue (Industrial)', 'liter'),
('Paint (Black Matte)', 'liter'), ('Paint (White Gloss)', 'liter'), ('Circuit Board (PCB)', 'unit'),
('Heat Sink (Aluminum)', 'unit'), ('Fan (40mm)', 'unit'), ('USB Cable', 'unit'),
('HDMI Cable', 'unit'), ('Ethernet Cable', 'unit'), ('Cardboard Box (Small)', 'unit'),
('Bubble Wrap', 'meter'), ('Adhesive Tape', 'roll'), ('Ink Cartridge (Black)', 'unit'),
('Ink Cartridge (Color)', 'unit'), ('Paper (A4)', 'ream'), ('Ink (Cyan)', 'liter'),
('Ink (Magenta)', 'liter'), ('Ink (Yellow)', 'liter'), ('Plastic Wrap', 'roll'),
('Styrofoam Pellets', 'liter'), ('Nails (2 inch)', 'kg'), ('Screwdriver bit set', 'unit'),
('Allen key set', 'unit'), ('Metal bracket (L-shaped)', 'unit'), ('Hinge (small)', 'unit'),
('Spring (compression)', 'unit');

-- Populating Products (50+ items)
INSERT INTO Products (product_name, description, selling_price) VALUES
('Smart Drone', 'A foldable drone with a 4K camera.', 599.99),
('Solar Powered Lantern', 'Eco-friendly lantern with multiple light modes.', 49.99),
('Automated Plant Watering System', 'A smart system to keep your plants healthy.', 79.99),
('Portable Bluetooth Speaker', 'Compact speaker with high-fidelity sound.', 99.50),
('Wireless Charging Pad', 'Fast and efficient wireless charger for smartphones.', 35.00),
('Digital Alarm Clock', 'Minimalist clock with a large LED display.', 25.00),
('Robot Vacuum Cleaner', 'An intelligent vacuum cleaner that maps your home.', 299.99),
('Smart Door Lock', 'Keyless entry lock with fingerprint recognition.', 150.00),
('LED Desk Lamp', 'Adjustable lamp with different color temperatures.', 60.00),
('Mini Projector', 'A small projector for home cinema.', 120.00),
('Fitness Tracker Watch', 'Tracks steps, heart rate, and sleep.', 89.99),
('Gaming Keyboard', 'Mechanical keyboard with RGB lighting.', 110.00),
('Ergonomic Mouse', 'Comfortable mouse for long hours of work.', 40.00),
('Noise-Cancelling Headphones', 'Over-ear headphones with superior sound quality.', 199.99),
('Smart Light Bulb', 'Wi-Fi enabled bulb with millions of colors.', 15.00),
('Coffee Grinder', 'Electric grinder with adjustable coarseness.', 45.00),
('Juicer', 'Cold press juicer for fresh, healthy drinks.', 180.00),
('Air Fryer', 'Cook crispy food with less oil.', 125.00),
('Rice Cooker', 'Multi-function cooker for perfect rice every time.', 75.00),
('Electric Kettle', 'Fast boiling kettle with temperature control.', 30.00),
('Toaster Oven', 'Compact oven for toasting, baking, and broiling.', 55.00),
('Blender Bottle', 'Portable blender for smoothies on the go.', 30.00),
('Waffle Maker', 'Makes crispy, fluffy waffles.', 45.00),
('Hand Mixer', 'Lightweight mixer for baking.', 20.00),
('Food Processor', 'Chop, slice, and dice with ease.', 85.00),
('Espresso Machine', 'Make cafe-quality espresso at home.', 250.00),
('Bread Maker', 'Automated machine for fresh bread.', 110.00),
('Ice Cream Maker', 'Makes homemade ice cream in minutes.', 50.00),
('Sandwich Maker', 'Perfectly toasted sandwiches every time.', 25.00),
('Electric Grill', 'Indoor grill for a smokeless BBQ experience.', 70.00),
('Garment Steamer', 'Quickly removes wrinkles from clothes.', 65.00),
('Sewing Machine', 'Beginner-friendly machine for all your sewing needs.', 120.00),
('Embroidery Machine', 'Create professional-grade embroidery.', 350.00),
('Serger', 'Finishes seams and edges for a professional look.', 200.00),
('Fabric Cutter', 'Rotary cutter for precision cutting.', 15.00),
('Heat Press', 'Applies custom designs to t-shirts and more.', 180.00),
('Laminator', 'Protects documents and photos with a plastic film.', 30.00),
('Paper Shredder', 'Shreds documents to protect your privacy.', 45.00),
('Label Maker', 'Prints custom labels for organization.', 25.00),
('3D Printer', 'Create three-dimensional objects from digital files.', 299.99),
('Engraving Machine', 'Etch designs into various materials.', 150.00),
('Vinyl Cutter', 'Cuts vinyl for stickers, decals, and more.', 99.00),
('Screen Printing Kit', 'All-in-one kit for screen printing at home.', 75.00),
('UV Curing Machine', 'Cures UV resin for 3D printing and crafts.', 60.00),
('Laser Cutter', 'Cuts and engraves a variety of materials with precision.', 500.00),
('Soldering Iron Kit', 'Complete kit for electronics soldering.', 40.00),
('Multimeter', 'Measures voltage, current, and resistance.', 20.00),
('Oscilloscope', 'Visualizes electronic signals for testing.', 180.00),
('Power Supply (Adjustable)', 'Provides stable power for electronic projects.', 70.00),
('Breadboard', 'Solderless breadboard for prototyping.', 10.00),
('Jumper Wires (Set)', 'Wires for connecting components on a breadboard.', 5.00);

-- Populating BillOfMaterials (BOM)
INSERT INTO BillOfMaterials (product_id, material_id, quantity_required) VALUES
(1, 1, 0.5), (1, 5, 2), (1, 6, 1), (1, 7, 1), (1, 12, 5),
(2, 1, 0.2), (2, 5, 1), (2, 6, 1), (2, 7, 1), (2, 12, 3),
(3, 1, 0.5), (3, 5, 2), (3, 6, 1), (3, 7, 1), (3, 12, 5),
(4, 1, 0.2), (4, 5, 1), (4, 6, 1), (4, 7, 1), (4, 12, 3),
(5, 1, 0.5), (5, 5, 2), (5, 6, 1), (5, 7, 1), (5, 12, 5),
(6, 1, 0.2), (6, 5, 1), (6, 6, 1), (6, 7, 1), (6, 12, 3),
(7, 1, 0.5), (7, 5, 2), (7, 6, 1), (7, 7, 1), (7, 12, 5),
(8, 1, 0.2), (8, 5, 1), (8, 6, 1), (8, 7, 1), (8, 12, 3),
(9, 1, 0.5), (9, 5, 2), (9, 6, 1), (9, 7, 1), (9, 12, 5),
(10, 1, 0.2), (10, 5, 1), (10, 6, 1), (10, 7, 1), (10, 12, 3),
(11, 1, 0.5), (11, 5, 2), (11, 6, 1), (11, 7, 1), (11, 12, 5),
(12, 1, 0.2), (12, 5, 1), (12, 6, 1), (12, 7, 1), (12, 12, 3),
(13, 1, 0.5), (13, 5, 2), (13, 6, 1), (13, 7, 1), (13, 12, 5),
(14, 1, 0.2), (14, 5, 1), (14, 6, 1), (14, 7, 1), (14, 12, 3),
(15, 1, 0.5), (15, 5, 2), (15, 6, 1), (15, 7, 1), (15, 12, 5);

-- Populating Inventory
-- 50 raw materials and 50 products initially
INSERT INTO Inventory (item_id, item_type, quantity)
SELECT material_id, 'raw_material', FLOOR(RAND() * 500) + 100 FROM RawMaterials;
INSERT INTO Inventory (item_id, item_type, quantity)
SELECT product_id, 'product', FLOOR(RAND() * 100) + 20 FROM Products;

-- Populating ProductionOrders (50+ rows)
INSERT INTO ProductionOrders (product_id, quantity_to_produce, status) VALUES
(1, 10, 'pending'), (2, 5, 'pending'), (3, 8, 'pending'), (4, 12, 'pending'), (5, 20, 'pending'),
(6, 15, 'pending'), (7, 7, 'pending'), (8, 10, 'pending'), (9, 5, 'pending'), (10, 10, 'pending'),
(11, 8, 'pending'), (12, 10, 'pending'), (13, 5, 'pending'), (14, 10, 'pending'), (15, 8, 'pending'),
(16, 10, 'pending'), (17, 5, 'pending'), (18, 10, 'pending'), (19, 8, 'pending'), (20, 10, 'pending'),
(21, 5, 'pending'), (22, 10, 'pending'), (23, 8, 'pending'), (24, 10, 'pending'), (25, 5, 'pending'),
(26, 10, 'pending'), (27, 8, 'pending'), (28, 10, 'pending'), (29, 5, 'pending'), (30, 10, 'pending'),
(31, 8, 'pending'), (32, 10, 'pending'), (33, 5, 'pending'), (34, 10, 'pending'), (35, 8, 'pending'),
(36, 10, 'pending'), (37, 5, 'pending'), (38, 10, 'pending'), (39, 8, 'pending'), (40, 10, 'pending'),
(41, 5, 'pending'), (42, 10, 'pending'), (43, 8, 'pending'), (44, 10, 'pending'), (45, 5, 'pending'),
(46, 10, 'pending'), (47, 8, 'pending'), (48, 10, 'pending'), (49, 5, 'pending'), (50, 10, 'pending');


-- =============================================================================
-- 3. Stored Procedure for Production
-- =============================================================================
-- This procedure processes a production order, checks and deducts raw materials,
-- and adds the finished product to inventory.

DELIMITER $$
CREATE PROCEDURE ProcessProductionOrder(
    IN p_order_id INT
)
BEGIN
    DECLARE v_product_id INT;
    DECLARE v_quantity_to_produce INT;
    DECLARE v_material_id INT;
    DECLARE v_quantity_required DECIMAL(10, 2);
    DECLARE v_current_material_quantity INT;
    DECLARE v_enough_materials BOOLEAN DEFAULT TRUE;

    -- Start a transaction
    START TRANSACTION;

    -- Get order details
    SELECT product_id, quantity_to_produce INTO v_product_id, v_quantity_to_produce
    FROM ProductionOrders WHERE order_id = p_order_id;

    -- Check if all materials are in stock
    DECLARE cur CURSOR FOR
        SELECT material_id, quantity_required
        FROM BillOfMaterials
        WHERE product_id = v_product_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_enough_materials = FALSE;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_material_id, v_quantity_required;
        IF NOT v_enough_materials THEN
            LEAVE read_loop;
        END IF;

        -- Get current raw material quantity
        SELECT quantity INTO v_current_material_quantity
        FROM Inventory
        WHERE item_id = v_material_id AND item_type = 'raw_material';

        IF v_current_material_quantity < v_quantity_to_produce * v_quantity_required THEN
            SET v_enough_materials = FALSE;
        END IF;
    END LOOP;
    CLOSE cur;

    IF v_enough_materials THEN
        -- Deduct raw materials
        UPDATE Inventory
        JOIN BillOfMaterials bom ON Inventory.item_id = bom.material_id AND Inventory.item_type = 'raw_material'
        SET Inventory.quantity = Inventory.quantity - (bom.quantity_required * v_quantity_to_produce)
        WHERE bom.product_id = v_product_id;

        -- Add finished products to inventory
        UPDATE Inventory
        SET quantity = quantity + v_quantity_to_produce
        WHERE item_id = v_product_id AND item_type = 'product';

        -- Update order status
        UPDATE ProductionOrders
        SET status = 'completed'
        WHERE order_id = p_order_id;
        COMMIT;
    ELSE
        -- Rollback if not enough materials and set status to cancelled
        UPDATE ProductionOrders
        SET status = 'cancelled'
        WHERE order_id = p_order_id;
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient raw materials. Production order cancelled.';
    END IF;
END $$
DELIMITER ;

-- Example of calling the stored procedure
-- This will complete a production order and update inventory
CALL ProcessProductionOrder(1);

-- =============================================================================
-- 4. Trigger for Supply Chain Management
-- =============================================================================
-- This trigger could be used to automatically add new stock to inventory
-- when a new purchase order for raw materials is processed.
-- (This requires an additional table like PurchaseOrders, but we can model the logic here).

DELIMITER $$
CREATE TRIGGER before_raw_material_purchase
BEFORE INSERT ON Inventory
FOR EACH ROW
BEGIN
    IF NEW.item_type = 'raw_material' THEN
        SET NEW.quantity = NEW.quantity + 500; -- Simulate adding 500 units to stock for a new purchase
    END IF;
END $$
DELIMITER ;

-- Example of using the trigger
-- Let's say we get a new material in a purchase order.
-- This will automatically add 500 units to the quantity.
-- To see this in action, first find the current quantity of a material.
SELECT * FROM Inventory WHERE item_id = 1 AND item_type = 'raw_material';
-- Now, insert a new row for the same item. The trigger will fire.
-- Note: This is a simplified example. In a real-world scenario, you would insert into a
-- "PurchaseOrders" table and have a trigger on that table instead.
INSERT INTO Inventory (item_id, item_type, quantity) VALUES (1, 'raw_material', 100);
-- Check the updated quantity. It will be 600 (100 + 500)
SELECT * FROM Inventory WHERE item_id = 1 AND item_type = 'raw_material';


-- Clean up: drop the procedure and trigger
DROP PROCEDURE IF EXISTS ProcessProductionOrder;
DROP TRIGGER IF EXISTS before_raw_material_purchase;


