-- 3. Regional Logistics Heatmap
CREATE VIEW analytics.regional_logistics AS
SELECT c.state,
	COUNT(o.order_id) AS order_volume,
	SUM(o.total_amount) AS total_revenue,
	AVG(o.total_amount) AS average_revenue
FROM operations.customers c
JOIN operations.orders o ON c.customer_id = o.customer_id
GROUP BY c.state
ORDER BY total_revenue DESC;

-- 5. Peak Sales Hours
CREATE MATERIALIZED VIEW analytics.peak_sales_hour AS
SELECT
	EXTRACT (HOUR FROM order_datetime) AS hour_of_day,
	COUNT(order_id) AS order_volume
FROM operations.orders
GROUP BY EXTRACT (HOUR FROM order_datetime)
ORDER BY order_volume DESC;
