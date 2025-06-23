# 🛒📊 Impact of Inflation on Essential Consumer Goods in France (2015–2023)

This project analyzes the evolution of inflation in France between 2015 and 2023, identifying which product categories are most sensitive to price changes. The focus is on fast-moving consumer goods (meat, drinks, hygiene products, and other food products).  
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
## 📁 Project Structure

📦 Projet-Etude-Inflation

<img src="https://github.com/Abrhm-ma25/Projet-Etude-Inflation/blob/main/Structure%20Projet%20inflation.png?raw=true" alt="Project structure" width="300"/>

---

## 🛠️ Work Plan

### 1. 🔍 Excel Work – Quick Preparation
- Import raw data `ipc-base-2015.csv` and `ipc_flash_manual.csv`.
- Light cleaning: check date formats, remove null values.
- Add helper columns using Excel functions to facilitate SQL processing (sorting and aggregations).


---

### 2. 🧮 SQL Work – Table Construction
- Import the files cleaned `ipc-base-2015.csv` and `ipc_flash_manual.csv` as *IPC base* and *IPC flash*.
- Standardize formats (dates, numbers).
- Clean: remove unnecessary columns.
- Merge the two datasets on the date, filter for the 2015–2023 period → create `ipc_complete`.
- Create a table `ipc_Analyse` containing monthly and annual variations.

<img src="https://github.com/Abrhm-ma25/Projet-Etude-Inflation/blob/main/LEXICON.png" width="600"/>

IPC Complete:

<img src="https://github.com/Abrhm-ma25/Projet-Etude-Inflation/blob/main/IPC COMPLETE.png" width="600"/>

IPC Analyse:

<img src="https://github.com/Abrhm-ma25/Projet-Etude-Inflation/blob/main/IPC ANALYSE.png" width="600"/>


---

### 3. 📊 Python Analysis – Visualization and Interpretation
- Use `ipc_Analyse` and `ipc_complete` to:
    - Generate interactive and statistical visualization charts.
    - Calculate the correlation between product price variations and the CPI.
    - Estimate beta (sensitivity to inflation).


<img src="https://github.com/Abrhm-ma25/Projet-Etude-Inflation/blob/main/Monthly variation of Indices.png" width="600"/>

---

## 🔍 Key Insights & Results

### 📊 Correlation Heatmap

<img src="https://github.com/Abrhm-ma25/Projet-Etude-Inflation/blob/main/Correlation%20heatmap.png" width="600"/>

This heatmap highlights the strength of correlation between general inflation and various product categories.

### 📉 Beta Coefficients

<img src="https://github.com/Abrhm-ma25/Projet-Etude-Inflation/blob/main/Beta%20coefficients.png" width="600"/>

The β values represent the **sensitivity** of each product categories to general inflation, based on linear regression.  
A higher β implies a stronger reaction to changes in the overall CPI.

### 📐 Sensitivity Table

<img src="https://github.com/Abrhm-ma25/Projet-Etude-Inflation/blob/main/Sensitivity.png" width="400"/>

This visualization provides additional interpretability of inflation responsiveness.

---

## 🧭 Conclusion

Hygiene and beauty products show the highest sensitivity to general inflation (β = 0.68),
followed by other food products (β = 0.62), meat (β = 0.60), and beverages (β = 0.44).

This suggests that non-essential or globally sourced goods are more reactive to inflationary shocks,
while staple foods move together but are less directly driven by the general price index.

The moderate R² values (0.19–0.23) indicate that much of the price variation is due to sector-specific factors
or external shocks, not just general inflation.

Future research could explore the role of supply chains, international prices, and consumer behavior
in shaping these sensitivities.
