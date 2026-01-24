CREATE TABLE operations.orders_partitioned (
	LIKE operations.orders INCLUDING DEFAULTS
) PARTITION BY RANGE (order_datetime);

ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT check_total_amount CHECK (total_amount >= 0);

ALTER TABLE operations.orders_partitioned
ADD PRIMARY KEY (order_id, order_datetime);

--Recreate the foreign keys
ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT fk_orders_customer 
	FOREIGN KEY (customer_id)
	REFERENCES operations.customers(customer_id);

ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT fk_orders_attendant 
	FOREIGN KEY (attendant_id)
	REFERENCES operations.employees(employee_id);

ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT fk_orders_drugs 
	FOREIGN KEY (drug_id)
	REFERENCES inventory.drugs(drug_id);

ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT fk_prescribed_by_fkay 
	FOREIGN KEY (prescribed_by)
	REFERENCES operations.employees(employee_id);

ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT fk_paid_to
	FOREIGN KEY (paid_to)
	REFERENCES operations.employees(employee_id);

ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT fk_dispatched_by
	FOREIGN KEY (dispatched_by)
	REFERENCES operations.employees(employee_id);

-- Assignment: Add connect the 'paid to' and
--'dispatched by' columns to their souce tables

-- Create partitions per year
CREATE TABLE operations.orders_2020 PARTITION OF
operations.order_partitioned
FOR VALUES FROM ('2020-01-01') TO ('2021-01-01');

CREATE TABLE operations.orders_2021 PARTITION OF
operations.order_partitioned
FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

CREATE TABLE operations.orders_2022 PARTITION OF
operations.order_partitioned
FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE operations.orders_2023 PARTITION OF
operations.order_partitioned
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE operations.orders_2024 PARTITION OF
operations.order_partitioned
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE operations.orders_2025 PARTITION OF
operations.order_partitioned
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Insert into the orders_partitioned after partitioning
--from the orders table
INSERT INTO operations.orders_partitioned
SELECT * FROM operations.orders;

-- Rename tables orders_partitioned table to orders and 
-- vice versa
ALTER TABLE operations.orders RENAME TO orders_old;
ALTER TABLE operations.orders_partitioned RENAME TO orders;
