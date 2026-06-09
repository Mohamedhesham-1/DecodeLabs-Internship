use ecommerce_orders;
SELECT * FROM orders LIMIT 5;
-- ---------------------------------
-- Total Revenue and Total Orders:
SELECT 
    COUNT(*) AS Total_Orders,
    SUM(TotalPrice) AS Total_Revenue,
    ROUND(AVG(TotalPrice), 2) AS Avg_Order_Value
FROM orders;
-- total orders --> 1200, total revenue --> 1264761.96, average order price --> 1053.97
-- ---------------------------------
-- Revenue by Product:
select
	Product,
    count(*) as Total_orders,
    sum(TotalPrice) as Total_revenue,
    round(avg(TotalPrice),2) as Avg_order_price
from orders
group by Product
order by Total_revenue desc;
-- ---------------------------------
-- Top 5 Best Selling Products by Order Count:
SELECT 
    Product,
    COUNT(*) AS Total_Orders,
    SUM(TotalPrice) AS Total_Revenue
FROM orders
GROUP BY Product
ORDER BY Total_Orders DESC
LIMIT 3;
-- ---------------------------------
-- Revenue by Payment Method
select
	PaymentMethod,
    count(*) as Total_orders,
    sum(TotalPrice) as Total_revenue,
    round(avg(TotalPrice),2) as Avg_order_price
from orders
group by PaymentMethod
order by Total_revenue desc;
-- ---------------------------------
--  Best Payment Method for Delivered Orders only:
SELECT PaymentMethod, COUNT(*) AS Delivered_Orders,
SUM(TotalPrice) AS Revenue
FROM orders
WHERE OrderStatus = 'Delivered'
GROUP BY PaymentMethod
ORDER BY Delivered_Orders DESC;
-- ---------------------------------
-- Filter Only Delivered Orders
select
	OrderID,
    Product,
    TotalPrice,
    Date
from orders
where OrderStatus = "Delivered"
ORDER BY TotalPrice DESC;

select count(*), sum(TotalPrice) from orders where OrderStatus = "Delivered";
-- ---------------------------------
-- Revenue by Order Status:
select
	OrderStatus,
    count(*) as Total_orders,
    sum(TotalPrice) as Total_revenue,
    round(avg(TotalPrice),2) as Avg_order_price
from orders
group by OrderStatus
order by Total_revenue desc;
-- ---------------------------------
-- Orders Above the Average:
SELECT 
    OrderID,
    Product,
    Quantity,
    TotalPrice,
    OrderStatus
FROM orders
WHERE TotalPrice > (SELECT AVG(TotalPrice) FROM orders)
ORDER BY TotalPrice DESC;

select count(*), sum(TotalPrice) from orders WHERE TotalPrice > (SELECT AVG(TotalPrice) FROM orders);
-- ---------------------------------
-- Dilevered Orders Above the Average:
SELECT 
    OrderID,
    Product,
    Quantity,
    TotalPrice,
    OrderStatus
FROM orders
WHERE TotalPrice > (SELECT AVG(TotalPrice) FROM orders) and OrderStatus =  "Delivered"
ORDER BY TotalPrice DESC;

select count(*), sum(TotalPrice) from orders WHERE TotalPrice > (SELECT AVG(TotalPrice) FROM orders) and OrderStatus =  "Delivered";
-- ---------------------------------
-- Revenue by Referral Source
SELECT 
    ReferralSource,
    COUNT(*) AS Total_Orders,
    SUM(TotalPrice) AS Total_Revenue,
    ROUND(AVG(TotalPrice), 2) AS Avg_Order_Value
FROM orders
GROUP BY ReferralSource
ORDER BY Total_Revenue DESC;
-- ---------------------------------
--  Monthly Revenue Trend:
SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    COUNT(*) AS Total_Orders,
    SUM(TotalPrice) AS Total_Revenue
FROM orders
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, Month;
-- ---------------------------------
-- Best Month Ever:
SELECT 
	YEAR(Date) AS Year,
	MONTH(Date) AS Month,
	SUM(TotalPrice) AS Revenue
FROM orders
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Revenue DESC
LIMIT 1;
-- ---------------------------------
-- Most used Coupon code:
SELECT 
	CouponCode, 
	COUNT(*) AS Total_Orders,
	SUM(TotalPrice) AS Total_Revenue
FROM orders
GROUP BY CouponCode
ORDER BY Total_Orders DESC
limit 1;
-- ---------------------------------
-- Cancelled and Returned Orders Summary (The Business Problem):
SELECT 
    OrderStatus,
    COUNT(*) AS Total_Orders,
    SUM(TotalPrice) AS Lost_Revenue,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2) AS Percentage
FROM orders
WHERE OrderStatus IN ('Cancelled', 'Returned')
GROUP BY OrderStatus
ORDER BY Total_Orders DESC;
-- ---------------------------------
--  Average Items in Cart by Order Status, Do cancelled orders have more items in cart than delivered ones?
SELECT OrderStatus,
ROUND(AVG(ItemsInCart), 2) AS Avg_Items_In_Cart,
ROUND(AVG(TotalPrice), 2) AS Avg_Order_Value
FROM orders
GROUP BY OrderStatus
ORDER BY Avg_Items_In_Cart DESC;
