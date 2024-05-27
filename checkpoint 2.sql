create database checkpoint2 
go 

use checkpoint2

create table customer(
customer_id INT PRIMARY KEY , 
customer_name varchar(80),
customer_tel varchar(50)
);
go 

create table product(
product_id INT PRIMARY KEY, 
product_name varchar(80),
category varchar (80),
price varchar(50)
); 
go 

create table orders(
customer_id INT,
product_id INT,
OrderDate varchar(80),
quantity varchar(80),
total_amount varchar(80)
);
go 

alter table orders
add constraint for_key FOREIGN KEY(customer_id) REFERENCES customer(customer_id);
go 


alter table orders
add constraint for_key2  FOREIGN KEY(product_id) REFERENCES product(product_id);
go 

INSERT INTO customer (customer_id, customer_name, customer_tel) VALUES (1, 'Adesewa Joy', '+2348009657101'),
(2, 'Patricia Herrera', '+2348058873737'),
(3, 'Holly Williams', '+2349515347854'),
(4, 'Ryan Hickman', '+2342118745678'),
(5, 'Eric', '+2344003456789'),
(6, 'Terry', '+2345001234567'),
(7, 'Bobby', '+2346007890123'),
(8, 'Adesewa Joy', '+2347003456789'),
(9, 'Patricia Villages', '+2348004567890'),
(10, 'Holly Williams', '+2349001234567'),
(11, 'Ryan Hickman', '+2341002345678'),
(12, 'Erica', '+2341103456789'),
(13, 'Tunde', '+2341204567890'),
(14, 'Nneka', '+2341301234567'),
(15, 'Chidi', '+2341402345678');
GO 

INSERT INTO product  (product_id, product_name, category,price) VALUES (1, 'Earbuds', 'gadget', '10000'),
(2, 'Smartwatch', 'widget', '20000'),
(3, 'Wireless Earbuds', 'gadget', '15000'),
(4, 'Power Bank', 'widget', '8000'),
(5, 'Fitness Tracker', 'gadget', '12000'),
(6, 'Virtual Reality Headset', 'widget', '30000'),
(7, 'Noise-Cancelling Headphones', 'gadget', '25000'),
(8, 'Smart Speaker', 'widget', '18000'),
(9, 'Gaming Laptop', 'gadget', '40000'),
(10, 'Portable Bluetooth Speaker', 'widget', '10000'),
(11, 'Smart Home Security System', 'gadget', '35000'),
(12, 'Wireless Charging Pad', 'widget', '5000'),
(13, '4K Ultra HD TV', 'gadget', '60000'),
(14, 'Robot Vacuum Cleaner', 'widget', '45000'),
(15, 'Smartphone Case', 'widget', '5000');
GO 

UPDATE product
SET product_name = 'Doohickeys'
WHERE product_id = 1 ;
GO 

UPDATE product
SET product_name = 'Doohickeys'
WHERE product_id = 12;
GO 

select * from product

ALTER TABLE orders
ALTER COLUMN Total_Amount INT;

ALTER TABLE orders
ALTER COLUMN quantity  INT;
go 

ALTER TABLE orders
ALTER COLUMN OrderDate  Date;


INSERT INTO orders (customer_id, product_id, OrderDate,quantity,total_amount) VALUES (1, 1, '2022-05-25' , 50, 250000),
(2, 2, '2024-05-25', 20, 40000),
(3, 3, '2023-03-15', 30, 45000),
(4, 1, '2022-02-10', 40, 200000),
(5, 4, '2021-08-28', 25, 37500),
(6, 5, '2020-11-12', 35, 52500),
(7, 2, '2023-06-05', 45, 90000),
(8, 6, '2022-01-22', 20, 30000),
(9, 3, '2021-04-18', 50, 75000),
(10, 7, '2020-09-08', 30, 45000),
(11, 8, '2023-07-25', 40, 60000),
(12, 4, '2022-10-15', 25, 37500),
(13, 9, '2021-05-01', 35, 52500),
(14, 10,'2024-03-12', 45, 90000),
(15, 5, '2023-02-28', 20, 30000);
go 


select * from customer

--Write a SQL query to retrieve the names of the customers who have placed an order for at least one widget and at least one gadget, along with the total cost of the widgets and gadgets ordered by each customer. The cost of each item should be calculated by multiplying the quantity by the price of the product.
SELECT customer_name,
  SUM(CASE WHEN product.category = 'Widget' THEN orders.quantity * product.price ELSE 0 END) AS total_widget_cost,
  SUM(CASE WHEN product.category = 'Gadget' THEN orders.quantity * product.price ELSE 0 END) AS total_gadget_cost
FROM 
  customer 
  JOIN orders ON customer.customer_id = orders.customer_id
  JOIN product ON orders.product_id = product.product_id
WHERE 
  product.category IN ('Widget', 'Gadget')
GROUP BY customer_name
HAVING 
  COUNT(DISTINCT CASE WHEN product.category = 'Widget' THEN 1 ELSE NULL END) > 0
  AND COUNT(DISTINCT CASE WHEN product.category = 'Gadget' THEN 1 ELSE NULL END) > 0
  ;
  go 

  --Write a query to retrieve the names of the customers who have placed an order for at least one widget, along with the total cost of the widgets ordered by each customer.
  SELECT customer_name,
  SUM(orders.quantity * product.price) AS total_widget_cost
FROM 
  customer
  INNER JOIN orders  ON customer.customer_id = orders.customer_id
  INNER JOIN product ON orders.product_id = product.product_id
WHERE 
  product.category = 'Widget'
GROUP BY customer_name
;
go 

 --Write a query to retrieve the names of the customers who have placed an order for at least one gadget, along with the total cost of the gadgets ordered by each customer.
 SELECT customer_name,
  SUM(orders.quantity * product.price) AS total_gadget_cost
FROM 
  customer
  INNER JOIN orders  ON customer.customer_id = orders.customer_id
  INNER JOIN product ON orders.product_id = product.product_id
WHERE 
  product.category = 'Gadget'
GROUP BY customer_name
;
go 

--Write a query to retrieve the names of the customers who have placed an order for at least one doohickey, along with the total cost of the doohickeys ordered by each customer.
SELECT customer_name,
  SUM(orders.quantity * product.price) AS total_doohickey_cost
FROM 
  customer
  INNER JOIN orders  ON customer.customer_id = orders.customer_id
  INNER JOIN product ON orders.product_id = product.product_id
WHERE 
  product.product_name = 'doohickeys'
GROUP BY customer_name
;
go 

--Write a query to retrieve the total number of widgets and gadgets ordered by each customer, along with the total cost of the orders.
SELECT 
  customer_name,
  SUM(CASE WHEN product.category = 'Widget' THEN orders.quantity ELSE 0 END) AS total_widget_quantity,
  SUM(CASE WHEN product.category = 'Gadget' THEN orders.quantity ELSE 0 END) AS total_gadget_quantity,
  SUM(orders.quantity * product.price) AS total_cost
FROM 
  customer
  INNER JOIN orders  ON customer.customer_id = orders.customer_id
  INNER JOIN product ON orders.product_id = product.product_id
WHERE 
  product.category IN ('Widget', 'Gadget')
GROUP BY 
  customer_name;

  --Write a query to retrieve the names of the products that have been ordered by at least one customer, along with the total quantity of each product ordered.
SELECT product.product_name, SUM(orders.quantity) AS total_quantity
FROM orders
JOIN product ON orders.product_id = product.product_id
GROUP BY product.product_name;
go 

--Write a query to retrieve the names of the customers who have placed the most orders, along with the total number of orders placed by each customer.
SELECT TOP 1 customer_name, COUNT(*) as total_orders
FROM orders 
JOIN customer  ON orders.customer_id = customer.customer_id
GROUP BY customer.customer_name
ORDER BY total_orders DESC;
go 

--Write a query to retrieve the names of the products that have been ordered the most, along with the total quantity of each product ordered.
SELECT TOP 1 product.product_name, SUM(orders.quantity) as total_quantity
FROM orders 
JOIN product  ON orders.product_id = product.product_id
GROUP BY product.product_name
ORDER BY total_quantity DESC;
go 

--Write a query to retrieve the names of the customers who have placed an order on every day of the week, along with the total number of orders placed by each customer.
SELECT customer.customer_name, COUNT(DISTINCT orders.OrderDate) as total_days
FROM orders 
JOIN customer  ON orders.customer_id = customer.customer_id
GROUP BY customer.customer_name
HAVING COUNT(DISTINCT orders.OrderDate) = 7;
go 
