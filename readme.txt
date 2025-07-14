============================================================
ReadMe – DeFi Analytics & Risk Assessment (Milestone 2)
============================================================

Project Title:
--------------
DeFi Analytics & Risk Assessment

Course:
-------
CSE 460/560 – Data Models and Query Languages (Spring 2025)

Team:
-----
Siddhi Nalawade-50613176
Mrudula Deshmukh-50605669

Project Summary:
----------------
This project builds a relational database system to analyze Ethereum blockchain transactions, particularly ERC-20 and ERC-721 token transfers. The database supports the detection of suspicious patterns such as large token movements, frequent small transfers, and high-activity wallets, enabling risk analysis within DeFi protocols.

Dataset Source:
---------------
- Public dataset: `bigquery-public-data.crypto_ethereum.token_transfers`
- Extracted using Google BigQuery SQL
- Filtered range: January 1, 2025 – February 1, 2025
- 20,000 token transfer rows exported to CSV format

Included Files:
---------------
1. `create.sql` – Defines the database schema and creates all tables:
   - `Block`, `Wallet`, `Token`, `Transaction`, `TokenEvent`, and `staging_deploy`

2. `load.sql` – Loads data from the staging table into normalized tables using bulk insert queries.

3. `cleaned_ethereum_events_10000.csv` – Contains 20,000 token transfer records (extracted from BigQuery).

4. `readme.txt` – Describes project purpose, data source, files, and execution steps.

5.  ‘DQML_EDA.ipynb’ - Have done EDA on the raw data.

‘Milestone2_report.pdf’ - briefly summarizes the project, data sources, execution steps, and file contents for easy reproducibility.

Execution Steps:
----------------
1. Run `create.sql` to create all schema tables and constraints.
2. Load the `staging_deploy.csv` into the `staging_deploy` table (via `COPY` or import tool).
3. Run `load.sql` to populate the normalized tables from `staging_deploy`.
4. Optionally, run performance optimization and analytical SQL queries (e.g., `EXPLAIN ANALYZE`, large transfer detection, wallet activity ranking).

Schema Features:
----------------
- Normalized to BCNF for minimal redundancy
- Referential integrity enforced via foreign keys
- Indexes applied to improve query performance
- Domain constraints and validation checks implemented
- Supports CRUD operations and DeFi-specific analytics

Tools Used:
-----------
- PostgreSQL
- Google BigQuery
- pgAdmin / psql (for execution)

Notes:
------
- The database can be extended for real-time ingestion or visual dashboards.
- Bonus risk metric queries (e.g., large transfers, wallet spam detection) are included separately in the report and codebase.

============================================================
End of ReadMe
============================================================
