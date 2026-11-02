-- ============================================================
-- Banking Customer & Transaction Analysis
-- File: 02_data_cleaning.sql
-- Purpose: Clean and standardize data based on findings from
--          the data exploration and quality validation stage
-- ============================================================

-- ============================================================
-- TEXT STANDARDIZATION
-- Check important text fields for leading or trailing spaces
-- ============================================================

-- Check account status and type for unwanted spaces
SELECT
    COUNT(*) FILTER (WHERE status != TRIM(status)) AS status_with_spaces,
    COUNT(*) FILTER (WHERE type != TRIM(type)) AS type_with_spaces
FROM accounts;

-- Finding: No leading or trailing spaces were found
-- in card status or type values.

-- Check loan status for unwanted spaces
SELECT
    COUNT(*) FILTER (WHERE status != TRIM(status)) AS status_with_spaces
FROM loans;

-- Finding: No leading or trailing spaces were found
-- in loan status values.

-- Check transaction type for unwanted spaces
SELECT
    COUNT(*) FILTER (WHERE type != TRIM(type)) AS type_with_spaces
FROM transactions;

-- Finding: No leading or trailing spaces were found
-- in transaction type values.

-- Check customer names for unwanted spaces
SELECT
    COUNT(*) FILTER (WHERE first_name != TRIM(first_name)) AS first_name_with_spaces,
    COUNT(*) FILTER (WHERE last_name != TRIM(last_name)) AS last_name_with_spaces
FROM customers;

-- Finding: No leading or trailing spaces were found
-- in customer first or last names.

-- Check branch names for unwanted spaces
SELECT
    COUNT(*) FILTER (WHERE name != TRIM(name)) AS name_with_spaces
FROM branches;

-- Finding: No leading or trailing spaces were found
-- in branch names.

-- ============================================================
-- 2. TEXT CASE CONSISTENCY
-- Check categorical fields for inconsistent capitalization
-- ============================================================

-- Check account status capitalization
SELECT
    status,
    COUNT(*) AS record_count
FROM accounts
GROUP BY status
ORDER BY status;

-- Finding: Account status values are consistently lowercase.
-- No capitalization standardization is required.

-- Check account type capitalization
SELECT
    type,
    COUNT(*) AS record_count
FROM accounts
GROUP BY type
ORDER BY type;

-- Finding: Account type values are consistently lowercase.
-- No capitalization standardization is required.


-- Check card status and type capitalization
SELECT
    status,
    type,
    COUNT(*) AS record_count
FROM cards
GROUP BY status, type
ORDER BY status, type;

-- Finding: Card status and type values are consistently lowercase.
-- No capitalization standardization is required.

-- Check loan status capitalization
SELECT
    status,
    COUNT(*) AS record_count
FROM loans
GROUP BY status
ORDER BY status;

-- Finding: Loan status values are consistently lowercase.
-- No capitalization standardization is required.

-- Check transaction type capitalization
SELECT
    type,
    COUNT(*) AS record_count
FROM transactions
GROUP BY type
ORDER BY type;

-- Finding: Transaction type values are consistently lowercase.
-- No capitalization standardization is required.

-- ============================================================
-- 3. BASIC FORMAT VALIDATION
-- Check important text fields for obvious formatting issues
-- ============================================================

-- Check customer emails without an @ symbol
SELECT COUNT(*) AS invalid_email_count
FROM customers
WHERE email NOT LIKE '%@%';

-- Finding: All customer email addresses contain an @ symbol.
-- No obvious email formatting issues were identified.

-- Check branch emails without an @ symbol
SELECT COUNT(*) AS invalid_branch_email_count
FROM branches
WHERE email NOT LIKE '%@%';

-- Finding: All branch email addresses contain an @ symbol.
-- No obvious email formatting issues were identified.

-- Check for blank account numbers
SELECT COUNT(*) AS blank_account_number_count
FROM accounts
WHERE TRIM(account_number) = '';

-- Finding: No blank account numbers were found.

-- Check for blank loan numbers
SELECT COUNT(*) AS blank_loan_number_count
FROM loans
WHERE TRIM(loan_number) = '';

-- Finding: No blank loan numbers were found.

-- Check for blank branch routing numbers
SELECT COUNT(*) AS blank_routing_number_count
FROM branches
WHERE TRIM(routing_number) = '';

-- Finding: No blank branch routing numbers were found.

-- Check for blank customer tax identifiers
SELECT COUNT(*) AS blank_tax_identifier_count
FROM customers
WHERE TRIM(tax_identifier) = '';

-- Finding: No blank customer tax identifiers were found.

-- ============================================================
-- 4. LOGICAL CONSISTENCY CHECKS
-- Validate relationships between related numeric fields
-- ============================================================

-- Check whether loan payment amount equals principal + interest
SELECT COUNT(*) AS inconsistent_payment_count
FROM loan_payments
WHERE amount <> principal_paid + interest_paid;

-- Finding: All loan payment amounts equal the sum of
-- principal paid and interest paid.

-- Check for transfers where source and destination accounts are the same
SELECT COUNT(*) AS same_account_transfer_count
FROM transfers
WHERE source_account_id = destination_account_id;

-- Finding: No transfers were made between the same source
-- and destination account.

-- Check for loans where total principal paid exceeds the loan amount
SELECT COUNT(*) AS overpaid_loan_count
FROM loans l
JOIN (
    SELECT
        loan_id,
        SUM(principal_paid) AS total_principal_paid
    FROM loan_payments
    GROUP BY loan_id
) lp
    ON l.id = lp.loan_id
WHERE lp.total_principal_paid > l.amount;

-- Finding: No loans have total principal payments exceeding
-- the original loan amount.

-- ============================================================
-- 5. CLEANING SUMMARY
-- ============================================================

-- The dataset was found to be largely clean and consistent.
-- No destructive cleaning operations (UPDATE or DELETE) were required.
--
-- Key findings:
-- 1. No leading or trailing spaces were found in checked text fields.
-- 2. Important categorical values use consistent lowercase formatting.
-- 3. No obvious email formatting issues were identified.
-- 4. Important business identifiers contain no blank values.
-- 5. Loan payment amounts are internally consistent:
--    amount = principal_paid + interest_paid.
-- 6. No transfers occur between the same source and destination account.
-- 7. No loan has total principal payments exceeding its original amount.
--
-- Therefore, the original records were retained for business analysis.

