CREATE TABLE amazon_sales (
    order_id VARCHAR(50),
    date DATE,
    status VARCHAR(100),
    fulfilment VARCHAR(30),
    sales_channel VARCHAR(30),
    ship_service_level VARCHAR(30),
    category VARCHAR(50),
    size VARCHAR(20),
    courier_status VARCHAR(50),
    qty INT,
    currency VARCHAR(10),
    amount DECIMAL(10,2),
    ship_city VARCHAR(100),
    ship_state VARCHAR(100),
    ship_postal_code BIGINT,
    ship_country VARCHAR(20),
    b2b BOOLEAN,
    fulfilled_by VARCHAR(30),
    year INT,
    month VARCHAR(20),
    month_number INT,
    day INT,
    day_name VARCHAR(20),
    quarter INT
);

/* Total Orders */

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM amazon_sales;

/* Total Revenue */

SELECT ROUND(SUM(amount),2) AS total_revenue
FROM amazon_sales;

/* Average Order Value */

SELECT ROUND(AVG(amount),2) AS average_order_value
FROM amazon_sales;

/* Total Quantity Sold */

SELECT SUM(qty) AS total_quantity_sold
FROM amazon_sales;

/* Monthly Revenue */

SELECT
    month_number,
    month,
    ROUND(SUM(amount),2) AS revenue
FROM amazon_sales
GROUP BY month_number, month
ORDER BY month_number;

/* Monthly Orders */

SELECT
    month_number,
    month,
    COUNT(DISTINCT order_id) AS orders
FROM amazon_sales
GROUP BY month_number, month
ORDER BY month_number;

/* Revenue by Product Category */

SELECT
    category,
    ROUND(SUM(amount),2) AS revenue
FROM amazon_sales
GROUP BY category
ORDER BY revenue DESC;

/* Quantity Sold by Product Category */

SELECT
    category,
    SUM(qty) AS quantity_sold
FROM amazon_sales
GROUP BY category
ORDER BY quantity_sold DESC;

/* Revenue by Product Size */

SELECT
    size,
    ROUND(SUM(amount),2) AS revenue
FROM amazon_sales
GROUP BY size
ORDER BY revenue DESC;

/* Orders by Order Status */

SELECT
    status,
    COUNT(DISTINCT order_id) AS orders
FROM amazon_sales
GROUP BY status
ORDER BY orders DESC;

/* Orders by Courier Status */

SELECT
    courier_status,
    COUNT(DISTINCT order_id) AS orders
FROM amazon_sales
GROUP BY courier_status
ORDER BY orders DESC;

/* Orders by Fulfilment Method */

SELECT
    fulfilment,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(amount),2) AS revenue
FROM amazon_sales
GROUP BY fulfilment;

/* B2B vs B2C Analysis */

SELECT
    CASE
        WHEN b2b = TRUE THEN 'B2B'
        ELSE 'B2C'
    END AS customer_type,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(amount),2) AS revenue
FROM amazon_sales
GROUP BY b2b;

/* Top 10 States by Revenue */

SELECT
    ship_state,
    ROUND(SUM(amount),2) AS revenue
FROM amazon_sales
GROUP BY ship_state
ORDER BY revenue DESC
LIMIT 10;

/* Top 10 Cities by Revenue */

SELECT
    ship_city,
    ROUND(SUM(amount),2) AS revenue
FROM amazon_sales
GROUP BY ship_city
ORDER BY revenue DESC
LIMIT 10;

/* Top Product Categories by Quantity Sold */

SELECT
    category,
    SUM(qty) AS quantity_sold
FROM amazon_sales
GROUP BY category
ORDER BY quantity_sold DESC;

/* Revenue by Sales Channel */

SELECT
    sales_channel,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(amount),2) AS revenue
FROM amazon_sales
GROUP BY sales_channel;

/* Revenue by Fulfilled By */

SELECT
    fulfilled_by,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(amount),2) AS revenue
FROM amazon_sales
GROUP BY fulfilled_by;

/* Top 10 Highest Revenue Orders */

SELECT
    order_id,
    amount
FROM amazon_sales
ORDER BY amount DESC
LIMIT 10;

/* Average Revenue by State */

SELECT
    ship_state,
    ROUND(AVG(amount),2) AS average_revenue
FROM amazon_sales
GROUP BY ship_state
ORDER BY average_revenue DESC;

/* Monthly Revenue by Category */

SELECT
    month,
    category,
    ROUND(SUM(amount),2) AS revenue
FROM amazon_sales
GROUP BY month_number, month, category
ORDER BY month_number, revenue DESC;

/* Top 5 States by Quantity Sold */

SELECT
    ship_state,
    SUM(qty) AS quantity_sold
FROM amazon_sales
GROUP BY ship_state
ORDER BY quantity_sold DESC
LIMIT 5;

/* Revenue by Ship Service Level */

SELECT
    ship_service_level,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(amount),2) AS revenue
FROM amazon_sales
GROUP BY ship_service_level;

/* Cancelled Orders Percentage */

SELECT
    ROUND(
        COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) * 100.0 /
        COUNT(*),
        2
    ) AS cancelled_order_percentage
FROM amazon_sales;

/* Revenue by Quarter */

SELECT
    quarter,
    ROUND(SUM(amount),2) AS revenue
FROM amazon_sales
GROUP BY quarter
ORDER BY quarter;

/* Top 5 Revenue Generating Days */

SELECT
    day_name,
    ROUND(SUM(amount),2) AS revenue
FROM amazon_sales
GROUP BY day_name
ORDER BY revenue DESC
LIMIT 5;

/* ===========================
   Business Insights
   ===========================

1. Amazon.in generated nearly all orders and revenue, indicating that the business is highly dependent on a single sales channel.

2. Amazon Fulfilment handled the majority of customer orders, demonstrating strong reliance on Amazon's logistics network.

3. T-Shirts and Shirts emerged as the top-performing product categories in terms of both revenue and quantity sold.

4. Medium (M), Large (L), and Extra Large (XL) sizes recorded the highest sales, reflecting customer preference for these sizes.

5. Maharashtra, Karnataka, and Tamil Nadu were among the highest revenue-generating states, indicating strong demand in these regions.

6. Metropolitan cities such as Bengaluru, Hyderabad, Mumbai, Chennai, and New Delhi contributed a significant share of total revenue.

7. Most orders were successfully shipped or delivered, indicating an efficient order fulfillment process with relatively fewer cancelled or pending orders.

8. The customer base is predominantly B2C, while B2B orders account for only a small percentage of total transactions.

9. The majority of customer purchases fall within a moderate price range, with only a few high-value transactions contributing to overall revenue.

10. Monthly sales trends show fluctuations in customer demand, highlighting the importance of seasonal planning for inventory and promotional campaigns.
*/



/* ===========================
   Business Recommendations
   ===========================

1. Reduce dependency on Amazon.in by expanding sales through additional online marketplaces and the company's own website.

2. Maintain adequate inventory levels for high-performing product categories such as T-Shirts and Shirts to prevent stock shortages.

3. Prioritize inventory for Medium, Large, and XL sizes, as they consistently generate higher customer demand.

4. Increase marketing efforts in top-performing states and metropolitan cities to maximize revenue and customer acquisition.

5. Investigate the primary causes of cancelled and pending orders to improve customer satisfaction and operational efficiency.

6. Strengthen logistics and delivery performance in regions with comparatively lower shipment success rates.

7. Develop targeted promotional campaigns during low-sales periods to improve monthly sales consistency.

8. Explore opportunities to expand B2B partnerships and corporate sales to diversify the customer base.

9. Analyze high-performing products regularly to optimize pricing, inventory management, and future product launches.

10. Implement data-driven demand forecasting using historical sales trends to optimize inventory planning, minimize stock shortages, and reduce excess inventory.
*/