# -*- coding: utf-8 -*-
"""
Created on Mon Apr 21 13:45:49 2025

@author: Easy Services Pro
"""

# -*- coding: utf-8 -*-

"""
Analyse des données agricoles africaines – Grandes cultures
TP de Statistiques Agricoles – ENSAE / ISEP2

Ce script réalise :
1. Le nettoyage et la préparation des données
2. Le calcul d’indicateurs agro-économiques pondérés par superficie
3. La visualisation de ces indicateurs
4. Une régression linéaire pondérée pour expliquer le rendement de l’arachide

Auteur : Math SOCE
Date : Avril 2025
"""

# ======================================================================
# IMPORTS & CONFIGURATIONS
# ======================================================================
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.linear_model import LinearRegression
from scipy.stats import entropy
import sys
import os

# Pour afficher tous les résultats de dataframe
pd.set_option('display.max_columns', None)

# ======================================================================
# 2.1 CHARGEMENT ET PRÉPARATION DES DONNÉES
# ======================================================================

#1. Explorer le dataset base_TP2
# Charger la base
sys.path.append("C:\\Users\\Easy Services Pro\\OneDrive\\Bureau\\ENSAE_ISEP2\\Semestre2\\Statistique\\Statistiques agricoles\\TP2-de-statistiques-agricoles")
data = pd.read_stata("C:\\Users\\Easy Services Pro\\OneDrive\\Bureau\\ENSAE_ISEP2\\Semestre2\\Statistique\\Statistiques agricoles\\TP2-de-statistiques-agricoles\\base_TP2.dta")

# Affichage initial
print(f"Nombre d’observations : {data.shape[0]}")
print(f"Nombre de variables : {data.shape[1]}")
print(f"Variables disponibles : {list(data.columns)}")
print("\nAperçu des données :\n", data.head())

#2. Inspecter la variable ID pour les doublons
print("Nombre de doublons sur ID :", data.duplicated("ID").sum())
print("L’ID peut être dupliqué car un ménage peut cultiver plusieurs spéculations")

#3. Liste des spéculations présentes
SPECULATIONS = data["cropname"].unique()
print("\nLes spéculations agricoles présentes sont :", SPECULATIONS)

#4. Suppression des observations pour lesquelles les productions et les superficies sont toutes deux nulles
data = data[~((data['cprod'] == 0) & (data['area'] == 0))]

#5. Ramener à missing les prix valant ”99”
data['cpg'] = data['cpg'].replace(99, np.nan)

# 6. Imputation des prix manquants (moyenne pondérée par superficie)
# Définition d'une fonction pour imputer les prix manquants avec une moyenne pondérée par la superficie
def impute_weighted_price(group):
    # Création d'un masque booléen pour identifier les valeurs non manquantes dans la variable 'cpg' (prix)
    valid = group['cpg'].notna()
    # Si aucune valeur n’est valide dans le groupe (tout est manquant), on retourne les valeurs originales (pas d’imputation possible)
    if valid.sum() == 0:
        return group['cpg']
    # Calcul de la moyenne pondérée des prix disponibles, en pondérant chaque prix par la superficie correspondante
    mean = np.average(group.loc[valid, 'cpg'], weights=group.loc[valid, 'cland'])
    # Remplacement des valeurs manquantes par cette moyenne pondérée, les autres valeurs sont conservées telles quelles
    return group['cpg'].fillna(mean)

# Application de la fonction d'imputation sur les groupes (commune, cropname)
data['cpg'] = data.groupby(['commune', 'cropname']).apply(impute_weighted_price).values

# 7. Transformation en format wide (une ligne par ménage)
#Chemin de sortie corrigé (échappement des backslashes)
output_dir = r"C:\Users\Easy Services Pro\OneDrive\Bureau\ENSAE_ISEP2\Semestre2\Statistique\Statistiques agricoles\TP2-de-statistiques-agricoles\tp3-indicateurs-de-base-mathlsedensae\Output"
os.makedirs(output_dir, exist_ok=True)

wide_data = data.pivot_table(
    index=['ID', 'zone', 'commune', 'if_extworkers', 'seedsexp', 'fertexp'],  # Variables d’identification qui restent en lignes
    columns='cropname',  # La variable qui sera transformée en colonnes (chaque culture devient un sous-ensemble de colonnes)
    values=['cprod', 'area', 'cpg', 'cqsold', 'cland'],  # Variables que l'on souhaite répartir selon les cultures
    aggfunc='first',  # Fonction d’agrégation utilisée en cas de doublon (ici, on prend la première valeur)
    observed=True  # Utilise uniquement les combinaisons observées (évite de créer des colonnes inutiles pour des couples culture/valeur inexistants)
)

# Fusion des noms de colonnes multi-niveaux (ex : ('area', 'mil')) en chaînes uniques (ex : 'area_mil')
wide_data.columns = ['_'.join(col) for col in wide_data.columns]

# Réinitialisation de l’index pour remettre les variables d’identification comme colonnes classiques
wide_data.reset_index(inplace=True)

# Export vers Excel
wide_data.to_excel(
    os.path.join(output_dir, "donnees_agricoles_wide.xlsx"),  # Chemin complet
    index=False,  # Sans exporter l'index
    sheet_name='Donnees_wide',  # Nom de feuille
    engine='openpyxl'  # Moteur d'écriture
)

# Export vers Stata
wide_data.to_stata(
    os.path.join(output_dir, "donnees_agricoles_wide.dta"),  # Chemin complet
    write_index=False,  # Sans exporter l'index
    version=118  # Version 118 de Stata (compatible avec les versions récentes)
)

# Affichage de la table obtenue
print(f"Nombre d’observations : {wide_data.shape[0]}")
print(f"Nombre de variables : {wide_data.shape[1]}")
print(f"Variables disponibles : {list(wide_data.columns)}")
print("\nAperçu des données :\n", wide_data.head())

# ======================================================================
# 2.2 CALCUL DES INDICATEURS AGRICOLES (PONDÉRÉS)
# ======================================================================

# 1. Calcul du rendement agricole (en kg/ha) pour chaque culture
for crop in SPECULATIONS:
    prod, cland = f"cprod_{crop}", f"cland_{crop}"  # Remplace area par cland
    if prod in wide_data and cland in wide_data:  # Vérification que les données de production et de superficie existent
        wide_data[f"yield_{crop}"] = wide_data[prod] / wide_data[cland]  # Calcul du rendement (production / superficie)

# 2. Calcul de la part des superficies par culture (%)
total_cland = wide_data[[f"cland_{c}" for c in SPECULATIONS if f"cland_{c}" in wide_data]].sum(axis=1)  # Somme des superficies totales
for crop in SPECULATIONS:
    cland = f"cland_{crop}"  # Superficie de la culture
    if cland in wide_data:  # Vérification que la superficie existe
        wide_data[f"share_cland_{crop}"] = wide_data[cland] / total_cland * 100  # Calcul de la part des superficies par culture en pourcentage

# 3. Calcul du taux d’autoconsommation (%)
for crop in SPECULATIONS:
    prod, sold = f"cprod_{crop}", f"cqsold_{crop}"  # Production et quantité vendue
    if prod in wide_data and sold in wide_data:  # Vérification que les données de production et de vente existent
        wide_data[f"autocons_{crop}"] = (wide_data[prod] - wide_data[sold]) / wide_data[prod] * 100  # Calcul du taux d'autoconsommation

# 4. Calcul de l’indice de diversité de Shannon (pondéré par cland)
def shannon_index(row):
    clands = np.array([row[f"cland_{c}"] for c in SPECULATIONS if f"cland_{c}" in row and pd.notna(row[f"cland_{c}"])])  # Récupération des superficies non nulles
    if clands.sum() == 0:  # Si la somme des superficies est nulle, retourne NaN
        return np.nan
    proportions = clands / clands.sum()  # Calcul des proportions des superficies
    return entropy(proportions)  # Calcul de l'indice de Shannon

wide_data["shannon_index"] = wide_data.apply(shannon_index, axis=1)  # Applique la fonction à chaque ligne du DataFrame
# Affichage des résultats finaux
print(wide_data)


# ======================================================================
# 2.3 VISUALISATIONS (MOYENNES PONDÉRÉES) - Version avec export séparé
# ======================================================================

# =====================
# 1. Graphique Camembert : Répartition des superficies par culture
# =====================

# Création d'une nouvelle figure de taille 10x8 pouces
plt.figure(figsize=(10, 8))
# Liste des colonnes de superficies existantes pour chaque spéculation
share_cols = [f"cland_{c}" for c in SPECULATIONS if f"cland_{c}" in wide_data]
# Dictionnaire des superficies totales par culture (clés = noms cultures)
weighted_shares = {
    col.replace("cland_", ""): np.nansum(wide_data[col]) for col in share_cols
}
# Création et configuration du camembert
pd.Series(weighted_shares).sort_values().plot.pie(
    autopct='%1.1f%%',  # Affichage des pourcentages avec 1 décimale
    startangle=90       # Angle de départ à 90° (positionnement initial)
)
# Ajout du titre et suppression du label y inutile
plt.title("Répartition pondérée des superficies par spéculation")
plt.ylabel("")
# Ajustement de la mise en page
plt.tight_layout()
# Sauvegarde en PNG avec haute résolution (300 DPI)
plt.savefig(os.path.join(output_dir, "repartition_superficies.png"), dpi=300)
# Fermeture de la figure pour libérer la mémoire
plt.close()

# =====================
# 2. Graphique Barres : Prix moyen de l'arachide par zone
# =====================

# Nouvelle figure de taille 10x6 pouces
plt.figure(figsize=(10, 6))
# Vérification de la présence des colonnes nécessaires
if {'cpg_Arachides', 'cland_Arachides', 'zone'}.issubset(wide_data.columns):
    # Nettoyage des données (suppression des NA)
    df_arach = wide_data.dropna(subset=['cpg_Arachides', 'cland_Arachides'])
    # Calcul du prix moyen pondéré par zone (pondération par superficie)
    grouped = df_arach.groupby('zone').apply(
        lambda x: np.average(x['cpg_Arachides'], weights=x['cland_Arachides'])
    )
    # Tri et tracé des barres
    grouped.sort_values().plot.bar()
    # Ajout des titres et labels
    plt.title("Prix moyen pondéré de l'arachide par zone")
    plt.xlabel("Zone")
    plt.ylabel("Coût de production (FCFA)")
    # Ajustement et sauvegarde
    plt.tight_layout()
    plt.savefig(os.path.join(output_dir, "prix_arachide_par_zone.png"), dpi=300)
    plt.close()

# =====================
# 3. Graphique Barres : Rendement du mil par commune
# =====================

# Figure plus large (12x6) pour accommoder plusieurs communes
plt.figure(figsize=(12, 6))
if {'yield_Mil', 'cland_Mil', 'commune'}.issubset(wide_data.columns):
    # Suppression des lignes avec données manquantes
    yield_mil = wide_data.dropna(subset=['yield_Mil', 'cland_Mil'])
    # Calcul du rendement moyen pondéré par commune
    avg_yield = yield_mil.groupby('commune').apply(
        lambda x: np.average(x['yield_Mil'], weights=x['cland_Mil'])
    )
    # Tri et tracé
    avg_yield.sort_values().plot.bar()
    # Libellés
    plt.title("Rendement du mil par commune (moyenne pondérée)")
    plt.xlabel("Commune")
    plt.ylabel("Rendement (kg/ha)")
    plt.tight_layout()
    plt.savefig(os.path.join(output_dir, "rendement_mil_par_commune.png"), dpi=300)
    plt.close()

# =====================
# 4. Graphique de Régression : Relation fertilisants-rendement
# =====================
import statsmodels.api as sm
# Filtrer les données valides
reg_data = wide_data[['fertexp', 'yield_Arachides']].dropna()
# Définir la variable explicative (X) et la variable à expliquer (y)
X = reg_data['fertexp']
y = reg_data['yield_Arachides']
# Ajouter une constante pour l'interception
X = sm.add_constant(X)
# Ajuster le modèle de régression linéaire
model = sm.OLS(y, X).fit()
# Afficher le résumé des résultats
print(model.summary())

plt.figure(figsize=(10, 6))
if {'yield_Arachides', 'fertexp'}.issubset(wide_data.columns):
    # Nuage de points avec droite de régression linéaire
    sns.regplot(
        data=wide_data, 
        x='fertexp',          # Variable explicative
        y='yield_Arachides',  # Variable à expliquer
        scatter_kws={'alpha': 0.4},  # Transparence des points
        line_kws={'color': 'red'}    # Couleur de la ligne de régression
    )
    # Titres et axes
    plt.title("Fertilisants vs. Rendement de l'arachide")
    plt.xlabel("Dépenses en fertilisants (FCFA)")
    plt.ylabel("Rendement (kg/ha)")
    plt.tight_layout()
    plt.savefig(os.path.join(output_dir, "relation_fertilisants_rendement.png"), dpi=300)
    plt.close()

# Message de confirmation
print(f"Les graphiques ont été exportés dans le dossier : {output_dir}")


# ======================================================================
# 2.4 BONUS : RÉGRESSION PONDÉRÉE SUR LE RENDEMENT ARACHIDE
# ======================================================================

# Affichage du titre de la section
print("\n=== RÉGRESSION PONDÉRÉE : RENDEMENT ARAchide ===")

# Vérification de la présence de la variable cible
if 'yield_Arachides' not in wide_data.columns:  # Vérifier la présence de la variable cible
    print("Erreur : La variable 'yield_Arachides' est absente du dataset.")  # Afficher un message d'erreur si elle est absente
else:
    print("Variable cible 'yield_Arachides' détectée.")  # Afficher un message de confirmation si elle est présente

    # Définir les variables nécessaires pour l'analyse
    required_vars = [
        'yield_Arachides',    # Variable cible
        'if_extworkers',      # Utilisation de main-d'œuvre externe
        'seedsexp',           # Dépenses en semences
        'fertexp',            # Dépenses en engrais
        'cpg_Arachides',      # Coût global de production
        'shannon_index',    # Indice de diversité culturale
        'cland_Arachides'     # Superficie comme poids
    ]

    # Vérification des variables manquantes
    missing_vars = [var for var in required_vars if var not in wide_data.columns]  # Liste des variables manquantes
    if missing_vars:
        print(f"Erreur : Variables manquantes : {missing_vars}")  # Afficher les variables manquantes
    else:
        print("Toutes les variables requises sont présentes.")  # Afficher un message de confirmation si toutes les variables sont présentes

        # Nettoyage : suppression des observations incomplètes
        model_data = wide_data.dropna(subset=required_vars)  # Suppression des lignes avec des valeurs manquantes
        n_initial = len(wide_data)  # Nombre de lignes avant nettoyage
        n_final = len(model_data)  # Nombre de lignes après nettoyage
        print(f"\nDonnées initiales : {n_initial}")
        print(f"Données après nettoyage : {n_final} ({n_final / n_initial * 100:.1f}%)")

        if n_final == 0:
            print("Aucune observation complète pour la régression.")  # Afficher un message d'erreur si aucune donnée valide n'est disponible
        else:
            # Définition des variables explicatives et de la cible
            X = model_data[['if_extworkers', 'seedsexp', 'fertexp', 'cpg_Arachides', 'shannon_index']]  # Variables explicatives
            y = model_data['yield_Arachides']  # Variable cible
            weights = model_data['cland_Arachides']  # Pondération basée sur la superficie

            # Régression linéaire pondérée
            reg = LinearRegression()  # Initialisation du modèle de régression
            reg.fit(X, y, sample_weight=weights)  # Entraînement du modèle avec pondération

            # Résultats du modèle
            r2 = reg.score(X, y, sample_weight=weights)  # R² pondéré
            coefficients = reg.coef_  # Coeff
            intercept = reg.intercept_ # Récupère l'ordonnée à l'origine (intercept) du modèle de régression.

            # Tableau des résultats
            results = pd.DataFrame({
            'Variable': X.columns,  # Crée une colonne avec les noms des variables explicatives.
            'Coefficient': coefficients,  # Ajoute les coefficients associés à chaque variable.
            'Importance_absolue': np.abs(coefficients),  # Calcule l'importance absolue de chaque coefficient.
            'Elasticité': coefficients * X.mean() / y.mean()  # Calcule l'élasticité en fonction des moyennes de X et y.
            }).sort_values(by='Importance_absolue', ascending=False)  # Trie les variables par ordre décroissant de l'importance absolue des coefficients.

            # Coefficients standardisés
            X_std = X.std()  # Calcule l'écart type de chaque variable explicative.
            results['Coeff_std'] = results['Coefficient'] * X_std  # Standardise les coefficients en les multipliant par l'écart type de X.

            print("\nRésultats de la régression pondérée :")  # Affiche un titre pour les résultats.
            print(f"• R² pondéré : {r2:.3f}")  # Affiche le R² pondéré avec trois décimales.
            print(f"• Intercept : {intercept:.2f}")  # Affiche l'intercept du modèle avec deux décimales.
            print("\nCoefficients standardisés :")  # Affiche un titre pour les coefficients standardisés.
            print(results[['Variable', 'Coefficient', 'Coeff_std', 'Elasticité']].to_string(index=False))  # Affiche le tableau des résultats sans les index.

            # Visualisation : Importance relative des variables
            plt.figure(figsize=(10, 6))  # Crée une figure avec une taille de 10x6 pouces.
            sns.barplot(
            data=results.sort_values('Coeff_std', ascending=False),  # Trie les résultats par les coefficients standardisés.
            x='Coeff_std',  # L'axe des x correspond aux coefficients standardisés.
            y='Variable'  # L'axe des y correspond aux noms des variables.
            )
            plt.title('Importance relative des variables (coefficients standardisés)')  # Titre du graphique.
            plt.xlabel('Coefficient standardisé')  # Libellé de l'axe des x.
            plt.ylabel('Variable')  # Libellé de l'axe des y.
            plt.tight_layout()  # Ajuste la mise en page pour éviter les chevauchements.
            plt.savefig(os.path.join(output_dir, "importance_variables.png"), dpi=300)  # Exporte le graphique
            plt.show()  # Affiche le graphique.

            # Résidus
            y_pred = reg.predict(X)  # Prédit les valeurs de y à partir des variables explicatives X.
            residuals = y - y_pred  # Calcule les résidus (différence entre les valeurs réelles et prédites).

            # Visualisation : Analyse des résidus
            plt.figure(figsize=(12, 5))  # Crée une figure avec une taille de 12x5 pouces.

            # Histogramme des résidus
            plt.subplot(1, 2, 1)  # Divise la figure en 1 ligne et 2 colonnes, et sélectionne le premier sous-graphique.
            sns.histplot(residuals, kde=True)  # Trace l'histogramme des résidus avec une estimation de la densité.
            plt.title('Distribution des résidus')  # Titre du graphique.

            # Nuage de points résidus vs prédictions
            plt.subplot(1, 2, 2)  # Sélectionne le deuxième sous-graphique.
            plt.scatter(y_pred, residuals, alpha=0.6)  # Trace un nuage de points des résidus vs les valeurs prédites.
            plt.axhline(0, color='red', linestyle='--')  # Trace une ligne horizontale rouge à y=0.
            plt.xlabel('Valeurs prédites')  # Libellé de l'axe des x.
            plt.ylabel('Résidus')  # Libellé de l'axe des y.
            plt.title('Résidus vs Prédictions')  # Titre du graphique.

            plt.tight_layout()  # Ajuste la mise en page pour éviter les chevauchements.
            plt.savefig(os.path.join(output_dir, "analyse_residus.png"), dpi=300)  # Exporte le graphique
            plt.show()  # Affiche le graphique.