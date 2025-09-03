# Unleashing Advanced Querying Power

__About the Project__
This project is a part of the __ALX Airbnb Database Module__, where you will implement advanced SQL querying and optimization techniques to work with a simulated Airbnb database. By diving into real-world challenges like optimizing query performance, writing complex SQL scripts, and applying indexing and partitioning, participants will gain hands-on experience with database management and performance tuning. This ensures you are equipped to handle large-scale applications where efficiency and scalability are critical.

__Learning Objectives__
This project is designed to enhance the skills of professional developers by focusing on advanced database concepts and practices. By the end of this project, learners will:
- 1. Master Advanced SQL: Write complex queries involving joins, subqueries, and aggregations for data retrieval and analysis.
- 2. Optimize Query Performance: Analyze and refactor SQL scripts using performance tools like EXPLAIN and ANALYZE.
- 3. Implement Indexing and Partitioning: Understand and apply indexing and table partitioning to improve database performance for large datasets.
- 4. Monitor and Refine Performance: Continuously monitor database health and refine schemas and queries for optimal performance.
- 4. Think Like a DBA: Learn to make data-driven decisions about schema design and optimization strategies for high-volume applications.


__Requirements__
To successfully complete this project, learners must:
- Have a solid understanding of SQL fundamentals, including SELECT, WHERE, and GROUP BY clauses.
- Be familiar with relational database concepts such as primary keys, foreign keys, and normalization.
- Have basic knowledge of performance monitoring tools (EXPLAIN, ANALYZE).
- Be able to set up and manage a GitHub repository for submitting their work.


__Key Highlights__
  1. Defining Relationships with ER Diagrams
  Learners start by creating an Entity-Relationship (ER) diagram, modeling relationships and dependencies between users, bookings, properties, and reviews in the Airbnb schema.
  2. __Complex Queries with Joins__
  Gain expertise in SQL joins with tasks that require combining multiple tables to extract meaningful insights. Learners explore INNER JOIN, LEFT JOIN, and FULL OUTER JOIN for various scenarios.
  3. __Power of Subqueries__
  Develop proficiency with both correlated and non-correlated subqueries. Learn how to nest queries for advanced data analysis, such as calculating average ratings or filtering users based on activity thresholds.
  4. __Aggregations and Window Functions__
  Unlock analytical capabilities using SQL aggregation functions like COUNT and SUM. Dive into advanced window functions like ROW_NUMBER and RANK to rank and analyze data sets.
  5. __Indexing for Optimization__
  Learners identify performance bottlenecks and write SQL commands to create indexes for frequently queried columns. They analyze the impact of these changes on query execution times.
  6. __Query Optimization Techniques__
  Write and analyze complex queries for retrieving detailed information about bookings, properties, users, and payments. Refactor queries to improve execution times by reducing redundancies and leveraging indexing.
  7. __Partitioning Large Tables__
  Address performance challenges with large datasets by implementing table partitioning. Focus on partitioning the Booking table to improve queries on date ranges and compare performance before and after partitioning.
  8. __Performance Monitoring and Schema Refinement__
  Learners monitor query performance using SHOW PROFILE and EXPLAIN ANALYZE, identify bottlenecks, and propose schema changes. Practical tasks include implementing these adjustments and documenting results.

This comprehensive task flow ensures you learn not only to write efficient SQL queries but also to think strategically about database design and optimization. The goal is to prepare you for real-world database challenges in high-performance applications.

📝 __Project Assessment (Hybrid)__
Your project will be evaluated primarily through manual reviews. To ensure you receive your full score, please:
✅ Complete your project on time
📄 Submit all required files
🔗 Generate your review link
👥 Have your peers review your work


## Question 1
- __Objective:__ Write both correlated and non-correlated subqueries.

__Instructions:__
Write a query to find all properties where the average rating is greater than 4.0 using a subquery.
Write a correlated subquery to find users who have made more than 3 bookings.


## Question 2
- __Objective:__ Use SQL aggregation and window functions to analyze data.

__Instructions:__
- Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.