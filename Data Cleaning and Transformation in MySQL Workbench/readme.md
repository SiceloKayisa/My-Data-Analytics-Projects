## Data Cleaning and Transformation Project

### Project Overview

This repository contains SQL scripts and documentation for a data cleaning and transformation project. The primary goal of this project is to take raw, messy data from an e-commerce platform's transactional tables (customers_raw, orders_raw, products_raw) and transform it into a clean, well-structured format for analysis and reporting. The final clean tables are intended to serve as a reliable source of truth for business intelligence, marketing, and operational teams.

### Data Sources
The project uses three raw tables, each containing data with various inconsistencies, missing values, and formatting issues.

**customers_raw:** Customer information, including names, contact details, and addresses.

**orders_raw:** Order details, linking customers to products and containing transactional data.

**products_raw:** Product information, including names, categories, and launch dates.

### Key Transformation Steps
The project follows a systematic approach to data cleaning, addressing several common data quality issues:

Handling Missing Values: Identifying and managing missing data points (NULL or empty strings) in critical columns like phone_number and email.

### Standardizing Text Data:

**Case Consistency:** Converting text to a single case (e.g., lowercase) to ensure consistent values (e.g., 'ELECTRONICS' and 'electronics' are treated as the same category).

**Whitespace Trimming:** Removing leading or trailing whitespace from text fields to eliminate subtle inconsistencies.

### Correcting Data Formats:

**Date Formats:** Correcting inconsistent date formats in columns like launch_date to ensure all dates are in a standardized format (e.g., YYYY-MM-DD). This is crucial for proper sorting and time-series analysis.

**Identifying and Handling Duplicates:** Using techniques to count and inspect unique values to identify duplicates that need to be resolved or removed.

### Technologies Used
**MySQL:** The relational database management system used for storing and manipulating the data.

**SQL (Structured Query Language):** The primary language used for all data cleaning, transformation, and querying operations.

**Git & GitHub:** Version control and project collaboration platform to track changes and manage the project's codebase.
