-- ============================================================
-- Banking Customer & Transaction Analysis
-- File: 03_business_analysis.sql
-- Purpose: Analyze customer, account, transaction, branch,
--          loan, card, and transfer data to answer key
--          business questions and identify insights
-- ============================================================

-- ============================================================
-- 1. CUSTOMER & ACCOUNT ANALYSIS
-- ============================================================

-- How many customers and accounts does the bank have?

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_accounts
FROM accounts;

-- How many accounts does each customer have?

SELECT
    customer_id,
    COUNT(*) AS number_of_accounts
FROM accounts
GROUP BY customer_id
ORDER BY number_of_accounts DESC;

-- How many customers have more than one account?

SELECT COUNT(*) AS customers_with_multiple_accounts
FROM (
    SELECT
        customer_id,
        COUNT(*) AS number_of_accounts
    FROM accounts
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) AS customer_account_counts;

-- Finding: 472 customers have more than one account,
-- representing approximately 39.3% of all customers.

-- What is the distribution of account types?

SELECT
    type,
    COUNT(*) AS number_of_accounts
FROM accounts
GROUP BY type
ORDER BY number_of_accounts DESC;

-- What is the distribution of account statuses?

SELECT
    status,
    COUNT(*) AS status_count
FROM accounts
GROUP BY status
ORDER BY status_count DESC;

SELECT *
FROM accounts;

-- What are the total, average, minimum, and maximum account balances?

SELECT
    SUM(balance) AS total_balance,
    AVG(balance) AS average_balance,
    MIN(balance) AS minimum_balance,
    MAX(balance) AS maximum_balance
FROM accounts;

-- How do account balances differ by account type?

SELECT
    type,
    COUNT(*) AS number_of_accounts,
    SUM(balance) AS total_balance,
    AVG(balance) AS average_balance
FROM accounts
GROUP BY type
ORDER BY total_balance DESC;

-- How do account balances differ by account status?

SELECT
    status,
    COUNT(*) AS number_of_accounts,
    SUM(balance) AS total_balance,
    AVG(balance) AS average_balance
FROM accounts
GROUP BY status
ORDER BY total_balance DESC;

-- Which customers have the highest total account balances?

SELECT
    c.id AS customer_id,
    c.first_name,
    c.last_name,
    COUNT(a.id) AS number_of_accounts,
    SUM(a.balance) AS total_customer_balance
FROM customers c
JOIN accounts a
    ON c.id = a.customer_id
GROUP BY
    c.id,
    c.first_name,
    c.last_name
ORDER BY total_customer_balance DESC
LIMIT 10;

-- Which individual accounts have the highest balances?

SELECT
    id AS account_id,
    account_number,
    customer_id,
    type,
    balance
FROM accounts
ORDER BY balance DESC
LIMIT 10;

-- Which cities have the most customers?

SELECT
    city,
    state,
    country,
    COUNT(*) AS number_of_customers
FROM addresses
GROUP BY city, state, country
ORDER BY number_of_customers DESC
LIMIT 10;

-- ============================================================
-- 2. TRANSACTION ANALYSIS
-- ============================================================

-- What is the overall transaction activity?

SELECT
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount),2) AS total_transaction_amount,
    ROUND(AVG(amount),2) AS average_transaction_amount
FROM transactions;

-- How is transaction activity distributed by transaction type?

SELECT
    type,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount),2) AS total_amount,
    ROUND(AVG(amount),2) AS average_amount
FROM transactions
GROUP BY type
ORDER BY total_amount DESC;

-- How does transaction activity change over time by month?

SELECT
    DATE_TRUNC('month', timestamp) AS transaction_month,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount),2) AS total_transaction_amount
FROM transactions
GROUP BY transaction_month
ORDER BY transaction_month;

-- How do deposits and withdrawals change over time by month?

SELECT
    DATE_TRUNC('month', timestamp) AS transaction_month,
    type,
    COUNT(*) AS transaction_count,
FROM transactions
WHERE type IN ('deposit', 'withdrawal')
GROUP BY transaction_month, type
ORDER BY transaction_month, type;

-- Which accounts have the highest transaction activity?

SELECT
    account_id,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY account_id
ORDER BY transaction_count DESC
LIMIT 10;

-- Which accounts have the highest total transaction value?

SELECT
    account_id,
    ROUND(SUM(amount), 2) AS total_transaction_amount
FROM transactions
GROUP BY account_id
ORDER BY total_transaction_amount DESC
LIMIT 10;

-- What is the average transaction amount by account type?

SELECT
    a.type AS account_type,
    ROUND(AVG(t.amount), 2) AS average_transaction_amount
FROM accounts a
JOIN transactions t
    ON a.id = t.account_id
GROUP BY a.type
ORDER BY average_transaction_amount DESC;
