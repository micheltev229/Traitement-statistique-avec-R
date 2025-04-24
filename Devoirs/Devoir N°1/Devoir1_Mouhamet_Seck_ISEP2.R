## Charger la bibliothèque nécessaire
library(dplyr)

f1_2024 <- data.frame(
  Pilote = c("Max Verstappen", "Sergio Perez", "Lewis Hamilton", "George Russell", "Charles Leclerc", 
             "Carlos Sainz", "Lando Norris", "Oscar Piastri", "Fernando Alonso", "Lance Stroll", 
             "Pierre Gasly", "Esteban Ocon", "Alex Albon", "Logan Sargeant", "Valtteri Bottas", 
             "Guanyu Zhou", "Kevin Magnussen", "Nico Hülkenberg", "Yuki Tsunoda", "Daniel Ricciardo"),
  Ecurie = c("Red Bull", "Red Bull", "Mercedes", "Mercedes", "Ferrari", 
             "Ferrari", "McLaren", "McLaren", "Aston Martin", "Aston Martin", 
             "Alpine", "Alpine", "Williams", "Williams", "Sauber", 
             "Sauber", "Haas", "Haas", "RB", "RB"),
  Nationalité = c("Néerlandais", "Mexicain", "Britannique", "Britannique", "Monégasque", 
                  "Espagnol", "Britannique", "Australien", "Espagnol", "Canadien", 
                  "Français", "Français", "Thaïlandais", "Américain", "Finlandais", 
                  "Chinois", "Danois", "Allemand", "Japonais", "Australien"),
  Âge = c(26, 34, 39, 26, 26, 
          29, 24, 23, 42, 25, 
          28, 27, 27, 23, 34, 
          24, 31, 36, 23, 34),
  Courses_Disputées = c(180, 265, 332, 103, 120, 
                        180, 104, 24, 381, 140, 
                        130, 133, 84, 23, 216, 
                        46, 167, 202, 64, 240),
  Titres_Mondiaux = c(3, 0, 7, 0, 0, 
                      0, 0, 0, 2, 0, 
                      0, 0, 0, 0, 1, 
                      0, 0, 0, 0, 0),
  Pole_Positions = c(35, 12, 104, 8, 23, 
                     5, 2, 1, 22, 1, 
                     3, 1, 1, 0, 1, 
                     0, 1, 1, 1, 3),
  Podiums = c(100, 40, 197, 12, 35, 
              25, 13, 2, 107, 3, 
              4, 2, 4, 0, 67, 
              0, 2, 2, 1, 32),
  Points = c(412, 265, 314, 175, 237, 
             220, 205, 97, 400, 110, 
             90, 70, 65, 0, 150, 
             20, 15, 10, 5, 30),
  Victoires = c(15, 4, 103, 1, 5, 
                2, 1, 0, 32, 0, 
                1, 1, 0, 0, 10, 
                0, 1, 0, 0, 8)
)

# Afficher le dataframe
print(f1_2024)



#####Devoir1

##1. Types de données en R
# Vecteur numérique : Âge des pilotes
ages <- f1_2024$Âge
print(ages)
typeof(ages)

# Vecteur entier : Nombre de victoires
victoires <- f1_2024$Victoires
print(victoires)
typeof(victoires)


# Vecteur caractère : Nationalité des pilotes
nationalites <- f1_2024$Nationalité
print(nationalites)
typeof(nationalites)

# Vecteur logique : Les pilotes ont-ils remporté un titre mondial ?
a_un_titre <- f1_2024$Titres_Mondiaux > 0
print(a_un_titre)
typeof(a_un_titre)

 
# Facteur : Liste des écuries
ecuries <- factor(f1_2024$Ecurie)
print(ecuries)
levels(ecuries)

# Facteur ordonné : Expérience basée sur le nombre de courses disputées
experience <- cut(f1_2024$Courses_Disputées, 
                  breaks = c(0, 50, 150, 300, 400),
                  labels = c("Débutant", "Intermédiaire", "Expérimenté", "Légende"))
print(experience)



# Listes: Informations sur Max Verstappen sous forme de liste
verstappen_info <- list(
  Pilote = f1_2024$Pilote[1],
  Ecurie = f1_2024$Ecurie[1],
  Âge = f1_2024$Âge[1],
  Titres = f1_2024$Titres_Mondiaux[1],
  Points = f1_2024$Points[1]
)
print(verstappen_info)
##Data Frames

# Sélection des pilotes avec au moins 1 titre mondial
champions <- f1_2024[f1_2024$Titres_Mondiaux > 0, ]
print(champions)


# Matrices: Création d'une matrice avec les podiums, points et victoires
statistiques <- as.matrix(f1_2024[, c("Podiums", "Points", "Victoires")])
print(statistiques)

# Dimensions de la matrice
dim(statistiques)


# Tableau multidimensionnel (courses, pôles et points pour 5 premiers pilotes)
array_stats <- array(f1_2024[1:5, c("Courses_Disputées", "Pole_Positions", "Points")], dim = c(5, 3, 1))
print(array_stats)
###2. Opérateurs en R



# Opérateurs arithmétiques : Calcul du ratio victoires/courses
ratio_victoires <- f1_2024$Victoires / f1_2024$Courses_Disputées
print(ratio_victoires)

# Nombre total de pôles en 2024
total_poles <- sum(f1_2024$Pole_Positions)
print(total_poles)


##Opérateurs de comparaison
 

# Pilotes ayant plus de 100 podiums
pilotes_podiums_100 <- f1_2024$Pilote[f1_2024$Podiums > 100]
print(pilotes_podiums_100)


##Opérateurs logiques


# Pilotes qui ont à la fois gagné au moins une course et obtenu plus de 200 points
grands_performeurs <- f1_2024[f1_2024$Victoires > 0 & f1_2024$Points > 200, ]
print(grands_performeurs)

##Opérateurs d’assignation


# Assignation d'un pilote à une variable
meilleur_pilote <- f1_2024$Pilote[1]
print(meilleur_pilote)

# Assignation alternative
plus_jeune <- f1_2024$Pilote[which.min(f1_2024$Âge)]
print(plus_jeune)

# Assignation droite à gauche
plus_age <- f1_2024$Pilote[which.max(f1_2024$Âge)] -> pilote_plus_vieux
print(pilote_plus_vieux)

##Opérateurs spéciaux


library(magrittr)

# Moyenne des points par pilote avec %>%
f1_2024$Points %>% mean() %>% round(1)

# Moyenne des victoires avec l'opérateur natif |>
f1_2024$Victoires |> mean() |> round(1)


###3. Manipulation de base des données
##Création de séquences

# Séquence des âges des pilotes
seq(min(f1_2024$Âge), max(f1_2024$Âge), by = 2)

##Indexation des vecteurs

# Sélection des points des 5 premiers pilotes
f1_2024$Points[1:5]

##Indexation des Data Frames


# Pilotes de Ferrari
ferrari_pilotes <- f1_2024[f1_2024$Ecurie == "Ferrari", ]
print(ferrari_pilotes)

##4. Fonctions utiles

##Statistiques

# Moyenne et médiane des courses disputées
mean(f1_2024$Courses_Disputées)
median(f1_2024$Courses_Disputées)

# Écart-type des points
sd(f1_2024$Points)

##Importation de données

# Importation d'un fichier CSV contenant des données fictives
donnees_f1 <- read.csv("f1_stats.csv")
head(donnees_f1)

##Gestion des valeurs manquantes


# Ajout de valeurs NA dans le dataframe (fictif)
f1_2024$Bonus <- c(10, NA, 5, 8, NA, rep(7, 15))

# Détection des valeurs manquantes
is.na(f1_2024$Bonus)

# Suppression des valeurs manquantes
f1_2024_sans_na <- na.omit(f1_2024)
print(f1_2024_sans_na)


















