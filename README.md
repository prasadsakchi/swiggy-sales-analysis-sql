# Swiggy Delivery & Restaurant Performance Analysis

## Problem Statement
Food delivery platforms generate large volumes of order data but often lack clear visibility into which restaurants drive demand, how orders are distributed across locations, and when peak demand occurs.
This project analyzes Swiggy order data to uncover demand patterns, restaurant performance, and operational insights to support better decision-making.

## Objectives

- Analyze restaurant performance and order volume
- Identify high-demand locations and categories
- Evaluate customer satisfaction using ratings
- Detect peak demand periods
- Provide actionable recommendations for operational planning

## Dataset

* Total Records: 10,000+ orders
* Includes:
  - Restaurant Name
  - Category / Cuisine
  - Order Value
  - Order Date
  - Customer Ratings
  - City

## Tools & Technologies

**SQL (Microsoft SQL Server)**

  - Joins
  - CTEs
  - Aggregations
  - Window Functions (RANK, ROW_NUMBER)

## Data Cleaning

- Handled missing and inconsistent values
- Standardized restaurant and location names
- Removed duplicate records
- Ensured consistent data formatting for analysis

## Key Analysis

## Restaurant Performance
- Ranked restaurants based on order volume and revenue
- Identified top-performing restaurants using window functions
  
## Category Analysis
- Analyzed order distribution across different cuisines
- Identified high-demand food categories
  
## Demand Trends

- Identified peak ordering periods
- Analyzed high-demand restaurants and cuisines

## Key Insights

- A small number of restaurants contribute a large share of total orders
- Certain cusisines consistently show higher demand than others
- Peak demand periods highlight high operational demand windows

## Business Recommendations
- Demand-Based Resource Allocation:
  Increase delivery capacity during peak hours
- Focus on High-Performing Restaurants:
  Strengthen partnerships with top-performing restaurants
- Enhance Customer Experience:
  Reduce delays to improve ratings and retention

## Conclusion

This project demonstrates how SQL can be used to analyze operational data in a food delivery business, helping improve efficiency, customer satisfaction, and overall performance.
