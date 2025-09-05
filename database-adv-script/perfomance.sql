-- WHERE AND

-- Write an initial query that retrieves all bookings along with the user details, property details, and payment details and save it on
SELECT
  b.booking_id,
  b.start_date,
  b.end_date,
  b.total_price,
  u.user_id,
  u.first_name,
  u.last_name,
  u.email,
  p.property_id,
  p.name AS property_name,
  p.description AS property_description,
  pay.payment_id,
  pay.amount AS payment_amount,
  pay.payment_date
FROM
  Bookings b
INNER JOIN
  Users u ON b.user_id = u.user_id
INNER JOIN
  Properties p ON b.property_id = p.property_id
LEFT JOIN
  Payments pay ON b.booking_id = pay.booking_id;

-- Analyze the query’s performance using EXPLAIN and identify any inefficiencies.
EXPLAIN ANALYZE
SELECT
  b.booking_id,
  b.start_date,
  b.end_date,
  b.total_price,
  u.user_id,
  u.first_name,
  u.last_name,
  u.email,
  p.property_id,
  p.name AS property_name,
  p.description AS property_description,
  pay.payment_id,
  pay.amount AS payment_amount,
  pay.payment_date
FROM
  Bookings b
INNER JOIN
  Users u ON b.user_id = u.user_id
INNER JOIN
  Properties p ON b.property_id = p.property_id
LEFT JOIN
  Payments pay ON b.booking_id = pay.booking_id;

-- Refactor the query to reduce execution time, such as reducing unnecessary joins or using indexing.
EXPLAIN ANALYZE
SELECT
  b.booking_id,
  b.start_date,
  b.end_date,
  b.total_price,
  u.user_id,
  u.first_name,
  u.last_name,
  u.email,
  p.property_id,
  p.name AS property_name,
  p.description AS property_description,
  pay.payment_id,
  pay.amount AS payment_amount,
  pay.payment_date
FROM
  Bookings b
JOIN
  Users u ON b.user_id = u.user_id
JOIN
  Properties p ON b.property_id = p.property_id
LEFT JOIN LATERAL (
  SELECT payment_amount, payment_date, payment_id
  FROM Payments pay
  WHERE pay.booking_id = b.booking_id,
  ORDER BY pay.payment_date DESC
  LIMIT 1
) pay ON true;


CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON Bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON Bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_payments_booking_id ON Payments(booking_id);
CREATE INDEX IF NOT EXISTS idx_users_user_id ON Users(user_id);
CREATE INDEX IF NOT EXISTS idx_properties_property_id ON Properties(property_id);
