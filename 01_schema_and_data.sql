DROP VIEW IF EXISTS vw_order_summary;

DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS delivery_partners;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50) NOT NULL,
    signup_date DATE NOT NULL
);

CREATE TABLE restaurants (
    restaurant_id SERIAL PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    cuisine_type VARCHAR(50) NOT NULL,
    average_rating NUMERIC(3, 2) CHECK (average_rating BETWEEN 0 AND 5),
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE delivery_partners (
    partner_id SERIAL PRIMARY KEY,
    partner_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL,
    joining_date DATE NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Active', 'Inactive')) DEFAULT 'Active'
);

CREATE TABLE menu_items (
    item_id SERIAL PRIMARY KEY,
    restaurant_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price > 0),
    is_available BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_menu_restaurant
        FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    partner_id INT,
    order_date TIMESTAMP NOT NULL,
    order_status VARCHAR(20) NOT NULL CHECK (
        order_status IN ('Delivered', 'Cancelled', 'Preparing', 'Out for Delivery')
    ),
    delivery_time_minutes INT CHECK (delivery_time_minutes >= 0),
    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    CONSTRAINT fk_order_restaurant
        FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id),
    CONSTRAINT fk_order_partner
        FOREIGN KEY (partner_id)
        REFERENCES delivery_partners(partner_id)
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    item_price NUMERIC(10, 2) NOT NULL CHECK (item_price > 0),
    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    CONSTRAINT fk_order_items_item
        FOREIGN KEY (item_id)
        REFERENCES menu_items(item_id)
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    payment_method VARCHAR(30) NOT NULL CHECK (
        payment_method IN ('UPI', 'Card', 'Cash', 'Wallet')
    ),
    payment_status VARCHAR(20) NOT NULL CHECK (
        payment_status IN ('Success', 'Failed', 'Refunded')
    ),
    amount NUMERIC(10, 2) NOT NULL CHECK (amount >= 0),
    payment_date TIMESTAMP NOT NULL,
    CONSTRAINT fk_payment_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

CREATE TABLE ratings (
    rating_id SERIAL PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    food_rating INT CHECK (food_rating BETWEEN 1 AND 5),
    delivery_rating INT CHECK (delivery_rating BETWEEN 1 AND 5),
    review_text TEXT,
    rating_date DATE NOT NULL,
    CONSTRAINT fk_rating_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    CONSTRAINT fk_rating_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    CONSTRAINT fk_rating_restaurant
        FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
);

INSERT INTO customers (customer_name, phone, email, city, signup_date) VALUES
('Aarav Sharma', '9000000001', 'aarav@example.com', 'Delhi', '2026-01-10'),
('Priya Verma', '9000000002', 'priya@example.com', 'Mumbai', '2026-01-15'),
('Rahul Mehta', '9000000003', 'rahul@example.com', 'Delhi', '2026-02-01'),
('Sneha Iyer', '9000000004', 'sneha@example.com', 'Bengaluru', '2026-02-12'),
('Karan Malhotra', '9000000005', 'karan@example.com', 'Mumbai', '2026-03-05'),
('Neha Singh', '9000000006', 'neha@example.com', 'Delhi', '2026-03-18'),
('Vikram Rao', '9000000007', 'vikram@example.com', 'Bengaluru', '2026-04-02'),
('Ananya Das', '9000000008', 'ananya@example.com', 'Kolkata', '2026-04-11'),
('Rohit Nair', '9000000009', 'rohit@example.com', 'Chennai', '2026-05-03'),
('Meera Kapoor', '9000000010', 'meera@example.com', 'Delhi', '2026-05-19'),
('Ishaan Gupta', '9000000011', 'ishaan@example.com', 'Pune', '2026-06-01'),
('Tanya Joshi', '9000000012', 'tanya@example.com', 'Mumbai', '2026-06-14');

INSERT INTO restaurants (restaurant_name, city, cuisine_type, average_rating, is_active) VALUES
('Spice Junction', 'Delhi', 'North Indian', 4.40, TRUE),
('Pizza Planet', 'Mumbai', 'Italian', 4.10, TRUE),
('Dosa House', 'Bengaluru', 'South Indian', 4.60, TRUE),
('Burger Bay', 'Delhi', 'Fast Food', 3.90, TRUE),
('Biryani Bowl', 'Hyderabad', 'Biryani', 4.50, TRUE),
('Tandoori Treats', 'Mumbai', 'North Indian', 4.20, TRUE),
('Noodle Nest', 'Kolkata', 'Chinese', 3.80, TRUE),
('Healthy Bites', 'Pune', 'Healthy', 4.00, TRUE);

INSERT INTO delivery_partners (partner_name, phone, city, joining_date, status) VALUES
('Ramesh Kumar', '8000000001', 'Delhi', '2025-11-10', 'Active'),
('Suresh Yadav', '8000000002', 'Mumbai', '2025-12-01', 'Active'),
('Imran Khan', '8000000003', 'Bengaluru', '2026-01-20', 'Active'),
('Arjun Patel', '8000000004', 'Delhi', '2026-02-14', 'Active'),
('Manoj Das', '8000000005', 'Kolkata', '2026-03-09', 'Inactive'),
('Nikhil Jain', '8000000006', 'Pune', '2026-04-23', 'Active');

INSERT INTO menu_items (restaurant_id, item_name, category, price, is_available) VALUES
(1, 'Paneer Butter Masala', 'Main Course', 260.00, TRUE),
(1, 'Butter Naan', 'Bread', 45.00, TRUE),
(1, 'Veg Thali', 'Combo', 220.00, TRUE),
(2, 'Margherita Pizza', 'Pizza', 299.00, TRUE),
(2, 'Farmhouse Pizza', 'Pizza', 399.00, TRUE),
(2, 'Garlic Bread', 'Starter', 149.00, TRUE),
(3, 'Masala Dosa', 'Dosa', 140.00, TRUE),
(3, 'Idli Sambar', 'Breakfast', 90.00, TRUE),
(3, 'Filter Coffee', 'Beverage', 60.00, TRUE),
(4, 'Classic Burger', 'Burger', 180.00, TRUE),
(4, 'French Fries', 'Side', 120.00, TRUE),
(4, 'Cold Coffee', 'Beverage', 110.00, TRUE),
(5, 'Chicken Biryani', 'Biryani', 320.00, TRUE),
(5, 'Veg Biryani', 'Biryani', 240.00, TRUE),
(5, 'Raita', 'Side', 50.00, TRUE),
(6, 'Chicken Tikka', 'Starter', 280.00, TRUE),
(6, 'Dal Makhani', 'Main Course', 230.00, TRUE),
(7, 'Hakka Noodles', 'Noodles', 210.00, TRUE),
(7, 'Chilli Paneer', 'Starter', 250.00, TRUE),
(8, 'Quinoa Bowl', 'Healthy Bowl', 310.00, TRUE),
(8, 'Fruit Salad', 'Dessert', 160.00, FALSE);

INSERT INTO orders (customer_id, restaurant_id, partner_id, order_date, order_status, delivery_time_minutes) VALUES
(1, 1, 1, '2026-06-01 12:30:00', 'Delivered', 32),
(2, 2, 2, '2026-06-02 19:15:00', 'Delivered', 41),
(3, 1, 4, '2026-06-05 13:05:00', 'Delivered', 28),
(4, 3, 3, '2026-06-07 09:20:00', 'Delivered', 24),
(5, 2, 2, '2026-06-09 20:40:00', 'Cancelled', NULL),
(6, 4, 1, '2026-06-10 18:30:00', 'Delivered', 36),
(7, 3, 3, '2026-06-13 08:45:00', 'Delivered', 22),
(8, 7, 5, '2026-06-15 21:00:00', 'Delivered', 48),
(9, 5, NULL, '2026-07-01 14:10:00', 'Cancelled', NULL),
(10, 1, 4, '2026-07-03 13:30:00', 'Delivered', 31),
(11, 8, 6, '2026-07-05 11:45:00', 'Delivered', 27),
(12, 6, 2, '2026-07-06 20:15:00', 'Delivered', 39),
(1, 4, 1, '2026-07-08 18:05:00', 'Delivered', 35),
(3, 5, 4, '2026-07-10 21:25:00', 'Delivered', 44),
(4, 3, 3, '2026-07-12 10:00:00', 'Delivered', 21),
(6, 1, 1, '2026-07-15 12:50:00', 'Out for Delivery', 18),
(2, 6, 2, '2026-07-18 19:40:00', 'Delivered', 42),
(5, 2, 2, '2026-07-20 20:00:00', 'Delivered', 38),
(8, 7, 5, '2026-07-22 21:15:00', 'Delivered', 51),
(10, 8, 6, '2026-07-25 12:10:00', 'Preparing', NULL);

INSERT INTO order_items (order_id, item_id, quantity, item_price) VALUES
(1, 1, 1, 260.00),
(1, 2, 3, 45.00),
(2, 4, 1, 299.00),
(2, 6, 1, 149.00),
(3, 3, 2, 220.00),
(4, 7, 1, 140.00),
(4, 9, 2, 60.00),
(5, 5, 1, 399.00),
(6, 10, 2, 180.00),
(6, 11, 1, 120.00),
(7, 8, 3, 90.00),
(8, 18, 1, 210.00),
(8, 19, 1, 250.00),
(9, 13, 1, 320.00),
(10, 1, 1, 260.00),
(10, 2, 2, 45.00),
(11, 20, 1, 310.00),
(12, 16, 1, 280.00),
(12, 17, 1, 230.00),
(13, 10, 1, 180.00),
(13, 12, 1, 110.00),
(14, 13, 2, 320.00),
(14, 15, 2, 50.00),
(15, 7, 2, 140.00),
(15, 9, 1, 60.00),
(16, 3, 1, 220.00),
(17, 16, 2, 280.00),
(18, 5, 1, 399.00),
(18, 6, 1, 149.00),
(19, 18, 2, 210.00),
(20, 20, 2, 310.00);

INSERT INTO payments (order_id, payment_method, payment_status, amount, payment_date) VALUES
(1, 'UPI', 'Success', 395.00, '2026-06-01 12:31:00'),
(2, 'Card', 'Success', 448.00, '2026-06-02 19:16:00'),
(3, 'UPI', 'Success', 440.00, '2026-06-05 13:06:00'),
(4, 'Wallet', 'Success', 260.00, '2026-06-07 09:21:00'),
(5, 'UPI', 'Refunded', 399.00, '2026-06-09 20:41:00'),
(6, 'Cash', 'Success', 480.00, '2026-06-10 18:31:00'),
(7, 'UPI', 'Success', 270.00, '2026-06-13 08:46:00'),
(8, 'Card', 'Success', 460.00, '2026-06-15 21:01:00'),
(9, 'Wallet', 'Failed', 320.00, '2026-07-01 14:11:00'),
(10, 'UPI', 'Success', 350.00, '2026-07-03 13:31:00'),
(11, 'Card', 'Success', 310.00, '2026-07-05 11:46:00'),
(12, 'UPI', 'Success', 510.00, '2026-07-06 20:16:00'),
(13, 'Cash', 'Success', 290.00, '2026-07-08 18:06:00'),
(14, 'UPI', 'Success', 740.00, '2026-07-10 21:26:00'),
(15, 'Wallet', 'Success', 340.00, '2026-07-12 10:01:00'),
(16, 'UPI', 'Success', 220.00, '2026-07-15 12:51:00'),
(17, 'Card', 'Success', 560.00, '2026-07-18 19:41:00'),
(18, 'UPI', 'Success', 548.00, '2026-07-20 20:01:00'),
(19, 'Wallet', 'Success', 420.00, '2026-07-22 21:16:00'),
(20, 'UPI', 'Success', 620.00, '2026-07-25 12:11:00');

INSERT INTO ratings (order_id, customer_id, restaurant_id, food_rating, delivery_rating, review_text, rating_date) VALUES
(1, 1, 1, 5, 4, 'Good food and quick delivery', '2026-06-01'),
(2, 2, 2, 4, 4, 'Pizza was fresh', '2026-06-02'),
(3, 3, 1, 5, 5, 'Excellent thali', '2026-06-05'),
(4, 4, 3, 5, 5, 'Very tasty dosa', '2026-06-07'),
(6, 6, 4, 3, 4, 'Average burger', '2026-06-10'),
(7, 7, 3, 4, 5, 'Nice breakfast', '2026-06-13'),
(8, 8, 7, 3, 3, 'Late but okay', '2026-06-15'),
(10, 10, 1, 4, 4, 'Good north Indian food', '2026-07-03'),
(11, 11, 8, 4, 5, 'Healthy and fresh', '2026-07-05'),
(12, 12, 6, 5, 4, 'Tikka was great', '2026-07-06'),
(13, 1, 4, 4, 4, 'Good snacks', '2026-07-08'),
(14, 3, 5, 5, 4, 'Best biryani', '2026-07-10'),
(15, 4, 3, 5, 5, 'Always reliable', '2026-07-12'),
(17, 2, 6, 4, 4, 'Good dinner', '2026-07-18'),
(18, 5, 2, 4, 3, 'Good pizza', '2026-07-20'),
(19, 8, 7, 3, 3, 'Could improve', '2026-07-22');

CREATE VIEW vw_order_summary AS
SELECT
    o.order_id,
    c.customer_name,
    c.city AS customer_city,
    r.restaurant_name,
    r.cuisine_type,
    dp.partner_name,
    o.order_date,
    o.order_status,
    o.delivery_time_minutes,
    p.payment_method,
    p.payment_status,
    p.amount
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
LEFT JOIN delivery_partners dp
    ON o.partner_id = dp.partner_id
JOIN payments p
    ON o.order_id = p.order_id;

