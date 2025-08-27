# Normalization
__1NF (First Normal Form)__
Ensure atomic values, no repeating groups.
- The schema already satisfies this (all attributes are atomic, no multi-valued fields).

__2NF (Second Normal Form)__
Remove partial dependencies (applies only if table has composite PKs).
- All your primary keys are single-column UUIDs, so 2NF is satisfied.

__3NF (Third Normal Form)__
All non-key attributes depend only on the primary key.
- Lookup/reference tables make the schema flexible and avoid schema changes for new roles, statuses, or payment methods.
