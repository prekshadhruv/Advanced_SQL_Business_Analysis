# Advanced SQL Business Analysis – Northwind Database

## Project Overview

This project focuses on advanced SQL-based business analysis using the **Northwind database**. The objective is to analyze customer purchasing behavior, revenue trends, discount patterns, and customer retention using SQL queries.

The project demonstrates the application of advanced SQL concepts to solve practical business problems and extract meaningful insights from relational data.

## Dataset

- **Database:** Northwind
- **Tables Used:** Customers, Orders, Order Details
- **SQL Environment:** Microsoft SQL Server

## Business Analysis Tasks

### 1. Customers with Zero Discount
Identified customers whose orders had no discounts applied and analyzed their order counts.

**SQL Concepts:** JOIN, GROUP BY, HAVING, MAX(), COUNT()

### 2. Top 3 Customers Per Country
Ranked customers based on total revenue within each country and identified the top three customers per country.

**SQL Concepts:** CTEs, JOIN, GROUP BY, DENSE_RANK(), PARTITION BY

### 3. Running Total Revenue
Calculated monthly revenue and cumulative revenue over time to understand overall business growth.

**SQL Concepts:** CTEs, SUM(), Window Functions, GROUP BY

### 4. Repeat vs One-Time Customers
Classified customers based on their number of orders to distinguish one-time buyers from repeat customers.

**SQL Concepts:** JOIN, GROUP BY, COUNT(), CASE WHEN

### 5. Monthly Revenue Trend
Analyzed monthly revenue across different years to understand revenue patterns over time.

**SQL Concepts:** YEAR(), MONTH(), DATENAME(), GROUP BY, Aggregate Functions

### 6. Consecutive Month Orders
Identified customers who placed orders in consecutive months to explore purchasing consistency.

**SQL Concepts:** CTEs, LAG(), Window Functions, PARTITION BY

## Key SQL Skills Demonstrated

- INNER JOIN and table relationships
- Common Table Expressions (CTEs)
- Aggregate Functions
- GROUP BY and HAVING
- Window Functions
- DENSE_RANK() and LAG()
- Running Total Calculations
- CASE WHEN Statements
- Date Functions
- Customer Segmentation
- Revenue Analysis

## Project Objective

The project demonstrates how SQL can be used to transform relational business data into meaningful analytical information, helping understand customer behavior, revenue performance, and purchasing patterns.

## Project File

`Advanced SQL Business Analysis.sql` – Contains all six SQL business analysis queries.
