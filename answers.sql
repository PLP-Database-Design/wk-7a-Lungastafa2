
-- Question 1 Achieving 1NF (First Normal Form) 🛠
-- Task:

-- You are given the following table ProductDetail:
  
-- OrderID	    CustomerName	    Products
-- 101	        John Doe	        Laptop, Mouse
-- 102	        Jane Smith	      Tablet, Keyboard, Mouse
-- 103	        Emily Clark	      Phone

  
-- In the table above, the Products column contains multiple values, which violates 1NF.
-- Write an SQL query to transform this table into 1NF, ensuring that each row represents a single product for an order


SELECT 
  OrderID, 
  CustomerName, 
  TRIM(Product) AS Product
FROM ProductDetail
CROSS APPLY STRING_SPLIT(Products, ',')



-- Question 2 Achieving 2NF (Second Normal Form) 


-- You are given the following table OrderDetails, 
-- which is already in 1NF but still contains partial dependencies:

-- OrderID	    CustomerName	    Product	  Quantity
-- 101	        John Doe	        Laptop	  2
-- 101	        John Doe	        Mouse  	  1
-- 102	        Jane Smith	      Tablet	  3
-- 102	        Jane Smith	      Keyboard	1
-- 102	        Jane Smith	      Mouse	    2
-- 103	        Emily Clark	      Phone	    1

-- In the table above,
-- the CustomerName column depends on OrderID (a partial dependency), which violates 2NF.

-- Write an SQL query to transform this table into 2NF by removing partial dependencies.
-- Ensure that each non-key column fully depends on the entire primary key.


-- First Create the Orders Table,that will store the OrderID and CustomerName

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);


 --Insert Data into the Orders Table without duplication of CustomerName

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;


-- Create the OrderDetails Table that will store OrderID, Product, and Quantity 
-- Where OrderID and Product together will form the composite primary key.


CREATE TABLE OrderDetails (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- Insert Data into the OrderDetails Table by copying data from original table 


INSERT INTO OrderDetails (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;


