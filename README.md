# Mental Health Support System

A database management system developed for managing users, counselors, counseling sessions, feedback, and billing information for a mental health support service.

This project was developed by **Wafi Fathema** as part of a Database Management Systems course.

## Features

- Store and manage user information
- Store counselor details and specializations
- Schedule and track counseling sessions
- Collect feedback and ratings
- Manage billing information
- Automatically log newly created sessions
- Retrieve user information using a stored procedure
- Count completed sessions using a database function

## Database Tables

The database contains the following tables:

- `Users`
- `Counselors`
- `Sessions`
- `Feedback`
- `Billing`
- `session_log`

## Database Concepts Used

- Primary keys
- Foreign keys
- Table relationships
- Stored procedure
- User-defined function
- Trigger
- Aggregate functions
- Sample data insertion
- SQL queries

## Technologies Used

- MySQL
- SQL
- MySQL Workbench

## How to Run the Project

1. Install MySQL Server and MySQL Workbench.
2. Open MySQL Workbench.
3. Open the `mental_health_support_system.sql` file.
4. Connect to your MySQL server.
5. Execute the complete SQL script.
6. The script will create the `mental_health_db` database and its tables.
7. Refresh the Schemas panel to view the database.

## Stored Procedure

The `GetUserInfo` stored procedure retrieves the name, age, and phone number of a user.

```sql
CALL GetUserInfo(1);
```

## Function

The `CountCompletedSessions` function returns the number of completed sessions for a particular user.

```sql
SELECT CountCompletedSessions(1);
```

## Trigger

The `after_session_insert` trigger automatically adds a record to the `session_log` table whenever a new counseling session is inserted.

## Project Files

- [`mental_health_support_system.sql`](mental_health_support_system.sql) - Complete database script
- [`DBMS_Mental Health Support System.pdf`](DBMS_Mental%20Health%20Support%20System.pdf) - Project report

## Future Improvements

- Develop a web-based user interface
- Add secure authentication
- Add counselor availability management
- Add appointment notifications
- Improve reporting and analytics

## Author

**Wafi Fathema**

Course: Database Management Systems
