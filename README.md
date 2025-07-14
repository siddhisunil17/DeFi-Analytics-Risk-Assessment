# DeFi-Analytics-Risk-Assessment

## 📌 Project Overview

This project builds a relational database to analyze Ethereum token transfer activity using real-world blockchain data. We designed a normalized schema, implemented analytical SQL queries, and built a lightweight Flask web interface for querying the database.

---

## 📁 Project Structure

- `database/create.sql` : SQL script to create the PostgreSQL schema  
- `database/load.sql` : SQL script to bulk load the data  
- `database/cleaned_ethereum_events_10000.csv` : Sample cleaned Ethereum transaction data  

- `notebook/dmql_eda.ipynb` : Exploratory data analysis notebook with queries, insights, and plots  

- `webapp/app.py` : Flask application to query and display results  
- `webapp/templates/index.html` : HTML template for the web UI  

- `report/Document1.pdf` : Milestone 1 proposal document  
- `report/DeFi_Analytics_Report.pdf` : Final analysis report with queries, performance evaluation, and discussion  
- `report/erd.png` : E/R diagram illustrating the database schema  

- `requirements.txt` : Python dependencies needed to run the notebook and Flask app  
- `README.md` : This file

---


## 🚀 Getting Started

pip install -r requirements.txt

psql -d ethereum_db -f database/create.sql

psql -d ethereum_db -f database/load.sql

python webapp/app.py


## 📊 Features

- ✅ Normalized relational schema (BCNF)
- 🔎 Complex SQL queries with JOINs, GROUP BY, subqueries
- 📈 Data analysis notebook for token movement and risk patterns
- 🌐 Lightweight Flask web interface for SQL query submission
- 🗂️ Clean data integration using `.csv` files and PostgreSQL

---

## 🧠 Key Learnings

- Practical database design using PostgreSQL
- Query optimization using `EXPLAIN` and indexing
- Flask integration with relational databases
- Team collaboration and structured milestone-based development

---
🧪 Sample SQL Queries

-- 🔝 Top 5 most frequently transferred tokens

SELECT token_id, COUNT(*) AS transfer_count
FROM tokenevent
GROUP BY token_id
ORDER BY transfer_count DESC
LIMIT 5;

-- 💰 Wallets that received the highest token volume

SELECT to_wallet, SUM(quantity) AS total_received
FROM tokenevent
GROUP BY to_wallet
ORDER BY total_received DESC
LIMIT 5;

-- 🔗 Join transaction and token events for a given token

SELECT t.transaction_hash, te.token_id, te.quantity, te.event_type
FROM tokenevent te
JOIN transaction t ON te.transaction_hash = t.transaction_hash
WHERE te.token_id = '0x123abc...';


## 📂 Dataset Description

The `cleaned_ethereum_events_10000.csv` file includes token transaction logs from the Ethereum blockchain.

| Column Name        | Description                                  |
|--------------------|----------------------------------------------|
| `transaction_hash` | Unique hash identifying the transaction      |
| `event_index`      | Index of the event within the transaction    |
| `quantity`         | Number of tokens transferred                 |
| `event_type`       | Type of token event (e.g., Transfer, Mint)   |
| `token_id`         | Contract address of the token                |
| `to_wallet`        | Wallet address receiving the tokens          |

> The data has been cleaned to remove nulls and duplicate entries, and formatted for bulk loading into PostgreSQL.




## 🔗 References

- [Ethereum Token Transfers – Open Data](https://etherscan.io/token-transfer)  
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)  
- [Flask Documentation](https://flask.palletsprojects.com/)  
- [PgAdmin](https://www.pgadmin.org/)  
- [IEEE LaTeX Template](https://www.overleaf.com/latex/templates/ieee-conference-template-example/nsncsyjfmpxy)

> All resources were used strictly for academic and educational purposes.

