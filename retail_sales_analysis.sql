CREATE TABLE Customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT,
    city TEXT
);

INSERT INTO Customers VALUES
(1, 'Aarav', 'Hyderabad'),
(2, 'Priya', 'Warangal'),
(3, 'Rahul', 'Vijayawada'),
(4, 'Sneha', 'Hyderabad'),
(5, 'Arjun', 'Chennai');
select * from customers;
CREATE TABLE Products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    unit_price REAL
);

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Headphones', 'Electronics', 2000),
(103, 'Mouse', 'Accessories', 800),
(104, 'Keyboard', 'Accessories', 1500),
(105, 'Office Chair', 'Furniture', 7000);
select * from products;
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date TEXT,
    status TEXT
);

INSERT INTO Orders VALUES
(1001, 1, '2026-01-05', 'Delivered'),
(1002, 2, '2026-01-12', 'Delivered'),
(1003, 3, '2026-01-18', 'Cancelled'),
(1004, 1, '2026-02-03', 'Delivered'),
(1005, 4, '2026-02-14', 'Delivered'),
(1006, 5, '2026-02-20', 'Pending'),
(1007, 2, '2026-03-02', 'Delivered'),
(1008, 3, '2026-03-10', 'Delivered');
select * from orders;
CREATE TABLE Order_Items (
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    unit_price REAL
);

INSERT INTO Order_Items VALUES
(1001, 101, 1, 55000),
(1001, 102, 2, 2000),
(1002, 105, 1, 7000),
(1002, 103, 2, 800),
(1003, 102, 1, 2000),
(1004, 107, 1, 25000),
(1004, 108, 1, 3000),
(1005, 106, 1, 10000),
(1005, 104, 2, 1500),
(1006, 101, 1, 55000),
(1007, 102, 3, 2000),
(1007, 103, 2, 800),
(1008, 105, 2, 7000),
(1008, 104, 1, 1500);
select * from Order_Items;
INSERT INTO Products VALUES
(106, 'Desk', 'Furniture', 10000),
(107, 'Phone', 'Electronics', 25000),
(108, 'Webcam', 'Electronics', 3000);
select* from products;
select* from order_items;
select order_id,product_id,quantity,unit_price,quantity*unit_price as item_total from order_items;



SELECT 100 AS test_value;
SELECT SUM(order_items.quantity * order_items.unit_price) as delivered_revenue
FROM orders
INNER JOIN order_items
ON orders.order_id = order_items.order_id
WHERE orders.status = 'Delivered';
select orders.customer_id,sum(order_items.quantity*order_items.unit_price) as total_revenue 
from orders 
inner join order_items 
ON orders.order_id = order_items.order_id
where orders.status='Delivered'
group by orders.customer_id;
select product_id,sum(quantity*unit_price)as total_revenue 
  from order_items 
  group by product_id;
select status,count(order_id) as order_count
from orders 
group by status;
SELECT
    strftime('%m', orders.order_date) AS month,
    SUM(order_items.quantity * order_items.unit_price) AS total_revenue
FROM orders
INNER JOIN order_items
    ON orders.order_id = order_items.order_id
WHERE orders.status = 'Delivered'
GROUP BY strftime('%m', orders.order_date)
ORDER BY month;
select product_id,sum(quantity*unit_price)as total_revenue
from order_items 
  group by product_id
order by total_revenue DESC;
select customers.customer_name,sum(order_items.quantity*order_items.unit_price) as total_revenue
  from order_items 
  inner join orders on order_items.order_id=orders.order_id 
  inner join customers 
  on customers.customer_id=orders.customer_id
where orders.status='Delivered'
group by customers.customer_name;
select products.category,sum(order_items.quantity*order_items.unit_price) as total_revenue
from order_items
inner join products 
on products.product_id=order_items.product_id
group by products.category
order by total_revenue desc;
select* from orders;
SELECT customers.customer_id, customers.customer_name
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
WHERE orders.customer_id IS NULL;
select customers.customer_id,sum(order_items.quantity*order_items.unit_price) as total_revenue
from customers
inner join orders
on customers.customer_id=orders.customer_id
inner join order_items
on orders.order_id=order_items.order_id
  where orders.status='Delivered'
  group by customers.customer_id
order by total_revenue DESC
limit 3;
select sum(order_items.quantity*order_items.unit_price) as total_revenue 
from orders
inner join order_items 
on orders.order_id=order_items.order_id 
where orders.status='Cancelled';
SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_orders,
    SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
    SUM(CASE WHEN status = 'Pending' THEN 1 ELSE 0 END) AS pending_orders,
    (
        SELECT SUM(oi.quantity * oi.unit_price)
        FROM Orders o
        INNER JOIN Order_Items oi
            ON o.order_id = oi.order_id
        WHERE o.status = 'Delivered'
    ) AS delivered_revenue
FROM Orders;
