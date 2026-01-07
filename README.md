## Swiggy Sales Analysis

## Project Overview
This project analyzes Swiggy food delivery data to understand sales performance, customer behavior, and food preferences across different locations and time periods.

## Business Objective
- Analyze overall order and revenue trends  
- Identify top-performing cities, restaurants, and cuisines  
- Understand customer spending behavior  
- Study rating distribution and food performance  

## Dataset
- Swiggy sales dataset  
- Includes state, city, restaurant, cuisine, dish, order date, price, and ratings  

## Tools Used
- SQL (Data Cleaning, Modeling, Analysis)
  
## Data Cleaning & Validation
- Checked for null and blank values in important columns  
- Identified and removed duplicate records using `ROW_NUMBER()`  
- Ensured data consistency before analysis  

## Data Modeling
- Implemented a Star Schema  
- Created dimension tables for date, location, restaurant, category, and dish  
- Built a central fact table for sales and ratings  

## KPIs Developed
- Total Orders  
- Total Revenue  
- Average Dish Price  
- Average Rating  

## Key Analysis
- Monthly, quarterly, and yearly order trends  
- Top cities and states by revenue  
- Top restaurants and cuisines by order volume  
- Customer spending distribution  
- Rating distribution analysis  

## Key Learnings
- Importance of data cleaning before analysis  
- How star schema improves analytical querying  
- Converting SQL outputs into business insights  
