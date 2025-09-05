```sql
-- Use SQL commands like SHOW PROFILE or EXPLAIN ANALYZE to monitor the performance of a few of your frequently used queries.
-- ===Retrieve booking by user===
SELECT * FROM new_booking WHERE user_id = 'some_uuid';

-- === Retrieve Booking in date Range==
SELECT * FROM new_booking WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';

-- === Join to get booking + user + property details ===
SELECT
  b.booking_id, b.start_date, b-end_date, b.total_price
  u.first_name, u.last_name
  p.name AS property_name
FROM booking b
JOIN users u ON b.user_id = u.user_id
JOIN property p ON b.property_id = p.property_id
WHERE b.start_date >= '2023-01-01';


-- == NOTE PostgreSQL does not support SHOW PROFILE like MYSQL, but you can use
EXPLAIN ANALYZE
SELECT * FROM new_booking WHERE user_id = 'some_uuid';


-- == Implement schema or index change ==
CREATE INDEX IF NOT EXISTS idx_new_booking_uer_id ON new_booking(user_id);
CREATE INDEX IF NOT EXISTS idx_new_booking_start_date ON new_booking(start_date);
CREATE INDEX IF NOT EXISTS idx_new_booking_end_date ON new_booking(end_date);
```
