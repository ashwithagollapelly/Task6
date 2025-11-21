CREATE DATABASE online_sales;
USE online_sales;
CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    product_id INT
);
INSERT INTO orders (order_id, order_date, amount, product_id) VALUES
(1, '2024-01-05', 500.00, 10),
(2, '2024-01-11', 1200.00, 12),
(3, '2024-02-02', 900.00, 11),
(4, '2024-02-10', 1500.00, 12),
(5, '2024-03-15', 800.00, 13),
(6, '2024-03-28', 1800.00, 10);
SELECT * FROM orders;
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;
SELECT
  m.year,
  m.month,
  m.total_revenue,
  m.order_volume,
  ROUND(m.total_revenue / NULLIF(m.order_volume,0), 2) AS avg_order_value,
  ROUND(
      (m.total_revenue - p.total_revenue)
      / NULLIF(p.total_revenue, 0) * 100
  ,2) AS mom_percent_change
FROM (
  SELECT YEAR(order_date) AS year,
         MONTH(order_date) AS month,
         SUM(amount) AS total_revenue,
         COUNT(DISTINCT order_id) AS order_volume
  FROM orders
  GROUP BY YEAR(order_date), MONTH(order_date)
) m
LEFT JOIN (
  SELECT YEAR(order_date) AS year,
         MONTH(order_date) AS month,
         SUM(amount) AS total_revenue
  FROM orders
  GROUP BY YEAR(order_date), MONTH(order_date)
) p
ON (p.year = m.year AND p.month = m.month - 1)
ORDER BY m.year, m.month;





