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

4. Employee Leaderboard (Role-Specific KPIs)
CREATE MATERIALIZED VIEW analytics.mv_employee_kpis AS
SELECT 
    e.name AS employee_name,
    e.role,
    e.branch_location,
    COUNT(o.order_id) AS tasks_completed,
    SUM(o.total_amount) AS total_value_handled
FROM operations.employees e
JOIN operations.orders o 
    ON e.employee_id = o.prescribed_by
    OR e.employee_id = o.dispatched_by
GROUP BY e.name, e.role, e.branch_location
ORDER BY total_value_handled DESC;

-- 5. Peak Sales Hours
CREATE MATERIALIZED VIEW analytics.peak_sales_hour AS
SELECT
	EXTRACT (HOUR FROM order_datetime) AS hour_of_day,
	COUNT(order_id) AS order_volume
FROM operations.orders
GROUP BY EXTRACT (HOUR FROM order_datetime)
ORDER BY order_volume DESC;
