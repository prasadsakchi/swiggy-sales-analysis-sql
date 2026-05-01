# Swiggy Delivery & Restaurant Performance Analysis

## Problem Statement

Food delivery platforms often face challenges such as delayed deliveries, inconsistent restaurant performance, and declining customer satisfaction.
This project analyzes Swiggy order data to identify operational inefficiencies, delivery delays, and performance gaps to support better decision-making.

## Objectives

- Analyze restaurant performance and order distribution
- Identify delivery inefficiencies across locations
- Evaluate customer satisfaction using ratings
- Detect peak demand periods
- Provide actionable recommendations for improving operations

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

- Handled missing values in ratings and delivery time
- Standardized restaurant and location names
- Removed duplicate and inconsistent records
- Ensured proper data formatting for analysis

## Key Analysis

## Restaurant Performance
- Ranked restaurants based on order volume and revenue
- Identified top-performing restaurants using window functions

## Delivery Efficiency

- Calculated average delivery time across locations
- Identified areas with consistently higher delivery delays
  
## Customer Satisfaction

- Analyzed relationship between delivery time and customer ratings
- Evaluated how operational delays impact user experience
  
## Demand Analysis

- Identified peak ordering periods
- Analyzed high-demand restaurants and cuisines

## Key Insights

- Longer delivery times are associated with lower customer ratings
- A small number of restaurants contribute a large share of total orders
- Certain locations consistently experience delivery delays
- Peak demand periods create pressure on delivery operations

## Business Recommendations
- Optimize Delivery Operations:
  Improve logistics in high-delay areas to reduce delivery time
- Demand-Based Resource Allocation:
  Increase delivery capacity during peak hours
- Focus on High-Performing Restaurants:
  Strengthen partnerships with top-performing restaurants
- Enhance Customer Experience:
  Reduce delays to improve ratings and retention

## Conclusion

This project demonstrates how SQL can be used to analyze operational data in a food delivery business, helping improve efficiency, customer satisfaction, and overall performance.
