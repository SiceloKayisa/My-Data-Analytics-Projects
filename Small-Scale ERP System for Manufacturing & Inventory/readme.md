## Small-Scale ERP System for Manufacturing & Inventory
## Project Overview
This project is a small-scale Enterprise Resource Planning (ERP) database system built with MySQL. It models the core operations of a manufacturing business, specifically focusing on the supply chain and production processes. The system manages raw materials, finished products, and production orders, all while maintaining strict data integrity and automating key business logic at the database level.

This project is a strong demonstration of foundational database design, data modeling for business applications, and the implementation of advanced SQL features like stored procedures and triggers.

### Features
- **Complex Data Modeling:** Uses a normalized relational schema to represent the intricate relationships between products, raw materials, and a Bill of Materials (BOM), which is crucial for manufacturing.

- **Automated Production Workflow:** A custom stored procedure automates the entire manufacturing process, from checking raw material availability to updating finished product inventory.

- **Real-time Inventory Management:** The system efficiently tracks both raw materials and finished goods within a single, streamlined inventory table.

- **Transactional Integrity:** Ensures data consistency by wrapping critical production processes in a secure transaction, preventing partial updates and maintaining the integrity of inventory levels.

- **Advanced Database Logic:** Implements both a stored procedure and a trigger to handle automated business rules, a key component of robust, real-world ERP systems.

### Setup Instructions
To get this project running on your local machine, follow these simple steps:

**1. Prerequisites:** Ensure you have MySQL installed on your system. A database management tool like MySQL Workbench or DBeaver is highly recommended.

**2. Open the Script:** Open the erp_database.sql file in your MySQL client.

**3. Execute the Script:** Run the entire script. It will automatically:

- Drop the database if it exists to ensure a clean slate.

- Create the erp_db database and all necessary tables.

- Populate the tables with over 50 rows of realistic sample data.

- Define the ProcessProductionOrder stored procedure and the before_raw_material_purchase trigger.

- Execute example queries to demonstrate the functionality of the stored procedure and trigger.

### Database Schema
The project is built on a normalized relational model with five core tables. The BillOfMaterials table is a key component, linking Products to the RawMaterials needed to produce them.

### Key Accomplishments
- **Database Schema Design:** Designed and implemented a normalized database schema with a key Bill of Materials (BOM) table, which accurately models the relationship between raw materials and finished products in a manufacturing process.

- **Automated Production Workflow:** Developed a stored procedure (`ProcessProductionOrder`) that automates the entire production process. The procedure checks for sufficient raw materials, deducts them from inventory, and updates the finished product stock, all within a secure transaction.

- **Transactional Integrity:** Implemented transactions with START TRANSACTION and COMMIT/ROLLBACK to ensure data consistency. This guarantees that all steps in a production order either succeed or fail as a single unit, preventing data inconsistencies.

- **Advanced Database Logic:** Created a database trigger (`before_raw_material_purchase`) to automatically update raw material stock upon a new shipment. This showcases an ability to implement automated business rules directly at the database level, which is a key component of robust ERP systems.

- **Technical Problem-Solving:** Successfully diagnosed and resolved a data type conflict that violated a CHECK constraint in the BillOfMaterials table. This demonstrates a strong ability to debug and troubleshoot complex database errors, ensuring the system functions as designed.
