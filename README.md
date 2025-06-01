# RFM Analysis (PostgreSQL + Power BI)

RFM segmentation | Channel effectiveness | Cohort retention

---

## Project Setup

**`setup_instructions.txt`**:

1. Create a PostgreSQL instance using **Docker Compose**.
2. Create the database **schema** with tables:
   - `users`
   - `transactions`

---

## Metrics & Segmentation

**`rfm_metrics.sql`**:

- Calculate RFM scores (Recency, Frequency, Monetary) for each user.
- Assign **RFM segments** based on score combinations.
- Group users like:
  - `Champions`
  - `Loyal Customers`
  - `Potential Loyalists`
  - `At Risk`
  - `Lost`
  - and others.

---

## Segment Revenue & ARPU

**`rfm_stats.sql`**:

- Calculates **total revenue per segment**.
- Computes **ARPU** (Average Revenue per User).
---

## Outlier Detection

**`rfm_outliers.sql`**:

- **z-score analysis** to monetary scores.
- Identified **14 outliers** with `z_score > 3`
- It was decided to keep them in the analysis.

---

## Dashboards (Power BI)

1. **Customer Segments Dashboard (RFM)**
   - Treemap based on segment sizes, metric slices for narrowing, key metrics in tabular.
   - Drill-through page for additional user details by each segment.

2. **Acquisition Channel Effectiveness**
   - Compares volume and quality (avg RFM score) across channels to identify high-volume vs. high-value channels.
   - Showcases channel distribution over time.
   - Labels underperforming channels using calculated metrics.

3. **Cohort Analysis**
   - Tracks user retention over monthly cohorts.
   - Conditional formatting based on cohort values.

---

---

## Key Findings

- **Champions** are **16% of total users** but bring **54% of total revenue**.
- **At Risk** customers have **below average RFM Score** but **relatively high ARPU (Avg Revenue Per User)**.
- **Direct and Referral channels** showcase **big volumes** both in customers and sales but **lower RFM Scores**. Great channels for acquisition, less engaging though.
- **Newsletter** channel has **lower volumes** but **higher average RFM score**. Slow burn, brings customers with higher loyalty.
- **High first month churn** in specific months, especially in **September 2018**.
- **Diagonal values in cohort analysis** (same month) are mostly declining. Need attention.
- The **March 2018 cohort** displays better engagement. **50% of users were still active after 3 months** compared to **9.80% of the June 2018 cohort**.
- **14 outliers detected** with extreme monetary scores in **Champions** and **Loyal Customer** segments. It was decided to **proceed without dropping** them.

---

## Recommendations

- **Reward Champions** segment with **exclusive and personalized offers** and investigate **WHY** they are loyal.
- **Target and offer incentives** to **At Risk** customers to win them back since they are **relatively high spenders** (high ARPU).
- **Promote Newsletter** channel. Brings in **loyal, high-value customers**.
- **Optimize Direct and Referral channels** to be more engaging after first acquisition. **Frequent follow-ups** to feel the vibe.
- **Reduce budgets** in underperforming channels (**Tiktok, Facebook, Google Ads**) and **run A/B tests** before launching.
- **Improve engagement in the first month** to reduce the observed **high churn**. Re-evaluate the strategy followed after subscribing.
- **Run campaigns for low retention months** (**May to October**).



---

