CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL
);
​
CREATE TABLE bike_codes (
    code TEXT NOT NULL PRIMARY KEY
      CHECK (code IN ('FLY', 'HAUL', 'SKIN', 'BUD')),
    msrp Numeric(10, 2) NOT NULL
);
​
CREATE TABLE bike_names (
    id SERIAL PRIMARY KEY,
    code TEXT NOT NULL REFERENCES bike_codes,
    bike_name TEXT NOT NULL
);
​
-- customer_id not customer, timestamp
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer INTEGER NOT NULL REFERENCES customers
);
-- id not sale_id, think about the table name, order_id not orders,
-- consider making sold_for NOT NULL and disregard "default case"
CREATE TABLE bikes_sold (
    sale_id SERIAL PRIMARY KEY,
    orders INTEGER NOT NULL REFERENCES orders,
    bike TEXT NOT NULL REFERENCES bike_codes,
    sold_for Numeric(10,2),
    notes TEXT
);
​
INSERT INTO customers (first_name, last_name) VALUES
    ('Ken', 'Yu'),
    ('Nico', 'Martinucci'),
    ('Elie', 'Schoppik');
​
INSERT INTO bike_codes (code, msrp) VALUES
    ('FLY', 500),
    ('HAUL', 600),
    ('SKIN', 700),
    ('BUD', 800);
​
INSERT INTO bike_names (code, bike_name) VALUES
    ('FLY', 'The Flyer'),
    ('HAUL', 'The Big Haul'),
    ('SKIN', 'The Skinny'),
    ('BUD', 'Big Buddy');
​
INSERT INTO orders (customer) VALUES
    (1),
    (2);
​
INSERT INTO bikes_sold (orders, bike, sold_for, notes) VALUES
    (1, 'FLY', NULL, NULL),
    (1, 'BUD', 200, 'got training wheels'),
    (2, 'SKIN', NULL, 'extra wide handlebars');
​
​
SELECT customers.first_name, COUNT(*),
        SUM(CASE WHEN bikes_sold.sold_for is not NULL THEN bikes_sold.sold_for ELSE bike_codes.msrp END)
    FROM customers
    JOIN orders ON orders.customer = customers.id
    JOIN bikes_sold ON bikes_sold.orders = orders.order_id
    JOIN bike_codes ON bike_codes.code = bikes_sold.bike
    GROUP BY customers.first_name;