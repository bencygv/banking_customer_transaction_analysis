-- ============================================================
-- Banking Customer & Transaction Analysis
-- File: 01_data_exploration.sql
-- Purpose: Validate imported data and perform initial
--          data quality and exploratory checks
-- ============================================================

-- ============================================================
-- 1. ROW COUNT VALIDATION
-- Verify that all CSV records were successfully imported
-- ============================================================

SELECT COUNT(*) AS customer_count
FROM customers;

SELECT COUNT(*) AS address_count
FROM addresses;

SELECT COUNT(*) AS branch_count
FROM branches;

SELECT COUNT(*) AS branch_address_count
FROM branch_addresses;

SELECT COUNT(*) AS account_count
FROM accounts;

SELECT COUNT(*) AS card_count
FROM cards;

SELECT COUNT(*) AS loan_count
FROM loans;

SELECT COUNT(*) AS loan_payment_count
FROM loan_payments;

SELECT COUNT(*) AS transaction_count
FROM transactions;

SELECT COUNT(*) AS transfer_count
FROM transfers;

-- ============================================================
-- 2. FOREIGN KEY RELATIONSHIP VALIDATION
-- Check whether every customer_id in accounts
-- exists in the customers table
-- ============================================================

SELECT COUNT(*) AS unmatched_customer_ids
FROM accounts a
LEFT JOIN customers c
    ON a.customer_id = c.id
WHERE c.id IS NULL;

-- Check whether every branch_id in accounts
-- exists in the branches table

SELECT COUNT(*) AS unmatched_branch_ids
FROM accounts a
LEFT JOIN branches b
    ON a.branch_id = b.id
WHERE b.id IS NULL;

-- Check whether every branch_id in branch_addresses
-- exists in the branches table

SELECT COUNT(*) AS unmatched_branch_address_ids
FROM branch_addresses ba
LEFT JOIN branches b
    ON ba.branch_id = b.id
WHERE b.id IS NULL;

-- Check whether every customer_id in addresses
-- exists in the customers table

SELECT COUNT(*) AS unmatched_address_customer_ids
FROM addresses a
LEFT JOIN customers c
    ON a.customer_id = c.id
WHERE c.id IS NULL;

-- Check whether every account_id in cards
-- exists in the accounts table

SELECT COUNT(*) AS unmatched_card_account_ids
FROM cards c
LEFT JOIN accounts a
    ON c.account_id = a.id
WHERE a.id IS NULL;

-- Check whether every customer_id in loans
-- exists in the customers table

SELECT COUNT(*) AS unmatched_loan_customer_ids
FROM loans l
LEFT JOIN customers c
    ON l.customer_id = c.id
WHERE c.id IS NULL;

-- Check whether every branch_id in loans
-- exists in the branches table

SELECT COUNT(*) AS unmatched_loan_branch_ids
FROM loans l
LEFT JOIN branches b
    ON l.branch_id = b.id
WHERE b.id IS NULL;

-- Check whether every loan_id in loan_payments
-- exists in the loans table

SELECT COUNT(*) AS unmatched_loan_payment_ids
FROM loan_payments lp
LEFT JOIN loans l
    ON lp.loan_id = l.id
WHERE l.id IS NULL;

-- Check whether every account_id in transactions
-- exists in the accounts table

SELECT COUNT(*) AS unmatched_transaction_account_ids
FROM transactions t
LEFT JOIN accounts a
    ON t.account_id = a.id
WHERE a.id IS NULL;

-- Check whether every source_account_id in transfers
-- exists in the accounts table

SELECT COUNT(*) AS unmatched_source_account_ids
FROM transfers t
LEFT JOIN accounts a
    ON t.source_account_id = a.id
WHERE a.id IS NULL;

-- Check whether every destination_account_id in transfers
-- exists in the accounts table

SELECT COUNT(*) AS unmatched_destination_account_ids
FROM transfers t
LEFT JOIN accounts a
    ON t.destination_account_id = a.id
WHERE a.id IS NULL;

-- ============================================================
-- 3. NULL VALUE CHECK
-- Check for missing values in important columns
-- ============================================================

-- Customers table
SELECT
    COUNT(*) FILTER (WHERE id IS NULL) AS null_id,
    COUNT(*) FILTER (WHERE date_of_birth IS NULL) AS null_date_of_birth,
    COUNT(*) FILTER (WHERE email IS NULL) AS null_email,
    COUNT(*) FILTER (WHERE first_name IS NULL) AS null_first_name,
    COUNT(*) FILTER (WHERE last_name IS NULL) AS null_last_name,
    COUNT(*) FILTER (WHERE phone IS NULL) AS null_phone,
    COUNT(*) FILTER (WHERE tax_identifier IS NULL) AS null_tax_identifier
FROM customers;

-- Addresses table
SELECT
    COUNT(*) FILTER (WHERE id IS NULL) AS null_id,
    COUNT(*) FILTER (WHERE city IS NULL) AS null_city,
    COUNT(*) FILTER (WHERE country IS NULL) AS null_country,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_customer_id,
    COUNT(*) FILTER (WHERE postal_code IS NULL) AS null_postal_code,
    COUNT(*) FILTER (WHERE state IS NULL) AS null_state,
    COUNT(*) FILTER (WHERE street IS NULL) AS null_street
FROM addresses;

-- Branches table
SELECT
    COUNT(*) FILTER (WHERE id IS NULL) AS null_id,
    COUNT(*) FILTER (WHERE email IS NULL) AS null_email,
    COUNT(*) FILTER (WHERE name IS NULL) AS null_name,
    COUNT(*) FILTER (WHERE phone IS NULL) AS null_phone,
    COUNT(*) FILTER (WHERE routing_number IS NULL) AS null_routing_number
FROM branches;

-- Branch Addresses table
SELECT
    COUNT(*) FILTER (WHERE id IS NULL) AS null_id,
    COUNT(*) FILTER (WHERE branch_id IS NULL) AS null_branch_id,
    COUNT(*) FILTER (WHERE city IS NULL) AS null_city,
    COUNT(*) FILTER (WHERE country IS NULL) AS null_country,
    COUNT(*) FILTER (WHERE postal_code IS NULL) AS null_postal_code,
    COUNT(*) FILTER (WHERE state IS NULL) AS null_state,
    COUNT(*) FILTER (WHERE street IS NULL) AS null_street
FROM branch_addresses;

-- Accounts table
SELECT
    COUNT(*) FILTER (WHERE id IS NULL) AS null_id,
    COUNT(*) FILTER (WHERE account_number IS NULL) AS null_account_number,
    COUNT(*) FILTER (WHERE balance IS NULL) AS null_balance,
    COUNT(*) FILTER (WHERE branch_id IS NULL) AS null_branch_id,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_customer_id,
    COUNT(*) FILTER (WHERE opened_date IS NULL) AS null_opened_date,
    COUNT(*) FILTER (WHERE status IS NULL) AS null_status,
    COUNT(*) FILTER (WHERE type IS NULL) AS null_type
FROM accounts;

-- Cards table
SELECT
    COUNT(*) FILTER (WHERE id IS NULL) AS null_id,
    COUNT(*) FILTER (WHERE account_id IS NULL) AS null_account_id,
    COUNT(*) FILTER (WHERE card_number IS NULL) AS null_card_number,
    COUNT(*) FILTER (WHERE cvv IS NULL) AS null_cvv,
    COUNT(*) FILTER (WHERE expiration_date IS NULL) AS null_expiration_date,
    COUNT(*) FILTER (WHERE pin_hash IS NULL) AS null_pin_hash,
    COUNT(*) FILTER (WHERE status IS NULL) AS null_status,
    COUNT(*) FILTER (WHERE type IS NULL) AS null_type
FROM cards;

-- Loans table
SELECT
    COUNT(*) FILTER (WHERE id IS NULL) AS null_id,
    COUNT(*) FILTER (WHERE amount IS NULL) AS null_amount,
    COUNT(*) FILTER (WHERE branch_id IS NULL) AS null_branch_id,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_customer_id,
    COUNT(*) FILTER (WHERE interest_rate IS NULL) AS null_interest_rate,
    COUNT(*) FILTER (WHERE loan_number IS NULL) AS null_loan_number,
    COUNT(*) FILTER (WHERE start_date IS NULL) AS null_start_date,
    COUNT(*) FILTER (WHERE status IS NULL) AS null_status,
    COUNT(*) FILTER (WHERE term_months IS NULL) AS null_term_months
FROM loans;

-- Loan Payments table
SELECT
    COUNT(*) FILTER (WHERE id IS NULL) AS null_id,
    COUNT(*) FILTER (WHERE amount IS NULL) AS null_amount,
    COUNT(*) FILTER (WHERE interest_paid IS NULL) AS null_interest_paid,
    COUNT(*) FILTER (WHERE loan_id IS NULL) AS null_loan_id,
    COUNT(*) FILTER (WHERE payment_date IS NULL) AS null_payment_date,
    COUNT(*) FILTER (WHERE principal_paid IS NULL) AS null_principal_paid
FROM loan_payments;

-- Transactions table
SELECT
    COUNT(*) FILTER (WHERE id IS NULL) AS null_id,
    COUNT(*) FILTER (WHERE account_id IS NULL) AS null_account_id,
    COUNT(*) FILTER (WHERE amount IS NULL) AS null_amount,
    COUNT(*) FILTER (WHERE description IS NULL) AS null_description,
    COUNT(*) FILTER (WHERE timestamp IS NULL) AS null_timestamp,
    COUNT(*) FILTER (WHERE type IS NULL) AS null_type
FROM transactions;

-- Transfers table
SELECT
    COUNT(*) FILTER (WHERE id IS NULL) AS null_id,
    COUNT(*) FILTER (WHERE amount IS NULL) AS null_amount,
    COUNT(*) FILTER (WHERE description IS NULL) AS null_description,
    COUNT(*) FILTER (WHERE destination_account_id IS NULL) AS null_destination_account_id,
    COUNT(*) FILTER (WHERE source_account_id IS NULL) AS null_source_account_id,
    COUNT(*) FILTER (WHERE timestamp IS NULL) AS null_timestamp
FROM transfers;

-- ============================================================
-- 4. DUPLICATE BUSINESS KEY CHECK
-- Check important identifiers for duplicate values
-- ============================================================

-- Check duplicate account numbers
SELECT
    account_number,
    COUNT(*) AS occurrence_count
FROM accounts
GROUP BY account_number
HAVING COUNT(*) > 1;

-- Check duplicate card numbers
SELECT
    card_number,
    COUNT(*) AS occurrence_count
FROM cards
GROUP BY card_number
HAVING COUNT(*) > 1;

-- Compare total card records with distinct card numbers
-- to identify whether card numbers are unique
SELECT
    COUNT(*) AS total_cards,
    COUNT(DISTINCT card_number) AS unique_card_numbers
FROM cards;

-- Investigate repeated card numbers to determine whether
-- they are associated with different customer accounts
SELECT
    card_number,
    COUNT(*) AS total_records,
    COUNT(DISTINCT account_id) AS different_accounts
FROM cards
GROUP BY card_number
ORDER BY total_records DESC;

-- Finding: Only 16 distinct card numbers exist across 1,500 card records.
-- Repeated card numbers are associated with different accounts.
-- Therefore, card_number is not treated as a unique identifier in this dataset;
-- cards.id remains the reliable unique identifier.

-- Check duplicate loan numbers
SELECT
    loan_number,
    COUNT(*) AS occurrence_count
FROM loans
GROUP BY loan_number
HAVING COUNT(*) > 1;

-- Check duplicate branch routing numbers
SELECT
    routing_number,
    COUNT(*) AS occurrence_count
FROM branches
GROUP BY routing_number
HAVING COUNT(*) > 1;

-- Check duplicate customer tax identifiers
SELECT
    tax_identifier,
    COUNT(*) AS occurrence_count
FROM customers
GROUP BY tax_identifier
HAVING COUNT(*) > 1;

-- ============================================================
-- 5. NUMERIC VALUE VALIDATION
-- Check numeric fields for unusual or potentially invalid values
-- ============================================================

-- Check accounts with negative balances
SELECT COUNT(*) AS negative_balance_count
FROM accounts
WHERE balance < 0;

-- Inspect accounts with negative balances
SELECT
    id,
    account_number,
    balance,
    customer_id,
    status,
    type
FROM accounts
WHERE balance < 0
ORDER BY balance;

-- Finding: 17 accounts have negative balances.
-- These records were retained because negative balances may represent
-- valid overdrawn accounts rather than data-quality errors.

-- Check for zero or negative loan amounts
SELECT COUNT(*) AS invalid_loan_amount_count
FROM loans
WHERE amount <= 0;

-- Finding: No zero or negative loan amounts were found.

-- Check for negative loan interest rates
SELECT COUNT(*) AS invalid_interest_rate_count
FROM loans
WHERE interest_rate < 0;

-- Finding: No negative loan interest rates were found.

-- Check for zero or negative loan terms
SELECT COUNT(*) AS invalid_loan_term_count
FROM loans
WHERE term_months <= 0;

-- Finding: No zero or negative loan terms were found.

-- Check for zero or negative loan payment amounts
SELECT COUNT(*) AS invalid_loan_payment_count
FROM loan_payments
WHERE amount <= 0;

-- Finding: No zero or negative loan payment amounts were found.

-- Check transaction amount range
SELECT
    MIN(amount) AS minimum_amount,
    MAX(amount) AS maximum_amount
FROM transactions;

-- Finding: Transaction amounts range from 0.05 to 4,999.66.
-- No zero or negative transaction amounts were found.

-- Check transfer amount range
SELECT
    MIN(amount) AS minimum_amount,
    MAX(amount) AS maximum_amount
FROM transfers;

-- Finding: Transfer amounts range from 5.00 to 9,999.03.
-- No zero or negative transfer amounts were found.

-- ============================================================
-- 6. DATE VALIDATION
-- Check date fields for unusual or invalid values
-- ============================================================

-- Check customer date-of-birth range
SELECT
    MIN(date_of_birth) AS earliest_date_of_birth,
    MAX(date_of_birth) AS latest_date_of_birth
FROM customers;

-- Finding: Customer dates of birth range from 1940-03-29 to 2006-10-24.
-- No obviously invalid dates of birth were identified.

-- Check account opening date range
SELECT
    MIN(opened_date) AS earliest_opened_date,
    MAX(opened_date) AS latest_opened_date
FROM accounts;

-- Finding: Account opening dates range from 2000-01-05 to 2020-12-31.
-- No obviously invalid account opening dates were identified.

-- Check loan start date range
SELECT
    MIN(start_date) AS earliest_loan_start_date,
    MAX(start_date) AS latest_loan_start_date
FROM loans;

-- Finding: Loan start dates range from 2017-01-01 to 2020-12-28.
-- No obviously invalid loan start dates were identified.

-- Check loan payment date range
SELECT
    MIN(payment_date) AS earliest_payment_date,
    MAX(payment_date) AS latest_payment_date
FROM loan_payments;

-- Finding: Loan payment dates range from 2017-03-17 to 2025-10-22.

-- Check for loan payments occurring before the loan start date
SELECT COUNT(*) AS payments_before_loan_start
FROM loan_payments lp
JOIN loans l
    ON lp.loan_id = l.id
WHERE lp.payment_date < l.start_date;

-- Finding: No loan payments occurred before their corresponding loan start date.

-- Check transaction date range
SELECT
    MIN(timestamp) AS earliest_transaction,
    MAX(timestamp) AS latest_transaction
FROM transactions;

-- Finding: Transactions range from 2021-01-01 08:58:36
-- to 2025-12-31 23:16:07.

-- Check for transactions occurring before the account opening date
SELECT COUNT(*) AS transactions_before_account_opening
FROM transactions t
JOIN accounts a
    ON t.account_id = a.id
WHERE t.timestamp::date < a.opened_date;

-- Finding: No transactions occurred before their corresponding account opening dates.

-- Check transfer date range
SELECT
    MIN(timestamp) AS earliest_transfer,
    MAX(timestamp) AS latest_transfer
FROM transfers;

-- Finding: Transfers range from 2021-01-01 09:04:00
-- to 2025-12-31 12:46:23.

-- Check for transfers occurring before the source account was opened
SELECT COUNT(*) AS transfers_before_source_account_opening
FROM transfers t
JOIN accounts a
    ON t.source_account_id = a.id
WHERE t.timestamp::date < a.opened_date;

-- Finding: No transfers occurred before the source account opening date.

-- Check for transfers occurring before the destination account was opened
SELECT COUNT(*) AS transfers_before_destination_account_opening
FROM transfers t
JOIN accounts a
    ON t.destination_account_id = a.id
WHERE t.timestamp::date < a.opened_date;

-- Finding: No transfers occurred before the destination account opening date.

-- ============================================================
-- 7. CATEGORICAL VALUE VALIDATION
-- Review distinct values in important categorical fields
-- ============================================================

-- Check account status values
SELECT DISTINCT status
FROM accounts
ORDER BY status;

-- Check account type values
SELECT DISTINCT type
FROM accounts
ORDER BY type;

-- Finding: Account status contains closed, open, and frozen.
-- Account type contains business, checking, and savings.
-- No unexpected categorical values were identified.

-- Check card status values
SELECT DISTINCT status
FROM cards
ORDER BY status;

-- Check card type values
SELECT DISTINCT type
FROM cards
ORDER BY type;

-- Finding: Card type contains credit and debit.
-- Card status contains active, blocked, and expired.
-- No unexpected categorical values were identified.

-- Check loan status values
SELECT DISTINCT status
FROM loans
ORDER BY status;

-- Finding: Loan status contains active, defaulted, and paid_off.
-- No unexpected categorical values were identified.

-- Check transaction type values
SELECT DISTINCT type
FROM transactions
ORDER BY type;

-- Finding: Transaction type contains deposit, fee, interest, and withdrawal.
-- No unexpected categorical values were identified.