-- set the customer_id in orders table to NULL when a customer
--is deleted
ALTER TABLE operations.orders
ADD CONSTRAINT order_customer_deletion
FOREIGN KEY (customer_id) REFERENCES 
operations.customers(customer_id) ON DELETE SET NULL;


-- delete the drug_id record in stock if the drug is deleted
ALTER TABLE inventory.stock
ADD CONSTRAINT stock_drug_deletion
FOREIGN KEY (drug_id) REFERENCES inventory.drugs(drug_id)
ON DELETE CASCADE;

-- orders table
ALTER TABLE operations.orders
ADD CONSTRAINT employees_customer_deletion
FOREIGN KEY (attendant_id) REFERENCES operations.employees(employee_id)
ON DELETE SET NULL;

ALTER TABLE operations.orders
ADD CONSTRAINT employees_customer_deletion_1
FOREIGN KEY (paid_to) REFERENCES operations.employees(employee_id)
ON DELETE SET NULL;

ALTER TABLE operations.orders
ADD CONSTRAINT employees_customer_deletion_2
FOREIGN KEY (dispatched_by) REFERENCES operations.employees(employee_id)
ON DELETE SET NULL;

ALTER TABLE operations.orders
ADD CONSTRAINT employees_customer_deletion_3
FOREIGN KEY (prescribed_by) REFERENCES operations.employees(employee_id)
ON DELETE SET NULL;

-- Assignment: Create a constraint to delete the supplier information when a drug is deleted.
ALTER TABLE inventory.suppliers
ADD CONSTRAINT suppliers_info_deletion
FOREIGN KEY (drug_id) REFERENCES inventory.drugs(drug_id)
ON DELETE CASCADE;


DELETE FROM operations.customers WHERE customer_id = 23;

SELECT * FROM operations.orders WHERE customer_id = 23;

SELECT * FROM operations.orders WHERE customer_id IS NULL;