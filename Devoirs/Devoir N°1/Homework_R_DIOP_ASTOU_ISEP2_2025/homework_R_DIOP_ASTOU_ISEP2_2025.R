
""" DIOP ASTOU HOMEWORK 1 """

# Chargement des packages
library(dplyr)
library(magrittr)  # Pour utiliser l'opérateur pipe %>%

# 1. CRÉATION D'UN DATAFRAME AVEC 10 VARIABLES ET 30 OBSERVATIONS
set.seed(123) # Assurer la reproductibilité des résultats
df <- data.frame(
  id = 1:30,  # Identifiant unique
  nom = sample(LETTERS, 30, replace = TRUE),  # Chaîne de caractères (string)
  age = sample(18:65, 30, replace = TRUE),  # Numérique (entier)
  salaire = round(runif(30, 1500, 5000), 2),  # Numérique (salaire aléatoire)
  genre = factor(sample(c("Homme", "Femme"), 30, replace = TRUE)),  # Facteur
  groupe = factor(sample(LETTERS[1:3], 30, replace = TRUE)),  # Facteur (catégorie A, B, C)
  score = sample(1:100, 30, replace = TRUE),  # Numérique (score sur 100)
  actif = sample(c(TRUE, FALSE), 30, replace = TRUE),  # Booléen
  niveau = factor(sample(c("Bac", "Licence", "Master"), 30, replace = TRUE)),  # Facteur
  evaluation = rnorm(30, mean = 10, sd = 2)  # Numérique (notation aléatoire)
)

# 2. OPÉRATEURS ARITHMÉTIQUES, DE COMPARAISON ET LOGIQUES
## a) Opérations arithmétiques
df$salaire_apres_impot <- df$salaire * 0.75  # Réduction de 25% d'impôt
df$bonus <- df$score / 10  # Score divisé par 10
df$revenu_total <- df$salaire + df$bonus  # Salaire + bonus

## b) Opérateurs de comparaison
df$est_riche <- df$salaire > 4000  # Indique si le salaire est > 4000
df$score_faible <- df$score < 50  # Score inférieur à 50 ?

## c) Opérateurs logiques
df$score_bonus <- ifelse(df$score > 50 & df$actif, df$score + 10, df$score) # Si actif et score > 50, +10

# 3. MANIPULATION DES DONNÉES AVEC DPLYR
## a) Sélection et filtrage
df_selection <- df %>%
  select(id, age, salaire, genre) %>%
  filter(salaire > 3000)  # Garde les salaires > 3000

## b) Modification conditionnelle
df <- df %>%
  mutate(categorie_salaire = if_else(salaire > 3500, "Élevé", "Moyen"))

## c) Création d'une séquence avec seq et rep
df$indice <- seq(1, 30, by = 1)  # Séquence simple
df$groupe_repetitif <- rep(c("X", "Y", "Z"), each = 10)  # Répétition

# 4. INDEXATION AVANCÉE
## a) Indexation des vecteurs
df$age_sup_30 <- df$age[df$age > 30]  # Extraction des âges supérieurs à 30

## b) Indexation des dataframes
df_femmes <- df[df$genre == "Femme", ]  # Extraction des femmes

## c) Opérateur pipe (%>%) pour transformation
df_resume <- df %>%
  group_by(genre) %>%
  summarise(moyenne_salaire = mean(salaire), max_score = max(score))

## d) Utilisation de l'opérateur natif (|>)
df_salaire_eleve <- df |> filter(salaire > 4000)

# 5. TRAVAIL AVEC DES MATRICES ET ARRAYS
## a) Création d'une matrice
matrice_salaire <- matrix(df$salaire[1:9], nrow = 3, ncol = 3)

## b) Création d'un array
array_data <- array(1:24, dim = c(3, 4, 2))  # Tableau 3x4x2

# AFFICHAGE DES RÉSULTATS
print(head(df, 10))  # Aperçu du dataframe
print(df_resume)  # Résumé des données
print(matrice_salaire)  # Affichage de la matrice
print(array_data)  # Affichage de l'array


