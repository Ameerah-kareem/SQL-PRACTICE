-- Create Checkpoint database 
Create DATABASE Checkpoints;
GO

--Access the new library 
USE Checkpoints ;
Go

--create the Products table
create table Products(
product_id INT Primary key,
Name varchar(50), 
price decimal, 
);
GO

--create the Customers table
create table Customers(
customer_id INT PRIMARY KEY , 
Name varchar(50), 
address varchar(70), 
);
GO

--create the Orders table
create table Orders(
customer_id INT , 
product_id INT ,
quantity INT, 
order_date DATE, 
);
GO

INSERT INTO products( product_id, name, price)
VALUES (1, 'Cookies', 10),
(2, 'candy', 5.2);
go 

INSERT INTO customers(customer_id, name, address)
VALUES (1, 'Ahmed', 'Tunisia'),
(2, 'coulibaly', 'Senegal'),
(3, 'Hasan', 'Egypt')
;
go 

insert into Orders(customer_id, product_id, quantity, order_date)
values (1, 2, 3, '2023-01-22'),
(2, 1, 10, '2023-04-14')
;
go

--add foreign key constraints to orders table 
Alter Table orders 
Add constraint for_key FOREIGN KEY (customer_id) references customers (customer_id)
;
go 

--add foreign key constraints to orders table 
Alter Table orders 
Add constraint for_key2 FOREIGN KEY (product_id) references products (product_id)
;
go 

UPDATE Orders
SET Quantity = 6
WHERE order_date = '2023-04-14' 
;
go

select * from Orders
go 

--deleting the third customer 
DELETE FROM customers where customer_id = 3 
;
go 

select * from customers 
go 

--deleting the orders then drop the table
delete from orders
;
go 

drop Table Orders
;
go 

--END 