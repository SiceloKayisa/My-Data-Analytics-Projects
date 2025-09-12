-- Data Cleaning Script

-- Firstly we import the desired datasets into MySQL Workbench as csv files
-- Our datasets of interests are the customers, orders and products tables 
-- The goal is to address common data quality issues like duplicates, inconsistent formatting, and missing values.


-- We'll start with a table named customers_raw  


use `data_cleaning_project` ;

SELECT * FROM customers_raw ; 

-- Checking for Duplicates

-- i will use full_name and email as a way to identify the duplicates

SELECT full_name, COUNT(*) AS occurences
FROM customers_raw 
GROUP BY full_name 
HAVING COUNT(*) > 1 ;

-- The code above shows that there are customers appearing more than once in the customers table we will need to fix this.

-- We first create a new table called cleaned table

CREATE TABLE customers_cleaned LIKE customers_raw;

-- Remove Duplicates
-- The most critical step is to identify and remove duplicate entries. 
-- In this case, I have defined a duplicate based on a combination of full_name and email.
 -- I will use a GROUP BY clause and a subquery to select the first occurrence of each unique record.
 
INSERT INTO customers_cleaned
SELECT * FROM customers_raw
WHERE (full_name, email) IN (
    SELECT full_name, email
    FROM customers_raw
    GROUP BY full_name, email
    HAVING COUNT(*) = 1
)
OR customer_id IN (
    SELECT MIN(customer_id)
    FROM customers_raw
    GROUP BY full_name, email
    HAVING COUNT(*) > 1
);


-- Handle Missing Values -----------------------------

-- Runnng the line below we can observe that there are missing values under the phone_number column.
-- Other columns do not have any missing values


SELECT * FROM customers_raw 
 WHERE  phone_number = '' ;
 
-- Now I'll Update the missing values in the dataset we have created 

UPDATE customers_cleaned
SET phone_number = 'Not Provided'
WHERE phone_number = '';


-- Standardizing data by removing whitespaces and Formating columns -------------------------- 

-- ### I have dealt with duplicates and addressed the missing values, now I will standardize the data further.

-- Standardize full_name: Use TRIM() to remove leading/trailing whitespace and CONCAT(UCASE(LEFT(column, 1)), 
-- LCASE(SUBSTRING(column, 2))) to apply proper casing. For example, "  john smith  " becomes "John smith".
--  We will use a CASE statement with TRIM and CONCAT to make this change.

-- Standardize email: Use LOWER() to convert all email addresses to lowercase. 
-- This helps ensure uniqueness and consistency.

--  Standardize phone_number: Use REPLACE() to remove any non-numeric characters like hyphens or spaces, 
-- then use CONCAT() to re-add them in a consistent format (e.g., XXX-XXXX). For this simple example, we'll just remove the space.


UPDATE customers_cleaned
SET
    full_name = TRIM(full_name),
    email = LOWER(email),
    phone_number = REPLACE(phone_number, ' ', '-');
    
-- ## Verification 

-- verifying the changes made so far!


SELECT * FROM customers_cleaned;

-- After removing the duplicates our data now contains 41 entries
-- Rows where there was a missing phone number have been updated with 'Not Provided'
-- All the emails are now in consistent format


-- ##  Now we move to the orders raw table 

-- Similar to the previous table, I will create a new table called orders_cleaned to store the results


CREATE TABLE orders_cleaned (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(100),
    order_quantity INT,
    order_price DECIMAL(10, 2),
    order_date DATE
);

-- Again we will first look for any duplicates 

SELECT * FROM orders_raw;

-- I  will identify and remove duplicate entries based on a combination of customer_id, product_name, and order_date

SELECT customer_id, product_name, order_date, COUNT(*) AS occurences
FROM orders_raw
GROUP BY customer_id, product_name, order_date
HAVING COUNT(*) > 1 ;

-- We have duplicates involving customer_id 1, 2 and 5

-- I'll keep the first instances of these duplicates


INSERT INTO orders_cleaned (order_id, customer_id, product_name, order_quantity, order_price, order_date)
SELECT
    MIN(order_id),
    customer_id,
    product_name,
    order_quantity,
    order_price,
    order_date
FROM orders_raw
GROUP BY customer_id, product_name, order_quantity, order_price, order_date;
 

-- Next Standardize and Format Data

-- Cleaned the individual fields in the orders_cleaned table.
-- Standardized product_name: Use TRIM() to remove whitespace and CONCAT() with UCASE() 
-- and LCASE() to capitalize the first letter and make the rest lowercase, ensuring consistency.

-- Handle Invalid order_quantity: We need to update order_quantity to be a positive number. 
-- In this example, we will set any value less than 1 to a default of 1.
-- Standardize order_date: We'll use the STR_TO_DATE() function to convert the different date string formats into a standard DATE format

UPDATE orders_cleaned
SET order_date = STR_TO_DATE(order_date, '%Y/%m/%d')
WHERE order_date LIKE '%/%';


UPDATE orders_cleaned
SET product_name = TRIM(product_name) ;

-- Verify the cleaned data


SELECT * FROM orders_cleaned;

-- On our last table ---


-- The product table


 -- I will clean data from products_raw into a new table named products_cleaned. 
 -- We will perform string manipulation, handle invalid data, and convert data types.
 
 CREATE TABLE products_cleaned (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2),
    launch_date DATE
);

-- First let us observe the produuct table

SELECT * FROM products_raw ; 

UPDATE products_raw
SET
    launch_date = CASE
        WHEN product_id = 6 THEN '2022-06-20'
        WHEN product_id = 8 THEN '2022-07-20'
        WHEN product_id = 32 THEN '2024-07-05'
        ELSE launch_date
    END
WHERE product_id IN (6, 8, 32);

-- observing the table there are trailing whitespaces in the table and with the code below we can clearly observe them.

SELECT DISTINCT category
FROM products_raw;

-- We have a problem here involving whitespaces, lower and uppercase letters
-- We need to remove whitespaces and adjust formating to ensure uniformity and consistency

SELECT DISTINCT product_name
FROM products_raw;

-- Same as above, similar product appear more than once while they represent the same product.


INSERT INTO products_cleaned(product_id, product_name, category, unit_price, launch_date)
SELECT
    product_id,
    TRIM(product_name),
    TRIM(category),
    CASE WHEN unit_price < 0 THEN NULL ELSE unit_price END AS unit_price,
    launch_date
FROM products_raw;

-- looking at this carefully we observe that there are TWO products with no unit price attached.
-- See line of code below


SELECT product_name FROM products_cleaned
WHERE unit_price IS NULL ;

-- After investigating we are given that the unit price of Headphones is 150.00
-- And the hard drive is 600.00

UPDATE products_cleaned
SET unit_price = 150.00 
   WHERE product_name = 'Headphones' AND unit_price IS NULL ;
   
UPDATE products_cleaned
SET unit_price = 600.00 
   WHERE product_name = 'Hard Drive' AND unit_price IS NULL ;

SELECT DISTINCT product_name
FROM products_cleaned;


UPDATE products_cleaned 
SET category = LOWER(category) ;

-- ## Let us see how the new product_cleaned data looks like

SELECT * FROM products_cleaned;


-- Now our data is clean and we can export our dataset 
-- We can then use these datasets to perform our analysis to Tableau






