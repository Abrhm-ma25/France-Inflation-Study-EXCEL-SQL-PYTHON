# 🛒📊 Study of the Impact of Inflation on Basic Products in France

This project analyzes the evolution of inflation in France between 2015 and 2023, identifying which products are most sensitive to price changes. The focus is on fast-moving consumer goods (meat, drinks, hygiene products, and other food products).  
It is based on **public data from INSEE** (the French National Institute of Statistics and Economic Studies).

---

## ℹ️ What is the IPC (CPI)?

**IPC** stands for _Indice des Prix à la Consommation_ (in English: **Consumer Price Index**, CPI).  
The CPI is the primary tool for measuring inflation. It estimates the average change over time in the prices of goods and services purchased by households. The index is calculated monthly by INSEE.

- The CPI is based on tracking a fixed "basket" of goods and services, updated annually to reflect household consumption habits.
- Each item in the basket is weighted according to its share in household spending.
- The CPI is **not** a cost-of-living index; it specifically measures price changes, not the cost required to maintain a certain standard of living.
- The CPI is widely used to adjust contracts, pensions, and the minimum wage (SMIC) in France.

**Abbreviation in French:** IPC  
**Abbreviation in English:** CPI

---

## 🧰 Data Used

### 1. Consumer Price Index – 2015 Base (IPC, INSEE)
- **Source:** [INSEE](https://www.data.gouv.fr/fr/datasets/indice-des-prix-a-la-consommation-base-2015-ensemble-des-menages-france/#/resources)
- **File:** `ipc-base-2015.csv`
- **Description:** Monthly evolution of the Consumer Price Index (CPI/IPC) with 2015 as the reference base, covering all categories (food, energy, etc.).

> _**Note:** This dataset is essential for analyzing overall inflation trends and comparing sectoral impacts over time._

**Used for:**
- Temporal analysis of inflation.
- Calculation of annual (year-on-year) variations.
- Sectoral comparison to identify the most affected segments.

---

### 2. Prices of Fast-Moving Consumer Goods – INSEE IPC Flash
- **Source:** [INSEE – IPC Flash](https://www.insee.fr/fr/statistiques/7766527#tableau-ipgd-g2-fr)
- **File:** `ipc_flash_manual.csv` (manually copied into Google Sheets)
- **Description:** Manually extracted data on specific products, not available for bulk download.

> _**Note:** This data allows for a more detailed analysis of price changes in specific product categories._

**Used for:**
- Detailed comparison of prices for targeted categories.
- Study of product sensitivity to inflation.

---

## 🧠 Expected Results

- Identify which products are most sensitive to price changes.
- Propose explanatory hypotheses for further research (energy, geopolitics, health crises, etc.).

---

## 📁 Project Structure

📦 Projet-Etude-Inflation

<img src="https://github.com/Abrhm-ma25/Projet-Etude-Inflation/blob/main/Structure%20Projet%20inflation.png?raw=true" alt="Project structure" width="300"/>

---

## 🛠️ Work Plan

### 1. 🔍 Excel Work – Quick Preparation
- Import raw data.
- Light cleaning: check date formats, remove null values.
- Add helper columns using Excel functions to facilitate SQL processing (sorting and aggregations).


---

### 2. 🧮 SQL Work – Table Construction
- Import the files `ipc-base-2015.csv` and `ipc_flash_manual.csv` as *IPC base* and *IPC flash*.
- Standardize formats (dates, numbers).
- Clean: remove unnecessary columns.
- Merge the two datasets on the date, filter for the 2015–2023 period → create `ipc_complete`.
- Create a table `ipc_Analyse` containing monthly and annual variations.


---

### 3. 📊 Python Analysis – Visualization and Interpretation
- Use `ipc_Analyse` and `ipc_complete` to:
  - Calculate the correlation between product price variations and the CPI.
  - Estimate beta (sensitivity to inflation).
  - Generate interactive and statistical visualization charts.


---
