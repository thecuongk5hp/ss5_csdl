
CREATE DATABASE ss5; 
USE ss5;

-- Tạo bảng customers
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY, -- Khóa chính
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255)
);

-- Tạo bảng orders
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY, -- Khóa chính
    customer_id INT, -- Khóa ngoại
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) -- Liên kết với bảng customers
);

-- Thêm bản ghi vào bảng customers
INSERT INTO customers (name, email, phone, address)
VALUES
('Nguyen Van An', 'nguyenvanan@example.com', '0901234567', '123 Le Loi, TP.HCM'),
('Tran Thi Bich', 'tranthibich@example.com', '0912345678', '456 Nguyen Hue, TP.HCM'),
('Le Van Cuong', 'levancuong@example.com', '0923456789', '789 Dien Bien Phu, Ha Noi');

-- Thêm bản ghi vào bảng orders
INSERT INTO orders (customer_id, order_date, total_amount, status)
VALUES
(1, '2025-01-10', 500000, 'Pending'),
(1, '2025-01-12', 325000, 'Completed'),
(NULL, '2025-01-13', 450000, 'Cancelled'),
(3, '2025-01-14', 270000, 'Pending'),
(2, '2025-01-16', 850000, NULL);

-- 2  Viết câu lệnh truy vấn để lấy toàn bộ dữ liệu từ bảng orders và bảng customers, bao gồm cả những đơn hàng không có khách hàng liên kết, sao cho kết quả trả về có dạng như bảng sau:
SELECT 
    orders.order_id, 
    orders.order_date, 
    orders.total_amount, 
    customers.name, 
    customers.email
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.customer_id;


-- 3  Viết câu lệnh truy vấn để lấy thông tin khách hàng (customer_id, name, phone) từ bảng customers và thông tin đơn hàng (order_id, status) từ bảng orders, bao gồm cả những khách hàng không có đơn hàng, sao cho kết quả trả về có dạng như bảng sau:
select c.customer_id , c.name , c.phone , o.order_id , o.status
from customers c
left join orders o 
ON c.customer_id = o.customer_id;

-- 4  Viết câu lệnh truy vấn để lấy thông tin khách hàng (customer_id, name) và thông tin đơn hàng (order_id, total_amount, order_date), chỉ hiển thị những đơn hàng có liên kết với khách hàng, sao cho kết quả trả về có dạng như bảng sau:
SELECT 
    customers.customer_id, 
    customers.name, 
    orders.order_id, 
    orders.total_amount, 
    orders.order_date
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id;
