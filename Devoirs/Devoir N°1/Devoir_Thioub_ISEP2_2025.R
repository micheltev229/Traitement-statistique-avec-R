# Chargement des bibliothèques nécessaires
library(dplyr)

# Création du dataframe des continents
continents <- data.frame(
  Continent = c("Afrique", "Asie", "Europe", "Amérique du Nord", "Amérique du Sud", "Océanie", "Antarctique"),
  Population = c(1300, 4600, 750, 370, 430, 42, 0),  # Population en millions
  Superficie = c(30370000, 44579000, 10180000, 24709000, 17840000, 8526000, 14000000),  # Superficie en km²
  Nombre_Pays = c(54, 49, 44, 23, 12, 14, 0),  # Nombre de pays
  PIB_Total = c(2500, 31000, 22000, 24000, 3900, 1600, 0),  # PIB total en milliards de dollars
  PIB_Par_Habitant = c(1900, 6700, 29000, 65000, 9000, 38000, 0),  # PIB par habitant en dollars
  Esperance_Vie = c(64, 73, 78, 79, 75, 82, 0),  # Espérance de vie en années
  Taux_Natalite = c(33, 18, 10, 12, 17, 13, 0),  # Taux de natalité (pour 1000 habitants)
  Taux_Mortalite = c(8, 7, 10, 8, 6, 7, 0),  # Taux de mortalité (pour 1000 habitants)
  Taux_Alphabetisation = c(65, 91, 99, 97, 93, 96, 0),  # Taux d'alphabétisation (%)
  Densite_Population = c(43, 103, 74, 15, 24, 5, 0),  # Densité de population (habitants/km²)
  Langues_Principales = c("Arabe, Swahili, Français", "Chinois, Hindi, Arabe", "Anglais, Français, Allemand", "Anglais, Espagnol, Français", "Espagnol, Portugais", "Anglais, Maori", "Aucune"),  # Langues principales
  Climat = c("Désertique, Tropical", "Diversifié (Tropical, Tempéré, Polaire)", "Tempéré, Continental", "Tempéré, Arctique", "Tropical, Tempéré", "Tempéré, Tropical", "Polaire"),  # Climat dominant
  Principales_Religions = c("Islam, Christianisme", "Islam, Hindouisme, Bouddhisme", "Christianisme, Athéisme", "Christianisme", "Christianisme", "Christianisme, Animisme", "Aucune")  # Religions principales
)

# Section 1 : Types de Données en R
# Vérification des types de données dans le dataframe
str(continents)

# Conversion de la colonne Continent en facteur
continents$Continent <- factor(continents$Continent)
print(levels(continents$Continent))  # Affiche les niveaux du facteur

# Section 2 : Opérateurs en R
# Opérateurs arithmétiques : Calcul de la densité de population
continents$Densite_Population <- continents$Population * 1e6 / continents$Superficie
print(continents$Densite_Population)

# Opérateurs de comparaison : Filtrage des continents avec une population > 500 millions
grands_continents <- continents[continents$Population > 500, ]
print(grands_continents)

# Opérateurs logiques : Filtrage des continents avec une espérance de vie > 70 ans
continents_vie_longue <- continents[continents$Esperance_Vie > 70, ]
print(continents_vie_longue)

# Section 3 : Manipulation de Base des Données
# Création de séquences pour l'indexation
seq_population <- seq(1, nrow(continents), by = 2)
print(seq_population)

# Indexation des lignes et colonnes
print(continents[1:3, ])  # Premières 3 lignes
print(continents[, c("Continent", "Population")])  # Colonnes Continent et Population

# Section 4 : Fonctions Utiles
# Statistiques descriptives
mean_population <- mean(continents$Population)
print(paste("Moyenne de la population :", mean_population))

sd_superficie <- sd(continents$Superficie)
print(paste("Écart-type de la superficie :", sd_superficie))

# Gestion des valeurs manquantes (ajout d'une valeur manquante pour l'exemple)
continents$Population[1] <- NA
print(sum(is.na(continents$Population)))  # Nombre de valeurs manquantes

# Filtrage des valeurs manquantes
continents_clean <- na.omit(continents)
print(continents_clean)

# Section 5 : Conclusion
# Affichage final du dataframe nettoyé
print("Dataframe final après manipulation :")
print(continents_clean)