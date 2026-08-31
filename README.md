Add food delivery database schema and data# 🍔 Food Delivery SQL Database Management System

<p align="center">

### 📊 A PostgreSQL-Based Food Delivery Database & Business Analytics Project

<img src="https://img.shields.io/badge/PostgreSQL-Database-336791?style=for-the-badge&logo=postgresql&logoColor=white"/>
<img src="https://img.shields.io/badge/SQL-Analytics-4479A1?style=for-the-badge&logo=mysql&logoColor=white"/>
<img src="https://img.shields.io/badge/Database-Management-6C63FF?style=for-the-badge"/>
<img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge"/>

</p>

---

## 📌 Project Overview

This project is a **relational Food Delivery Database Management System** built using **PostgreSQL and SQL**.

The database represents a real-world food delivery platform where customers can place orders from restaurants, delivery partners handle deliveries, payments are processed, and customers can provide ratings and reviews.

The project focuses on **database design, data management and business-oriented SQL analysis**.

---

## 🎯 Project Objectives

* Design a structured relational database for a food delivery platform
* Manage customers, restaurants, menu items and orders
* Track delivery partners and delivery status
* Manage payment transactions
* Store customer ratings and reviews
* Perform business analysis using SQL
* Create a reusable reporting view for order analysis

---

## 🗄️ Database Structure

The project contains **8 main tables**:

| Table                  | Purpose                                   |
| ---------------------- | ----------------------------------------- |
| 👤 `customers`         | Stores customer information               |
| 🍽️ `restaurants`      | Stores restaurant and cuisine information |
| 🛵 `delivery_partners` | Stores delivery partner details           |
| 🍔 `menu_items`        | Stores restaurant menu items              |
| 🧾 `orders`            | Stores customer orders                    |
| 📦 `order_items`       | Stores items included in each order       |
| 💳 `payments`          | Stores payment information                |
| ⭐ `ratings`            | Stores food and delivery ratings          |

### 📊 Reporting View

`vw_order_summary`

This view combines order, customer, restaurant, delivery partner and payment information for easier reporting and analysis.

---

## 🔗 Database Relationships

```text
Customers
    │
    │ 1 ──── N
    ▼
  Orders ───────────► Restaurants
    │                     │
    │                     │ 1 ──── N
    │                     ▼
    │                 Menu Items
    │
    ├──────────────► Order Items
    │
    ├──────────────► Payments
    │
    └──────────────► Ratings

Orders ───────────► Delivery Partners
```

---

## 🛠️ Technologies Used

* **PostgreSQL**
* **SQL**
* **pgAdmin 4**

---

## 🧠 SQL Concepts Used

### Basic SQL

* `SELECT`
* `WHERE`
* `ORDER BY`
* `DISTINCT`
* `LIMIT`

### Aggregation

* `COUNT()`
* `SUM()`
* `AVG()`
* `MIN()`
* `MAX()`
* `GROUP BY`
* `HAVING`

### Advanced SQL

* `INNER JOIN`
* `LEFT JOIN`
* Subqueries
* CTEs
* Window Functions
* Views
* Aggregate Functions

### Database Concepts

* Primary Keys
* Foreign Keys
* Unique Constraints
* Check Constraints
* Default Values
* `SERIAL` IDs
* Relational Database Design

---

## 📊 Business Analysis Areas

This database can be used to answer real-world business questions such as:

* Which restaurants receive the most orders?
* What is the average delivery time?
* Which customers place the most orders?
* Which cuisine performs best?
* What is the total payment revenue?
* Which payment method is most popular?
* Which restaurants have the highest ratings?
* Which delivery partners handle the most orders?
* What percentage of orders are cancelled?
* Which menu items are most frequently ordered?
* Which cities generate the most orders?
* What is the average food and delivery rating?

---

## ⭐ Key Features

### 👥 Customer Management

Customer details including name, phone, email, city and signup date.

### 🍽️ Restaurant Management

Restaurant name, city, cuisine type, rating and active status.

### 🍔 Menu Management

Menu items, categories, prices and availability.

### 🧾 Order Management

Order date, customer, restaurant, delivery partner, status and delivery time.

### 🛵 Delivery Management

Delivery partners with joining date and active/inactive status.

### 💳 Payment Management

Payment method, payment status, amount and payment date.

### ⭐ Rating System

Separate food and delivery ratings along with customer reviews.

---

## 📈 Reporting View

The project includes:

```sql
vw_order_summary
```

This view provides a consolidated order-level report containing:

* Customer
* Customer City
* Restaurant
* Cuisine
* Delivery Partner
* Order Date
* Order Status
* Delivery Time
* Payment Method
* Payment Status
* Payment Amount

This makes the database easier to use for reporting and analytics.

---

## 🚀 How to Run the Project

### 1️⃣ Install PostgreSQL

Install PostgreSQL and open **pgAdmin 4**.

### 2️⃣ Create a Database

Create a new database, for example:

```text
food_delivery_db
```

### 3️⃣ Open Query Tool

Open the Query Tool for the database.

### 4️⃣ Run the SQL File

Open:

```text
01_schema_and_data(5).sql
```

Copy the SQL code into Query Tool and execute it.

The script will:

```text
DROP old tables/views
        ↓
CREATE tables
        ↓
INSERT sample data
        ↓
CREATE reporting view
```

### 5️⃣ Verify

Check the tables inside the database:

```text
customers
restaurants
delivery_partners
menu_items
orders
order_items
payments
ratings
```

---

## 📂 Project Files

```text
food-delivery-sql-database/
│
├── README.md
│
└── 01_schema_and_data(5).sql
```

---

## 🎓 What I Learned

Through this project, I practiced:

* Relational database design
* Database normalization concepts
* Creating relationships between tables
* Managing constraints
* Writing analytical SQL queries
* Joining multiple tables
* Working with aggregate functions
* Creating SQL views
* Designing databases for real-world business scenarios

---

## 👨‍💻 Author

### Ujawal Singh

**MCA (Data Science) | Aspiring Data Analyst**

📊 SQL | PostgreSQL | Python | Power BI | Excel

💼 Open to Data Analyst opportunities and freelance projects.

### Connect With Me

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge\&logo=linkedin\&logoColor=white)](https://www.linkedin.com/in/ujawal-singh-data-analyst)

[![Email](https://img.shields.io/badge/Email-Contact-EA4335?style=for-the-badge\&logo=gmail\&logoColor=white)](mailto:iamujawalsingh@gmail.com)

---

<p align="center">

### ⭐ If you find this project useful, feel free to star the repository!

**Built with PostgreSQL & SQL 🚀**

</p>
