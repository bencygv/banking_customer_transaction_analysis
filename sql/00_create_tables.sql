-- ============================================================
-- Banking Customer & Transaction Analysis
-- File: 00_create_tables.sql
-- Purpose: Create the core PostgreSQL tables for the project
-- ============================================================


-- ============================================================
-- CUSTOMERS
-- Stores basic customer information
-- ============================================================

CREATE TABLE customers (
    id INT PRIMARY KEY,
    date_of_birth DATE,
    email VARCHAR(255),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(50),
    tax_identifier VARCHAR(50)
);

-- ============================================================
-- ADDRESSES
-- Stores customer address information
-- customer_id links each address to a customer
-- ============================================================

CREATE TABLE addresses (
    id INTEGER PRIMARY KEY,
    city VARCHAR(100),
    country VARCHAR(100),
    customer_id INTEGER,
    postal_code VARCHAR(20),
    state VARCHAR(100),
    street VARCHAR(255)
);

-- ============================================================
-- BRANCHES
-- Stores information about bank branches
-- ============================================================

CREATE TABLE branches (
    id INTEGER PRIMARY KEY,
    email VARCHAR(255),
    name VARCHAR(255),
    phone VARCHAR(50),
    routing_number VARCHAR(50)
);

-- ============================================================
-- BRANCH ADDRESSES
-- Stores the location of each bank branch
-- branch_id links the address to a branch
-- ============================================================

CREATE TABLE branch_addresses (
    id INTEGER PRIMARY KEY,
    branch_id INTEGER,
    city VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    state VARCHAR(100),
    street VARCHAR(255)
);

-- ============================================================
-- ACCOUNTS
-- Stores customer bank account information
-- Links customers with their corresponding bank branches
-- ============================================================

CREATE TABLE accounts (
    id INTEGER PRIMARY KEY,
    account_number VARCHAR(50),
    balance NUMERIC(15,2),
    branch_id INTEGER,
    customer_id INTEGER,
    opened_date DATE,
    status VARCHAR(50),
    type VARCHAR(50)
);

-- ============================================================
-- CARDS
-- Stores debit/credit card information associated with accounts
-- ============================================================

CREATE TABLE cards (
    id INTEGER PRIMARY KEY,
    account_id INTEGER,
    card_number VARCHAR(50),
    cvv VARCHAR(10),
    expiration_date DATE,
    pin_hash VARCHAR(255),
    status VARCHAR(50),
    type VARCHAR(50)
);

-- ============================================================
-- LOANS
-- Stores customer loan information
-- Links each loan to a customer and bank branch
-- ============================================================

CREATE TABLE loans (
    id INTEGER PRIMARY KEY,
    amount NUMERIC(15,2),
    branch_id INTEGER,
    customer_id INTEGER,
    interest_rate NUMERIC(10,4),
    loan_number VARCHAR(50),
    start_date DATE,
    status VARCHAR(50),
    term_months INTEGER
);

-- ============================================================
-- LOAN PAYMENTS
-- Stores payments made toward customer loans
-- ============================================================

CREATE TABLE loan_payments (
    id INTEGER PRIMARY KEY,
    amount NUMERIC(15,2),
    interest_paid NUMERIC(15,2),
    loan_id INTEGER,
    payment_date DATE,
    principal_paid NUMERIC(15,2)
);

-- ============================================================
-- TRANSACTIONS
-- Stores transactions performed on bank accounts
-- ============================================================

CREATE TABLE transactions (
    id INTEGER PRIMARY KEY,
    account_id INTEGER,
    amount NUMERIC(15,2),
    description TEXT,
    timestamp TIMESTAMP,
    type VARCHAR(50)
);

-- ============================================================
-- TRANSFERS
-- Stores transfers between bank accounts
-- ============================================================

CREATE TABLE transfers (
    id INTEGER PRIMARY KEY,
    amount NUMERIC(15,2),
    description TEXT,
    destination_account_id INTEGER,
    source_account_id INTEGER,
    timestamp TIMESTAMP
);

-- ============================================================
-- End of table creation script
-- ============================================================