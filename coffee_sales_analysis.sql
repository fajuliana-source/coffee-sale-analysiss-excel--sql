CREATE table Coffee_sales(
 transaction_id int,
transaction_date varchar,
week_day varchar,
month varchar,
year varchar,
transaction_time varchar,
Time_Of_Day varchar,
transaction_qty int,
store_id int,
store_location varchar,
product_id int,
unit_price numeric(10,2),
total_sales numeric(10,2),
product_category varchar,	
product_type varchar,
product_detail varchar
);
COPY Coffee_sales FROM 'C:\Program Files\PostgreSQL\SQL\COFFEE.CSV' DELIMITER ',' CSV HEADER;
SELECT * FROM Coffee_sales;

QUESTION 1 ; THE METRIC CARDS

    a. TOTAL SALES	
SELECT SUM(total_sales) from coffee_sales;

    b. TOTAL ORDERS
SELECT COUNT(transaction_qty) from coffee_sales;

    c. AVG UNIT PRICE
SELECT AVG(unit_price) from coffee_sales;

    d. TOTAL UNIT SOLD
SELECT SUM(transaction_qty) FROM coffee_sales

    e. TOP PRODUCT
SELECT product_type, SUM(total_sales) as total_sales FROM coffee_sales
GROUP BY product_type
ORDER BY total_sales DESC
LIMIT 1;

    a. TIME OF THE DAY SALES
SELECT * FROM Coffee_sales;
SELECT time_of_day, SUM(total_sales) as total_sales FROM coffee_sales
GROUP BY time_of_day
ORDER BY total_sales DESC;

   b. WEEK DAYS SALES
SELECT week_day, SUM(total_sales) as total_sales FROM coffee_sales
GROUP BY week_day
ORDER BY total_sales DESC;

   c. SALES TREND MY MONTH
SELECT month, SUM(total_sales) as total_sales FROM coffee_sales
GROUP BY month
ORDER BY total_sales DESC;

   d. TOP SELLING PRODUCTS
SELECT product_category, SUM(total_sales) as total_sales FROM coffee_sales
GROUP BY product_category
ORDER BY total_sales DESC
LIMIT 5;

   e. TOP 10 MOST ORDERED PRODUCT TYPE
   SELECT * FROM Coffee_sales;
SELECT product_type, COUNT(transaction_qty) as quantity_ordered FROM coffee_sales
GROUP BY product_type
ORDER BY quantity_ordered DESC
LIMIT 10;

   f. TOP 10 HIGHEST EARNING PRODUCT TYPE
SELECT product_type, SUM(total_sales) as total_sales  FROM coffee_sales
GROUP BY product_type
ORDER BY total_sales DESC
LIMIT 10;