School of Analytics Hackathon 2026 — Synthetic Marketplace Product Analytics Dataset

Scenario:
A marketplace tested a new AI recommendation model on the homepage for 30 days.
Participants need to decide whether the model should be rolled out to all users, rolled out to selected segments, or rejected.

Tables:
users.csv, experiment_assignments.csv, sessions.csv, impressions.csv, clicks.csv, orders.csv, products.csv, sellers.csv, support_tickets.csv, premium_subscriptions.csv, data_dictionary.csv

Business logic:
- Every impression belongs to one session and one user.
- Clicks are generated only from clicked impressions.
- Orders are generated only after clicks and preserve click/session/user consistency.
- Products belong to sellers and categories.
- Returns are possible only for existing orders.
- Support tickets are linked to users and orders.
- The experiment generally improves CTR and GMV, but also increases returns and support contacts.
- Effects are heterogeneous by device, category, region, premium status, and user tenure.

Intentional data quality issues:
- ~0.6% of users have duplicate experiment assignments to both groups.
- ~0.8% of users are bot-like users with unusually high activity.
- ~4% of orders have missing delivery_fee_rub.
- ~0.3% of impressions have is_duplicate_event=1.
- Some returns occur after the 30-day observation window.

Generated summary:
Users: 50,000
Products: 4,500
Sellers: 700
Sessions: 164,739
Impressions: 1,066,434
Clicks: 91,266
Orders: 7,407
Returns: 462
Support tickets: 337
Premium subscription rows: 9,127
Control users: 24,815
Test users: 25,185
