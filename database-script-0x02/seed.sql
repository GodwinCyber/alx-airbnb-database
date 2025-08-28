-- Create SQL scripts to populate the database with sample data.
-- Extension to support uuid_generate_v4() function
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- insert into User
insert into User (user_id, first_name, last_name, email, password_hash,phone_number, role, created_at) values
  (uuid_generate_v4(), 'Julien', 'Bieber', 'julien.bieber@example.com', 'hashed_password', '+1234567890', 'host', now()),
  (uuid_generate_v4(), 'John', 'Doe', 'john.doe@example.com', 'hashed_password', '+0987654321', 'guest', now()),
  (uuid_generate_v4(), 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password', '+1122334455', 'guest', now()),
  (uuid_generate_v4(), 'Alice', 'Johnson', 'alice.johnson@example.com', 'hashed_password', '+6677889900', 'guest', now()),
  (uuid_generate_v4(), 'Bob', 'Brown', 'bob.brown@example.com', 'hashed_password', '+5566778899', 'guest', now());

-- insert into Property
insert into Property (property_id, host_id, name, description, location, price_per_night, created_at, updated_at) values
  (uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'julien.bieber@example.com'), 'Julien''s House', 'A cozy house in the heart of the city.', '123 Main St', 100, now(), now()),
  (uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'john.doe@example.com'), 'John''s Apartment', 'A modern apartment in the suburbs.', '456 Elm St', 80, now(), now()),
  (uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'jane.smith@example.com'), 'Jane''s Villa', 'A luxurious villa on the beach.', '789 Oak St', 200, now(), now()),
  (uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'alice.johnson@example.com'), 'Alice''s Cottage', 'A charming cottage in the countryside.', '101 Pine St', 60, now(), now()),
  (uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'bob.brown@example.com'), 'Bob''s Mansion', 'A grand mansion in the city.', '202 Maple St', 300, now(), now());

-- insert into Booking
insert into Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) values
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Julien''s House'), (SELECT user_id FROM User WHERE email = 'john.doe@example.com'), '2023-01-01', '2023-01-05', 400, 'confirmed', now()),
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'John''s Apartment'), (SELECT user_id FROM User WHERE email = 'jane.smith@example.com'), '2023-02-01', '2023-02-03', 240, 'confirmed', now()),
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Jane''s Villa'), (SELECT user_id FROM User WHERE email = 'alice.johnson@example.com'), '2023-03-01', '2023-03-07', 1400, 'confirmed', now()),
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Alice''s Cottage'), (SELECT user_id FROM User WHERE email = 'bob.brown@example.com'), '2023-04-01', '2023-04-05', 240, 'confirmed', now()),
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Bob''s Mansion'), (SELECT user_id FROM User WHERE email = 'julien.bieber@example.com'), '2023-05-01', '2023-05-07', 2100, 'confirmed', now()),
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Julien''s House'), (SELECT user_id FROM User WHERE email = 'jane.smith@example.com'), '2023-06-01', '2023-06-05', 400, 'confirmed', now()),
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'John''s Apartment'), (SELECT user_id FROM User WHERE email = 'alice.johnson@example.com'), '2023-07-01', '2023-07-03', 240, 'confirmed', now()),
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Jane''s Villa'), (SELECT user_id FROM User WHERE email = 'bob.brown@example.com'), '2023-08-01', '2023-08-07', 1400, 'confirmed', now()),
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Alice''s Cottage'), (SELECT user_id FROM User WHERE email = 'julien.bieber@example.com'), '2023-09-01', '2023-09-05', 240, 'confirmed', now()),
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Bob''s Mansion'), (SELECT user_id FROM User WHERE email = 'john.doe@example.com'), '2023-10-01', '2023-10-07', 2100, 'confirmed', now());
  
-- Insert into payment
insert into Payment (payment_id, booking_id, amount, payment_date, payment_method) values
  (uuid_generate_v4(), (SELECT booking_id FROM Booking WHERE booking_id = '1'), 1400, '2023-03-01', 'credit_card'),
  (uuid_generate_v4(), (SELECT booking_id FROM Booking WHERE booking_id = '2'), 240, '2023-04-01', 'cash'),
  (uuid_generate_v4(), (SELECT booking_id FROM Booking WHERE booking_id = '3'), 2100, '2023-05-01', 'credit_card'),
  (uuid_generate_v4(), (SELECT booking_id FROM Booking WHERE booking_id = '4'), 240, '2023-06-01', 'paypal'),
  (uuid_generate_v4(), (SELECT booking_id FROM Booking WHERE booking_id = '5'), 2100, '2023-07-01', 'credit_card');
    
-- Insert into review
insert into Review (review_id, property_id, user_id, rating, comment, created_at) values
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Alice''s Cottage'), (SELECT user_id FROM User WHERE email = 'julien.bieber@example.com'), 5, 'Great experience!', now()),
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Bob''s Mansion'), (SELECT user_id FROM User WHERE email = 'john.doe@example.com'), 4, 'Good value for money.', now()),
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'John''s Apartment'), (SELECT user_id FROM User WHERE email = 'alice.johnson@example.com'), 5, 'Excellent location!', now()),
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Jane''s Villa'), (SELECT user_id FROM User WHERE email = 'bob.brown@example.com'), 4, 'Spacious and clean.', now()),
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'John''s Apartment'), (SELECT user_id FROM User WHERE email = 'alice.johnson@example.com'), 5, 'Spacious and clean.', now()),
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name = 'Jane''s Villa'), (SELECT user_id FROM User WHERE email = 'bob.brown@example.com'), 4, 'Spacious and clean.', now());
  
  
-- Insert into message
insert into Message (message_id, sender_id, recipient_id, message_body, sent_at) values
(uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'alice.johnson@example.com'), (SELECT user_id FROM User WHERE email = 'julien.bieber@example.com'), 'Meeting', 'Let''s meet at the park.', now()),
(uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'bob.brown@example.com'), (SELECT user_id FROM User WHERE email = 'john.doe@example.com'), 'Booking', 'Can you confirm the booking?', now()),
(uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'alice.johnson@example.com'), (SELECT user_id FROM User WHERE email = 'bob.brown@example.com'), 'Booking', 'Can you confirm the booking?', now()),
(uuid_generate_v4(), (SELECT user_id FROM User WHERE email = 'julien.bieber@example.com'), (SELECT user_id FROM User WHERE email = 'alice.johnson@example.com'), 'Meeting', 'Let''s meet at the park.', now());

