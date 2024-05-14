-- Create library database 
Create DATABASE Customers_details ;
GO

--Access the new customers table 
USE Customers ;
Go

--create the Customers table
create table customers(
customer_id INT PRIMARY KEY, 
name varchar(70) , 
address varchar(50),
);
GO

--create the products table
create table products(
product_id INT PRIMARY KEY, 
name varchar(70) , 
price decimal,
);
GO

--create the orders table
create table orders(
order_id INT PRIMARY KEY, 
customer_id INT , 
product_id INT,
quantity INT,
order_date date , 
);
GO

--add maximum constraints
Alter Table products
add constraint CHK_Price CHECK (Price > 0);
GO 

--add foreign key constraints to author_id column
Alter Table orders
Add constraint for_key FOREIGN KEY (customer_id) References customers (customer_id);
GO 

--add foreign key constraints to author_id column
Alter Table orders
Add constraint for2_key FOREIGN KEY (product_id) References products (product_id);