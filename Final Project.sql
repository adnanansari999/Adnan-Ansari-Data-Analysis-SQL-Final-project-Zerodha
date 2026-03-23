-- 1️. Database Creation

CREATE DATABASE ZerodhaKiteDB;

USE ZerodhaKiteDB;


-- Database Creation & Users Tables
-- 1. Users Table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    mobile_no VARCHAR(15) UNIQUE NOT NULL,
    dob DATE,
    pan_no CHAR(10) UNIQUE,
    aadhaar_no CHAR(12) UNIQUE,
    account_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    kyc_status ENUM('Pending','Verified','Rejected') DEFAULT 'Pending',
    user_type ENUM('Individual','Corporate') DEFAULT 'Individual'
);
drop database ZerodhaKiteDB;

-- Insert 10 records into Users Table
INSERT INTO Users (full_name, email, mobile_no, dob, pan_no, aadhaar_no, kyc_status, user_type) VALUES
('Adnan Ansari','adnan@gmail.com','9876543210','2002-05-14','ABCDE1234F','123456789012','Verified','Individual'),
('Riya Mehta','riya@gmail.com','9876501234','2000-10-22','FGHIJ5678K','987654321098','Pending','Individual'),
('Karan Singh','karan@gmail.com','9876512345','1998-08-11','KLMNO9876P','234567890123','Verified','Individual'),
('Sanya Kapoor','sanya@gmail.com','9876523456','2001-07-20','PQRST5678L','345678901234','Verified','Individual'),
('Rahul Sharma','rahul@gmail.com','9876534567','1999-11-15','UVWXY1234A','456789012345','Pending','Individual'),
('Aisha Khan','aisha@gmail.com','9876541123','2000-01-25','LMNOP3456K','567890123456','Verified','Individual'),
('Vikram Rao','vikram@gmail.com','9876542234','1997-06-12','QRSTU7890V','678901234567','Verified','Individual'),
('Neha Gupta','neha@gmail.com','9876543345','2001-09-03','ABCDE9876X','789012345678','Pending','Individual'),
('Amit Verma','amit@gmail.com','9876544456','1998-03-14','FGHIJ1234Y','890123456789','Verified','Individual'),
('Pooja Singh','pooja@gmail.com','9876545567','2002-12-22','KLMNO5678Z','901234567890','Verified','Individual');

-- 2. User_Address Table
CREATE TABLE User_Address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    address_line1 VARCHAR(150) NOT NULL,
    address_line2 VARCHAR(150),
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    country VARCHAR(50) DEFAULT 'India',
    pincode VARCHAR(10) NOT NULL,
    address_type ENUM('Home','Office') DEFAULT 'Home',
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
-- Insert 10 records into User_Address table
INSERT INTO User_Address (user_id, address_line1, address_line2, city, state, country, pincode, address_type) VALUES
(1, '123 Green Park', 'Near Central Mall', 'Mumbai', 'Maharashtra', 'India', '400001', 'Home'),
(2, '45 Blue Street', 'Apt 12B', 'Delhi', 'Delhi', 'India', '110001', 'Home'),
(3, '78 Rose Avenue', NULL, 'Bangalore', 'Karnataka', 'India', '560001', 'Home'),
(4, '56 Lotus Road', 'Block A', 'Chennai', 'Tamil Nadu', 'India', '600001', 'Office'),
(5, '89 Jasmine Lane', NULL, 'Pune', 'Maharashtra', 'India', '411001', 'Home'),
(6, '23 Palm Street', 'Suite 101', 'Hyderabad', 'Telangana', 'India', '500001', 'Office'),
(7, '67 Oak Boulevard', NULL, 'Kolkata', 'West Bengal', 'India', '700001', 'Home'),
(8, '12 Maple Drive', 'Near Park', 'Ahmedabad', 'Gujarat', 'India', '380001', 'Home'),
(9, '90 Pine Street', 'Floor 2', 'Jaipur', 'Rajasthan', 'India', '302001', 'Office'),
(10, '34 Cedar Avenue', NULL, 'Lucknow', 'Uttar Pradesh', 'India', '226001', 'Home');


-- 3. User_Bank_Details Table
CREATE TABLE User_Bank_Details (
    bank_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    bank_name VARCHAR(100) NOT NULL,
    account_no VARCHAR(20) UNIQUE NOT NULL,
    ifsc_code CHAR(11) NOT NULL,
    account_type ENUM('Savings','Current') DEFAULT 'Savings',
    balance DECIMAL(15,2) DEFAULT 0.00,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
-- Insert 10 records into User_Bank_Details table
INSERT INTO User_Bank_Details (user_id, bank_name, account_no, ifsc_code, account_type, balance) VALUES
(1, 'HDFC Bank', 'HDFC0001234', 'HDFC0001234', 'Savings', 100000.00),
(2, 'ICICI Bank', 'ICIC0002345', 'ICIC0002345', 'Savings', 50000.00),
(3, 'State Bank of India', 'SBIN0003456', 'SBIN0003456', 'Savings', 150000.00),
(4, 'Axis Bank', 'AXIS0004567', 'AXIS0004567', 'Current', 200000.00),
(5, 'Kotak Mahindra Bank', 'KOTK0005678', 'KOTK0005678', 'Savings', 75000.00),
(6, 'HDFC Bank', 'HDFC0006789', 'HDFC0006789', 'Current', 120000.00),
(7, 'ICICI Bank', 'ICIC0007890', 'ICIC0007890', 'Savings', 90000.00),
(8, 'State Bank of India', 'SBIN0008901', 'SBIN0008901', 'Savings', 60000.00),
(9, 'Axis Bank', 'AXIS0009012', 'AXIS0009012', 'Savings', 110000.00),
(10, 'Kotak Mahindra Bank', 'KOTK0010123', 'KOTK0010123', 'Savings', 95000.00);


-- 4. Brokers Table
CREATE TABLE Brokers (
    broker_id INT AUTO_INCREMENT PRIMARY KEY,
    broker_name VARCHAR(100) NOT NULL,
    brokerage_percentage DECIMAL(5,2) DEFAULT 0.05,
    contact_email VARCHAR(100),
    contact_no VARCHAR(15),
    status ENUM('Active','Inactive') DEFAULT 'Active'
);
-- Insert 10 records into Brokers table
INSERT INTO Brokers (broker_name, brokerage_percentage, contact_email, contact_no, status) VALUES
('Zerodha', 0.05, 'support@zerodha.com', '1800123456', 'Active'),
('Upstox', 0.04, 'support@upstox.com', '1800654321', 'Active'),
('Angel Broking', 0.03, 'support@angelbroking.com', '1800765432', 'Active'),
('Groww', 0.05, 'support@groww.in', '1800876543', 'Active'),
('5Paisa', 0.02, 'support@5paisa.com', '1800987654', 'Active'),
('ICICI Direct', 0.04, 'support@icicidirect.com', '1801098765', 'Active'),
('HDFC Securities', 0.03, 'support@hdfcsec.com', '1801123456', 'Active'),
('Motilal Oswal', 0.05, 'support@motilaloswal.com', '1801234567', 'Active'),
('Kotak Securities', 0.04, 'support@kotak.com', '1801345678', 'Active'),
('Sharekhan', 0.05, 'support@sharekhan.com', '1801456789', 'Active');


-- 5. Trading_Accounts Table
CREATE TABLE Trading_Accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    broker_id INT NOT NULL,
    account_type ENUM('Equity','Commodity','MutualFund') NOT NULL,
    balance DECIMAL(15,2) DEFAULT 0.00,
    margin_available DECIMAL(15,2) DEFAULT 0.00,
    status ENUM('Active','Suspended','Closed') DEFAULT 'Active',
    opened_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (broker_id) REFERENCES Brokers(broker_id)
);
 -- Insert 10 records into Trading_Accounts table
INSERT INTO Trading_Accounts (user_id, broker_id, account_type, balance, margin_available, status, opened_date) VALUES
(1, 1, 'Equity', 100000.00, 50000.00, 'Active', '2025-01-01'),
(2, 2, 'Commodity', 50000.00, 25000.00, 'Active', '2025-02-15'),
(3, 3, 'Equity', 200000.00, 100000.00, 'Active', '2025-03-10'),
(4, 4, 'MutualFund', 150000.00, 0.00, 'Active', '2025-04-05'),
(5, 5, 'Equity', 75000.00, 35000.00, 'Active', '2025-05-20'),
(6, 6, 'Equity', 120000.00, 60000.00, 'Active', '2025-06-15'),
(7, 7, 'MutualFund', 90000.00, 0.00, 'Active', '2025-07-12'),
(8, 8, 'Commodity', 60000.00, 30000.00, 'Active', '2025-08-08'),
(9, 9, 'Equity', 110000.00, 50000.00, 'Active', '2025-09-01'),
(10, 10, 'Equity', 95000.00, 45000.00, 'Active', '2025-10-01');


 -- Market & Securities Tables
 -- 6. Stock_Sectors Table
CREATE TABLE Stock_Sectors (
    sector_id INT AUTO_INCREMENT PRIMARY KEY,
    sector_name VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(255)
);

-- Insert 10 stock sectors
INSERT INTO Stock_Sectors (sector_name, description) VALUES
('Technology', 'IT and software companies'),
('Finance', 'Banks and financial institutions'),
('Energy', 'Oil, Gas and power companies'),
('Pharmaceuticals', 'Medicines and healthcare'),
('Automobile', 'Cars, bikes, vehicles'),
('Telecom', 'Telecommunication companies'),
('Consumer Goods', 'FMCG companies'),
('Infrastructure', 'Construction and real estate'),
('Metals', 'Mining and metal companies'),
('Agriculture', 'Farming and fertilizers');


 -- 7. Stocks Table
CREATE TABLE Stocks (
    stock_id INT AUTO_INCREMENT PRIMARY KEY,
    stock_symbol VARCHAR(10) UNIQUE NOT NULL,
    company_name VARCHAR(100) NOT NULL,
    sector_id INT,
    market_cap BIGINT,
    ipo_date DATE,
    FOREIGN KEY (sector_id) REFERENCES Stock_Sectors(sector_id)
);
-- Insert 10 stocks
INSERT INTO Stocks (stock_symbol, company_name, sector_id, market_cap, ipo_date) VALUES
('RELI', 'Reliance Industries', 3, 2000000000000, '1977-07-01'),
('TCS', 'Tata Consultancy Services', 1, 1200000000000, '2004-08-25'),
('HDFCBANK', 'HDFC Bank', 2, 900000000000, '1995-01-01'),
('INFY', 'Infosys', 1, 700000000000, '1993-03-20'),
('LT', 'Larsen & Toubro', 8, 500000000000, '1947-01-01'),
('MARUTI', 'Maruti Suzuki', 5, 200000000000, '1992-05-01'),
('SUNPHARMA', 'Sun Pharma', 4, 150000000000, '1993-09-01'),
('BHARTIARTL', 'Bharti Airtel', 6, 250000000000, '2000-10-15'),
('ITC', 'ITC Ltd', 7, 350000000000, '1991-08-01'),
('TATAMOTORS', 'Tata Motors', 5, 220000000000, '1945-10-01');


-- 8. Stock_Prices Table
CREATE TABLE Stock_Prices (
    price_id INT AUTO_INCREMENT PRIMARY KEY,
    stock_id INT NOT NULL,
    price_date DATE NOT NULL,
    open_price DECIMAL(10,2) NOT NULL,
    close_price DECIMAL(10,2) NOT NULL,
    high_price DECIMAL(10,2),
    low_price DECIMAL(10,2),
    volume BIGINT,
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);
-- Insert 10 records into Stock_Prices
INSERT INTO Stock_Prices (stock_id, price_date, open_price, close_price, high_price, low_price, volume) VALUES
(1, '2025-10-01', 2500.00, 2550.00, 2560.00, 2490.00, 1200000),
(2, '2025-10-01', 3500.00, 3525.00, 3530.00, 3480.00, 800000),
(3, '2025-10-01', 1500.00, 1520.00, 1530.00, 1490.00, 500000),
(4, '2025-10-01', 1250.00, 1260.00, 1270.00, 1240.00, 700000),
(5, '2025-10-01', 2000.00, 1985.00, 2020.00, 1975.00, 600000),
(6, '2025-10-01', 8000.00, 8050.00, 8100.00, 7950.00, 300000),
(7, '2025-10-01', 600.00, 610.00, 615.00, 590.00, 400000),
(8, '2025-10-01', 700.00, 715.00, 720.00, 695.00, 350000),
(9, '2025-10-01', 220.00, 225.00, 230.00, 215.00, 450000),
(10, '2025-10-01', 450.00, 460.00, 470.00, 440.00, 500000);


-- 9.Mutual_Funds Table
CREATE TABLE Mutual_Funds (
    mf_id INT AUTO_INCREMENT PRIMARY KEY,
    mf_name VARCHAR(100) NOT NULL,
    fund_type ENUM('Equity','Debt','Hybrid') DEFAULT 'Equity',
    launch_date DATE,
    nav DECIMAL(10,2),
    expense_ratio DECIMAL(5,2)
);
-- Insert 10 records into Mutual_Funds
INSERT INTO Mutual_Funds (mf_name, fund_type, launch_date, nav, expense_ratio) VALUES
('ICICI Equity Fund', 'Equity', '2010-01-01', 250.50, 1.25),
('HDFC Hybrid Fund', 'Hybrid', '2012-03-15', 150.75, 1.10),
('SBI Bluechip Fund', 'Equity', '2011-06-10', 300.10, 1.30),
('Axis Long Term Equity', 'Equity', '2013-09-20', 200.25, 1.20),
('Nippon India Debt Fund', 'Debt', '2015-05-05', 110.50, 0.90),
('Kotak Flexi Cap Fund', 'Equity', '2014-11-11', 180.75, 1.15),
('UTI Retirement Fund', 'Hybrid', '2016-02-02', 125.60, 1.05),
('Mirae Asset Large Cap', 'Equity', '2017-07-07', 210.40, 1.18),
('Aditya Birla Sun Life', 'Debt', '2013-12-12', 105.25, 0.95),
('Franklin India Equity', 'Equity', '2012-08-08', 220.75, 1.22);


-- 10. ETF Table
CREATE TABLE ETF (
    etf_id INT AUTO_INCREMENT PRIMARY KEY,
    etf_name VARCHAR(100) NOT NULL,
    sector_id INT,
    launch_date DATE,
    nav DECIMAL(10,2),
    FOREIGN KEY (sector_id) REFERENCES Stock_Sectors(sector_id)
);
-- Insert 10 records into ETF table
INSERT INTO ETF (etf_name, sector_id, launch_date, nav) VALUES
('Nifty 50 ETF', 1, '2010-01-01', 150.25),
('Bank Nifty ETF', 2, '2011-03-05', 250.40),
('Reliance Energy ETF', 3, '2012-05-10', 200.50),
('Infosys IT ETF', 1, '2013-07-15', 300.75),
('L&T Infrastructure ETF', 8, '2014-09-20', 180.30),
('Maruti Auto ETF', 5, '2015-11-25', 400.60),
('Sun Pharma Pharma ETF', 4, '2016-01-30', 120.10),
('Bharti Telecom ETF', 6, '2017-03-15', 210.50),
('ITC Consumer ETF', 7, '2018-05-20', 170.75),
('Tata Motors Auto ETF', 5, '2019-07-25', 350.40);


-- Orders & Trades Table
-- 11. Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    stock_id INT,
    order_type ENUM('Buy','Sell') NOT NULL,
    quantity INT NOT NULL,
    order_status ENUM('Pending','Executed','Cancelled') DEFAULT 'Pending',
    placed_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES Trading_Accounts(account_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);
-- Insert 10 records into Orders table
INSERT INTO Orders (account_id, stock_id, order_type, quantity, order_status, placed_on) VALUES
(1, 1, 'Buy', 10, 'Executed', '2025-10-01 10:00:00'),
(2, 2, 'Sell', 5, 'Pending', '2025-10-01 11:15:00'),
(3, 3, 'Buy', 20, 'Executed', '2025-10-01 09:45:00'),
(4, 4, 'Buy', 15, 'Cancelled', '2025-10-02 14:30:00'),
(5, 5, 'Sell', 8, 'Executed', '2025-10-02 10:20:00'),
(6, 6, 'Buy', 12, 'Pending', '2025-10-03 12:10:00'),
(7, 7, 'Sell', 6, 'Executed', '2025-10-03 15:00:00'),
(8, 8, 'Buy', 18, 'Pending', '2025-10-04 09:30:00'),
(9, 9, 'Buy', 25, 'Executed', '2025-10-04 11:50:00'),
(10, 10, 'Sell', 10, 'Cancelled', '2025-10-05 13:40:00');


-- 12.  Order_Details Table
CREATE TABLE Order_Details (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    executed_quantity INT DEFAULT 0,
    executed_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
-- Insert 10 records into Order_Details table
INSERT INTO Order_Details (order_id, executed_quantity, executed_price) VALUES
(1, 10, 2550.00),
(2, 0, NULL),
(3, 20, 1520.00),
(4, 0, NULL),
(5, 8, 8000.00),
(6, 0, NULL),
(7, 6, 715.00),
(8, 0, NULL),
(9, 25, 460.00),
(10, 0, NULL);

-- 13. Trades Table
CREATE TABLE Trades (
    trade_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    trade_date DATE DEFAULT (CURRENT_DATE),
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
-- Insert 10 records into Trades table
INSERT INTO Trades (order_id, trade_date, quantity, price) VALUES
(1, '2025-10-01', 10, 2550.00),
(2, '2025-10-01', 0, 0.00),
(3, '2025-10-01', 20, 1520.00),
(4, '2025-10-02', 0, 0.00),
(5, '2025-10-02', 8, 8000.00),
(6, '2025-10-03', 0, 0.00),
(7, '2025-10-03', 6, 715.00),
(8, '2025-10-04', 0, 0.00),
(9, '2025-10-04', 25, 460.00),
(10, '2025-10-05', 0, 0.00);


-- 14. Trade_History Table
CREATE TABLE Trade_History (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    trade_id INT NOT NULL,
    trade_date DATE NOT NULL,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (trade_id) REFERENCES Trades(trade_id)
);
-- Insert 10 records into Trade_History table
INSERT INTO Trade_History (trade_id, trade_date, quantity, price) VALUES
(1, '2025-10-01', 10, 2550.00),
(2, '2025-10-01', 0, 0.00),
(3, '2025-10-01', 20, 1520.00),
(4, '2025-10-02', 0, 0.00),
(5, '2025-10-02', 8, 8000.00),
(6, '2025-10-03', 0, 0.00),
(7, '2025-10-03', 6, 715.00),
(8, '2025-10-04', 0, 0.00),
(9, '2025-10-04', 25, 460.00),
(10, '2025-10-05', 0, 0.00);


-- 15. Holdings Table
CREATE TABLE Holdings (
    holding_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    stock_id INT NOT NULL,
    quantity INT DEFAULT 0,
    avg_price DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (account_id) REFERENCES Trading_Accounts(account_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);
-- Insert 10 records into Holdings table
INSERT INTO Holdings (account_id, stock_id, quantity, avg_price) VALUES
(1, 1, 10, 2500.00),
(2, 2, 5, 3500.00),
(3, 3, 20, 1500.00),
(4, 4, 15, 2000.00),
(5, 5, 8, 8000.00),
(6, 6, 12, 600.00),
(7, 7, 6, 700.00),
(8, 8, 18, 220.00),
(9, 9, 25, 450.00),
(10, 10, 10, 460.00);


-- Finance & Wallet Tables
-- 16. Transactions Table
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_type ENUM('Deposit','Withdrawal') NOT NULL,
    amount DECIMAL(15,2) NOT NULL CHECK(amount > 0),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES Trading_Accounts(account_id)
);
-- Insert 10 records into Transactions table
INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date) VALUES
(1, 'Deposit', 50000.00, '2025-10-01 10:00:00'),
(2, 'Deposit', 30000.00, '2025-10-01 11:00:00'),
(3, 'Withdrawal', 20000.00, '2025-10-01 12:00:00'),
(4, 'Deposit', 40000.00, '2025-10-02 09:30:00'),
(5, 'Withdrawal', 15000.00, '2025-10-02 10:20:00'),
(6, 'Deposit', 60000.00, '2025-10-03 14:00:00'),
(7, 'Withdrawal', 10000.00, '2025-10-03 15:30:00'),
(8, 'Deposit', 35000.00, '2025-10-04 09:15:00'),
(9, 'Deposit', 45000.00, '2025-10-04 11:45:00'),
(10, 'Withdrawal', 20000.00, '2025-10-05 10:50:00');

-- 17. Payments Table
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT NOT NULL,
    payment_mode ENUM('UPI','NetBanking','CreditCard','DebitCard') NOT NULL,
    status ENUM('Success','Failed','Pending') DEFAULT 'Pending',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id)
);
-- Insert 10 records into Payments table
INSERT INTO Payments (transaction_id, payment_mode, status, payment_date) VALUES
(1, 'UPI', 'Success', '2025-10-01 10:05:00'),
(2, 'NetBanking', 'Success', '2025-10-01 11:10:00'),
(3, 'CreditCard', 'Failed', '2025-10-01 12:05:00'),
(4, 'DebitCard', 'Success', '2025-10-02 09:35:00'),
(5, 'UPI', 'Success', '2025-10-02 10:25:00'),
(6, 'NetBanking', 'Pending', '2025-10-03 14:10:00'),
(7, 'CreditCard', 'Success', '2025-10-03 15:40:00'),
(8, 'DebitCard', 'Success', '2025-10-04 09:20:00'),
(9, 'UPI', 'Success', '2025-10-04 11:50:00'),
(10, 'NetBanking', 'Failed', '2025-10-05 10:55:00');


-- 18. Deposits Table
CREATE TABLE Deposits (
    deposit_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    amount DECIMAL(15,2) NOT NULL CHECK(amount > 0),
    deposit_date DATE DEFAULT (CURRENT_DATE),
    method ENUM('UPI','NetBanking','CreditCard','DebitCard') DEFAULT 'UPI',
    FOREIGN KEY (account_id) REFERENCES Trading_Accounts(account_id)
);
-- Insert 10 records into Deposits table
INSERT INTO Deposits (account_id, amount, deposit_date, method) VALUES
(1, 50000.00, '2025-10-01', 'UPI'),
(2, 30000.00, '2025-10-01', 'NetBanking'),
(3, 20000.00, '2025-10-01', 'CreditCard'),
(4, 40000.00, '2025-10-02', 'DebitCard'),
(5, 15000.00, '2025-10-02', 'UPI'),
(6, 60000.00, '2025-10-03', 'NetBanking'),
(7, 10000.00, '2025-10-03', 'CreditCard'),
(8, 35000.00, '2025-10-04', 'DebitCard'),
(9, 45000.00, '2025-10-04', 'UPI'),
(10, 20000.00, '2025-10-05', 'NetBanking');


-- 19. Withdrawals Table
CREATE TABLE Withdrawals (
    withdrawal_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    amount DECIMAL(15,2) NOT NULL CHECK(amount > 0),
    withdrawal_date DATE DEFAULT (CURRENT_DATE),
    status ENUM('Pending','Completed','Rejected') DEFAULT 'Pending',
    FOREIGN KEY (account_id) REFERENCES Trading_Accounts(account_id)
);
-- Insert 10 records into Withdrawals table
INSERT INTO Withdrawals (account_id, amount, withdrawal_date, status) VALUES
(1, 20000.00, '2025-10-01', 'Completed'),
(2, 15000.00, '2025-10-01', 'Pending'),
(3, 10000.00, '2025-10-01', 'Completed'),
(4, 25000.00, '2025-10-02', 'Rejected'),
(5, 12000.00, '2025-10-02', 'Completed'),
(6, 30000.00, '2025-10-03', 'Pending'),
(7, 8000.00, '2025-10-03', 'Completed'),
(8, 18000.00, '2025-10-04', 'Completed'),
(9, 22000.00, '2025-10-04', 'Pending'),
(10, 15000.00, '2025-10-05', 'Completed');


-- Alerts, Portfolio, Dividends, Watchlist
-- 20. Watchlist Table
CREATE TABLE Watchlist (
    watch_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    stock_id INT NOT NULL,
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES Trading_Accounts(account_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);
-- Insert 10 records into Watchlist table
INSERT INTO Watchlist (account_id, stock_id, added_on) VALUES
(1, 2, '2025-10-01 10:05:00'),
(2, 3, '2025-10-01 11:15:00'),
(3, 1, '2025-10-01 12:30:00'),
(4, 5, '2025-10-02 09:20:00'),
(5, 6, '2025-10-02 10:45:00'),
(6, 4, '2025-10-03 14:00:00'),
(7, 7, '2025-10-03 15:10:00'),
(8, 8, '2025-10-04 09:30:00'),
(9, 9, '2025-10-04 11:50:00'),
(10, 10, '2025-10-05 10:40:00');


-- 21.  Portfolio_Performance Table
CREATE TABLE Portfolio_Performance (
    perf_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    performance_date DATE DEFAULT (CURRENT_DATE),
    total_value DECIMAL(15,2),
    profit_loss DECIMAL(15,2),
    FOREIGN KEY (account_id) REFERENCES Trading_Accounts(account_id)
);
-- Insert 10 records into Portfolio_Performance table
INSERT INTO Portfolio_Performance (account_id, performance_date, total_value, profit_loss) VALUES
(1, '2025-10-01', 255000.00, 5000.00),
(2, '2025-10-01', 152000.00, 2000.00),
(3, '2025-10-01', 304000.00, 4000.00),
(4, '2025-10-02', 210000.00, -1000.00),
(5, '2025-10-02', 88000.00, 3000.00),
(6, '2025-10-03', 180000.00, 5000.00),
(7, '2025-10-03', 42500.00, 2500.00),
(8, '2025-10-04', 95000.00, 1500.00),
(9, '2025-10-04', 115000.00, -2000.00),
(10, '2025-10-05', 46000.00, 1000.00);


-- 22. Alerts Table
CREATE TABLE Alerts (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    stock_id INT NOT NULL,
    alert_type ENUM('PriceRise','PriceDrop') NOT NULL,
    target_price DECIMAL(10,2) NOT NULL,
    alert_status ENUM('Pending','Triggered') DEFAULT 'Pending',
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES Trading_Accounts(account_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);
-- Insert 10 records into Alerts table
INSERT INTO Alerts (account_id, stock_id, alert_type, target_price, alert_status, created_on) VALUES
(1, 1, 'PriceRise', 2600.00, 'Pending', '2025-10-01 10:05:00'),
(2, 2, 'PriceDrop', 3450.00, 'Pending', '2025-10-01 11:15:00'),
(3, 3, 'PriceRise', 1550.00, 'Pending', '2025-10-01 12:30:00'),
(4, 4, 'PriceDrop', 1980.00, 'Pending', '2025-10-02 09:20:00'),
(5, 5, 'PriceRise', 8100.00, 'Pending', '2025-10-02 10:45:00'),
(6, 6, 'PriceDrop', 590.00, 'Pending', '2025-10-03 14:00:00'),
(7, 7, 'PriceRise', 720.00, 'Pending', '2025-10-03 15:10:00'),
(8, 8, 'PriceDrop', 215.00, 'Pending', '2025-10-04 09:30:00'),
(9, 9, 'PriceRise', 470.00, 'Pending', '2025-10-04 11:50:00'),
(10, 10, 'PriceDrop', 455.00, 'Pending', '2025-10-05 10:40:00');


-- 23. Dividends Table
CREATE TABLE Dividends (
    dividend_id INT AUTO_INCREMENT PRIMARY KEY,
    stock_id INT NOT NULL,
    ex_date DATE NOT NULL,
    record_date DATE,
    dividend_amount DECIMAL(10,2),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);
-- Insert 10 records into Dividends table
INSERT INTO Dividends (stock_id, ex_date, record_date, dividend_amount) VALUES
(1, '2025-09-15', '2025-09-17', 15.00),
(2, '2025-09-20', '2025-09-22', 12.50),
(3, '2025-09-25', '2025-09-27', 10.00),
(4, '2025-10-01', '2025-10-03', 8.50),
(5, '2025-10-05', '2025-10-07', 20.00),
(6, '2025-10-10', '2025-10-12', 7.25),
(7, '2025-10-15', '2025-10-17', 5.50),
(8, '2025-10-20', '2025-10-22', 6.00),
(9, '2025-10-25', '2025-10-27', 4.75),
(10, '2025-10-30', '2025-11-01', 9.00);


-- Support & KYC Tables
-- 24. Support_Tickets Table
CREATE TABLE Support_Tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    subject VARCHAR(150) NOT NULL,
    description TEXT,
    status ENUM('Open','InProgress','Resolved','Closed') DEFAULT 'Open',
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_on TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
-- Insert 10 records into Support_Tickets table
INSERT INTO Support_Tickets (user_id, subject, description, status, created_on, resolved_on) VALUES
(1, 'KYC Verification Issue', 'Unable to upload documents for KYC.', 'Open', '2025-10-01 09:30:00', NULL),
(2, 'Failed Deposit', 'Deposit via NetBanking failed but amount debited.', 'InProgress', '2025-10-01 10:15:00', NULL),
(3, 'Trading Account Locked', 'Cannot place orders, account shows suspended.', 'Resolved', '2025-10-01 11:00:00', '2025-10-01 14:00:00'),
(4, 'Incorrect Stock Price', 'Stock price displayed incorrect in dashboard.', 'Open', '2025-10-02 09:20:00', NULL),
(5, 'Withdrawal Delay', 'Withdrawal not credited to bank account.', 'InProgress', '2025-10-02 10:50:00', NULL),
(6, 'ETF NAV Issue', 'ETF NAV not updating correctly.', 'Resolved', '2025-10-03 14:10:00', '2025-10-03 16:00:00'),
(7, 'App Crash', 'App crashes on order placement.', 'Open', '2025-10-03 15:40:00', NULL),
(8, 'Mutual Fund Redemption', 'Redemption amount not reflected in account.', 'InProgress', '2025-10-04 09:30:00', NULL),
(9, 'Incorrect Alert Trigger', 'Price alert triggered at wrong price.', 'Resolved', '2025-10-04 11:50:00', '2025-10-04 13:00:00'),
(10, 'PAN Update Request', 'Need to update PAN details in account.', 'Open', '2025-10-05 10:45:00', NULL);


-- 25. KYC_Documents Table
CREATE TABLE KYC_Documents (
    doc_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    doc_type ENUM('PAN','AADHAAR','Passport','Other') NOT NULL,
    doc_number VARCHAR(50) NOT NULL,
    uploaded_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    verified ENUM('Yes','No') DEFAULT 'No',
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
-- Insert 10 records into KYC_Documents table
INSERT INTO KYC_Documents (user_id, doc_type, doc_number, uploaded_on, verified) VALUES
(1, 'PAN', 'ABCDE1234F', '2025-09-01 10:00:00', 'Yes'),
(2, 'AADHAAR', '123456789012', '2025-09-02 11:00:00', 'Yes'),
(3, 'Passport', 'M1234567', '2025-09-03 12:00:00', 'No'),
(4, 'PAN', 'FGHIJ5678K', '2025-09-04 09:30:00', 'Yes'),
(5, 'AADHAAR', '234567890123', '2025-09-05 10:45:00', 'No'),
(6, 'PAN', 'KLMNO9876P', '2025-09-06 14:00:00', 'Yes'),
(7, 'Passport', 'N7654321', '2025-09-07 15:10:00', 'No'),
(8, 'AADHAAR', '345678901234', '2025-09-08 09:30:00', 'Yes'),
(9, 'PAN', 'QRSTU5432V', '2025-09-09 11:50:00', 'No'),
(10, 'Other', 'DL1234567', '2025-09-10 10:40:00', 'Yes');


-- 1. Database Queries
-- Show all databases
SHOW DATABASES;

-- Use your database
USE ZerodhaKiteDB;

-- Show all tables
SHOW TABLES;

-- Describe table structure
DESCRIBE Users;
DESCRIBE Stocks;

-- 2. Basic Table Queries
-- SELECT Queries

-- Select all records
SELECT * FROM Users;
SELECT * FROM Stocks;
SELECT * FROM Trading_Accounts;

-- Select specific columns
SELECT full_name, email, mobile_no FROM Users;

-- Filtering data
SELECT * FROM Stocks WHERE market_cap > 5000000000;
SELECT * FROM Orders WHERE order_status='Pending';


-- Sorting
SELECT * FROM Trades ORDER BY trade_date DESC;


-- Limiting results
SELECT * FROM Users LIMIT 5;


-- 3. UPDATE Records
-- Update KYC status
UPDATE Users SET kyc_status='Verified' WHERE user_id=3;

-- Update stock NAV (example)
UPDATE Mutual_Funds SET nav=255.00 WHERE mf_id=1;

-- 4. DELETE Records
-- Delete a trade history entry
DELETE FROM Trade_History WHERE history_id=10;


-- 5.TRUNCATE Table
-- Remove all records but keep table structure
TRUNCATE TABLE Alerts;

-- 6. DROP Table
-- Delete table permanently
DROP TABLE IF EXISTS Watchlist;


-- 7. JOINs
-- Inner Join Users with Accounts
SELECT u.full_name, t.account_type, t.balance
FROM Users u
JOIN Trading_Accounts t ON u.user_id = t.user_id;

-- Orders with Trade details
SELECT o.order_id, o.order_type, od.executed_quantity, od.executed_price
FROM Orders o
LEFT JOIN Order_Details od ON o.order_id = od.order_id;

-- Stocks with sector names
SELECT s.stock_symbol, ss.sector_name
FROM Stocks s
JOIN Stock_Sectors ss ON s.sector_id = ss.sector_id;


-- 8. Aggregate Functions
-- Count number of users
SELECT COUNT(*) AS total_users FROM Users;

-- Average stock price
SELECT AVG(close_price) AS avg_close_price FROM Stock_Prices;

-- Maximum trade price
SELECT MAX(price) AS highest_trade FROM Trades;

-- Group by example
SELECT kyc_status, COUNT(*) AS total_users
FROM Users
GROUP BY kyc_status;


-- 9. Subqueries
-- Users with the highest balance
SELECT * FROM Trading_Accounts
WHERE balance = (SELECT MAX(balance) FROM Trading_Accounts);

-- Stocks with above-average market cap
SELECT * FROM Stocks
WHERE market_cap > (SELECT AVG(market_cap) FROM Stocks);


-- 10. Using LIMIT, OFFSET
-- Get top 5 trades
SELECT * FROM Trades ORDER BY trade_date DESC LIMIT 5;

-- Get next 5 trades
SELECT * FROM Trades ORDER BY trade_date DESC LIMIT 5 OFFSET 5;


-- 11. Conditional Queries
-- Users with KYC pending
SELECT * FROM Users WHERE kyc_status='Pending';


-- Orders that are either Pending or Cancelled
SELECT * FROM Orders WHERE order_status IN ('Pending','Cancelled');


-- 12. Show Data from Tables
SELECT * FROM Users;
SELECT * FROM Stocks;
SELECT * FROM Trading_Accounts;
SELECT * FROM Orders;
SELECT * FROM Order_Details;
SELECT * FROM Trades;
SELECT * FROM Holdings;
SELECT * FROM Transactions;
SELECT * FROM Payments;
SELECT * FROM Deposits;
SELECT * FROM Withdrawals;
SELECT * FROM Watchlist;
SELECT * FROM Alerts;
SELECT * FROM Portfolio_Performance;
SELECT * FROM Support_Tickets;
SELECT * FROM KYC_Documents;
SELECT * FROM Dividends;
SELECT * FROM Mutual_Funds;
SELECT * FROM ETF;

