# Ici on commente
# Creation de vecteur
x<-c(1:7)# Un vecteur de type numerique
typeof(x)
y<-as.character(x)
typeof(y)
# S'il est possible de l'utiliser comme calculatrice
1+1
sum(x)
sum(y)

# NA
x1<-c(x,NA,9)
x1
print(x1)
sum(x1,na.rm=TRUE) 
#Les facteurs (ou factors en anglais) sont un type de données 
#en R particulièrement utile pour représenter des variables catégorielles. Ils sont souvent utilisés pour stocker des données qui prennent un nombre limité de valeurs distinctes, comme des catégories ou des niveaux
#(par exemple, "homme", "femme", ou "rouge", "vert", "bleu").
# Création d'un vecteur de catégories
categories <- c("homme", "femme", "femme", "homme", "femme")

# Conversion en facteur
f <- factor(categories)

# Affichage du facteur
print(f)
# Création d'une matrice à partir d'un vecteur
m <- matrix(1:6, nrow = 2, ncol = 3)
print(m)
## Création d'une liste
ma_liste <- list(
  nom = "Alice",
   25,
  scores = c(85, 90, 78),
  est_etudiant = TRUE
)

# Affichage de la liste
print(ma_liste)
dataframe<-data.frame(ma_liste)

# Création d'un data frame
df <- data.frame(
  nom = c("Alice", "Bob", "Charlie"),
  age = c(25, 30, 35),
  est_etudiant = c(TRUE, FALSE, TRUE)
)

# Affichage du data frame
print(df)

#Vecteur logique (LOGICAL)
x_log<-c(TRUE,FALSE,TRUE,FALSE)
print(x_log)
sum(x_log)
#Complex vector
x_complex<-c(1+2i,3+4i)
print(x_complex)
sum(x_complex)
typeof(x_complex)
library(data.table)
x1<- 1:5
x2<- -1:-5
x3<- c(-2:2)
mot <- matrix(c(x1,x2,x3),ncol=5,nrow=3)
print(mot)




##Second
   # Factors
sexe<-rep(c("Homme","Femme"),7)
sex <- rep(c(1,2),7)
length(sexe)
data<- data.frame(s1=sexe,s2=sexe,sex)
head(data)
data$sexe1 <- factor(data$sex, 
                     levels = c(1, 2), 
                     labels = c("homme", "femme"))
table(data$sexe1)

ma_liste<-list(
nombre=42,
texte="Bonjour",
logique=TRUE,
vecteur=c(1,2,3)
)
print(ma_liste)

#HOMEWORK
#CREER UN DATA.FRAME DE 10 VARIABLES,EN Y AJOUTANT DES FACTEURS:
#nombre de choix


# Charger les bibliothèques nécessaires
library(dplyr)
library(magrittr)

# Créer le data.frame de 10 variables
df <- data.frame(
  ID = 1:10,  # Variable numérique : ID unique
  Age = sample(18:65, 10, replace = TRUE),  # Variable numérique : Âge aléatoire
  Genre = factor(sample(c("Homme", "Femme"), 10, replace = TRUE)),  # Facteur : Genre
  Statut_Marital = factor(sample(c("Célibataire", "Marié", "Divorcé"), 10, replace = TRUE)),  # Facteur : Statut marital
  Niveau_Education = factor(sample(c("Licence", "Master", "Doctorat"), 10, replace = TRUE)),  # Facteur : Niveau d'éducation
  Revenu = sample(2000:5000, 10, replace = TRUE),  # Variable numérique : Revenu aléatoire
  Region = factor(sample(c("Nord", "Sud", "Est", "Ouest"), 10, replace = TRUE)),  # Facteur : Région
  Satisfaction = sample(1:10, 10, replace = TRUE),  # Variable numérique : Niveau de satisfaction
  Employé = factor(sample(c("Oui", "Non"), 10, replace = TRUE)),  # Facteur : Employé ou non
  Nombre_Enfants = sample(0:4, 10, replace = TRUE)  # Variable numérique : Nombre d'enfants
)

# Afficher le data.frame initial
print("Data.frame initial :")
print(df)

# -----------------------------------------------------
# 1. Types de données en R
# -----------------------------------------------------

# Vérification du type de chaque colonne
print("Types de données des colonnes :")
print(sapply(df, typeof))

# -----------------------------------------------------
# 2. Opérateurs en R
# -----------------------------------------------------

# Opérateurs arithmétiques
print("Opérateurs arithmétiques :")
print(df$Revenu + df$Nombre_Enfants)  # Addition
print(df$Revenu * df$Satisfaction)    # Multiplication

# Opérateurs de comparaison
print("Opérateurs de comparaison :")
print(df$Age > 30)  # Âge supérieur à 30

# Opérateurs logiques
print("Opérateurs logiques :")
print(df$Employé == "Oui" & df$Satisfaction > 5)  # Employé et satisfaction > 5

# Opérateurs d'assignation
df$Revenu_Annuel <- df$Revenu * 12  # Ajout d'une nouvelle colonne
print("Data.frame avec Revenu_Annuel :")
print(df)

# Opérateurs spéciaux (pipe)
print("Utilisation du pipe :")
df %>% filter(Age > 30) %>% select(ID, Age, Revenu) %>% print()

# -----------------------------------------------------
# 3. Manipulation de base des données
# -----------------------------------------------------

# Création de séquences
print("Séquence de 1 à 10 avec un pas de 2 :")
print(seq(1, 10, by = 2))

# Indexation des vecteurs
print("Indexation des vecteurs :")
print(df$Age[1:3])  # Premiers 3 âges

# Indexation des data frames
print("Indexation des data frames :")
print(df[df$Region == "Nord", ])  # Filtre par région

# Indexation avancée avec dplyr
print("Indexation avancée avec dplyr :")
df %>% filter(Revenu > 3000) %>% select(ID, Age, Revenu) %>% print()

# -----------------------------------------------------
# 4. Fonctions utiles
# -----------------------------------------------------

# Fonctions statistiques de base
print("Statistiques descriptives :")
print(mean(df$Revenu))  # Moyenne du revenu
print(median(df$Age))   # Médiane de l'âge
print(sd(df$Satisfaction))  # Écart-type de la satisfaction

# Gestion des valeurs manquantes
df$Revenu[3] <- NA  # Ajout d'une valeur manquante
print("Valeurs manquantes dans Revenu :")
print(sum(is.na(df$Revenu)))

# Remplacer les valeurs manquantes par la moyenne
df$Revenu[is.na(df$Revenu)] <- mean(df$Revenu, na.rm = TRUE)
print("Data.frame après remplacement des NA :")
print(df)

# -----------------------------------------------------
# 5. Conclusion
# -----------------------------------------------------

# Aperçu des données
print("Aperçu des données :")
print(head(df, 3))
print(tail(df, 3))

# Structure des données
print("Structure des données :")
print(str(df))

# Résumé statistique
print("Résumé statistique :")
print(summary(df))