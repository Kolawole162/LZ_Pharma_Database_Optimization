-- Role Based Access Control
CREATE ROLE data_engineer_role NOLOGIN;
CREATE ROLE data_analyst_role NOLOGIN;
CREATE ROLE admin_role NOLOGIN;
CREATE ROLE researcher_role NOLOGIN;

-- Grant permissions to the roles;
-- Data engineering role permissions: full
--read/write on the operations and inventory
GRANT USAGE ON SCHEMA operations, inventory
TO data_engineer_role;
GRANT ALL PRIVILEGES ON SCHEMA operations,
inventory TO data_engineer_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA 
operations, inventory TO data_engineer_role;

-- Assignment 1: Grant the Data Engineering role
--Read-Only access to all tables in the research schema
GRANT USAGE ON SCHEMA research TO data_engineer_role;
GRANT SELECT ON ALL TABLES IN SCHEMA
research TO data_engineer_role;

-- Data Analyst permissions: Full access to
-- the analytics table and read only on 
--operations, inventory
GRANT USAGE ON SCHEMA analytics, operations,
inventory TO data_analyst_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA
analytics TO data_analyst_role;
GRANT SELECT ON ALL TABLES IN SCHEMA operations,
inventory TO data_analyst_role;
REVOKE SELECT ON operations.customers FROM 
data_analyst_role;

-- Assignment 2: Grant the researcher role full
--read/write access to the research schema and
--read access to the drugs table
GRANT USAGE ON SCHEMA research, inventory.drugs TO researcher_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA
research TO researcher_role;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA research TO researcher_role;
GRANT SELECT ON TABLE inventory.drugs TO researcher_role;


-- Admin role: full access to all SCHEMAS
GRANT ALL PRIVILEGES ON SCHEMA analytics, 
inventory, operations, research TO admin_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA analytics, 
inventory, operations, research TO admin_role;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA 
analytics, inventory, operations, research TO admin_role;

--Create the users
CREATE USER Chinyere WITH PASSWORD 'omk*#123';
CREATE USER Mohammed WITH PASSWORD '*moh492#';
CREATE USER Kolawole WITH PASSWORD 'Ace@123';

-- Grant permissions to users based on roles
GRANT data_engineer_role TO Chinyere;
GRANT data_analyst_role TO Mohammed, Kolawole;

-- Assignment 3: We just onboarded 4 new team members in
--LZ Pharma (Crainsor, Temitayo, Vincent, Anthony).
-- Anthony was onboarded as a database Administrator, 
-- Vincent as a researcher, Temitayo as  business analyst,
-- Crainsor as a data engineer. Using these information given,
--create and grant user permissions based on their appropriate roles.
CREATE USER Anthony WITH PASSWORD 'Anth123@';
CREATE USER Vincent WITH PASSWORD 'Vinc@123';
CREATE USER Temitayo WITH PASSWORD 'Temi123@';
CREATE USER Crainsor WITH PASSWORD 'Crai@123';

GRANT admin_role TO Anthony;
GRANT researcher_role TO Vincent;
GRANT data_analyst_role TO Temitayo;
GRANT data_engineer_role TO Crainsor;

