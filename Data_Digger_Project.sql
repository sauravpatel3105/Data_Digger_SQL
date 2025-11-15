create database data_digger;
use data_digger;


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100),
    Address VARCHAR(100)
);

INSERT INTO Customers (CustomerID, Name, Email, Address) VALUES
(1, 'Alice', 'alice@example.com', 'manpur'),
(2, 'Bob', 'bob@example.com', 'methan'),
(3, 'Charlie', 'charlie@example.com', 'gandhinagr'),
(4, 'David', 'david@example.com', 'kuntalpur'),
(5, 'Emma', 'emma@example.com', 'khanpur');

select*from Customers;


SET SQL_SAFE_UPDATES = 1 ;

update Customers set Address = 'pipali' where Customerid = 5 ;

delete from Customers where  Customerid = 5 ;

select * from Customers where Name = 'Alice'; 
drop table Customers ;


create table Orders (
Orderid int primary key ,
CustomerID int ,
OrderDate date ,
TotalAmount decimal(10,2),
foreign key (CustomerID) references Customers (CustomerID)
);


INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(101, 1, '2025-10-20', 45.99),
(102, 2, '2025-10-25', 120.50),
(103, 3, '2025-11-05', 88.00),
(104, 4, '2025-11-10', 25.75),
(105, 5, '2025-11-12', 300.00);

select*from Orders where CustomerID = 2 ;

update Orders set TotalAmount = 3000 where CustomerID = 2 ;

delete from Orders where OrderID = 5 ;

select*from Orders 
where OrderDate >= (curdate() - interval 30 day );
SELECT 
    MAX(o.TotalAmount) AS HighestAmount,
    MIN(o.TotalAmount) AS LowestAmount,
    AVG(o.TotalAmount) AS AverageAmount
FROM data_digger.Orders AS o;


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    Stock INT
);

INSERT INTO Products (ProductID, ProductName, Price, Stock) VALUES
(1, 'Laptop', 45000.00, 15),
(2, 'Mouse', 750.00, 150),
(3, 'Keyboard', 1250.50, 80),
(4, 'Monitor', 15000.00, 25),
(5, 'Webcam', 450.00, 0);

select * from products order by Price desc ;  
update Products set Price = 60000 where ProductID = 2;
SET SQL_SAFE_UPDATES = 0 ;

DELETE FROM Products
WHERE Stock = 0 ;

select * from Products where Price between 500 and 2000 ;

select 
max(Price) as Expensive ,
min(Price) as cheapest
from Products ;


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10, 2),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, SubTotal) VALUES
(1, 101, 1, 2, 1500.00), 
(2, 102, 2, 1, 1250.50),
(3, 103, 3, 1, 45000.00), 
(4, 104, 4, 5, 3750.00), 
(5, 105, 5, 2, 5000.00);


select * from OrderDetails where OrderID = 1;

select ProductID , sum(Quantity) AS TotalSold from OrderDetails 
group by ProductID 
order by TotalSold desc limit 3 ;

select ProductID , count(*) AS TimesSold
from OrderDetails
where ProductID = 2 
group by ProductID ;
