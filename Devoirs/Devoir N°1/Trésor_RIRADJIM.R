# ICI ON COMMENTE

# CREATION DE VECTEUR
x<-c(1:7) # UN VECTEUR DE TYPE NUMERIQUE
typeof(x)
y<-as.character(x)
typeof(y)
# S'il est possible d'utiliser comme calculatrice
1+1
sum(x)
sum(y)
#NA
x1<-c(x,9,NA)
x1
sum(x1,na.rm=TRUE)

#VECTEUR LOGIQUE
x_log <- c(TRUE, FALSE, TRUE, FALSE)
print(x_log)
typeof(x_log)

#VECTEUR COMPLEXE
x_complexe<-c(1+1i, 3+4i)
print(x_complexe)

#FACTEUR
x_fact<-factor(c("homme", "femme", "femme", "homme"))
print(x_fact)

levels(x_fact) #modalités

#FACTEURS
sexe<-rep(c("homme", "femme"),7)
length(sexe)
sexe1 <- factor(sexe,levels=c(1,2),
                labels=c("homme", "femme"))
print(sexe1)


#LISTE
ma_liste<- list(42,"bonjpur",TRUE, c(1,2,3))
print(ma_liste)

#DATA FRAME
non_df <- data.frame(
  id=1:3,
  non=c("alice","bob","charlie"),
  age=c(25,30,35),
  actif=c(TRUE,FALSE,TRUE)
)
print(non_df)

#homework
#creer un dataframe de 10 variables en y ajoutant des facteurs; rappelez les types de vairibalees et ajoutez un type.convert()
#en gros creer un dataframe avec des donnes et variables qualitatives et quantitatives
#difference entre dataframe et base de donnees

#MATRICE
ma_matrice <- matrix(1:9, nrow=3, ncol=3)
print(ma_matrice)

#DIMENSIONS
dim(ma_matrice)

#ESSAI DE HOMEWORK

#On créee les Vecteurs pour Chaque Colonne

# Variables quantitatives
var1_quant <- c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
var2_quant <- c(1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5, 10.5)

# Variables qualitatives
var3_qual <- c("A", "B", "C", "A", "B", "C", "A", "B", "C", "A")
var4_qual <- c("X", "Y", "Z", "X", "Y", "Z", "X", "Y", "Z", "X")

# Autres variables
var5_logi <- c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)
var6_char <- c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j")
var7_num <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
var8_fact <- factor(c("M", "F", "M", "F", "M", "F", "M", "F", "M", "F"))
var9_date <- as.Date(c("2025-01-01", "2025-01-02", "2025-01-03", "2025-01-04", "2025-01-05", "2025-01-06", "2025-01-07", "2025-01-08", "2025-01-09", "2025-01-10"))
var10_time <- c("08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00")

#On crée ensuite le Dataframe

df <- data.frame(
  var1_quant = var1_quant,
  var2_quant = var2_quant,
  var3_qual = var3_qual,
  var4_qual = var4_qual,
  var5_logi = var5_logi,
  var6_char = var6_char,
  var7_num = var7_num,
  var8_fact = var8_fact,
  var9_date = var9_date,
  var10_time = var10_time,
  stringsAsFactors = FALSE
)
# stringsAsFactors = FALSE par précaution, pour s'assurer de les avoir ainsi au cas où ma version de R<4.0

#Utiliser type.convert() pour Convertir les Types de Variables.Cependant, elle ne fonctionne pas directement sur un dataframe entier, mais plutôt sur des vecteurs individuels. Pour appliquer cette fonction à chaque colonne, vous pouvez utiliser une boucle ou des fonctions comme lapply().
# Exemple avec lapply()
df[] <- lapply(df, function(x) type.convert(as.character(x)))


#tableaux
mon_array <- array(1:24, dim=c(2,3,4))
print(mon_array)

#vecteurs atomiques
#vecteurs numériques

x_num<-c(13,2,3,5,5)
print(x_num)
typeof(x_num)

#vecteur entier 
x_int<-c(1L, 2L, 5L,8L, 3L) # L est un entier 
print(x_int)
typeof(x_int)

#vecteur caractère
x_char<-c("w","x", "y","z")
print(x_char)
typeof(x_char)

#vecteur complexe
x_complex<-c(1+2i, 10+10i)
print(x_complex)
typeof(x_complex)

#vecteur binaire
x_raw<-raw(13)
print(x_raw)
typeof(x_raw)

#facteur ordonné
x_ord<-factor(c("pas satisfait","satisfait","très satisfait","extremenet satisfait"),
              levels=c("pas satisfait","satisfait","très satisfait"),
              ordered=TRUE)
print(x_ord)
typeof(x_ord)

#vérification de type de données
x_complex<-c(1+2i, 10+10i)
is.numeric(x_complex)
is.character(x_complex)
is.data.frame(x_complex)
is.matrix(x_complex)

#vérification de la classe
class(x_complex)

#Quelques opérateurs arithmétiques
#division
13/3

#puissance
3^10^2

#appliqués aux vexteurs
c(11,12,13)^c(1,1,1)

#combinaison des opérateurs logiques
TRUE & FALSE

#court-circuit des opérateurs logiques
TRUE && FALSE
TRUE/FALSE

#opérateurs d'asignation
y=0
13->z
print(y)
print(z)

#opérateurs pipe du package magrittt et natif 
1:10
#séquences


# Séquence régulière
seq(1, 10, by = 3)

# Séquence de longueur spécifique
seq(0, 2, length.out = 3)

# Répétition
rep(1:3, times = 1)
rep(1:3, each = 2)

# Vecteur exemple
x <- c(10, 20, 30, 40, 50)

x[c(1, 3)] # Premier et troisième éléments 
# Indexation négative (exclusion) x[-2] # Tous sauf le deuxième

# Exemple de data frame
df <- data.frame(
  id = 1:5,
  valeur = c(10, 20, 30, 40, 50), groupe = c("A", "B", "A", "B", "A")
)


#Indexation avancée
# Avec dplyr
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}

library(dplyr)
df %>%
  select(id, valeur) %>% 
  filter(valeur > 20)

# Vecteur exemple
donnees <- c(13, 113, 212, 186, 294, 149, 220)

# Statistiques descriptives mean(donnees) # Moyenne
median(donnees) # Médiane 
sd(donnees) # Écart-type
var(donnees) # Variance

# Importation CSV
data_csv <- read.csv("donnees.csv")
# Importation Excel (avec readxl)
library(readxl)
data_excel <- read_excel("donnees.xlsx")
# Importation SPSS, SAS, Stata (avec haven)
library(haven)
data_spss <- read_spss("donnees.sav") data_sas <- read_sas("donnees.sas7bdat") data_stata <- read_stata("donnees.dta")

# Aperçu des premières lignes
head(iris, 3)

# Aperçu des dernières lignes
tail(iris, 3)

# Structure des données
str(iris)

# Créer des valeurs manquantes
x <- c(1, 22, NA, 45, 55, NA)

# Détecter les valeurs manquantes
is.na(x)

# Compter les valeurs manquantes
sum(is.na(x))

# Filtrer les valeurs manquantes
x[!is.na(x)]
