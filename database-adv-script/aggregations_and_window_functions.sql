-- Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
SELECT
  u.user_id,
  u.first_name,
  u.last_name,
  COUNT(b.booking_id) AS total_bookings
FROM
  Users u
LEFT JOIN
  Bookings b ON u.user_id = b.user_id
GROUP BY
  u.user_id, u.first_name, u.last_name


-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
WITH PropertyBookings AS (
  SELECT
    p.property_id,
    p.name,
    COUNT(b.booking_id) AS total_bookings
  FROM
    Property p
  LEFT JOIN
    Bookings b ON p.property_id = b.property_id
  GROUP BY
    p.property_id, p.name
)
SELECT
  pb.property_id,
  pb.name,
  pb.total_bookings,
  RANK() OVER (ORDER BY pb.total_bookings DESC) AS booking_rank
FROM
  PropertyBookings pb

ORDER BY
  total_bookings DESC, pb.name ASC;

