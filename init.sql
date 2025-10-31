CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0
);

INSERT INTO users (username, email) VALUES
('admin', 'admin@example.com'),
('oumaima', 'oumaima@example.com');

INSERT INTO products (name, price, stock) VALUES
('Laptop', 1200.00, 10),
('Phone', 800.00, 25);
