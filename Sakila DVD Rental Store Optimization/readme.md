
# 📀 Sakila DVD Rental Store Optimization: Data-Driven Analytics Project

## Project Overview

This project is a comprehensive **Data Analytics capstone** focused on optimizing the operations of a hypothetical DVD rental store using the **Sakila Database**. Leveraging **SQL**, **Excel**, and **Power BI**, the initiative transforms raw transactional data into **actionable, visual insights** for rental store proprietors.

The primary goal was to engineer an exhaustive Power BI dashboard that delivers discerning insights into **customer behavior, film performance metrics, and operational dynamics**. These insights are designed to empower stakeholders to make judicious decisions, **optimize film inventory**, enhance customer satisfaction, improve staff performance, and streamline store operations, thereby elevating business efficiency.

## 📊 Key Insights and Dashboard Highlights

The Power BI dashboard provides multi-faceted analytical perspectives, broken down into specialized reports:

### 1. Customer Insights & Geographic Analysis
* **Customer Segmentation:** Analysis of active vs. inactive customers and their distribution across various film ratings (PG-13, NC-17, PG, R, G).
* **Sales by Category:** Identifies the top-performing film categories by sales, with **Sports**, **Sci-Fi**, and **Animation** being the top three revenue drivers.
* **Geographic Distribution:** Visualizes the global distribution of customers and maps rental revenue and frequency by country, highlighting **India** and the **United States** as key markets.

### 2. Film Performance Examination
* **Inventory & Distribution:** Detailed breakdown of the **1000 films** by rating (e.g., PG-13, R) and film category (e.g., Action, Drama).
* **Revenue vs. Rental Rate:** Illustrates the relationship between revenue and rental rates across different film categories, revealing categories with high revenue potential.
* **Film-Category Breakdown:** Provides an inventory count by category, showing the distribution of the store's film collection.

### 3. Actor Insights & Star Power Analytics
* **Actor Performance:** Ranks actors by total number of films and their contribution to overall revenue. **Kenneth** and **Penelope** are shown to be the top revenue contributors.
* **Genre Preferences:** Analyzes the distribution of films based on rating, giving insight into the store's "Star Power" and preferred actor genres.
* **Rental Rate Variation:** Tracks the fluctuation of rental rates across the entire actor portfolio.

### 4. Revenue & Rental Behavior Analysis
* **Total Revenue:** Presents overall metrics like **$67.41K Revenue**, **2.98K Total Rental Rate**, and **129M Total Rentals**.
* **Revenue by Month:** Clearly shows the seasonality of rental activity, with a major peak in **August 2005** and a trough in **January 2006**.
* **Revenue by Country:** Confirms **India** ($6.6K) and **China** ($5.8K) as the highest revenue-generating countries.
* **Rental Behavior:** Analyzes rental frequency by duration and month, showing the average rental duration is **4.99 days**.

## 🛠️ Technology Stack

* **Database:** Sakila DVD Rental Store Database (MySQL structure)
* **Data Transformation & Querying:** **SQL** (for querying and shaping the dataset)
* **Data Cleaning & Initial Analysis:** **Microsoft Excel**
* **Visualization & Dashboarding:** **Power BI** (for interactive reporting and visual analytics)

## 🏗️ Data Model & Relationships

The project is built on the relational structure of the Sakila database, which comprises 15 tables capturing customer demographics, film inventory specifics, and transaction details.

Key tables and relationships include:
* **`customer`** linked to **`rental`** (1-to-many)
* **`rental`** linked to **`inventory`** (1-to-many)
* **`inventory`** linked to **`film`** (1-to-many)
* **`film`** linked to **`film_category`** and **`film_actor`** (1-to-many)
* **`payment`** linked to **`customer`** and **`rental`** (1-to-many)


## 🚀 Quantifiable Achievements for Resume

Use these specific metrics and actions to highlight your impact and skills on your resume:

| Achievement Area | Quantifiable Statement |
| :--- | :--- |
| **Data Visualization & Reporting** | Engineered a comprehensive **Power BI Dashboard** from the Sakila Database, consolidating **15 tables** and **1000 films** into four inter-connected, actionable reports. |
| **Business Intelligence** | Identified **India ($6.6K)** and **China ($5.8K)** as the top-revenue-generating countries and prioritized **Sports** and **Sci-Fi** as the highest-grossing film categories by revenue. |
| **Performance Analysis** | Tracked and visualized transactional data demonstrating a peak rental period in **August 2005**, facilitating inventory and staffing optimization recommendations. |
| **Actor/Inventory Analysis** | Established **Kenneth** and **Penelope** as the top revenue-contributing actors, directly informing future star-power based inventory acquisition strategies. |
| **Data Modeling** | Developed a robust relational data model (ERD) from the raw Sakila dataset to support complex cross-table calculations and visual filters in Power BI. |
| **Operational Metrics** | Analyzed a total of **129M rentals** with an average duration of **4.99 days**, providing key performance indicators for operational efficiency. |

## Prerequisites

To explore and replicate this project, you should have a foundational understanding of:

* **SQL:** For data extraction and transformation.
* **Power BI:** For visualization and dashboard creation.
* **Excel:** For initial data cleaning and summary.
* **Problem Solving:** For translating business questions into analytical queries.

---

Would you like me to elaborate on a specific section of the dashboard or perhaps draft a section explaining your methodology for cleaning and modeling the data?
