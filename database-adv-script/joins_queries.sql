-- Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT
  b.booking_id,
  b.start_date,
  b.end_date,
  b.total_price,
  u.user_id,
  u.first_name,
  u.last_name,
  u.email,
FROM
  bookings b
INNER JOIN
  Users u ON b.user_id = u.user_id

-- Write a query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT
  p.property_id,
  p.name,
  p.description,
  r.review_id,
  r.rating,
  r.comment
FROM
  Properties p
LEFT JOIN
  Reviews r ON p.property_id = r.property_id
ORDER BY
  p.property_id, r.review_id;

--- Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT
  u.user_id,
  u.first_name,
  u.last_name,
  b.booking_id,
  b.start_date,
  b.end_date,
  b.total_price
FROM
  Users u
FULL OUTER JOIN
  Bookings b ON u.user_id = b.user_id


-- Identify high-usage columns in your User, Booking, and Property tables (e.g., columns used in WHERE, JOIN, ORDER BY clauses).
SELECT * FROM Users
WHERE email = 'godwinchuks032@gmail.com';

-- Write SQL CREATE INDEX commands to create appropriate indexes for those columns and save them on database_index.sql
CREATE INDEX idx_users_email ON Users(email);

-- Measure the query performance before and after adding indexes using EXPLAIN or ANALYZE.
EXPLAIN ANALYZE
SELECT * FROM Users
WHERE email = 'godwinchuks032@gmail.com';