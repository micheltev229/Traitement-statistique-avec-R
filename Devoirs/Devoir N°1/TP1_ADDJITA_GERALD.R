
#============== Module 1 : type de données et Objet =================


# Type de données 

# numeric

a <- 2

typeof(a)
mode(a)
class(a)
is.numeric(a)
is.double(a)

# character

b <- "Moussa"

is.numeric(b)
typeof(b)
mode(b)
is.character(b)

d <- "1"

is.numeric(d)

n <- as.numeric(d)
m <- as.numeric(b)

is.numeric(n)

# logical

is.numeric(n)

x <- (a>n)

typeof(x)

# Structures de données

# vecteur
Nom <- c("Ndiaye", "Diop", "Mendy", "Mané", "Gueye")
typeof(Nom)
class(Nom)

Age <- c(25,18.5,26,40,27)
Age1 <- c(25,18.5,26,40,"a")
class(Age1)
Age2 <- c(25,18.5,26,40,TRUE)
class(Age2)

Metier <- c("Medecin","Chauffeur","Medecin","Chauffeur","Medecin")

Metier_1 <- factor(Metier)
# Metier <- factor(Metier)#Ecrase le vecteur Metier

# Metier <-factor(c("Medecin","Chauffeur","Medecin","Chauffeur","Medecin")) 

class(Age)
class(Metier)
class(Metier_1)

#
Emploi <- data.frame(Nom,Age,Metier_1)

Metier_2 <- c("Medecin","Chauffeur","Medecin","Chauffeur")

Emploi_1 <- data.frame(Nom,Age,Metier_2)# affiche une erreur 

View(Emploi)

length(Emploi$Nom) # donne le nombre d'element du vecteur

length(Emploi)# le nombre de variables


######### SESSION 3 ##########

# sequence

rep("Logiciel R",5)

Sexe <-factor(rep(c("Homme","Femme"),10))

Sexe

a <- rep("moi",5)
a
#a <- rep("moi",5);a

n <- seq(0,6,1)
n

n <- seq(0,6,2)
n

m <- 0:6
m

##### indexing

chaine <- c("a", "b", "c", "d")


# renvoi du 2è élément
chaine[2]

# renvoi du 2è élément
chaine[c(2,3)]

# renvoi tous les éléments sauf le 2e
chaine[-2]

# renvoi du dernier élément
chaine[length(chaine)]

#affiche les elements dans le sens inverse
chaine[4:1]

#chaine[1:5]



# indexing sur les data.frames 

Nom <- c("Isac", "Emma", "Nadou", "David", "Elisa")

Age <- c(15,14,17,14,16)

Sexe <- factor(c("Homme","Homme","Femme","Homme","Femme"))

Note <- c(15,16,10,14,12)

AS <- data.frame(Nom,Age,Sexe,Note)

View(AS)
#affiche la 1ere colonne

AS[1]

#affiche les 2 premieres colonnes

AS[c(1,2)]

# affiche l'age du 1e individu

AS[1,2]

#AS[1,c("Age")]

# La base avec que les homme

AS[AS$Sexe=="Homme",]

View(AS[AS$Sexe=="Homme",])

nrow(AS[AS$Sexe=="Homme",])

AS_H <- AS[AS$Sexe=="Homme",]

# Connaitre ceux qui ont une note au moins égale à 14

View(AS[AS$Note>=14,])

nrow(AS[AS$Note>=14,])

Mention_Bien <- AS[,AS$Sexe=="Homme"]
Mention_Bien

AS[AS$Note==12,]

AS[AS$Sexe=="Homme" & AS$Note>=14,]

AS_H[AS_H$Note>=14,]

#Ajouter une variable

#1ere méthode

Quartier <- c("Mermoz", "Ngor", "Ouakam", "Dakar Plateau", "Fann")

AS<- data.frame(AS,Quartier)

View(AS)

#2e methode

AS$quartier <- c("Mermoz", "Ngor", "Ouakam", "Dakar Plateau", "Fann")

View(AS)

install.packages("dplyr")

library(dplyr)

AS <-AS %>%
  mutate(quartier1=c("Mermoz", "Ngor", "Ouakam", "Dakar Plateau", "Fann"))

# Opérateurs

X <- c(2,3,4,8,10)

Y <- c(2,4,6,8,2)

Z <- c(1,2,4)

(X+Y)

X+Z

### NB : data frame

Nom <- c("Ndiaye", "Diop", "Mendy", "Mané", "Gueye")

Age <- c(25,18.5,26,40,27)

Metier <- c("Medecin","Chauffeur", "Enseignant", "Avocat","Pecheur")

Emploi <- data.frame(Nom,Age,Metier)


Nom <- c("Isac", "Emma", "Nadou", "David", "Elisa")

Age <- c(15,14,17,14,16)

Sexe <- c("Homme","Homme","Femme","Homme","Femme")

Note <- c(15,16,10,14,12)

Matiere <- data.frame(Nom,Age,Sexe,Note)

View(Matiere)

Matiere$quartier <- c("Mermoz", "Ngor", "Ouakam", "Dakar Plateau", "Fann")



### Les mactrices

#Les matrices sont une structure de données particulière
#du point de vue des opérations à effectuer.
#Elles sont définies par leurs nombres de lignes et de colonnes.


X <- matrix(1:12,nrow=4,ncol=3,byrow=TRUE)

Y <- matrix(1:12,nrow=4,ncol=3,byrow=F)

Z <- matrix(c(1,5,8,3),2,2,T)

