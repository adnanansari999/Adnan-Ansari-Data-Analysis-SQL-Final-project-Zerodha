USE ZerodhaKiteDB;

-- INNER JOIN: Users who have placed orders
DESC Orders;
SHOW COLUMNS FROM Orders;


SELECT u.full_name,
       o.order_id,
       o.order_type
FROM Users u
INNER JOIN Trading_Accounts ta ON u.user_id = ta.user_id
INNER JOIN Orders o ON ta.account_id = o.account_id;



-- LEFT JOIN: Show all users even if they don't have a trading account
SELECT u.full_name,
       ta.account_id,
       ta.balance
FROM Users u
LEFT JOIN Trading_Accounts ta ON u.user_id = ta.user_id;

-- RIGHT JOIN: All orders with user details if available
SELECT u.full_name,
       o.order_id,
       o.order_status
FROM Users u
RIGHT JOIN Trading_Accounts ta ON u.user_id = ta.user_id
RIGHT JOIN Orders o ON ta.account_id = o.account_id;

-- FULL JOIN simulation using UNION
SELECT u.user_id, u.full_name, ta.account_id
FROM Users u
LEFT JOIN Trading_Accounts ta ON u.user_id = ta.user_id

UNION

SELECT u.user_id, u.full_name, ta.account_id
FROM Users u
RIGHT JOIN Trading_Accounts ta ON u.user_id = ta.user_id;

-- SELF JOIN
DESC Users;
-- If the correct column is registered_on, then:
SELECT u1.full_name AS User1,
       u2.full_name AS User2,
       u1.registered_on
FROM Users u1
JOIN Users u2
  ON u1.registered_on = u2.registered_on
 AND u1.user_id <> u2.user_id;

SELECT u1.full_name AS User1,
       u2.full_name AS User2
FROM Users u1
JOIN Users u2
  ON u1.user_id <> u2.user_id;

SHOW COLUMNS FROM Users;

-- CROSS JOIN
-- CROSS JOIN: User × Broker combinations
SELECT u.full_name,
       b.broker_name
FROM Users u
CROSS JOIN Brokers b;


-- APPLY SUBQUERIES
-- Scalar subquery
SELECT u.full_name, ta.balance
FROM Users u
JOIN Trading_Accounts ta ON u.user_id = ta.user_id
WHERE ta.balance > (
    SELECT AVG(balance)
    FROM Trading_Accounts
);

-- Subquery with IN
SELECT full_name
FROM Users
WHERE user_id IN (
    SELECT ta.user_id
    FROM Trading_Accounts ta
    JOIN Orders o ON ta.account_id = o.account_id
    GROUP BY ta.user_id
    HAVING COUNT(o.order_id) > 3
);

-- EXISTS: Users who have at least one trade
SELECT u.full_name
FROM Users u
WHERE EXISTS (
    SELECT 1
    FROM Trading_Accounts ta
    JOIN Trades t ON ta.account_id = t.account_id
    WHERE ta.user_id = u.user_id
);

-- ANY: Stocks priced higher than any IT sector stock
SELECT company_name
FROM Stocks
WHERE market_price > ANY (
    SELECT market_price
    FROM Stocks
    WHERE sector_id = 1
);

-- Derived table (subquery in FROM)
SELECT sector_id, AVG(avg_price) AS sector_avg_price
FROM (
    SELECT sector_id, AVG(current_price) AS avg_price
    FROM Stocks
    GROUP BY sector_id
) AS sector_data
GROUP BY sector_id;

-- Average stock price per sector
SELECT sector_id,
       AVG(current_price) AS sector_avg_price
FROM Stocks
GROUP BY sector_id;


-- FUNCTIONS
-- BUILT-IN FUNCTIONS
-- string function 
SELECT UPPER(full_name) AS NAME_CAPS,
       CONCAT(email, ' | ', mobile_no) AS contact
FROM Users;

-- numerbic function 
SELECT stock_id,
       ROUND(current_price, 2) AS rounded_price
FROM Stocks;

-- Date Functions
SELECT order_id,
       DATEDIFF(CURDATE(), order_date) AS days_since_order
FROM Orders;

-- Aggregate Functions
SELECT stock_id,
       SUM(quantity) AS total_quantity
FROM Trades
GROUP BY stock_id;


-- USER-DEFINED FUNCTIONS (5 REQUIRED)
CREATE FUNCTION GetAnnualVolume(qty INT)
RETURNS INT
DETERMINISTIC
RETURN qty * 12;

-- 2. Brokerage Calculation
CREATE FUNCTION CalculateBrokerage(amount DECIMAL(10,2), rate DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (amount * rate) / 100;

-- Portfolio Value
CREATE FUNCTION PortfolioValue(quantity INT, price DECIMAL(10,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
RETURN quantity * price;

-- KYC Status Label
CREATE FUNCTION KYCLabel(status VARCHAR(20))
RETURNS VARCHAR(30)
DETERMINISTIC
RETURN
    CASE
        WHEN status = 'Verified' THEN 'APPROVED'
        ELSE 'PENDING'
    END;

-- Profit / Loss
CREATE FUNCTION ProfitLoss(buy_price DECIMAL(10,2), sell_price DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN sell_price - buy_price;

-- USING UDFs
SELECT u.full_name,
       KYCLabel(u.kyc_status) AS kyc_result
FROM Users u;
