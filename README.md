# LZ Pharma Database Security & Optimisation

A PostgreSQL project to secure and optimise a pharmacy database with four schemas: operations, inventory, research and analytics.

## What it does
- **Access control:** four roles (admin, data engineer, data analyst, researcher), each given only the access it needs. Analysts cannot read customer data.
- **Data integrity:** CHECK constraints (e.g. no negative prices or stock) and foreign keys with ON DELETE rules.
- **Performance:** the orders table is range-partitioned by year (2020–2025).
- **Analytics:** views and a materialized view for stock-out risk and supplier revenue.

## Tools
PostgreSQL, pgAdmin, SQL

## Folder structure
- `sql/Security`: roles and permissions
- `sql/Constraint`: data validation rules
- `sql/Optimization`: partitioning and delete rules
- `sql/Analytics`: reporting views
- `docs`: data architecture diagram
