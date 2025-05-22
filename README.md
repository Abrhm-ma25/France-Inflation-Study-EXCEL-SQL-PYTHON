# 🛒📊 Étude de l’impact de l’inflation sur les produits de base en France

Ce projet vise à analyser l’évolution de l'inflation en France entre 2015 et 2024, en se concentrant sur les produits essentiels (alimentation, énergie, logement...).  
Il s’appuie sur des **données publiques de l’INSEE** pour explorer les tendances de prix et identifier les périodes de tension inflationniste.

---

## 🧰 Données utilisées

### 1. Indice des prix à la consommation - Base 2015
- **Source** : [INSEE ](https://www.data.gouv.fr/fr/datasets/indice-des-prix-a-la-consommation-base-2015-ensemble-des-menages-france/#/resources)
- **Fichier** : `ipc-base-2015.csv`
- **Description** : Évolution mensuelle de l’indice des prix à la consommation (IPC) en base 2015 pour l'ensemble des postes (alimentation, énergie, etc.).

**Utilisation dans le projet :**
- Analyse temporelle de l’inflation globale.
- Calcul des variations annuelles (glissement).
- Comparaison sectorielle pour identifier les segments les plus impactés.

---

### 2. Prix des produits de grande consommation – INSEE
- **Source** : [INSEE – IPC Flash](https://www.insee.fr/fr/statistiques/7766527#tableau-ipgd-g2-fr)
- **Fichier** : `ipc_flash_manual.csv` (copié manuellement dans Google Sheets)
- **Description** : Données extraites manuellement sur des produits spécifiques, difficiles à télécharger en masse.

**Utilisation dans le projet :**
- Comparaison fine des prix sur des postes ciblés.
- Étude de la sensibilité des produits à l’inflation.

---

## 🧠 Résultats attendus

- Déterminer quels produits sont les plus sensibles aux variations de prix.
- Identifier les périodes de chocs inflationnistes majeurs.
- Proposer des hypothèses explicatives (énergie, géopolitique, crise sanitaire…).

---

## 📁 Structure du projet

📦 Projet-Etude-Inflation/
│
├── Data/
│   ├── ipc_Analyse.csv
│   ├── ipc_complete.csv
│   ├── ipc_flash_manual.csv
│   └── ipc-base-2015.csv
│
├── Notebook/
│   └── (notebooks d’analyse Python)
│
├── SQL Script/
│   └── (scripts SQL pour le traitement initial)
│
├── README.md
└── requirements.txt


---

## 🛠️ Plan de travail

### 1. 🔍 Travail sur Excel – Préparation rapide
- Importation brute des données.
- Nettoyage léger : vérification des formats de date, suppression des valeurs nulles.
- Ajout de colonnes d’assistance pour faciliter l’analyse SQL.

🎯 **Objectif** : Structurer les fichiers pour intégration SQL.

---

### 2. 🧮 Travail sur SQL – Construction des tables
- Importation des fichiers `ipc-base-2015.csv` et `ipc_flash_manual.csv` comme *IPC base* et *IPC flash*.
- Standardisation des formats (dates, nombres).
- Nettoyage : suppression des colonnes inutiles.
- Fusion des deux jeux sur la date, filtrage de la période 2015–2023 → création de `ipc_complete`.
- Création d’une table `ipc_Analyse` contenant les variations mensuelles et annuelles.

---

### 3. 📊 Analyse Python – Visualisation et interprétation
- Utilisation de `ipc_Analyse` et `ipc_complete` pour :
  - Calculer la corrélation entre les variations des produits et les IPC.
  - Estimer le bêta (sensibilité à l’inflation).
  - Générer des graphiques de visualisation interactifs/statistiques.

---
