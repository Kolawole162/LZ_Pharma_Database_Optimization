-- Supply Chain Risk Monitor
CREATE VIEW analytics.supply_chain_risk AS
SELECT stock.drug_id, 
	drugs."name" AS drug_name, 
	stock.quantity AS current_stock,
	CASE
		WHEN stock.quantity <= 100 THEN 'CRITICAL: Stock out'
		WHEN stock.quantity <=500 THEN 'WARNING: Low Stock'
		ELSE 'Good Stock'
	END AS risk_status,
	suppliers.name AS supplier_name,
	suppliers.contact_email AS supplier_contact_email
FROM inventory.stock
LEFT JOIN inventory.drugs ON stock.drug_id = drugs.drug_id
LEFT JOIN inventory.suppliers ON suppliers.drug_id = drugs.drug_id
WHERE stock.quantity <= 1000;

-- 2. Supplier Value Reports
CREATE MATERIALIZED VIEW analytics.mv_supplier_value AS
SELECT 
    sup.name AS supplier_name,
    sup.country,
    COUNT(DISTINCT o.order_id) AS total_orders_fulfilled,
    SUM(o.total_amount) AS total_revenue_generated
FROM inventory.suppliers sup
JOIN inventory.drugs d ON sup.drug_id = d.drug_id
JOIN operations.orders o ON d.drug_id = o.drug_id
GROUP BY sup.name, sup.country
ORDER BY total_revenue_generated DESC;