-- =============================================================================
-- E-Commerce Product Catalog and Inventory System
-- This script creates a database for an e-commerce platform, including tables for products,
-- categories, customers, orders, order items, and inventory. It is designed to be
-- executed in MySQL Workbench.
-- =============================================================================

-- Drop the database if it already exists to allow for a clean run
DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- =============================================================================
-- 1. Table Creation
-- =============================================================================

-- Table for Categories
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- Table for Products
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Table for Inventory
CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL UNIQUE,
    quantity INT NOT NULL CHECK (quantity >= 0),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Table for Customers
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    address TEXT
);

-- Table for Orders
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Table for Order Items (Junction table for Orders and Products)
CREATE TABLE OrderItems (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    CONSTRAINT unique_order_product UNIQUE (order_id, product_id)
);


-- =============================================================================
-- 2. Data Population (50+ rows for each table)
-- =============================================================================

-- Populating Categories
INSERT INTO Categories (category_name) VALUES
('Electronics'), ('Clothing'), ('Home Goods'), ('Books'), ('Toys'),
('Sports'), ('Beauty'), ('Food & Beverage');

-- Populating Products (50+ rows)
INSERT INTO Products (product_name, description, price, category_id) VALUES
('Smartphone X', 'A powerful new smartphone with a 6.7-inch display.', 999.99, 1),
('Laptop Pro 15', 'High-performance laptop for professionals.', 1499.50, 1),
('Wireless Headphones', 'Noise-cancelling headphones with 24-hour battery.', 199.99, 1),
('Smartwatch Z', 'Track your fitness and receive notifications.', 299.00, 1),
('4K UHD TV', 'Vivid colors and sharp detail for the ultimate viewing experience.', 750.00, 1),
('Gaming Console', 'Next-gen gaming console with ultra-fast SSD.', 499.99, 1),
('Bluetooth Speaker', 'Portable speaker with rich, clear sound.', 85.00, 1),
('Digital Camera', 'Capture professional-quality photos and videos.', 600.00, 1),
('T-shirt (Crew Neck)', 'Comfortable cotton t-shirt, available in multiple colors.', 25.00, 2),
('Jeans (Slim Fit)', 'Classic slim-fit jeans with a modern look.', 59.99, 2),
('Winter Jacket', 'Warm, insulated jacket for cold weather.', 120.00, 2),
('Running Shoes', 'Lightweight and breathable running shoes.', 89.99, 2),
('Sneakers (Casual)', 'Stylish and comfortable casual sneakers.', 75.00, 2),
('Dress Shirt (Formal)', 'Crisp white dress shirt, perfect for formal events.', 45.00, 2),
('Hoodie (Fleece)', 'Soft fleece hoodie with a kangaroo pocket.', 50.00, 2),
('Socks (Pack of 5)', 'Everyday socks for comfort and style.', 15.00, 2),
('Pillow Set (2-Pack)', 'Soft and supportive pillows for a good night sleep.', 49.99, 3),
('Coffee Maker', 'Programmable coffee maker with a 12-cup carafe.', 79.99, 3),
('Toaster (4-Slice)', 'Toaster with extra-wide slots for bagels and thick bread.', 35.00, 3),
('Blender', 'Powerful blender for smoothies and shakes.', 65.00, 3),
('Kitchen Utensil Set', '10-piece stainless steel utensil set.', 30.00, 3),
('Bedding Set', 'Complete bedding set with sheets and duvet cover.', 110.00, 3),
('Lampshade', 'Elegant lampshade to add a touch of style to any room.', 20.00, 3),
('Cookbook', 'A collection of recipes for all skill levels.', 22.50, 4),
('Science Fiction Novel', 'A thrilling sci-fi adventure in a dystopian future.', 18.00, 4),
('Fantasy Epic Book', 'First installment of a classic fantasy epic series.', 25.00, 4),
('Children\'s Book', 'A colorful and educational book for young readers.', 10.00, 4),
('Mystery Thriller', 'A page-turning thriller with an unexpected twist.', 19.99, 4),
('LEGO Building Kit', 'A large building kit with thousands of pieces.', 85.00, 5),
('Remote Control Car', 'High-speed remote control car for indoor and outdoor fun.', 40.00, 5),
('Doll House', 'A classic doll house with furniture and accessories.', 70.00, 5),
('Jigsaw Puzzle', '1000-piece puzzle of a famous landmark.', 15.00, 5),
('Yoga Mat', 'Non-slip yoga mat for a perfect workout.', 35.00, 6),
('Dumbbell Set', 'Adjustable dumbbell set for strength training.', 95.00, 6),
('Resistance Bands', 'Set of resistance bands for various exercises.', 20.00, 6),
('Soccer Ball', 'Regulation-size soccer ball for practice and games.', 25.00, 6),
('Basketball', 'High-grip basketball for indoor and outdoor use.', 30.00, 6),
('Mascara', 'Volumizing mascara for long and full lashes.', 12.00, 7),
('Lipstick', 'Long-lasting matte lipstick in various shades.', 10.00, 7),
('Foundation', 'Full-coverage foundation for a flawless finish.', 28.00, 7),
('Moisturizer', 'Hydrating face moisturizer with SPF 30.', 18.00, 7),
('Shampoo & Conditioner Set', 'Set for healthy and shiny hair.', 25.00, 7),
('Coffee Beans (Dark Roast)', '1lb bag of whole bean dark roast coffee.', 15.00, 8),
('Organic Green Tea', 'Box of 100 organic green tea bags.', 8.00, 8),
('Energy Drink (Pack of 12)', 'Case of energy drinks for a quick boost.', 24.00, 8),
('Protein Bar (Box of 10)', 'Box of high-protein bars for an active lifestyle.', 19.99, 8),
('Oatmeal (Bulk)', 'Large container of classic rolled oats.', 10.00, 8),
('Gummy Bears', 'Large bag of assorted gummy bears.', 7.50, 8),
('Pajama Set', 'Comfortable cotton pajama set.', 40.00, 2),
('Workout Leggings', 'Stretchy, moisture-wicking leggings.', 55.00, 2),
('Water Bottle (Insulated)', 'Stainless steel water bottle that keeps drinks cold.', 25.00, 6),
('Fitness Tracker', 'Monitor your activity and heart rate.', 65.00, 1);

-- Populating Inventory
INSERT INTO Inventory (product_id, quantity)
SELECT product_id, FLOOR(RAND() * 200) + 50 FROM Products;

-- Populating Customers (50+ rows)
INSERT INTO Customers (first_name, last_name, email, phone_number, address) VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', '123 Main St, Anytown'),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', '456 Oak Ave, Somewhere'),
('Peter', 'Jones', 'peter.jones@example.com', '555-9012', '789 Pine Ln, Nowhere'),
('Mary', 'Williams', 'mary.williams@example.com', '555-3456', '101 Maple Rd, Cityville'),
('Robert', 'Brown', 'robert.brown@example.com', '555-7890', '202 Birch Blvd, Townsville'),
('Lisa', 'Davis', 'lisa.davis@example.com', '555-1122', '303 Cedar Dr, Villageton'),
('Michael', 'Garcia', 'michael.garcia@example.com', '555-3344', '404 Elm St, Metropoli'),
('Jennifer', 'Rodriguez', 'jennifer.rodriguez@example.com', '555-5566', '505 Poplar Pl, Hamlet'),
('William', 'Wilson', 'william.wilson@example.com', '555-7788', '606 Ash Way, Suburbia'),
('Sarah', 'Martinez', 'sarah.martinez@example.com', '555-9900', '707 Walnut Cir, Urbania'),
('David', 'Miller', 'david.miller@example.com', '555-0011', '808 Cherry Ct, Outskirts'),
('Jessica', 'Moore', 'jessica.moore@example.com', '555-2233', '909 Willow Rd, Countryside'),
('James', 'Taylor', 'james.taylor@example.com', '555-4455', '111 Sycamore Ln, The City'),
('Patricia', 'Anderson', 'patricia.anderson@example.com', '555-6677', '222 Oak St, Northtown'),
('Charles', 'Thomas', 'charles.thomas@example.com', '555-8899', '333 Pine Rd, Southtown'),
('Linda', 'Jackson', 'linda.jackson@example.com', '555-0000', '444 Maple St, Eastville'),
('Joseph', 'White', 'joseph.white@example.com', '555-1111', '555 Birch Blvd, Westville'),
('Betty', 'Harris', 'betty.harris@example.com', '555-2222', '666 Cedar Dr, Centerville'),
('Thomas', 'Martin', 'thomas.martin@example.com', '555-3333', '777 Elm St, Rivertown'),
('Nancy', 'Thompson', 'nancy.thompson@example.com', '555-4444', '888 Poplar Pl, Hillside'),
('Chris', 'Clark', 'chris.clark@example.com', '555-5555', '999 Ash Way, Lakeside'),
('Anna', 'Lewis', 'anna.lewis@example.com', '555-6666', '121 Walnut Cir, Seaside'),
('Paul', 'Lee', 'paul.lee@example.com', '555-7777', '232 Cherry Ct, Foothills'),
('Karen', 'Allen', 'karen.allen@example.com', '555-8888', '343 Willow Rd, Baytown'),
('Daniel', 'King', 'daniel.king@example.com', '555-9999', '454 Sycamore Ln, Meadowland'),
('Donna', 'Wright', 'donna.wright@example.com', '555-0123', '565 Oak St, Valleyview'),
('George', 'Scott', 'george.scott@example.com', '555-4567', '676 Pine Rd, Summit'),
('Carol', 'Green', 'carol.green@example.com', '555-8901', '787 Maple St, Greenfield'),
('Steven', 'Baker', 'steven.baker@example.com', '555-2345', '898 Birch Blvd, Redwood'),
('Susan', 'Hall', 'susan.hall@example.com', '555-6789', '1010 Cedar Dr, Springdale'),
('Kevin', 'Adams', 'kevin.adams@example.com', '555-0987', '1111 Elm St, Sunnyside'),
('Sharon', 'Nelson', 'sharon.nelson@example.com', '555-7654', '1212 Poplar Pl, Bayside'),
('Mark', 'Carter', 'mark.carter@example.com', '555-3210', '1313 Ash Way, Forestville'),
('Deborah', 'Mitchell', 'deborah.mitchell@example.com', '555-8765', '1414 Walnut Cir, Lakeside'),
('Brian', 'Perez', 'brian.perez@example.com', '555-4321', '1515 Cherry Ct, Hillcrest'),
('Laura', 'Roberts', 'laura.roberts@example.com', '555-1098', '1616 Willow Rd, Portside'),
('Edward', 'Turner', 'edward.turner@example.com', '555-5432', '1717 Sycamore Ln, Northwood'),
('Helen', 'Phillips', 'helen.phillips@example.com', '555-9876', '1818 Oak St, Westlake'),
('Patrick', 'Campbell', 'patrick.campbell@example.com', '555-6543', '1919 Pine Rd, Southview'),
('Judy', 'Parker', 'judy.parker@example.com', '555-2109', '2020 Maple St, Eastside'),
('Larry', 'Evans', 'larry.evans@example.com', '555-8765', '2121 Birch Blvd, Midtown'),
('Brenda', 'Edwards', 'brenda.edwards@example.com', '555-3456', '2222 Cedar Dr, Downtown'),
('Frank', 'Collins', 'frank.collins@example.com', '555-7890', '2323 Elm St, Oldtown'),
('Pamela', 'Stewart', 'pamela.stewart@example.com', '555-1122', '2424 Poplar Pl, Newburg'),
('Raymond', 'Sanchez', 'raymond.sanchez@example.com', '555-3344', '2525 Ash Way, Centerville'),
('Amy', 'Morris', 'amy.morris@example.com', '555-5566', '2626 Walnut Cir, Lakeside'),
('Gregory', 'Rogers', 'gregory.rogers@example.com', '555-7788', '2727 Cherry Ct, Hillcrest'),
('Christine', 'Reed', 'christine.reed@example.com', '555-9900', '2828 Willow Rd, Portside'),
('Douglas', 'Cook', 'douglas.cook@example.com', '555-0011', '2929 Sycamore Ln, Northwood'),
('Kathryn', 'Morgan', 'kathryn.morgan@example.com', '555-2233', '3030 Oak St, Westlake'),
('Jerry', 'Bell', 'jerry.bell@example.com', '555-4455', '3131 Pine Rd, Southview');

-- Populating Orders (51 rows to match the number of customers)
INSERT INTO Orders (customer_id, total_amount) VALUES
(1, 199.99), (2, 75.00), (3, 1499.50), (4, 45.00), (5, 59.99),
(6, 999.99), (7, 120.00), (8, 25.00), (9, 15.00), (10, 49.99),
(11, 79.99), (12, 110.00), (13, 22.50), (14, 19.99), (15, 85.00),
(16, 40.00), (17, 70.00), (18, 15.00), (19, 35.00), (20, 95.00),
(21, 20.00), (22, 25.00), (23, 30.00), (24, 12.00), (25, 10.00),
(26, 28.00), (27, 18.00), (28, 25.00), (29, 15.00), (30, 8.00),
(31, 24.00), (32, 19.99), (33, 10.00), (34, 7.50), (35, 40.00),
(36, 55.00), (37, 25.00), (38, 65.00), (39, 299.00), (40, 750.00),
(41, 499.99), (42, 85.00), (43, 600.00), (44, 25.00), (45, 59.99),
(46, 120.00), (47, 89.99), (48, 75.00), (49, 45.00), (50, 50.00),
(51, 15.00);

-- Populating OrderItems (51 rows to match the number of orders)
INSERT INTO OrderItems (order_id, product_id, quantity, price_at_purchase) VALUES
(1, 3, 1, 199.99), (2, 13, 1, 75.00), (3, 2, 1, 1499.50), (4, 16, 1, 45.00),
(5, 10, 1, 59.99), (6, 1, 1, 999.99), (7, 11, 1, 120.00), (8, 9, 1, 25.00),
(9, 18, 1, 15.00), (10, 17, 1, 49.99), (11, 18, 1, 79.99), (12, 22, 1, 110.00),
(13, 24, 1, 22.50), (14, 28, 1, 19.99), (15, 29, 1, 85.00), (16, 30, 1, 40.00),
(17, 31, 1, 70.00), (18, 32, 1, 15.00), (19, 33, 1, 35.00), (20, 34, 1, 95.00),
(21, 35, 1, 20.00), (22, 36, 1, 25.00), (23, 37, 1, 30.00), (24, 38, 1, 12.00),
(25, 39, 1, 10.00), (26, 40, 1, 28.00), (27, 41, 1, 18.00), (28, 42, 1, 25.00),
(29, 43, 1, 15.00), (30, 44, 1, 8.00), (31, 45, 1, 24.00), (32, 46, 1, 19.99),
(33, 47, 1, 10.00), (34, 48, 1, 7.50), (35, 50, 1, 40.00), (36, 51, 1, 55.00),
(37, 52, 1, 25.00), (38, 52, 1, 65.00), (39, 4, 1, 299.00), (40, 5, 1, 750.00),
(41, 6, 1, 499.99), (42, 7, 1, 85.00), (43, 8, 1, 600.00), (44, 9, 1, 25.00),
(45, 10, 1, 59.99), (46, 11, 1, 120.00), (47, 12, 1, 89.99), (48, 13, 1, 75.00),
(49, 16, 1, 45.00), (50, 15, 1, 50.00), (51, 16, 1, 15.00);


-- =============================================================================
-- 3. After the successful creation of our database
-- We can retrieve all the products with their category names and inventory quantity
-- Moving forward we can a new product to the database
-- These provides a view on how we can deploy CRUD operations in our relational database
-- =============================================================================

-- READ: Retrieve all products with their category names and inventory quantity
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    i.quantity
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
JOIN Inventory i ON p.product_id = i.product_id;

-- CREATE: Add a new product to the database
INSERT INTO Products (product_name, description, price, category_id)
VALUES ('New Product Test', 'This is a test product.', 5.00, 1);
-- You would also need to insert a corresponding row into the Inventory table.
INSERT INTO Inventory (product_id, quantity)
VALUES (LAST_INSERT_ID(), 100);

-- UPDATE: Change the price of a specific product
UPDATE Products
SET price = 10.99
WHERE product_name = 'New Product Test';

-- DELETE: Remove a product from the database
-- Note: Deleting a product requires deleting its corresponding inventory first due to foreign key constraints.
DELETE FROM Inventory WHERE product_id = (SELECT product_id FROM Products WHERE product_name = 'New Product Test');
DELETE FROM Products WHERE product_name = 'New Product Test';

-- =============================================================================
-- 4. Stored Procedure for Order Processing
-- =============================================================================
-- This stored procedure simplifies the process of placing an order.
-- It handles creating the order record, adding the order items, and updating the
-- inventory, all within a transaction to ensure atomicity.

DELIMITER $$
CREATE PROCEDURE ProcessOrder(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_product_price DECIMAL(10, 2);
    DECLARE v_current_quantity INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction in case of any error
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Transaction failed. Inventory not updated.';
    END;

    -- Start a transaction
    START TRANSACTION;

    -- Get the product price and current inventory quantity
    SELECT price, quantity INTO v_product_price, v_current_quantity
    FROM Products p
    JOIN Inventory i ON p.product_id = i.product_id
    WHERE p.product_id = p_product_id
    FOR UPDATE; -- Lock the row for the duration of the transaction

    -- Check if enough inventory is available
    IF v_current_quantity < p_quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient inventory for this product.';
    ELSE
        -- Calculate the total amount for the new order
        SET @total_amount = v_product_price * p_quantity;

        -- Insert a new order
        INSERT INTO Orders (customer_id, total_amount)
        VALUES (p_customer_id, @total_amount);

        -- Insert the order item
        INSERT INTO OrderItems (order_id, product_id, quantity, price_at_purchase)
        VALUES (LAST_INSERT_ID(), p_product_id, p_quantity, v_product_price);

        -- Update the inventory
        UPDATE Inventory
        SET quantity = quantity - p_quantity
        WHERE product_id = p_product_id;

        -- Commit the transaction if everything is successful
        COMMIT;
    END IF;

END $$
DELIMITER ;

-- Example of calling the stored procedure to place an order
-- Note: This will decrease the quantity of product_id 1 in the Inventory table
-- You can run this multiple times to see the inventory level decrease.
CALL ProcessOrder(1, 1, 1);
SELECT * FROM Inventory WHERE product_id = 1;

-- =============================================================================
-- 5. Trigger for Automated Inventory Management
-- =============================================================================
-- This trigger automatically updates the Inventory table whenever a new
-- order item is added, ensuring that inventory levels are always accurate.
-- Note: This is an alternative to the stored procedure approach and demonstrates
-- another way to handle business logic in the database layer.

DELIMITER $$
CREATE TRIGGER after_order_item_insert
AFTER INSERT ON OrderItems
FOR EACH ROW
BEGIN
    UPDATE Inventory
    SET quantity = quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END$$
DELIMITER ;

-- Example of using the trigger
-- To test the trigger, you can directly insert a new order item.
-- Note: The `total_amount` in the Orders table will not be automatically updated by this trigger.
-- For a complete solution, you would need to use a stored procedure or an additional trigger.
-- Let's create a new order first.
INSERT INTO Orders (customer_id, total_amount) VALUES (1, 0.00);
-- Now insert an order item. This will trigger the inventory update.
-- You can check the Inventory table before and after running this.
INSERT INTO OrderItems (order_id, product_id, quantity, price_at_purchase)
VALUES (LAST_INSERT_ID(), 2, 2, 1499.50);

-- Check the updated inventory level for product_id 2
SELECT * FROM Inventory WHERE product_id = 2;

-- Clean up: drop the trigger and stored procedure
DROP TRIGGER IF EXISTS after_order_item_insert;
DROP PROCEDURE IF EXISTS ProcessOrder;
