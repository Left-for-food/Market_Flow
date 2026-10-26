# MarketFlow — Recommendation Model A/B Test

[Русская версия](README_RU.md)

A marketplace tested a new AI recommendation model on its homepage for 30 days. The goal was to assess its effect on engagement, purchases, and profitability and decide whether to roll it out.

**Stack:** PostgreSQL, Python, pandas, NumPy, SQLAlchemy, SciPy, Matplotlib, Seaborn.

## Work completed

- Explored the source CSV files, checked data types and missing values, and excluded 300 users with multiple experiment assignments.
- Designed and populated a PostgreSQL database with 8 related tables. The analysis covers 49,700 assigned users, with over 1 million impressions in the source data.
- Analysed traffic, the purchase funnel, profitability, repeat purchases, returns, support tickets, and categories using SQL joins, CTEs, and window functions.
- Defined 7 metrics and estimated sample size: 23,100 users per group at alpha = 5%, power = 95%, and relative CTR MDE = 3%. Actual groups: 24,674 and 25,026 users.
- Checked the 50/50 assignment split: the SRM test found no significant imbalance (p = 0.1154).
- Summarised all 7 metrics with effects, confidence intervals, and conclusions. Used user-level Welch and permutation tests, bootstrap intervals for ratios, and Holm correction for six secondary metrics.

The design and sample-size calculation are retrospective, based on the available experiment data.

## Results

| Metric | Control | Test | Relative change |
| --- | ---: | ---: | ---: |
| CTR | 7.64% | 9.46% | +23.84% |
| Gross profit per assigned user, RUB | 35.06 | 46.17 | +31.68% |
| Session-to-purchase conversion | 3.78% | 5.03% | +32.99% |
| Users with at least two orders | 0.82% | 1.64% | +99.62% |
| Product card-to-purchase conversion | 7.76% | 8.40% | +8.21% |
| Return rate | 5.50% | 6.82% | +23.97% |
| Quality-related support tickets per 100 orders | 1.86 | 1.89 | +1.76% |

The first five metrics improved significantly. Return rate also increased significantly (+1.32 percentage points; adjusted p = 0.0396). No significant change was detected in quality-related support tickets.

Gross profit includes all assigned users and the recorded impact of returns. Card-to-purchase conversion counts clicks linked to at least one order.

**I recommend a phased rollout with close monitoring of return rate and gross profit per user.** The model improves engagement and short-term financial performance, with higher returns as the main tradeoff.

## Selected visualisations

**Funnel conversion by card position.** CTR increases across positions. The right panel shows orders per click, rather than the tested share of clicks resulting in purchases.

![Funnel conversion by card position](assets/funnel_conversion.png)

**Order volume and gross profit per order.** More orders can increase profit per user even when profit per order is lower.

![Daily orders and rolling gross profit per order](assets/profit_and_orders.png)

**Gross profit per order distribution.** Descriptive changes, without separate significance tests, shows the increase in low-cost sales.

![Relative change in gross profit per order by category](assets/profit_distribution.png)

## Project files and setup

- [DB_init.ipynb](DB_init.ipynb) — data inspection, preparation, and database loading.
- [EDA.ipynb](EDA.ipynb) — SQL analysis, visualisations, test design, and A/B results.
- [Create_Market_Flow.sql](Create_Market_Flow.sql) and [Market_Flow.png](Market_Flow.png) — database schema.
- [db_conn.py](db_conn.py) — PostgreSQL connection helpers.

To rerun, install the listed Python libraries plus `psycopg2-binary`, `python-dotenv`, and Jupyter. Place the eight required CSVs in `data/`: `users`, `experiment_assignments`, `sessions`, `impressions`, `clicks`, `orders`, `products`, and `support_tickets`. Set `DB_USER`, `DB_PASSWORD`, and `DB_HOST` in `.env`, then run `DB_init.ipynb` followed by `EDA.ipynb`.

The source CSVs are not included. Database initialisation recreates the `public` schema in `market_flow`; use a dedicated project database.
