-- PARTITION BY

-- Assume the Booking table is large and query performance is slow. Implement partitioning on the Booking table based on the start_date column. Save the query in a file partitioning.sql

-- If you already have an existing booking table, rename it to booking_old
DO $$
BEGIN
  -- if "booking" exists (lowercase)
  IF EXISTS (SELECT 1 FROM schema.tables WHERE table_schema = 'public' AND table_name = 'booking') THEN
    RAISE NOTICE 'Renaming existing table public.booking -> public.booking_old';
    EXECUTE 'ALTER TABLE public.booking RENAME TO booking_old';
  -- if "Booking" (case-sensitive) exists
  ELSIF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'Booking') THEN
    RAISE NOTICE 'Renaming existing table public."Booking" -> public.booking_old';
    EXECUTE 'ALTER TABLE public."Booking" RENAME TO booking_old';
  ELSE
    RAISE NOTICE 'No existing booking table found; continuing to create partitioned table';
  END IF;
END
$$;

-- Create a new partitioned table
CREATE TABLE new_Booking (
    booking_id UUID PRIMARY KEY,
    start_date DATE NOT NULL,
    booking_id UUID PRIMARY KEY,
    user_id UUID,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (booking_id, start_date)
) 

-- Create partitions for each year
CREATE TABLE Booking_2022 PARTITION OF new_Booking
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');


CREATE TABLE Booking_2023 PARTITION OF new_Booking
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE Booking_2024 PARTITION OF new_Booking
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE Booking_2025 PARTITION OF new_Booking
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Default partition for dates outside defined ranges
CREATE TABLE Booking_default PARTITION OF new_Booking DEFAULT;

-- create per-partition indexes for join columns (user_id, property_id)
-- (create them for each partition ensure optimal lookups can be automated for new partitions)
CREATE INDEX IF NOT EXISTS idx_booking_2022_user_id ON Booking_2022(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_2022_property_id ON Booking_2022(property_id);

CREATE INDEX IF NOT EXISTS idx_booking_2023_user_id ON Booking_2023(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_2023_property_id ON Booking_2023(property_id);

CREATE INDEX IF NOT EXISTS idx_booking_2024_user_id ON Booking_2024(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_2024_property_id ON Booking_2024(property_id);

CREATE INDEX IF NOT EXISTS idx_booking_2025_user_id ON Booking_2025(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_2025_property_id ON Booking_2025(property_id);

CREATE INDEX IF NOT EXISTS idx_booking_default_user_id ON Booking_default(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_default_property_id ON Booking_default(property_id);


-- add foriegn key constraints after partitioning
ALTER TABLE new_Booking
  ADD CONSTRAINT fk_booking_user
  FOREIGN KEY (user_id) REFERENCES Users(user_id);

ALTER TABLE new_Booking
  ADD CONSTRAINT fk_booking_property
  FOREIGN KEY (property_id) REFERENCES Properties(property_id);


DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_tables WHERE schemaname = 'public' AND tablename = 'booking_old') THEN
    RAISE NOTICE 'Migrating data from booking_old to partitioned booking...';
    -- Insert rows into partitioned table; rows will be routed to correct partitions
    EXECUTE 'INSERT INTO booking (booking_id, user_id, property_id, start_date, end_date, total_price, status, created_at) SELECT booking_id, user_id property_id, start_date, end_date, total_price, status, created_at FROM booking_old';
    RAISE NOTICE 'Data migration complete.';
  ELSE
    RAISE NOTICE 'No booking_old table found; skipping migration.';
  END IF;
END
$$;

-- ANALYSE performance test query
EXPLAIN (ANALYZE, BUFFERS, VERBOSE)
SELECT * FROM new_Booking
WHERE start_date >= '2023-05-01' AND start_date < '2023-06-01';

EXPLAIN (ANALYZE, BUFFERS)
SELECT property_id, COUNT(*) AS bookings_count
FROM new_Booking
WHERE start_date >= '2023-01-01' AND start_date < '2024-01-01'
GROUP BY property_id
ORDER BY bookings_count DESC
LIMIT 10;

-- ===== Brief report (observations and guidance) =====
-- Expected improvements after partitioning:
-- 1) Partition pruning: queries that filter by start_date will only scan the relevant partitions
-- (e.g., a single year's partition) instead of the whole table. This reduces I/O and CPU.
-- 2) Reduced query latency for date-range queries (less data scanned). EXPLAIN ANALYZE should show
-- fewer heap blocks read and lower total execution time compared to a single large table.
-- 3) Maintenance tasks (VACUUM, index rebuild) can be done per-partition, making them faster.


-- What to measure (run both BEFORE and AFTER to compare):
-- - total_time (from EXPLAIN ANALYZE)
-- - buffers: shared hit / read / dirtied (EXPLAIN (ANALYZE, BUFFERS))
-- - number of heap blocks read and rows removed


-- Notes / caveats:
-- - Primary key on the partitioned table includes the partition key (booking_id, start_date).
-- This is required by PostgreSQL to ensure uniqueness across partitions.
-- - When adding new partitions (e.g., for 2026), remember to create the partition and
-- add the same per-partition indexes and any local constraints you need.
-- - If you prefer global indexes or automatic index propagation, newer PostgreSQL versions
-- have improved behavior. Check your Postgres version and adapt the index creation strategy.


-- End of partitioning.sql

