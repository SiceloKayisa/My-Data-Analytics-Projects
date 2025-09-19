## E-Commerce Product Catalog and Inventory System

### Project Overview
This project involved designing, implementing, and debugging a relational database for a complete e-commerce platform. The core goal was to create a robust and scalable database schema capable of handling product catalogues, customer information, orders, and inventory management within MySQL workbench.

### Features
- **Product Catalog Management:** A complete system to handle product and category information.

- **Customer & Order Tracking:** Tables to store customer details and track order history.

- **Automated Inventory Management:** Logic implemented at the database level to ensure stock levels are always accurate.

- **CRUD Operations:** Examples of queries for creating, reading, updating, and deleting data.

- **Stored Procedures & Triggers:** Demonstrates advanced database features for automating complex business logic.

### Setup Instructions
To get this project up and running, follow these simple steps:

**1. Prerequisites:** You need to have MySQL installed on your system. A database management tool like MySQL Workbench is highly recommended for running the script.

**2. Run the SQL Script:** Open the ecommerce_database.sql file in your MySQL environment.

**3. Execute:** Run the entire script. This will perform the following actions automatically:

- Drop the database if it exists to ensure a clean start.

- Create the ecommerce_db database.

- Define all six tables with their respective columns, constraints, and relationships.

- Populate each table with over 50 rows of sample data.

- Define the ProcessOrder stored procedure and the after_order_item_insert trigger.

- Execute example queries to demonstrate CRUD operations, the stored procedure, and the trigger.

### Database Schema

The project uses a normalized relational schema with six main tables. The relationships between these tables are defined using foreign keys to maintain data consistency.

### Key Achievements
- **Database Schema Design:** Designed and implemented a normalized database schema consisting of six interconnected tables: Products, Categories, Customers, Orders, OrderItems, and Inventory. Utilized PRIMARY KEY, FOREIGN KEY, and UNIQUE constraints to establish clear relationships and enforce data integrity.

- **Data Integrity and Validation:** Successfully diagnosed and resolved two critical database errors (Error Code: 1062 and Error Code: 1452). This involved correcting a duplicate entry in the Inventory table to satisfy a unique constraint and fixing a foreign key violation in the OrderItems table to ensure referential integrity.

- **Automated Business Logic:** Developed a stored procedure (ProcessOrder) to automate the entire order placement process, including inserting order details and simultaneously updating inventory levels within a single, atomic transaction. This demonstrates an ability to create efficient and reliable backend logic.

- **Real-time Inventory Management:** Implemented a database trigger (after_order_item_insert) that automatically decremented product quantities in the Inventory table whenever a new item was added to an order. This ensures real-time and accurate inventory tracking.

- **Core CRUD Operations:** Wrote and implemented clear examples for CRUD (Create, Read, Update, Delete) operations, showcasing proficiency in standard data manipulation queries for managing the product catalog and customer data.
