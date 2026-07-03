use computer_shop;
-- 1. Table: parties
CREATE TABLE parties (
    parties_id INT PRIMARY KEY,
    Phone_number VARCHAR(255),
    Email VARCHAR(255),
    Address TEXT
);

-- 2. Table: Categories
CREATE TABLE Categories (
    Categories_id INT PRIMARY KEY,
    Name VARCHAR(255)
);

-- 3. Table: Stock_Location
CREATE TABLE Stock_Location (
    Location_id INT PRIMARY KEY,
    Location VARCHAR(255)
);

-- 4. Table: item_Name
CREATE TABLE item_Name (
    itemName_id BIGINT PRIMARY KEY,
    item_name VARCHAR(255)
);

-- 5. Table: Suppliers
CREATE TABLE Suppliers (
    Suppliers_id INT PRIMARY KEY,
    parties_id INT,
    Name VARCHAR(255),
    FOREIGN KEY (parties_id) REFERENCES parties(parties_id)
);

-- 6. Table: Customers
CREATE TABLE Customers (
    Customers_id INT PRIMARY KEY,
    parties_id INT,
    First_name VARCHAR(255),
    Last_name VARCHAR(255),
    FOREIGN KEY (parties_id) REFERENCES parties(parties_id)
);

-- 7. Table: Products
CREATE TABLE Products (
    Products_id INT PRIMARY KEY,
    Categories_id INT,
    Name VARCHAR(255),
    Warranty DATETIME,
    Suppliers_id INT,
    FOREIGN KEY (Categories_id) REFERENCES Categories(Categories_id),
    FOREIGN KEY (Suppliers_id) REFERENCES Suppliers(Suppliers_id)
);

-- 8. Table: Stocks
CREATE TABLE Stocks (
    Stock_id INT PRIMARY KEY,
    Location_id INT,
    Min_capacity INT,
    Max_capacity INT,
    FOREIGN KEY (Location_id) REFERENCES Stock_Location(Location_id)
);

-- 9. Table: Stock_Products (Bridge / Junction Table)
CREATE TABLE Stock_Products (
    Stock_id INT,
    Products_id INT,
    Quantity INT,
    PRIMARY KEY (Stock_id, Products_id),
    FOREIGN KEY (Stock_id) REFERENCES Stocks(Stock_id),
    FOREIGN KEY (Products_id) REFERENCES Products(Products_id)
);

-- 10. Table: Departments
CREATE TABLE Departments (
    Departments_id INT PRIMARY KEY,
    Employees_id INT, -- Note: This creates a cyclical reference if Employees also references Departments. 
    Name VARCHAR(255) -- (Added foreign key down below via ALTER if needed, or keeping it as regular INT based on your exact diagram)
);

-- 11. Table: Employees
CREATE TABLE Employees (
    Employees_id INT PRIMARY KEY,
    First_name VARCHAR(255),
    Last_name VARCHAR(255),
    SSN CHAR(14), -- Defaulted to CHAR(14) assuming Egyptian SSN standard length, adjust as needed
    Started_at DATE,
    Job_title VARCHAR(255),
    Salary FLOAT,
    Departments_id INT,
    parties_id INT,
    FOREIGN KEY (Departments_id) REFERENCES Departments(Departments_id),
    FOREIGN KEY (parties_id) REFERENCES parties(parties_id)
);

-- Adding the foreign key for Departments after Employees table is created to avoid reference errors
ALTER TABLE Departments ADD FOREIGN KEY (Employees_id) REFERENCES Employees(Employees_id);

-- 12. Table: Sales
CREATE TABLE Sales (
    Sales_id INT PRIMARY KEY,
    Tax DECIMAL(10,2),
    Order_date DATE,
    Employees_id INT,
    Customers_id INT,
    Total_Price FLOAT,
    FOREIGN KEY (Employees_id) REFERENCES Employees(Employees_id),
    FOREIGN KEY (Customers_id) REFERENCES Customers(Customers_id)
);

-- 13. Table: Pro_Sales (Bridge / Junction Table for Sales and Products)
CREATE TABLE Pro_Sales (
    Products_id INT,
    Sales_id INT,
    Quantity INT,
    Subtotal_price FLOAT,
    Price FLOAT,
    PRIMARY KEY (Products_id, Sales_id),
    FOREIGN KEY (Products_id) REFERENCES Products(Products_id),
    FOREIGN KEY (Sales_id) REFERENCES Sales(Sales_id)
);

-- 14. Table: Offers
CREATE TABLE Offers (
    Offers_id INT PRIMARY KEY,
    Products_id INT,
    Start_At DATE,
    End_At DATE,
    Discount_percentage DECIMAL(5,2),
    Is_active BOOLEAN,
    FOREIGN KEY (Products_id) REFERENCES Products(Products_id)
);

-- 15. Table: Maintenance_item
CREATE TABLE Maintenance_item (
    Maintenance_item_id INT PRIMARY KEY,
    ItemName_id BIGINT,
    Date DATE,
    Reparing_price FLOAT,
    Stock_id INT,
    Customers_id INT,
    Employees_id INT,
    FOREIGN KEY (ItemName_id) REFERENCES item_Name(itemName_id),
    FOREIGN KEY (Stock_id) REFERENCES Stocks(Stock_id),
    FOREIGN KEY (Customers_id) REFERENCES Customers(Customers_id),
    FOREIGN KEY (Employees_id) REFERENCES Employees(Employees_id)
);

-- 16. Table: Maintenance
CREATE TABLE Maintenance (
    Maintenance_id INT PRIMARY KEY,
    Maintenance_item_id INT,
    Total_Reparing_price FLOAT,
    FOREIGN KEY (Maintenance_item_id) REFERENCES Maintenance_item(Maintenance_item_id)
);
