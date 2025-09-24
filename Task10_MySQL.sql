DROP DATABASE IF EXISTS EcommerceDB;
CREATE DATABASE EcommerceDB;
USE EcommerceDB;
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
INSERT INTO Customers (customer_name, email, city) VALUES
('Amit Sharma', 'amit@gmail.com', 'Mumbai'),
('Priya Verma', 'priya@gmail.com', 'Delhi'),
('Ravi Kumar', 'ravi@gmail.com', 'Pune'),
('Neha Singh', 'neha@gmail.com', 'Bangalore');
INSERT INTO Products (product_name, price) VALUES
('Laptop', 55000.00),
('Smartphone', 20000.00),
('Headphones', 3000.00),
('Smartwatch', 7000.00);
INSERT INTO Orders (customer_id, product_id, order_date) VALUES
(1, 1, '2025-09-01'),
(2, 2, '2025-09-02'),
(3, 3, '2025-09-05'),
(1, 2, '2025-09-06'),
(4, 4, '2025-09-07');
INSERT INTO Payments (order_id, amount, payment_date) VALUES
(1, 55000.00, '2025-09-01'),
(2, 20000.00, '2025-09-02'),
(3, 3000.00, '2025-09-05'),
(4, 20000.00, '2025-09-06'),
(5, 7000.00, '2025-09-07');
SELECT * FROM Customers;
SELECT * FROM Products;
SELECT o.order_id, o.order_date, c.customer_name, p.product_name
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id;
SELECT SUM(amount) AS total_sales
FROM Payments;
SELECT c.customer_name, SUM(pay.amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments pay ON o.order_id = pay.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 1;
SELECT p.product_name, COUNT(o.order_id) AS total_orders
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY total_orders DESC
LIMIT 1;
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month, SUM(pay.amount) AS total_sales
FROM Orders o
JOIN Payments pay ON o.order_id = pay.order_id
GROUP BY month
ORDER BY month;

