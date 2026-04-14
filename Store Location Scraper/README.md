# End-to-End Data Engineering Pipeline: Store Location Analytics

## Project Overview
This project involved the development of a robust data pipeline to extract, transform, and load (ETL) store location data from a retail website into a structured SQL Server environment. The task demonstrates the ability to handle the entire lifecycle of data—from raw web discovery to high-precision spatial analysis.

## 🛠 Tools & Technologies
- **Python 3.x**: Core programming language.
- **BeautifulSoup4**: HTML parsing and web scraping.
- **Pandas**: Data manipulation and cleaning.
- **GeoPy (Nominatim API)**: Geographic coordinate extraction.
- **SQLAlchemy & pyodbc**: Database connection and management.
- **SQL Server (T-SQL)**: Relational database storage.
- **JSON & HTML Libraries**: Handling hidden web data.

## 🚀 Key Achievements
- **Automated Discovery**: Successfully implemented a "Scout" script that identifies store URLs from both hidden JSON blobs and standard HTML tags.
- **Dynamic Geocoding Fallback**: Engineered a resilient geocoding system that automatically broadens search parameters if a specific store location is not found, ensuring 100% coordinate coverage.
- **Cross-Border Standardization**: Normalized messy address data across three different countries (South Africa, Namibia, and Zimbabwe) into a unified schema.
- **Production-Ready SQL Schema**: Designed a relational table with an **Identity Primary Key** and optimized **Decimal(9,6)** types for spatial precision.
- **Data Integrity**: Filtered out closed/missing store records and standardized city/province naming conventions to eliminate duplicates and errors.

## 📂 Project Structure

### 1. Extraction (Scraping)
- **Script**: `scrape.txt`
- Extracts a list of URLs from a local HTML source and visits each to scrape attributes like Store Name, Address, Phone, Email, and Social Media links.

### 2. Transformation (Cleaning & Geocoding)
- Standardizes "Snake_Case" to "PascalCase" for database alignment.
- Parses unstructured address strings into logical columns (Country, Province, City).
- Implements a `RateLimiter` with a 2-second backoff to comply with API usage policies.
- Uses a fallback strategy for missing coordinates (Specific Location -> Broader City search).

### 3. Loading (SQL Ingestion)
- **Script**: `create_table.sql` & `load.txt`
- Uses Windows Authentication (Trusted Connection) via SQLAlchemy.
- Maps cleaned Python DataFrames directly to SQL Server tables while handling Identity column constraints.

## 📈 Methodology: An Iterative Process
Unlike a linear task, this project utilized an **iterative development cycle**. Regular validation checks during the geocoding and loading phases led to refinements in the transformation logic, ensuring that the final database output was cleaned, validated, and ready for immediate BI reporting.

---
**Author:** Sicelo Kayisa  
**Role:** Data Analyst Graduate  
