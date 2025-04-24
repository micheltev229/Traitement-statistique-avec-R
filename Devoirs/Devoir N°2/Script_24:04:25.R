## base de données 
# Charger le data frame CO2
data("CO2")              
co2base <- as.data.frame(CO2)

# 2 Vérifier le type de co2base
typeof(co2base)
        
# Somme des concentrations
sum(co2base$conc)


##importrer une base de données
# Installer le package haven (à faire une seule fois)
install.packages("haven")

# Charger haven
library(haven)

# Importer un fichier Stata
base_TP2 <- read_dta("/Users/HP/Desktop/base_TP2.dta")

# Vérifier l’import
str(base_TP2)   # structure du data.frame
head(base_TP2)  # premières lignes
summary(base_TP2) # résumé statistique





# Choisir un miroir CRAN fiable (France, Allemagne, USA)
chooseCRANmirror()  
# Sélectionnez un miroir (ex: France [https://cran.univ-lyon1.fr/])

# Installer readxl
install.packages("readxl")
31
install.packages("readxl")

library(readxl)
library(openxlsx)
library(haven)

## création de fonctions



## Fonctions avec les structures if,for, foreach, while


# Exemple simple avec if
is_even <- function(n) {
  if (n %% 2 == 0) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

# Boucle for
print_numbers <- function(n) {
  for (i in 1:n) {
    print(i)
  }
}

# Boucle while
countdown <- function(n) {
  while (n > 0) {
    print(n)
    n <- n - 1
  }
}


## Recherche de nombres premiers
is_prime <- function(n) {
  if (n <= 1) return(FALSE)
  for (i in 2:sqrt(n)) {
    if (n %% i == 0) return(FALSE)
  }
  return(TRUE)
}

## Application avec le nombre 13
is_prime(13)



## Résoudre une équation
solve_equation <- function(a, b, c) {
  # a*x + b = c
  x <- (c - b) / a
  return(x)
}
# Application avec l'équation 2x + 3 = 7
solve_equation(2, 3, 7)



## Résolution d'un systeme d'équation
solve_system <- function(A, B) {
  # A : matrice des coefficients
  # B : vecteur des constantes
  solution <- solve(A, B)
  return(solution)
}
## Application d'une matrice 
A <- matrix(c(2, 1,
              4, -3), nrow = 2, byrow = TRUE)
B <- c(5, -5)

solve(A, B)



## Fonctions gradient et hessien 

# 1. Installer numDeriv (à faire une seule fois)
install.packages("numDeriv")

# 2. Charger le package
library(numDeriv)

f <- function(x) (x[1] - 1)^2 + (x[2] - 2)^2
gradient_f <- function(x) grad(f, x)
hessian_f  <- function(x) hessian(f, x)

point <- c(2, 3)
gradient_f(point)   
hessian_f(point)   



## Inversion de matrice
inverse_matrix <- function(M) {
  solve(M)
}

# Exemple : matrice 2×2
M <- matrix(c(1, 2,
              3, 4), nrow = 2, byrow = TRUE)

invM <- inverse_matrix(M)
invM



##Opérations de base
add      <- function(a, b) a + b
subtract <- function(a, b) a - b
multiply <- function(a, b) a * b
divide   <- function(a, b) {
  if (b == 0) return(NA) else return(a / b)
}


add(10, 4)      
subtract(10, 4) 
multiply(10, 4)
divide(10, 4)   
divide(10, 0)   










