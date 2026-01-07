--DATA VALIDATION & CLEANING 

--NULL CHECK
SELECT * FROM Swiggy
WHERE State IS NULL
OR City IS NULL
OR Order_Date IS NULL
OR Restaurant_Name IS NULL
OR Location IS NULL
OR Category IS NULL
OR Dish_Name IS NULL
OR Price_INR IS NULL
OR Rating IS NULL
OR Rating_Count IS NULL;

--BLANK OR EMPTY STRINGS
SELECT * FROM Swiggy
WHERE State=''
OR City= ''
OR Restaurant_Name= '' 
OR Location= ''
OR Dish_Name='';  

--DETECTING DUPLICATE VALUES 
SELECT State, City, Order_date, 
Restaurant_Name, Location, Category, 
Dish_Name, Price_INR, Rating,
Rating_Count, COUNT(*) AS Dcount
FROM Swiggy
GROUP BY State, City, Order_date, 
Restaurant_Name, Location, Category, 
Dish_Name, Price_INR, Rating,
Rating_Count
HAVING COUNT(*) > 1;

--DELETING DUPLICATE VALUES
WITH CTE AS (
SELECT *, ROW_NUMBER() OVER(
PARTITION BY State, City, Order_date, 
Restaurant_Name, Location, Category, 
Dish_Name, Price_INR, Rating,
Rating_Count
ORDER BY (SELECT NULL)
) AS rn 
FROM Swiggy)
DELETE FROM CTE 
WHERE rn > 1;

--CREATING DIMENSION TABLE

-- DATE TABLE
CREATE TABLE dim_date(
    date_id INT IDENTITY(1,1) PRIMARY KEY,
    Full_Date DATE,
    Year INT,
    Month INT,
    Month_Name VARCHAR(20),
    Week INT,
    Day INT,
    Quarter INT
    );

--LOCATION TABLE
CREATE TABLE dim_location(
    Location_Id INT IDENTITY(1,1) PRIMARY KEY,
    Location VARCHAR(250),
    City VARCHAR(250));

--RESTAURANT TABLE
CREATE TABLE dim_restaurant(
        Restaurant_Id INT IDENTITY(1,1) PRIMARY KEY,
        Restaurant_Name VARCHAR(200));

--CATEGORY TABLE
CREATE TABLE dim_category(
        category_ID INT IDENTITY(1,1) PRIMARY KEY,
        Category VARCHAR(200));

--DISH TABLE
CREATE TABLE dim_dish(
    dish_Id INT IDENTITY(1,1) PRIMARY KEY,
    Dish_Name VARCHAR(200));

--FACT TABLE
CREATE TABLE fact_swiggy(
    order_ID INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT,
    Price_INR Decimal(10,2),
    Rating DECIMAL(4,2),
    Rating_Count INT,
    Location_Id INT,
    Restaurant_Id INT,
    category_ID INT,
    dish_Id INT,
FOREIGN KEY (Restaurant_Id) REFERENCES dim_restaurant(Restaurant_Id),
FOREIGN KEY (category_ID) REFERENCES dim_category(category_ID),
FOREIGN KEY (dish_Id) REFERENCES dim_dish(dish_Id)
);

--INSERT DATA IN TABLE
--dim_date 
INSERT INTO dim_date (Full_Date,Year, Month,Month_Name,WEEK,Day,Quarter)
SELECT DISTINCT Order_Date,
                YEAR(Order_Date),
                MONTH(Order_Date),
                DATENAME(MONTH,Order_Date),
                DATEPART(QUARTER,Order_Date),
                DAY(Order_Date),
                DATEPART(Week,Order_Date)
FROM Swiggy
WHERE Order_Date IS NOT NULL;

--dim_location
INSERT INTO dim_location(State,Location,City)
SELECT DISTINCT State,
                Location,
                City
FROM Swiggy;

--dim_restaurant
INSERT INTO dim_restaurant(Restaurant_Name)
SELECT DISTINCT 
            Restaurant_Name 
FROM Swiggy;

--dim_category
INSERT INTO dim_category(Category)
SELECT DISTINCT 
            Category 
FROM Swiggy;

--dim_dish
INSERT INTO dim_dish(Dish_Name)
SELECT DISTINCT 
            Dish_Name 
FROM Swiggy;

--Fact_swiggy
INSERT INTO fact_swiggy(
            date_id,
            Price_INR,
            Rating,
            Rating_Count,
            Location_Id,
            Restaurant_Id,
            category_ID,
            dish_Id
            )
SELECT dd.date_id,
        s.Price_INR,
        s.Rating,
        s.Rating_Count,
        dl.Location_Id,
        dr.Restaurant_Id,
        dc.category_ID,
        ds.dish_Id
FROM Swiggy s
JOIN dim_date dd
        ON dd.Full_Date = s.Order_Date
JOIN dim_location dl 
        ON dl.Location = s.Location
        AND dl.City = s.City
        AND dl.State = s.State
JOIN dim_restaurant dr
        ON dr.Restaurant_Name = s.Restaurant_Name
JOIN dim_category dc
        ON dc.Category = s.Category
JOIN dim_dish ds 
        ON ds.Dish_Name = s.Dish_Name

        SELECT date_id, COUNT(*) as cnt FROM fact_swiggy
        group by date_id
        having COUNT(*) > 1;

        

select * from fact_swiggy f 
JOIN dim_date d ON f.date_id = d.date_id
JOIN dim_dish dh ON f.dish_Id = dh.dish_Id
JOIN dim_location l ON f.Location_Id = l.Location_Id
JOIN dim_restaurant rr ON f.Restaurant_Id = rr.Restaurant_Id
JOIN dim_category cy ON f.category_ID = cy.category_ID
ORDER BY Full_Date;

SELECT * FROM fact_swiggy;
SELECT
    s.Order_Date,
    s.State,
    s.City,
    s.Location,
    s.Restaurant_Name,
    s.Category,
    s.Dish_Name,
    s.Price_INR,
    s.Rating,
    s.Rating_Count,
    COUNT(*) AS cnt
FROM Swiggy s
JOIN dim_location dl
  ON dl.State = s.State
 AND dl.City = s.City
 AND dl.Location = s.Location
GROUP BY
    s.Order_Date,
    s.State,
    s.City,
    s.Location,
    s.Restaurant_Name,
    s.Category,
    s.Dish_Name,
    s.Price_INR,
    s.Rating,
    s.Rating_Count
HAVING COUNT(*) > 1;


INSERT INTO dim_date
(Full_Date, Year, Month, Month_Name, Week, Day, Quarter)
SELECT
    d.Order_Date,
    YEAR(d.Order_Date),
    MONTH(d.Order_Date),
    DATENAME(MONTH, d.Order_Date),
    DATEPART(WEEK, d.Order_Date),
    DAY(d.Order_Date),
    DATEPART(QUARTER, d.Order_Date)
FROM (
    SELECT DISTINCT Order_Date
    FROM Swiggy
    WHERE Order_Date IS NOT NULL
) d;

TRUNCATE TABLE fact_swiggy;

INSERT INTO fact_swiggy
(
    date_id,
    Price_INR,
    Rating,
    Rating_Count,
    Location_Id,
    Restaurant_Id,
    category_ID,
    dish_Id
)
SELECT
    dd.date_id,
    s.Price_INR,
    s.Rating,
    s.Rating_Count,
    dl.Location_Id,
    dr.Restaurant_Id,
    dc.category_ID,
    ds.dish_Id
FROM Swiggy s
JOIN dim_date dd
  ON dd.Full_Date = CAST(s.Order_Date AS DATE)
JOIN dim_location dl
  ON TRIM(dl.State) = TRIM(s.State)
 AND TRIM(dl.City) = TRIM(s.City)
 AND TRIM(dl.Location) = TRIM(s.Location)
JOIN dim_restaurant dr
  ON TRIM(dr.Restaurant_Name) = TRIM(s.Restaurant_Name)
JOIN dim_category dc
  ON TRIM(dc.Category) = TRIM(s.Category)
JOIN dim_dish ds
  ON TRIM(ds.Dish_Name) = TRIM(s.Dish_Name);

  SELECT COUNT(*) AS swiggy_rows FROM Swiggy;
SELECT COUNT(*) AS fact_rows   FROM fact_swiggy;

--KPI'S

--TOTAL ORDER
SELECT COUNT(*) AS Total_Order
FROM fact_swiggy;

--TOTAL REVENUE
SELECT 
    SUM(Price_INR) / 1000000.0 AS Total_Revenue_Million
FROM fact_swiggy;


--AVERAGE DISH PRICE
SELECT AVG(Price_INR) AS Avg_Price
FROM fact_swiggy;

--AVERAGE RATING
SELECT AVG(Rating) AS Avg_Rating
FROM fact_swiggy;


--DATE BASED ANALYSIS
--MONTHLY ORDER TREND
SELECT d.Year, d.Month, d.Month_Name,
        COUNT(*) AS TotalMonthly_Order
FROM fact_swiggy f
JOIN dim_date d ON d.date_id = f.date_id
GROUP BY d.Year, d.Month, d.Month_Name
ORDER BY d.Year, d.Month;

--QUARTER ORDER TREND
SELECT d.Year,d.Quarter,
        COUNT(*) AS TotalQuarter_Order
FROM fact_swiggy f
JOIN dim_date d ON d.date_id = f.date_id
GROUP BY d.Year,d.Quarter
ORDER BY d.Year,d.Quarter;

--YEARLY ORDER TREND
SELECT d.Year,
        COUNT(*) AS Total_Order
FROM fact_swiggy f
JOIN dim_date d ON d.date_id = f.date_id
GROUP BY d.Year
ORDER BY d.Year;

--DAY OF WEEK ORDER COUNT
SELECT DATENAME(WEEKDAY, d.Full_Date) AS Day_Name,
        DATEPART(WEEKDAY, d.Full_Date)AS Day_No,
        COUNT(*) AS TotalWeekly_Order
FROM fact_swiggy f
JOIN dim_date d ON d.date_id = f.date_id
GROUP BY DATENAME(WEEKDAY, d.Full_Date),DATEPART(WEEKDAY, d.Full_Date)
ORDER BY DATEPART(WEEKDAY, d.Full_Date);


--LOCATION BASED ANALYSIS
--TOP 10 CITY BY ORDER
SELECT TOP 10 l.City,COUNT(*) AS City_count
FROM fact_swiggy f
JOIN dim_location l ON l.Location_Id = f.Location_Id
GROUP BY l.City
ORDER BY COUNT(*) DESC;

--REVENUE CONTRIBUTED BY STATES 
SELECT l.State, SUM(Price_INR) AS State_Revenue
FROM fact_swiggy f
JOIN dim_location l ON l.Location_Id = f.Location_Id
GROUP BY l.State
ORDER BY SUM(Price_INR) DESC;


--FOOD PERFORMANCE
--TOP 10 RESTAURANT BY ORDER
SELECT TOP 10 r.Restaurant_Name,COUNT(*) As Total_Order
FROM fact_swiggy f 
JOIN dim_restaurant r ON r.Restaurant_Id = f.Restaurant_Id
GROUP BY r.Restaurant_Name
ORDER BY COUNT(*) DESC;

--TOP CATEGORIES
select c.Category, COUNT(*) AS Category_count
FROM fact_swiggy f
JOIN dim_category c ON c.category_ID=f.category_ID
GROUP BY c.Category
ORDER BY COUNT(*)DESC;

--MOST ORDERED DISH
SELECT d.Dish_Name, COUNT(*) AS Dish_Count
FROM fact_swiggy f 
JOIN dim_dish d ON d.dish_Id=f.dish_Id
GROUP BY d.Dish_Name
ORDER BY COUNT(*) DESC;

--CUISINE PERFORMANCE 
SELECT c.Category, COUNT(*) AS Category_Count,
AVG(f.Rating) AS avg_rate,SUM(Price_INR) AS Category_Spend
FROM fact_swiggy f 
JOIN dim_category c ON c.category_ID=f.category_ID
GROUP BY c.Category
ORDER BY Category_Count DESC;


--CUSTOMER SPENDING INSIGHTS
SELECT 
    CASE
    WHEN Price_INR< 100 THEN 'Under 100'
    WHEN Price_INR Between 100 AND 199 THEN '100-199'
    WHEN Price_INR Between 200 AND 299 THEN '200-299'
    WHEN Price_INR Between 300 AND 499 THEN '300-499'
    ELSE '500+'
        END 
        AS Price_Range,
        COUNT(*) As Total_Order
        FROM fact_swiggy
        GROUP BY CASE
    WHEN Price_INR<100 THEN 'Under 100'
    WHEN Price_INR Between 100 AND 199 THEN '100-199'
    WHEN Price_INR Between 200 AND 299 THEN '200-299'
    WHEN Price_INR Between 300 AND 499 THEN '300-499'
    ELSE '500+'
    END;

--RATING DISTRIBUTION
SELECT Rating, COUNT(*) AS Rating_Count
FROM fact_swiggy
GROUP BY Rating
ORDER BY Rating_Count DESC;