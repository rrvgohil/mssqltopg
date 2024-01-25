
CREATE TABLE Employees (
	EmployeeID int GENERATED ALWAYS AS IDENTITY (START WITH 1  INCREMENT BY 1) NOT NULL ,
	LastName varchar (20) NOT NULL ,
	FirstName varchar (10) NOT NULL ,
	Title varchar (30) NULL ,
	TitleOfCourtesy varchar (25) NULL ,
	BirthDate Timestamp(3) NULL ,
	HireDate Timestamp(3) NULL ,
	Address varchar (60) NULL ,
	City varchar (15) NULL ,
	Region varchar (15) NULL ,
	PostalCode varchar (10) NULL ,
	Country varchar (15) NULL ,
	HomePhone varchar (24) NULL ,
	Extension varchar (4) NULL ,
	Photo Bytea NULL ,
	Notes text NULL ,
	ReportsTo int NULL ,
	PhotoPath varchar (255) NULL ,
	CONSTRAINT PK_Employees PRIMARY KEY  
	(
		EmployeeID
	),
	CONSTRAINT FK_Employees_Employees FOREIGN KEY 
	(
		ReportsTo
	) REFERENCES Employees (
		EmployeeID
	),
	CONSTRAINT CK_Birthdate CHECK (BirthDate < now())
);
 
 CREATE  INDEX LastName ON Employees(LastName);
 
 
 CREATE  INDEX PostalCode ON Employees(PostalCode);
 


CREATE TABLE Categories (
	CategoryID int GENERATED ALWAYS AS IDENTITY (START WITH 1  INCREMENT BY 1) NOT NULL ,
	CategoryName varchar (15) NOT NULL ,
	Description text NULL ,
	Picture Bytea NULL ,
	CONSTRAINT PK_Categories PRIMARY KEY  
	(
		CategoryID
	)
);
 
 CREATE  INDEX CategoryName ON Categories(CategoryName);
 


CREATE TABLE Customers (
	CustomerID char (5) NOT NULL ,
	CompanyName varchar (40) NOT NULL ,
	ContactName varchar (30) NULL ,
	ContactTitle varchar (30) NULL ,
	Address varchar (60) NULL ,
	City varchar (15) NULL ,
	Region varchar (15) NULL ,
	PostalCode varchar (10) NULL ,
	Country varchar (15) NULL ,
	Phone varchar (24) NULL ,
	Fax varchar (24) NULL ,
	CONSTRAINT PK_Customers PRIMARY KEY  
	(
		CustomerID
	)
);
 
 CREATE  INDEX City ON Customers(City);
 
 
 CREATE  INDEX CompanyName ON Customers(CompanyName);
 
 
 CREATE  INDEX PostalCode ON Customers(PostalCode);
 
 
 CREATE  INDEX Region ON Customers(Region);
 


CREATE TABLE Shippers (
	ShipperID int GENERATED ALWAYS AS IDENTITY (START WITH 1  INCREMENT BY 1) NOT NULL ,
	CompanyName varchar (40) NOT NULL ,
	Phone varchar (24) NULL ,
	CONSTRAINT PK_Shippers PRIMARY KEY  
	(
		ShipperID
	)
);

CREATE TABLE Suppliers (
	SupplierID int GENERATED ALWAYS AS IDENTITY (START WITH 1  INCREMENT BY 1) NOT NULL ,
	CompanyName varchar (40) NOT NULL ,
	ContactName varchar (30) NULL ,
	ContactTitle varchar (30) NULL ,
	Address varchar (60) NULL ,
	City varchar (15) NULL ,
	Region varchar (15) NULL ,
	PostalCode varchar (10) NULL ,
	Country varchar (15) NULL ,
	Phone varchar (24) NULL ,
	Fax varchar (24) NULL ,
	HomePage text NULL ,
	CONSTRAINT PK_Suppliers PRIMARY KEY  
	(
		SupplierID
	)
);
 
 CREATE  INDEX CompanyName ON Suppliers(CompanyName);
 
 
 CREATE  INDEX PostalCode ON Suppliers(PostalCode);
 


CREATE TABLE Orders (
	OrderID int GENERATED ALWAYS AS IDENTITY (START WITH 1  INCREMENT BY 1) NOT NULL ,
	CustomerID char (5) NULL ,
	EmployeeID int NULL ,
	OrderDate Timestamp(3) NULL ,
	RequiredDate Timestamp(3) NULL ,
	ShippedDate Timestamp(3) NULL ,
	ShipVia int NULL ,
	Freight money NULL CONSTRAINT "DF_Orders_Freight" DEFAULT (0),
	ShipName varchar (40) NULL ,
	ShipAddress varchar (60) NULL ,
	ShipCity varchar (15) NULL ,
	ShipRegion varchar (15) NULL ,
	ShipPostalCode varchar (10) NULL ,
	ShipCountry varchar (15) NULL ,
	CONSTRAINT PK_Orders PRIMARY KEY  
	(
		OrderID
	),
	CONSTRAINT FK_Orders_Customers FOREIGN KEY 
	(
		CustomerID
	) REFERENCES Customers (
		CustomerID
	),
	CONSTRAINT FK_Orders_Employees FOREIGN KEY 
	(
		EmployeeID
	) REFERENCES Employees (
		EmployeeID
	),
	CONSTRAINT FK_Orders_Shippers FOREIGN KEY 
	(
		ShipVia
	) REFERENCES Shippers (
		ShipperID
	)
);
 
 CREATE  INDEX CustomerID ON Orders(CustomerID);
 
 
 CREATE  INDEX CustomersOrders ON Orders(CustomerID);
 
 
 CREATE  INDEX EmployeeID ON Orders(EmployeeID);
 
 
 CREATE  INDEX EmployeesOrders ON Orders(EmployeeID);
 
 
 CREATE  INDEX OrderDate ON Orders(OrderDate);
 
 
 CREATE  INDEX ShippedDate ON Orders(ShippedDate);
 
 
 CREATE  INDEX ShippersOrders ON Orders(ShipVia);
 
 
 CREATE  INDEX ShipPostalCode ON Orders(ShipPostalCode);
 


CREATE TABLE Products (
	ProductID int GENERATED ALWAYS AS IDENTITY (START WITH 1  INCREMENT BY 1) NOT NULL ,
	ProductName varchar (40) NOT NULL ,
	SupplierID int NULL ,
	CategoryID int NULL ,
	QuantityPerUnit varchar (20) NULL ,
	UnitPrice money NULL CONSTRAINT "DF_Products_UnitPrice" DEFAULT (0),
	UnitsInStock smallint NULL CONSTRAINT "DF_Products_UnitsInStock" DEFAULT (0),
	UnitsOnOrder smallint NULL CONSTRAINT "DF_Products_UnitsOnOrder" DEFAULT (0),
	ReorderLevel smallint NULL CONSTRAINT "DF_Products_ReorderLevel" DEFAULT (0),
	Discontinued int NOT NULL CONSTRAINT "DF_Products_Discontinued" DEFAULT (0),
	CONSTRAINT PK_Products PRIMARY KEY  
	(
		ProductID
	),
	CONSTRAINT FK_Products_Categories FOREIGN KEY 
	(
		CategoryID
	) REFERENCES Categories (
		CategoryID
	),
	CONSTRAINT FK_Products_Suppliers FOREIGN KEY 
	(
		SupplierID
	) REFERENCES Suppliers (
		SupplierID
	),
	CONSTRAINT CK_Products_UnitPrice CHECK (UnitPrice >= 1),
	CONSTRAINT CK_ReorderLevel CHECK (ReorderLevel >= 0),
	CONSTRAINT CK_UnitsInStock CHECK (UnitsInStock >= 0),
	CONSTRAINT CK_UnitsOnOrder CHECK (UnitsOnOrder >= 0)
);
 
 CREATE  INDEX CategoriesProducts ON Products(CategoryID);
 
 
 CREATE  INDEX CategoryID ON Products(CategoryID);
 
 
 CREATE  INDEX ProductName ON Products(ProductName);
 
 
 CREATE  INDEX SupplierID ON Products(SupplierID);
 
 
 CREATE  INDEX SuppliersProducts ON Products(SupplierID);
 
CREATE TABLE "Order Details" (
	OrderID int NOT NULL ,
	ProductID int NOT NULL ,
	UnitPrice int NOT NULL CONSTRAINT "DF_Order_Details_UnitPrice" DEFAULT (0),
	Quantity smallint NOT NULL CONSTRAINT "DF_Order_Details_Quantity" DEFAULT (1),
	Discount real NOT NULL CONSTRAINT "DF_Order_Details_Discount" DEFAULT (0),
	CONSTRAINT PK_Order_Details PRIMARY KEY  
	(
		OrderID,
		ProductID
	),
	CONSTRAINT FK_Order_Details_Orders FOREIGN KEY 
	(
		OrderID
	) REFERENCES Orders (
		OrderID
	),
	CONSTRAINT FK_Order_Details_Products FOREIGN KEY 
	(
		ProductID
	) REFERENCES Products (
		ProductID
	),
	CONSTRAINT CK_Discount CHECK (Discount >= 0 and (Discount <= 1)),
	CONSTRAINT CK_Quantity CHECK (Quantity > 0),
	CONSTRAINT CK_UnitPrice CHECK (UnitPrice >= 0)
);
 
 CREATE  INDEX OrderID ON "Order Details"(OrderID);
 
 
 CREATE  INDEX OrdersOrder_Details ON "Order Details"(OrderID);
 
 
 CREATE  INDEX ProductID ON "Order Details"(ProductID);
 
 
 CREATE  INDEX ProductsOrder_Details ON "Order Details"(ProductID);
 



create view "Customer and Suppliers by City" AS
SELECT City, CompanyName, ContactName, 'Customers' AS Relationship 
FROM Customers
UNION SELECT City, CompanyName, ContactName, 'Suppliers'
FROM Suppliers;

 


create view "Alphabetical list of products" AS
SELECT Products.*, Categories.CategoryName
FROM Categories INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
WHERE (((Products.Discontinued)=0));

create view "Current Product List" AS
SELECT Product_List.ProductID, Product_List.ProductName
FROM Products AS Product_List
WHERE (((Product_List.Discontinued)=0));


create view "Orders Qry" AS
SELECT Orders.OrderID, Orders.CustomerID, Orders.EmployeeID, Orders.OrderDate, Orders.RequiredDate, 
	Orders.ShippedDate, Orders.ShipVia, Orders.Freight, Orders.ShipName, Orders.ShipAddress, Orders.ShipCity, 
	Orders.ShipRegion, Orders.ShipPostalCode, Orders.ShipCountry, 
	Customers.CompanyName, Customers.Address, Customers.City, Customers.Region, Customers.PostalCode, Customers.Country
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
 


create view "Products Above Average Price" AS
SELECT Products.ProductName, Products.UnitPrice
FROM Products
WHERE Products.UnitPrice>(SELECT AVG(UnitPrice) From Products);

 


create view "Products by Category" AS
SELECT Categories.CategoryName, Products.ProductName, Products.QuantityPerUnit, Products.UnitsInStock, Products.Discontinued
FROM Categories INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
WHERE Products.Discontinued <> 1;

 


create view "Quarterly Orders" AS
SELECT DISTINCT Customers.CustomerID, Customers.CompanyName, Customers.City, Customers.Country
FROM Customers RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderDate BETWEEN '19970101' And '19971231';
 


create view Invoices AS
SELECT Orders.ShipName, Orders.ShipAddress, Orders.ShipCity, Orders.ShipRegion, Orders.ShipPostalCode, 
	Orders.ShipCountry, Orders.CustomerID, Customers.CompanyName AS CustomerName, Customers.Address, Customers.City, 
	Customers.Region, Customers.PostalCode, Customers.Country, 
	(FirstName || ' ' || LastName) AS Salesperson, 
	Orders.OrderID, Orders.OrderDate, Orders.RequiredDate, Orders.ShippedDate, Shippers.CompanyName As ShipperName, 
	"Order Details".ProductID, Products.ProductName, "Order Details".UnitPrice, "Order Details".Quantity, 
	"Order Details".Discount, 
	(CAST(("Order Details".UnitPrice*Quantity*(1-Discount)/100) AS int)*100) AS ExtendedPrice, Orders.Freight
FROM 	Shippers INNER JOIN 
		(Products INNER JOIN 
			(
				(Employees INNER JOIN 
					(Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID) 
				ON Employees.EmployeeID = Orders.EmployeeID) 
			INNER JOIN "Order Details" ON Orders.OrderID = "Order Details".OrderID) 
		ON Products.ProductID = "Order Details".ProductID) 
	ON Shippers.ShipperID = Orders.ShipVia;


create view "Order Details Extended" AS
SELECT "Order Details".OrderID, "Order Details".ProductID, Products.ProductName, 
	"Order Details".UnitPrice, "Order Details".Quantity, "Order Details".Discount, 
	(CAST(("Order Details".UnitPrice*Quantity*(1-Discount)/100) AS int)*100) AS ExtendedPrice
FROM Products INNER JOIN "Order Details" ON Products.ProductID = "Order Details".ProductID;

 


create view "Order Subtotals" AS
SELECT "Order Details".OrderID, Sum(CAST(("Order Details".UnitPrice*Quantity*(1-Discount)/100) AS int)*100) AS Subtotal
FROM "Order Details"
GROUP BY "Order Details".OrderID;
 


create view "Product Sales for 1997" AS
SELECT Categories.CategoryName, Products.ProductName, 
Sum(CAST(("Order Details".UnitPrice*Quantity*(1-Discount)/100) AS int)*100) AS ProductSales
FROM (Categories INNER JOIN Products ON Categories.CategoryID = Products.CategoryID) 
	INNER JOIN (Orders 
		INNER JOIN "Order Details" ON Orders.OrderID = "Order Details".OrderID) 
	ON Products.ProductID = "Order Details".ProductID
WHERE (((Orders.ShippedDate) Between '19970101' And '19971231'))
GROUP BY Categories.CategoryName, Products.ProductName;
 


create view "Category Sales for 1997" AS
SELECT "Product Sales for 1997".CategoryName, Sum("Product Sales for 1997".ProductSales) AS CategorySales
FROM "Product Sales for 1997"
GROUP BY "Product Sales for 1997".CategoryName;
 


create view "Sales by Category" AS
SELECT Categories.CategoryID, Categories.CategoryName, Products.ProductName, 
	Sum("Order Details Extended".ExtendedPrice) AS ProductSales
FROM 	Categories INNER JOIN 
		(Products INNER JOIN 
			(Orders INNER JOIN "Order Details Extended" ON Orders.OrderID = "Order Details Extended".OrderID) 
		ON Products.ProductID = "Order Details Extended".ProductID) 
	ON Categories.CategoryID = Products.CategoryID
WHERE Orders.OrderDate BETWEEN '19970101' And '19971231'
GROUP BY Categories.CategoryID, Categories.CategoryName, Products.ProductName;

 


create view "Sales Totals by Amount" AS
SELECT "Order Subtotals".Subtotal AS SaleAmount, Orders.OrderID, Customers.CompanyName, Orders.ShippedDate
FROM 	Customers INNER JOIN 
		(Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID) 
	ON Customers.CustomerID = Orders.CustomerID
WHERE ("Order Subtotals".Subtotal >2500) AND (Orders.ShippedDate BETWEEN '19970101' And '19971231');
 


create view "Summary of Sales by Quarter" AS
SELECT Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal
FROM Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID
WHERE Orders.ShippedDate IS NOT NULL;

 


create view "Summary of Sales by Year" AS
SELECT Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal
FROM Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID
WHERE Orders.ShippedDate IS NOT NULL;

 


create or replace procedure "Ten Most Expensive Products" (out cur refcursor) AS $$
begin
SET ROWCOUNT to 10;
OPEN cur FOR SELECT Products.ProductName AS TenMostExpensiveProducts, Products.UnitPrice
FROM Products
ORDER BY Products.UnitPrice DESC;
END;
$$ language plpgsql;


create or replace procedure "Employee Sales by Country" ( 
p_Beginning_Date TIMESTAMP(3), p_Ending_Date TIMESTAMP(3), out cur refcursor) AS $$
begin
OPEN cur FOR SELECT Employees.Country, Employees.LastName, Employees.FirstName, Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal AS SaleAmount
FROM Employees INNER JOIN 
	(Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID) 
	ON Employees.EmployeeID = Orders.EmployeeID
WHERE Orders.ShippedDate Between p_Beginning_Date And p_Ending_Date;
END;
$$ language plpgsql;


create or replace procedure "Sales by Year" ( 
	p_Beginning_Date TIMESTAMP(3), p_Ending_Date TIMESTAMP(3), out cur refcursor) AS $$
begin
OPEN cur FOR SELECT Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal, TO_CHAR(ShippedDate, 'YYYY') AS Year
FROM Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID
WHERE Orders.ShippedDate Between p_Beginning_Date And p_Ending_Date;
END;
$$ language plpgsql;

 


