SET XACT_ABORT ON;

BEGIN TRANSACTION;

CREATE TABLE customers (
    cust_id INT PRIMARY KEY,
    cust_firstname VARCHAR(50),
    cust_lastname VARCHAR(50)
);

CREATE TABLE address (
    address_id INT PRIMARY KEY,
    delivery_address1 VARCHAR(200),
    delivery_address2 VARCHAR(200),
    delivery_city VARCHAR(50),
    delivery_zipcode VARCHAR(20)
);

CREATE TABLE item (
    item_id VARCHAR(10) PRIMARY KEY,
    sku VARCHAR(20),
    item_name VARCHAR(50),
    item_category VARCHAR(50),
    item_size VARCHAR(20),
    item_price DECIMAL(5,2)
);

CREATE TABLE orders (
    row_id INT PRIMARY KEY,
    order_id VARCHAR(15),
    created_at DATETIME,
    item_id VARCHAR(10) REFERENCES item(item_id),
    quantity INT,
    cust_id INT REFERENCES customers(cust_id),
    delivery BIT,
    address_id INT REFERENCES address(address_id)
);

CREATE TABLE ingredient (
    ing_id VARCHAR(10) PRIMARY KEY,
    ing_name VARCHAR(100),
    ing_weight INT,
    ing_meas VARCHAR(20),
    ing_price DECIMAL(5,2)
);

CREATE TABLE recipe (
    row_id INT PRIMARY KEY,
    recipe_id VARCHAR(200),
    ing_id VARCHAR(10) REFERENCES ingredient(ing_id),
    quantity INT
);

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    item_id VARCHAR(10) REFERENCES item(item_id),
    quantity INT
);

CREATE TABLE staff (
    staff_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    position VARCHAR(100),
    hourly_rate DECIMAL(5,2)
);

CREATE TABLE shift (
    shift_id VARCHAR(20) PRIMARY KEY,
    day_of_week VARCHAR(10),
    start_time TIME,
    end_time TIME
);

CREATE TABLE rota (
    row_id INT PRIMARY KEY,
    rota_id INT,
    date DATETIME,
    shift_id VARCHAR(20) REFERENCES shift(shift_id),
    staff_id VARCHAR(20) REFERENCES staff(staff_id)
);

COMMIT



select * from address
select * from customers
select * from ingredient
select * from item
select * from orders
select * from recipe
select * from rota
select * from shift
select * from staff