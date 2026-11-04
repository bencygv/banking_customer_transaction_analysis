
# Banking Customer & Transaction Analysis

## Project Overview

This project analyzes banking customer, account, transaction,
loan, card, and transfer data using PostgreSQL, SQL, and
Microsoft Power BI.

The objective is to explore banking operations, identify
financial trends, evaluate branch performance, and develop
interactive dashboards that support data-driven decisions.

The project demonstrates an end-to-end data analytics workflow,
including:

- Relational database creation in PostgreSQL
- CSV data import and data quality validation
- Data exploration and cleaning using SQL
- Business analysis using joins, aggregations, and CTEs
- Relational data modeling in Power BI
- Interactive dashboard development and KPI validation

## Technologies Used

- **PostgreSQL:** Database management and SQL analysis
- **SQL:** Data exploration, validation, cleaning, and reporting
- **Power BI:** Data modeling, DAX, and visualization
- **VS Code:** SQL development and project organization
- **Git & GitHub:** Version control and portfolio documentation


## Dataset Description

The project uses a relational banking dataset containing
customer, account, transaction, loan, card, and transfer records.

The dataset was imported into PostgreSQL from CSV files.

### Database Tables

| Table | Records | Description |
|---|---:|---|
| customers | 1,200 | Customer information |
| addresses | 1,200 | Customer addresses |
| branches | 20 | Bank branch information |
| branch_addresses | 20 | Branch locations |
| accounts | 2,000 | Customer bank accounts |
| cards | 1,500 | Debit and credit cards |
| loans | 300 | Customer loans |
| loan_payments | 5,000 | Loan repayment records |
| transactions | 100,000 | Account transactions |
| transfers | 5,000 | Transfers between accounts |

### Database Relationships

- Customers are linked to accounts through `customer_id`.
- Customers are linked to addresses through `customer_id`.
- Branches are linked to accounts through `branch_id`.
- Accounts are linked to transactions through `account_id`.
- Accounts are linked to cards through `account_id`.
- Loans are linked to loan payments through `loan_id`.
- Transfers reference source and destination accounts.
- Branches are linked to branch addresses through `branch_id`.

Primary and foreign key relationships were validated
using SQL before building the Power BI data model.


## Data Exploration and Quality Checks

Before performing business analysis, data quality checks
were conducted in PostgreSQL to ensure the reliability
and consistency of the dataset.

### 1. Record Count Validation

Verified the number of records in each imported table.

```sql
SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_accounts
FROM accounts;

SELECT COUNT(*) AS total_transactions
FROM transactions;
```

### 2. Missing Value Checks

Checked important columns for missing values.

```sql
SELECT
    COUNT(*) FILTER (WHERE id IS NULL) AS missing_id,
    COUNT(*) FILTER (WHERE email IS NULL) AS missing_email,
    COUNT(*) FILTER (WHERE first_name IS NULL) AS missing_first_name
FROM customers;
```

### 3. Duplicate Checks

Checked for duplicate account numbers.

```sql
SELECT account_number, COUNT(*)
FROM accounts
GROUP BY account_number
HAVING COUNT(*) > 1;
```

### 4. Referential Integrity Validation

Checked whether accounts reference valid customers.

```sql
SELECT COUNT(*) AS unmatched_accounts
FROM accounts a
LEFT JOIN customers c
    ON a.customer_id = c.id
WHERE c.id IS NULL;
```

Result: No unmatched customer references were identified.

### 5. Data Standardization

Examined account statuses and types for inconsistent
formatting, including capitalization and extra spaces.

```sql
SELECT DISTINCT status
FROM accounts;

SELECT DISTINCT type
FROM accounts;

SELECT COUNT(*) AS untrimmed_statuses
FROM accounts
WHERE status <> TRIM(status);
```

### 6. Financial Data Validation

Reviewed account balances and financial amounts
for potentially unusual values.

Identified 17 accounts with negative balances.
These records were retained because negative balances
may represent overdrafts rather than data errors.

### Outcome

The data validation process helped establish a
reliable foundation for SQL business analysis and
Power BI reporting.

Detailed SQL scripts are available in the `sql/` folder.


## SQL Business Analysis and Key Findings

SQL queries were developed to analyze customer behavior,
account activity, transaction patterns, and financial performance.

### 1. Customer and Account Analysis

**Business Question:** How many customers and accounts does the bank have?

```sql
SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_accounts
FROM accounts;
```

**Results:**
- Total customers: 1,200
- Total accounts: 2,000
- Customers with multiple accounts: 472

### 2. Account Status Distribution

**Business Question:** What is the distribution of account statuses?

```sql
SELECT
    status,
    COUNT(*) AS account_count
FROM accounts
GROUP BY status
ORDER BY account_count DESC;
```

**Results:**
- Open: 1,859
- Closed: 124
- Frozen: 17

Most bank accounts are open.

### 3. Account Type Distribution

**Business Question:** Which account types are most common?

```sql
SELECT
    type,
    COUNT(*) AS account_count
FROM accounts
GROUP BY type
ORDER BY account_count DESC;
```

**Results:**
- Checking: 1,204
- Savings: 636
- Business: 160

Checking accounts represent the largest account category.

### 4. Total Account Balance

**Business Question:** What is the total balance held across all accounts?

```sql
SELECT
    ROUND(SUM(balance), 2) AS total_balance
FROM accounts;
```

**Result:** 53,518,448.92

### 5. Transaction Type Analysis

**Business Question:** What types of transactions occur most frequently?

```sql
SELECT
    type,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY type
ORDER BY transaction_count DESC;
```

**Results:**
- Withdrawals: 48,017
- Deposits: 43,841
- Interest: 4,079
- Fees: 4,063

Withdrawals and deposits account for the majority of transactions.

### 6. Loan Status Analysis

**Business Question:** What is the distribution of loan statuses?

```sql
SELECT
    status,
    COUNT(*) AS loan_count
FROM loans
GROUP BY status
ORDER BY loan_count DESC;
```

**Results:**
- Active: 231
- Paid off: 61
- Defaulted: 8

### 7. Card Status Analysis

**Business Question:** What is the distribution of card statuses?

```sql
SELECT
    status,
    COUNT(*) AS card_count
FROM cards
GROUP BY status
ORDER BY card_count DESC;
```

**Results:**
- Active: 1,370
- Expired: 86
- Blocked: 44

### 8. Transfer Analysis

**Business Question:** What is the total amount transferred between accounts?

```sql
SELECT
    COUNT(*) AS total_transfers,
    ROUND(SUM(amount), 2) AS total_transfer_amount
FROM transfers;
```

**Results:**
- Total transfers: 5,000
- Total transfer amount: approximately 16.83 million

### Additional Analyses

The project also includes:
- Monthly transaction trends
- Monthly deposits versus withdrawals
- Branch-level account balances and account counts
- Average account balances by branch
- Loan repayment and outstanding principal analysis
- Top sending and receiving accounts

Full SQL queries are available in
`sql/03_business_analysis.sql`.


## Power BI Dashboard

An interactive Power BI dashboard was developed using
data imported from PostgreSQL.

The dashboard consists of three pages covering banking
operations, financial performance, and customer activity.

### Page 1: Banking Overview

This page provides an overview of the bank's key metrics.

**Key Performance Indicators:**
- Total Customers: 1,200
- Total Accounts: 2,000
- Total Account Balance: 53.52M
- Total Transactions: 100,000

**Visualizations:**
- Account Status Distribution
- Account Type Distribution
- Total Account Balance by Type

![Banking Overview](images/01_banking_overview.png)

### Page 2: Loans, Cards & Transfers

This page analyzes loan performance, card activity,
and money transfers.

**Key Metrics:**
- Total Loans: 300
- Total Cards: 1,500
- Total Transfers: 5,000
- Total Transfer Amount: 16.83M

**Visualizations:**
- Loan Status Distribution
- Loan Amount by Status
- Principal vs Interest Paid
- Annual Loan Repayment Trend
- Card Type Distribution
- Card Status Distribution
- Monthly Transfer Amount Trend

Interactive slicers allow filtering by year and loan status.

![Loans, Cards and Transfers](images/02_loans_cards_transfers.png)

### Page 3: Transactions & Branches

This page explores transaction activity and branch-level
financial performance.

**Visualizations:**
- Monthly Transaction Trend
- Monthly Deposits vs Withdrawals
- Transactions by Type
- Total Account Balance by Branch
- Number of Accounts by Branch
- Average Account Balance by Branch

![Transactions and Branches](images/03_transactions_branches.png)

### Power BI Data Modeling

The PostgreSQL tables were imported into Power BI,
and relationships were configured using primary
and foreign keys.

DAX calculated columns were created to support
monthly transaction and transfer trend analysis.

The dashboard results were validated against
SQL query outputs to ensure consistency.


## Project Structure

```text
banking_customer_transaction_analysis/
|
|-- data/                  # Raw CSV files (excluded from Git)
|-- docs/                  # Project documentation
|-- images/                # Dashboard screenshots
|   |-- 01_banking_overview.png
|   |-- 02_loans_cards_transfers.png
|   |-- 03_transactions_branches.png
|-- powerbi/               # Power BI dashboard file
|   |-- Banking_Customer_Transaction_Dashboard.pbix
|-- sql/
|   |-- 00_create_tables.sql
|   |-- 01_data_exploration.sql
|   |-- 02_data_cleaning.sql
|   |-- 03_business_analysis.sql
|-- .gitignore
|-- README.md
```

## How to Reproduce the Project

### Prerequisites

- PostgreSQL
- pgAdmin or another PostgreSQL SQL editor
- Microsoft Power BI Desktop
- Visual Studio Code (optional)

### Steps

1. Obtain the banking dataset CSV files.
2. Create a PostgreSQL database named `banking_analysis`.
3. Run `sql/00_create_tables.sql` to create the database tables.
4. Import the CSV files into their corresponding tables.
5. Run `sql/01_data_exploration.sql` to explore the data.
6. Run `sql/02_data_cleaning.sql` to review data quality.
7. Run `sql/03_business_analysis.sql` to execute the
   business analysis queries.
8. Open the Power BI dashboard file from the `powerbi/` folder.
9. Update the PostgreSQL connection settings if necessary.
10. Refresh the Power BI data to explore the dashboards.

**Note:** Raw CSV files are excluded from the GitHub
repository. Reproducing the analysis requires access
to the original dataset.

## Project Outcomes

This project demonstrates practical experience in:

- Designing and querying relational databases
- Validating data quality and referential integrity
- Analyzing financial transactions using SQL
- Developing business KPIs and analytical reports
- Building interactive Power BI dashboards
- Organizing an analytics project for version control
```
