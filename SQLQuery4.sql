use OnlineStore;
create table Suppliers(
SupplierId int Primary Key,
Name varchar(20) Not null,
country varchar(20),
Email varchar(30),
Address varchar(50) Not null,
ContactNumber varchar(20) Not null
)
create table Categories(
CategoryId int Primary Key,
CategoryName varchar(20) Not null,
Description varchar(50)
)

create table Customer(
CustomerId int Primary Key,
Name varchar(20) Not null,
Email varchar(30),
Address varchar(50) Not null,
Phone varchar(20) Not null
)

create table Payments(
paymentId int Primary Key,
PaymentDate Date,
Amount decimal(10,2),
Status varchar(20),
Method varchar(20)
)

create table Products(
productId int Primary Key,
Name varchar(20) Not null,
Description varchar(50),
Price decimal(10,2),
StockQuantity int,
CategoryId INT,
CONSTRAINT FK_CategoryId
FOREIGN KEY (CategoryId)
REFERENCES Categories(CategoryId)
)

create table Orders(
OrderId int Primary Key,
Status varchar(20),
TotalAmount decimal(10,2),
OrderDate Date,
CustomerId INT,
CONSTRAINT FK_CustomerId
FOREIGN KEY (CustomerId)
REFERENCES Customer(CustomerID)
)

create table OrderItems(
OrderItemId int Primary Key,
Quantity int,
UnitPrice decimal(10,2),

OrderId INT,
CONSTRAINT FK_OrderId
FOREIGN KEY (OrderId)
REFERENCES Orders(OrderId),

ProductId INT,
CONSTRAINT FK_ProductId
FOREIGN KEY (ProductId)
REFERENCES products(ProductId)
)

CREATE TABLE Reviews
(
    ReviewId INT PRIMARY KEY,
    Rating INT,
    Date DATE,
    Comment VARCHAR(200),

    ProductId INT,
    CONSTRAINT FK_Reviews_Products
        FOREIGN KEY (ProductId)
        REFERENCES Products(ProductId),

    CustomerId INT,
    CONSTRAINT FK_Reviews_Customer
        FOREIGN KEY (CustomerId)
        REFERENCES Customer(CustomerId)
)

CREATE TABLE StockTransactions
(
    TranId INT PRIMARY KEY,
    TranDate DATE,
    QuantityChange INT,
    Type VARCHAR(20),
    Reference VARCHAR(100),

    ProductId INT,
    CONSTRAINT FK_StockTransactions_Products
        FOREIGN KEY (ProductId)
        REFERENCES Products(ProductId)
)

CREATE TABLE Orders_Payments
(
    OrderId INT,
    PaymentId INT,

    CONSTRAINT PK_Orders_Payments
        PRIMARY KEY (OrderId, PaymentId),

    CONSTRAINT FK_Orders_Payments_Orders
        FOREIGN KEY (OrderId)
        REFERENCES Orders(OrderId),

    CONSTRAINT FK_Orders_Payments_Payments
        FOREIGN KEY (PaymentId)
        REFERENCES Payments(PaymentId)
)

CREATE TABLE Shipments
(
    ShipmentId INT PRIMARY KEY,
    ShipmentDate DATE,
    Status VARCHAR(20),
    DeliveryDate DATE,
    CarrierName VARCHAR(50),
    TrackingNumber VARCHAR(50),

    OrderId INT,
    CONSTRAINT FK_Shipments_Orders
        FOREIGN KEY (OrderId)
        REFERENCES Orders(OrderId)
)

CREATE TABLE Products_Suppliers
(
    SupplierId INT,
    ProductId INT,

    CONSTRAINT PK_Products_Suppliers
        PRIMARY KEY (SupplierId, ProductId),

    CONSTRAINT FK_Products_Suppliers_Suppliers
        FOREIGN KEY (SupplierId)
        REFERENCES Suppliers(SupplierId),

    CONSTRAINT FK_Products_Suppliers_Products
        FOREIGN KEY (ProductId)
        REFERENCES Products(ProductId)
);