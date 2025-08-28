CREATE TYPE 'role' AS ENUM (
  'guest',
  'host',
  'admin'
);

CREATE TYPE 'booking_status' AS ENUM (
  'pending',
  'confirmed',
  'cancelled'
);

CREATE TYPE 'payment_method' AS ENUM (
  'credit_card',
  'paypal',
  'stripe'
);

CREATE TABLE IF NOT EXISTS 'Users' (
  "user_id" UUID PRIMARY KEY,
  "first_name" varchar (255) NOT NULL,
  "last_name" varchar (255) NOT NULL,
  "email" varchar (255) UNIQUE NOT NULL,
  "password" varchar (255) NOT NULL,
  "phone_number" varchar (255) NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE IF NOT EXISTS 'Property' (
  "Property_id" UUID PRIMARY KEY,
  "host_id" UUID,
  "name" varchar (255) NOT NULL,
  "description" text NOT NULL,
  "location" varchar (255) NOT NULL,
  "price_per_night" decimal NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS 'Booking' (
  "booking_id" UUID PRIMARY KEY,
  "property_id" UUID,
  "user_id" UUID,
  "start_date" DATE NOT NULL,
  "end_date" DATE NOT NULL,
  "total_price" decimal NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS 'Payment' (
  "payment_id" UUID PRIMARY KEY,
  "booking_id" UUID,
  "amount" decimal NOT NULL,
  "payment_date" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS 'Review' (
  "review_id" UUID PRIMARY KEY,
  "user_id" UUID,
  "property_id" UUID,
  "rating" integer NOT NULL CHECK ("rating" >= 1 AND "rating" <= 5),
  "comment" text NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS 'Message' (
  "message_id" UUID PRIMARY KEY,
  "sender_id" UUID,
  "recipient_id" UUID,
  "message_body" text NOT NULL,
  "sent_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance optimization --
CREATE INDEX IF NOT EXISTS "idx_user_email" ON "User" ("email");
CREATE INDEX IF NOT EXISTS "idx_property_location" ON "Property" ("location");
CREATE INDEX IF NOT EXISTS "idx_property_host_id" ON "Property" ("host_id");
CREATE INDEX IF NOT EXISTS "idx_booking_property_id" ON "Booking" ("property_id");
CREATE INDEX IF NOT EXISTS "idx_booking_guest" ON "Booking" ("user_id");
CREATE INDEX IF NOT EXISTS "idx_payment_booking_id" ON "Payment" ("booking_id");
CREATE INDEX IF NOT EXISTS "idx_review_user_id" ON "Review" ("user_id");
CREATE INDEX IF NOT EXISTS "idx_review_property_id" ON "Review" ("property_id");
CREATE INDEX IF NOT EXISTS "idx_message_sender_id" ON "Message" ("sender_id");
CREATE INDEX IF NOT EXISTS "idx_message_recipient_id" ON "Message" ("recipient_id");

COMMENT ON COLUMN "Property"."updated_at" IS 'On Update set `now()`';

COMMENT ON COLUMN "Review"."rating" IS 'Rating out of 5';
COMMENT ON COLUMN "Review"."comment" IS 'User review comment';

ALTER TABLE "Property" ADD FOREIGN KEY ("host_id") REFERENCES "User" ("user_id");
ALTER TABLE "Booking" ADD FOREIGN KEY ("property_id") REFERENCES "Property" ("property_id");
ALTER TABLE "Booking" ADD FOREIGN KEY ("user_id") REFERENCES "User" ("user_id");
ALTER TABLE "Payment" ADD FOREIGN KEY ("booking_id") REFERENCES "Booking" ("booking_id");
ALTER TABLE "Review" ADD FOREIGN KEY ("user_id") REFERENCES "User" ("user_id");
ALTER TABLE "Review" ADD FOREIGN KEY ("property_id") REFERENCES "Property" ("property_id");
ALTER TABLE "Message" ADD FOREIGN KEY ("sender_id") REFERENCES "User" ("user_id");
ALTER TABLE "Message" ADD FOREIGN KEY ("recipient_id") REFERENCES "User" ("user_id");
