-- Before creating the index
SELECT * FROM Bookings
WHERE email = 'godwinchuks032@gmail.com';

-- Create index on the email column in the Users table
CREATE INDEX idx_bookings_email ON users(email);

-- After creating the index
EXPLAIN ANALYZE
SELECT * FROM Bookings
WHERE email = 'godwinchuks032@gmail,com';
