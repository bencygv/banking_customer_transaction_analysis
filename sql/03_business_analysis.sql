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