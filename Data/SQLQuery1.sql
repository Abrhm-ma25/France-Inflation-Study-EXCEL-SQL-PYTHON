/*****************************************************************************************
    PART 1: DATA STRUCTURE VERIFICATION
    -----------------------------------
    This section checks the structure of the two imported tables (ipc_base and ipc_flash)
    by listing their columns and data types. This is useful to ensure that the data
    imported matches the expected schema before any further processing is done.
******************************************************************************************/

SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ipc_base';

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ipc_flash';


/*****************************************************************************************
    PART 2: DATA CONSOLIDATION AND CLEANING
    ---------------------------------------
    - Create a new table (ipc_complete) to consolidate data from both ipc_base and ipc_flash.
    - Insert merged data for the years 2015 to 2023 (2015 is the reference year and ipc_flash
      is limited to data up to 01/2024).
    - Remove unnecessary columns used only for merging or technical purposes.
    - Standardize and clean the date column, then extract year and month for further analysis.
******************************************************************************************/

-- Create the consolidated table
CREATE TABLE ipc_complete (
    Periode VARCHAR(20),
    IPC FLOAT,
    Viandes FLOAT,
    Boissons FLOAT,
    [Autres produits alimentaires] FLOAT,
    [Entretien-hygiène-beauté] FLOAT,
    Date2 DATE,
    [JOIN] DATE,
    [LEFT] VARCHAR(50),
    [RIGHT] VARCHAR(50),
    [DAY] INT
);

-- Insert merged data for the selected years
INSERT INTO ipc_complete
SELECT 
    b.Periode,
    b.IPC,
    f.Viandes,
    f.Boissons,
    f.[Autres produits alimentaires],
    f.[Entretien-hygiène-beauté],
    b.Date2,
    b.[JOIN],
    b.[LEFT],
    b.[RIGHT],
    b.[DAY]
FROM ipc_base b
JOIN ipc_flash f
    ON b.[JOIN] = f.[JOIN]
WHERE YEAR(b.[JOIN]) BETWEEN 2015 AND 2023;

-- Remove columns no longer needed
ALTER TABLE ipc_complete
DROP COLUMN [LEFT], [RIGHT], [DAY], [JOIN];

-- Add and populate a new, clean date column
ALTER TABLE ipc_complete ADD [Date] DATE;
UPDATE ipc_complete
SET Date2 = CONVERT(DATE, FORMAT(Date2, 'yyyy-dd-MM'), 120);
UPDATE ipc_complete
SET [Date] = Date2;

-- Check the data type of the new Date column (optional check)
SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ipc_complete' AND COLUMN_NAME = 'Date';

-- Remove temporary Date2 column
ALTER TABLE ipc_complete DROP COLUMN Date2;

-- Add year and month columns and fill them
ALTER TABLE ipc_complete ADD Annee INT; 
ALTER TABLE ipc_complete ADD Mois INT;
UPDATE ipc_complete
SET 
    Annee = YEAR([Date]),
    Mois = MONTH([Date]);


/*****************************************************************************************
    PART 3: ANALYSIS TABLE CREATION AND POPULATION
    ----------------------------------------------
    - Create a new analysis table (IPC_Analyse) to store monthly and annual variations
      for IPC and its main components (meat, drinks, other food, hygiene).
    - Calculate for each month:
        * The annual percentage variation (compared to the same month in the previous year)
        * The monthly percentage variation (compared to the previous month)
    - Populate the analysis table with these calculated values.
******************************************************************************************/

USE Inflation_Data;
CREATE TABLE IPC_Analyse (
    Annee INT,
    Mois INT,
    Var_IPC_Mens FLOAT,
    Var_IPC_An FLOAT,
    Var_An_Viande FLOAT,
    Var_Mens_Viande FLOAT,
    Var_An_Boisson FLOAT,
    Var_Mens_Boisson FLOAT,
    Var_An_Autre_Alim FLOAT,
    Var_Mens_Autre_Alim FLOAT,
    Var_An_Hygiene FLOAT,
    Var_Mens_Hygiene FLOAT
);

-- Insert calculated variations into the analysis table
INSERT INTO IPC_Analyse (
    Annee, Mois,
    Var_An_Viande, Var_Mens_Viande,
    Var_An_Boisson, Var_Mens_Boisson,
    Var_An_Autre_Alim, Var_Mens_Autre_Alim,
    Var_An_Hygiene, Var_Mens_Hygiene,
    Var_IPC_An, Var_IPC_Mens
)
SELECT 
    ic.Annee,
    ic.Mois,

    -- Yearly and monthly variation for Viandes
    (ic.Viandes - ann.Viandes) / NULLIF(ann.Viandes, 0) * 100 AS Var_An_Viande,
    (ic.Viandes - prev.Viandes) / NULLIF(prev.Viandes, 0) * 100 AS Var_Mens_Viande,

    -- Yearly and monthly variation for Boissons
    (ic.Boissons - ann.Boissons) / NULLIF(ann.Boissons, 0) * 100 AS Var_An_Boisson,
    (ic.Boissons - prev.Boissons) / NULLIF(prev.Boissons, 0) * 100 AS Var_Mens_Boisson,

    -- Yearly and monthly variation for Other Food Products
    (ic.[Autres produits alimentaires] - ann.[Autres produits alimentaires]) / NULLIF(ann.[Autres produits alimentaires], 0) * 100 AS Var_An_Autre_Alim,
    (ic.[Autres produits alimentaires] - prev.[Autres produits alimentaires]) / NULLIF(prev.[Autres produits alimentaires], 0) * 100 AS Var_Mens_Autre_Alim,

    -- Yearly and monthly variation for Hygiene
    (ic.[Entretien-hygiène-beauté] - ann.[Entretien-hygiène-beauté]) / NULLIF(ann.[Entretien-hygiène-beauté], 0) * 100 AS Var_An_Hygiene,
    (ic.[Entretien-hygiène-beauté] - prev.[Entretien-hygiène-beauté]) / NULLIF(prev.[Entretien-hygiène-beauté], 0) * 100 AS Var_Mens_Hygiene,

    -- Yearly and monthly variation for IPC (general inflation)
    (ic.IPC - ann.IPC) / NULLIF(ann.IPC, 0) * 100 AS Var_IPC_An,
    (ic.IPC - prev.IPC) / NULLIF(prev.IPC, 0) * 100 AS Var_IPC_Mens

FROM ipc_complete ic
LEFT JOIN ipc_complete ann
    ON ann.Annee = ic.Annee - 1 AND ann.Mois = ic.Mois
LEFT JOIN ipc_complete prev
    ON (prev.Annee = ic.Annee AND prev.Mois = ic.Mois - 1)
    OR (ic.Mois = 1 AND prev.Annee = ic.Annee - 1 AND prev.Mois = 12)
WHERE ann.Annee IS NOT NULL AND prev.Annee IS NOT NULL;
