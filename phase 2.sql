USE ZerodhaKiteDB;

-- Phase -2
-- DDL – Data Definition Language
-- 1. CREATE (New Table)
CREATE TABLE Audit_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(50),
    operation ENUM('INSERT','UPDATE','DELETE'),
    operation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ALTER (Add / Modify / Drop Columns)
-- 1. Add column
ALTER TABLE Users
ADD last_login TIMESTAMP;

-- 2. Modify column
ALTER TABLE Users
MODIFY mobile_no VARCHAR(15) NOT NULL;

-- 3. Drop column
ALTER TABLE Users
DROP last_login;

-- 4. RENAME
RENAME TABLE ETF TO Exchange_Traded_Funds;

-- 5. TRUNCATE (Delete all data, keep structure)
TRUNCATE TABLE Trade_History;

-- 6. DROP (Delete table permanently)
DROP TABLE Audit_Log;

-- DML – Data Manipulation Language

-- 1. INSERT (Single & Bulk)
INSERT INTO Brokers (broker_name, brokerage_percentage)
VALUES ('Test Broker', 0.06);

INSERT INTO Stock_Sectors (sector_name)
VALUES ('AI'), ('Renewable Energy');

-- 2. UPDATE (With Condition)
UPDATE Users
SET kyc_status = 'Verified'
WHERE user_id = 2;

-- Increase margin by 10%
UPDATE Trading_Accounts
SET margin_available = margin_available * 1.10
WHERE status = 'Active';

-- 3. DELETE (Safe Deletion)
DELETE FROM Orders
WHERE order_status = 'Cancelled';

DELETE FROM Users
WHERE kyc_status = 'Rejected';

-- 3. DQL – Data Query Language

-- BASIC SELECT
SELECT * FROM Users;

SELECT full_name, email
FROM Users;

-- DISTINCT
SELECT DISTINCT bank_name
FROM User_Bank_Details;

-- 1. WHERE + OPERATORS
SELECT full_name
FROM Users
WHERE kyc_status = 'Verified'
AND user_type = 'Individual';
-- 2
SELECT *
FROM Trading_Accounts
WHERE balance BETWEEN 50000 AND 150000;

-- 3
SELECT *
FROM Stocks
WHERE company_name LIKE '%Tata%';

-- ORDER BY + LIMIT
SELECT company_name, market_cap
FROM Stocks
ORDER BY market_cap DESC
LIMIT 5;

-- AGGREGATION FUNCTIONS
-- 1
SELECT COUNT(*) AS total_users
FROM Users;

-- 2 
SELECT AVG(balance) AS avg_balance
FROM Trading_Accounts;

-- 3
SELECT MAX(market_cap) AS largest_company
FROM Stocks;

-- GROUP BY + HAVING
-- 1
SELECT broker_id, COUNT(*) AS total_accounts
FROM Trading_Accounts
GROUP BY broker_id;

-- 2
SELECT broker_id, SUM(balance) AS total_balance
FROM Trading_Accounts
GROUP BY broker_id
HAVING SUM(balance) > 20000;

-- JOINS (CORE SKILL )
-- INNER JOIN
SELECT u.full_name, ta.balance
FROM Users u
JOIN Trading_Accounts ta ON u.user_id = ta.user_id;

-- LEFT JOIN
SELECT u.full_name, o.order_id
FROM Users u
LEFT JOIN Trading_Accounts ta ON u.user_id = ta.user_id
LEFT JOIN Orders o ON ta.account_id = o.account_id;

-- MULTI-TABLE JOIN
SELECT u.full_name, s.company_name, h.quantity
FROM Holdings h
JOIN Trading_Accounts ta ON h.account_id = ta.account_id
JOIN Users u ON ta.user_id = u.user_id
JOIN Stocks s ON h.stock_id = s.stock_id;

-- SUBQUERIES
SELECT full_name
FROM Users
WHERE user_id IN (
    SELECT user_id
    FROM Trading_Accounts
    WHERE balance > (SELECT AVG(balance) FROM Trading_Accounts)
);

-- Stocks never traded
SELECT company_name
FROM Stocks
WHERE stock_id NOT IN (
    SELECT stock_id FROM Orders WHERE stock_id IS NOT NULL
);

-- CASE STATEMENT
SELECT full_name,
       CASE
           WHEN kyc_status = 'Verified' THEN 'Approved'
           ELSE 'Pending Approval'
       END AS kyc_remark
FROM Users;

-- ALIASES (Professional Style)
SELECT u.full_name AS customer,
       SUM(h.quantity * sp.close_price) AS portfolio_value
FROM Users u
JOIN Trading_Accounts ta ON u.user_id = ta.user_id
JOIN Holdings h ON ta.account_id = h.account_id
JOIN Stock_Prices sp ON h.stock_id = sp.stock_id
WHERE sp.price_date = '2025-10-01'
GROUP BY u.full_name;

-- SET OPERATORS
SELECT user_id FROM Trading_Accounts
UNION
SELECT user_id FROM User_Bank_Details;

-- EXISTS
SELECT full_name
FROM Users u
WHERE EXISTS (
    SELECT 1 FROM Orders o
    JOIN Trading_Accounts ta ON o.account_id = ta.account_id
    WHERE ta.user_id = u.user_id
);

