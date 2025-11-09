# 🍕 SQL EDA Project — Pizza Sales Analysis

### Overview
This project demonstrates how SQL can be used for **Exploratory Data Analysis (EDA)** on a real-world **Pizza Sales Dataset**.  
The analysis covers the entire process — from **database creation and schema design** to **running analytical queries** that uncover business insights about sales performance, customer demand, and order trends.

---

### 📊 Objectives
- Design a normalized **relational database schema** for pizza sales data  
- Import and manage data using **MySQL Workbench**  
- Perform **exploratory data analysis** using advanced SQL queries  
- Derive actionable insights such as:
  - Total revenue and order count  
  - Most popular pizza types and sizes  
  - Category-wise and hourly sales trends  
  - Revenue distribution and cumulative sales growth  

---

### 🧩 Schema Design

#### 1️⃣ `orders`
| Column | Type | Description |
|---------|------|-------------|
| `order_id` | INT (PK) | Unique ID for each order |
| `order_date` | DATE | Date the order was placed |
| `order_time` | TIME | Time the order was placed |

#### 2️⃣ `pizza_types`
| Column | Type | Description |
|---------|------|-------------|
| `pizza_type_id` | VARCHAR(50) (PK) | Unique ID for each pizza type |
| `name` | VARCHAR(255) | Pizza name |
| `category` | VARCHAR(100) | Pizza category (e.g., Chicken, Classic, Veggie) |
| `ingredients` | TEXT | Ingredients list |

#### 3️⃣ `pizzas`
| Column | Type | Description |
|---------|------|-------------|
| `pizza_id` | VARCHAR(50) (PK) | Unique ID for each pizza variant |
| `pizza_type_id` | VARCHAR(50) (FK) | Links to `pizza_types` |
| `size` | ENUM('S','M','L','XL') | Pizza size |
| `price` | DECIMAL(8,2) | Price for this size |

#### 4️⃣ `order_details`
| Column | Type | Description |
|---------|------|-------------|
| `order_details_id` | INT (PK) | Unique line-item ID |
| `order_id` | INT (FK) | References `orders` |
| `pizza_id` | VARCHAR(50) (FK) | References `pizzas` |
| `quantity` | INT | Number of pizzas ordered |

---

### 🧠 Key SQL Queries & Insights

| # | Objective | Description |
|---|------------|-------------|
| 1 | Retrieve total number of orders | Count total orders placed |
| 2 | Calculate total revenue | SUM(quantity × price) across all orders |
| 3 | Identify highest-priced pizza | Find pizza with maximum price |
| 4 | Find most common pizza size | Group & count by `size` |
| 5 | Top 5 ordered pizza types | Rank pizza types by total quantity |
| 6 | Quantity per category | Join tables to sum quantity by category |
| 7 | Order distribution by hour | Group by `HOUR(order_time)` |
| 8 | Category-wise pizza distribution | Count pizza types in each category |
| 9 | Average pizzas per day | Average `SUM(quantity)` by `order_date` |
| 10 | Top 3 pizzas by revenue | Group by pizza type, order by total revenue |
| 11 | Category revenue % | Revenue share by category |
| 12 | Cumulative revenue over time | Window function for running total |
| 13 | Top 3 pizzas per category | Use `RANK()` with `PARTITION BY` |

---

### 💻 Tech Stack
- **Database:** MySQL  
- **Tools:** MySQL Workbench, Excel (for visualization), PowerPoint  
- **Language:** SQL (DDL, DML, Joins, Aggregations, Window Functions)  
- **Data Source:** Public CSV dataset (approx. 25,000 records total)

---

### 📈 Insights Summary
- **Total Orders:** 2,135  
- **Total Revenue:** ≈ ₹8,186  
- **Most Ordered Size:** Large (L)  
- **Top Performing Pizza (by Revenue):** Greek Pizza  
- **Peak Order Hours:** Around midday and evening  
- **Top Categories:** Classic and Chicken pizzas dominate total sales  

---

### 🪄 Business Takeaways
- Focus on **Large-size pizzas** — highest demand share  
- Promote **top 5 revenue-generating pizzas** through combo offers  
- Align staffing and promotions with **peak order hours** to optimize sales  
- Diversify underperforming categories (e.g., Veggie) to improve balance  

---

### 📂 Repository Structure
