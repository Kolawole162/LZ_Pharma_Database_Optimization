-- Inventory CONSTRAINTS
ALTER TABLE inventory.drugs
ADD CONSTRAINT check_positive_price CHECK (price > 0);

-- check the price of each drugs recorded into the database
ALTER TABLE inventory.stock
ADD CONSTRAINT check_nonnegative_quantity CHECK (quantity >= 0)

-- orders table
ALTER TABLE operations.orders
ADD CONSTRAINT check_total_amount CHECK (total_amount >= 0)

-- Assignment: Set a constraint on the trial_participant table
-- where the age must be between 8 to 85
ALTER TABLE research,trail_participant
ADD CONSTRAINT check_age CHECK (age 8 > 0 <= 85 )

