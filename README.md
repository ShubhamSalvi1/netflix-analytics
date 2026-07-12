# Netflix-Style Streaming Platform User Engagement Analysis

A SQL and Power BI portfolio project analyzing user engagement patterns on a synthetic streaming-platform dataset — covering database design, relational SQL analysis, and an interactive Power BI dashboard.

> **Note:** This project is inspired by the type of analytics a streaming platform might perform. It does **not** use proprietary Netflix data, and no finding in this project should be interpreted as a statement about Netflix's real users, business, or operations. See [Why a Synthetic Dataset?](#why-a-synthetic-dataset) below.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Business Problem](#business-problem)
- [Project Objectives](#project-objectives)
- [Why a Synthetic Dataset?](#why-a-synthetic-dataset)
- [Dataset Description](#dataset-description)
- [Data Dictionary](#data-dictionary)
- [Database Schema & Relationships](#database-schema--relationships)
- [Tools and Technologies](#tools-and-technologies)
- [SQL Concepts Demonstrated](#sql-concepts-demonstrated)
- [Analysis Questions](#analysis-questions)
- [Power BI Dashboard Components](#power-bi-dashboard-components)
- [Key Insights](#key-insights)
- [Project Workflow](#project-workflow)
- [Repository Structure](#repository-structure)
- [Setup Instructions](#setup-instructions)
- [Limitations](#limitations)
- [Future Improvements](#future-improvements)
- [Skills Demonstrated](#skills-demonstrated)
- [Résumé-Ready Project Description](#résumé-ready-project-description)

---

## Project Overview

This project simulates a small streaming platform's backend data and analyzes how users engage with content across genres, subscription plans, and countries. It combines a relational MySQL database with SQL-based analysis and a Power BI dashboard for interactive exploration of the results.

The goal was to practice the full analyst workflow: designing a relational schema, writing SQL queries to answer business questions, and building a dashboard that communicates findings clearly to a non-technical audience.

---

## Business Problem

Streaming platforms generate large volumes of behavioral data — but to be useful, that data needs to answer specific business questions: which content resonates most, which subscription tiers drive engagement, and which users represent the most valuable segment.

This project simulates that scenario: given three connected tables of user, content, and viewing data, the task was to answer core engagement questions and present them through a dashboard suitable for stakeholder review.

---

## Project Objectives

- Design a normalized relational database with proper primary and foreign keys
- Write SQL queries to extract, filter, and aggregate engagement data
- Practice joining data across multiple related tables
- Build DAX measures and relationships inside Power BI
- Design a clean, interactive dashboard suitable for a portfolio or job application
- Translate raw query results into clear, business-style insights

---

## Why a Synthetic Dataset?

This section is here deliberately — the dataset used in this project is **synthetic (fabricated for learning purposes)**, and that choice is intentional, not a limitation to hide. Here's the reasoning:

1. **The objective was relational database design and analysis practice**, not analyzing Netflix's proprietary business data.
2. **Public Netflix datasets are limited.** They typically cover only the content catalogue (titles, genres, release years) and do not include linked user accounts, subscription plans, or individual watch histories, because that data is private and not publicly released.
3. **A custom dataset made a full relational model possible** — connecting users, content, and viewing activity in a way that mirrors how a real streaming platform's backend would be structured.
4. **This structure enabled practicing core analyst skills**: primary/foreign keys, joins, aggregations, user segmentation, and Power BI relationship modeling — skills that a catalogue-only dataset would not support.
5. **Synthetic data avoids any risk of misrepresenting private or proprietary information as real.**
6. **The findings in this project demonstrate analytical methods only.** They are not, and should not be interpreted as, conclusions about Netflix's actual customers, viewing habits, or business performance.

---

## Dataset Description

The dataset consists of three related tables, generated specifically for this project:

| Table | Description | Approx. Size |
|---|---|---|
| `users` | User accounts, signup dates, country, and subscription plan | 200 users |
| `content` | Content catalogue with genre, type, and release year | 50 titles |
| `watch_history` | Individual viewing records linking users to content | 2,459 records |

---

## Data Dictionary

### `users`

| Column | Type | Description |
|---|---|---|
| `user_id` | INT (PK) | Unique identifier for each user |
| `signup_date` | DATE | Date the user joined the platform |
| `country` | VARCHAR | User's country |
| `plan_type` | VARCHAR | Subscription tier (e.g., Basic, Standard, Premium) |

### `content`

| Column | Type | Description |
|---|---|---|
| `content_id` | INT (PK) | Unique identifier for each title |
| `title` | VARCHAR | Name of the content |
| `genre` | VARCHAR | Content genre (e.g., Horror, Comedy, Drama) |
| `content_type` | VARCHAR | Movie or Series |
| `release_year` | INT | Year the content was released |

### `watch_history`

| Column | Type | Description |
|---|---|---|
| `watch_id` | INT (PK) | Unique identifier for each viewing record |
| `user_id` | INT (FK) | References `users.user_id` |
| `content_id` | INT (FK) | References `content.content_id` |
| `watch_date` | DATE | Date the content was watched |
| `minutes_watched` | INT | Minutes watched in that session |

---

## Database Schema & Relationships

The schema follows a standard star-like structure, with `watch_history` acting as the fact table connecting two dimension tables:

```
users (1) ────────< (many) watch_history (many) >──────── (1) content
   user_id                    user_id, content_id                content_id
```

- `users.user_id → watch_history.user_id` — one-to-many (one user can have many watch records)
- `content.content_id → watch_history.content_id` — one-to-many (one title can be watched many times)

<img width="1005" height="287" alt="Schema" src="https://github.com/user-attachments/assets/568262d7-8aa7-45f0-bf7b-5d74483f9697" />


---

## Tools and Technologies

| Tool | Purpose |
|---|---|
| MySQL | Relational database design and SQL analysis |
| Power BI Desktop | Data modeling, DAX measures, dashboard design |
| CSV | Source data format for import into MySQL and Power BI |
| Git / GitHub | Version control and project hosting |

---

## SQL Concepts Demonstrated

- `SELECT`, `FROM`, `WHERE`
- Logical filtering with `AND`, `OR`
- Aggregate functions: `COUNT`, `COUNT DISTINCT`, `SUM`, `AVG`
- `GROUP BY` and `ORDER BY`
- `LIMIT` for top-N queries
- Column and table aliases
- `INNER JOIN` across multiple tables

Full queries are available in [`sql/analysis_queries.sql`](sql/analysis_queries.sql).

---

## Analysis Questions

The SQL analysis was designed to answer the following business questions:

1. How many users and viewing records exist in total?
2. Which countries and subscription plans have the most users?
3. What is the total watch time across the platform?
4. What is the average watch time per viewing session?
5. Which genres generate the most engagement?
6. Which titles have the highest total watch time?
7. Who are the top 10 most engaged users?
8. How does total and average engagement differ by subscription plan?

---

## Power BI Dashboard Components

The three source tables were imported into Power BI, with relationships built matching the SQL schema above.

**Key DAX measure:**

```dax
Total Minutes = SUM(watch_history[minutes_watched])
```

**Dashboard visuals:**

- Total Platform Engagement KPI card
- Engagement by Genre (bar chart)
- Engagement by Subscription Plan (bar chart)
- Top 10 Users by Engagement (table)
- Movie vs. Series consumption (chart)
- Country slicer for interactive filtering

<img width="1297" height="727" alt="Dashboard" src="https://github.com/user-attachments/assets/5b0563a5-2ab1-4146-93fd-80a60d5c43f3" />


---

## Key Insights

> Replace each placeholder below with your actual query/dashboard results before publishing.

- **Total platform watch time:** 228K
- **Most-watched genre:** Horror, accounting for approximately 32% of total watch time
- **Top-performing subscription plan by engagement:** Premium
- **Average watch time per user:** 1.14K minutes
- **Movie vs. Series split:** 51.12% Movies vs. 48.8% Series
- **Top user engagement concentration:** The top 10 users account forapproximately 9% of total platform watch time

---

## Project Workflow

1. Defined the business questions the analysis needed to answer
2. Designed the relational schema (`users`, `content`, `watch_history`)
3. Generated a synthetic dataset matching that schema
4. Created the MySQL database and loaded the CSV data
5. Wrote SQL queries to answer each analysis question
6. Imported the data into Power BI and built table relationships
7. Created DAX measures and designed dashboard visuals
8. Reviewed dashboard results against SQL query outputs for consistency
9. Documented findings and packaged the project for GitHub

---

## Repository Structure

```
streaming-platform-analytics/
├── data/
│   ├── users.csv
│   ├── content.csv
│   └── watch_history.csv
├── sql/
│   ├── create_tables.sql
│   └── analysis_queries.sql
├── powerbi/
│   └── netflix.pbix
├── images/
│   ├── Dashboard.png
│   └── Schema.png
└── README.md
```

---

## Setup Instructions

### 1. Set up the MySQL database

```sql
-- Create the database
CREATE DATABASE netflix_challenge;
USE netflix_challenge;

-- Run the schema script
SOURCE sql/create_tables.sql;
```

### 2. Import the CSV files

1. Open MySQL Workbench (or your preferred client).
2. Select the `netflix_challenge` database.
3. Use **Table Data Import Wizard** (or `LOAD DATA INFILE`) to import each file:
   - `data/users.csv` → `users` table
   - `data/content.csv` → `content` table
   - `data/watch_history.csv` → `watch_history` table
4. Confirm row counts match the dataset description above.

### 3. Run the analysis queries

Open `sql/analysis_queries.sql` in your SQL client and run each query section to reproduce the results referenced in [Key Insights](#key-insights).

### 4. Open the Power BI dashboard

1. Install [Power BI Desktop](https://powerbi.microsoft.com/desktop/) (free).
2. Open `powerbi/Dashboard.pbix`.
3. If prompted, update the data source connection to point to your local MySQL database or the CSV files in `data/`.
4. Click **Refresh** to load the data.

---

## Limitations

- The dataset is synthetic and does not reflect real user behavior or real Netflix data.
- Dataset size (200 users, 50 titles) is small and intended for learning/demonstration, not statistically robust analysis.
- No time-series depth beyond `watch_date`/`signup_date` — long-term trend analysis is limited.
- No content metadata such as ratings, cast, or descriptions was included.

---

## Future Improvements

- Add a date/calendar table to support richer time-based trend analysis
- Expand the dataset to include churn/cancellation behavior
- Add cohort analysis (engagement by signup month)
- Build a genre-vs-plan cross-analysis for deeper segmentation
- Add row-level security or drill-through pages for a more advanced Power BI build

---

## Skills Demonstrated

- Relational database design (primary keys, foreign keys, normalization)
- SQL querying: filtering, aggregation, joins, sorting, top-N analysis
- Data modeling in Power BI
- DAX measure creation
- Dashboard design and interactive filtering
- Translating raw data into business insights
- Technical documentation and project presentation

---

## Résumé-Ready Project Description

> **Netflix-Style Streaming Platform User Engagement Analysis** — Designed a relational MySQL database (users, content, watch history) and used SQL joins and aggregations to analyze engagement across genres, subscription plans, and countries. Built an interactive Power BI dashboard with custom DAX measures to visualize key engagement metrics, translating query results into business-style insights for a portfolio-ready analytics project.

---

## Screenshots


<img width="1297" height="727" alt="Dashboard" src="https://github.com/user-attachments/assets/b1cec0eb-b27b-46b6-be9a-cd9b5ab84245" />
<img width="1005" height="287" alt="Schema" src="https://github.com/user-attachments/assets/ba59f1e1-53cc-4e98-90da-cdfa1515234a" />


