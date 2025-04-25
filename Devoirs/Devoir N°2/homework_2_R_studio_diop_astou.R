""" DIOP ASTOU HOMEWORK 2 """

# 1. Structures de contrôle de base

# Fonction démontrant les structures de contrôle if, ifelse, for, while, which
demo_structures <- function(x) {
  # Structure if simple
  if (x > 10) {
    print("x est plus grand que 10")
  } else {
    print("x est 10 ou moins")
  }
  
  # Structure ifelse (vectorisée)
  print(ifelse(x > 0, "Positif", "Négatif ou zéro"))
  
  # Boucle for
  print("Compte à rebours avec for:")
  for (i in x:1) {
    print(i)
  }
  
  # Boucle while
  print("Compte à rebours avec while:")
  while (x > 0) {
    print(x)
    x <- x - 1
  }
  
  # Utilisation de which
  vec <- c(1, 5, 10, 15, 20)
  print(paste("Indices des éléments > 10:", paste(which(vec > 10), collapse=", ")))
}

# Exemple d'utilisation
demo_structures(5)


# 2. Recherche de nombres premiers

# Fonction pour vérifier si un nombre est premier (version finale)
est_premier <- function(n) {
  if (n <= 1) return(FALSE)
  if (n == 2) return(TRUE)
  if (n %% 2 == 0) return(FALSE)
  
  # Vérifier les diviseurs jusqu'à la racine carrée de n
  max_diviseur <- floor(sqrt(n))
  i <- 3
  while (i <= max_diviseur) {
    if (n %% i == 0) return(FALSE)
    i <- i + 2  # On vérifie seulement les nombres impairs
  }
  return(TRUE)
}

# Fonction pour trouver tous les nombres premiers jusqu'à n (version finale)
nombres_premiers <- function(n) {
  if (n < 2) return(numeric(0))
  
  # Utilisation de la vectorisation pour plus d'efficacité
  nombres <- 2:n
  premiers <- nombres[sapply(nombres, est_premier)]
  return(premiers)
}

# Exemples d'utilisation
print(est_premier(17))  # TRUE
print(est_premier(9))   # FALSE
print(nombres_premiers(20))  # 2 3 5 7 11 13 17 19
print(nombres_premiers(1))    # numeric(0)
print(nombres_premiers(100))  # Nombres premiers jusqu'à 100

# 3. Résolution d'équation simple

# Fonction pour résoudre une équation linéaire ax + b = 0
resoudre_equation <- function(a, b) {
  if (a == 0) {
    if (b == 0) {
      return("Tous les réels sont solutions")
    } else {
      return("Pas de solution")
    }
  } else {
    return(-b / a)
  }
}

# Exemple d'utilisation
print(resoudre_equation(2, -4))  
print(resoudre_equation(0, 5))   

# 4. Résolution d'un système d'équations linéaires

# Fonction pour résoudre un système d'équations linéaires Ax = b
resoudre_systeme <- function(A, b) {
  # Vérifier si la matrice est carrée
  if (nrow(A) != ncol(A)) {
    stop("La matrice A doit être carrée")
  }
  
  # Vérifier si le système a une solution unique
  if (det(A) == 0) {
    stop("Le système n'a pas de solution unique")
  }
  
  # Résoudre le système
  return(solve(A) %*% b)
}

# Exemple d'utilisation
A <- matrix(c(2, 1, 1, 3), nrow = 2)
b <- c(5, 10)
print(resoudre_systeme(A, b))  

# 5. Problème d'optimisation avec gradient et hessien

# Fonction pour calculer le gradient d'une fonction à 2 variables
calculer_gradient <- function(f, x, y, h = 1e-5) {
  # Dérivée partielle par rapport à x
  df_dx <- (f(x + h, y) - f(x - h, y)) / (2 * h)
  
  # Dérivée partielle par rapport à y
  df_dy <- (f(x, y + h) - f(x, y - h)) / (2 * h)
  
  return(c(df_dx, df_dy))
}

# Fonction pour calculer la matrice hessienne
calculer_hessien <- function(f, x, y, h = 1e-5) {
  # Dérivées secondes
  d2f_dx2 <- (f(x + h, y) - 2 * f(x, y) + f(x - h, y)) / h^2
  d2f_dy2 <- (f(x, y + h) - 2 * f(x, y) + f(x, y - h)) / h^2
  d2f_dxdy <- (f(x + h, y + h) - f(x + h, y - h) - f(x - h, y + h) + f(x - h, y - h)) / (4 * h^2)
  
  return(matrix(c(d2f_dx2, d2f_dxdy, d2f_dxdy, d2f_dy2), nrow = 2))
}

# Exemple d'utilisation avec la fonction f(x,y) = x^2 + y^2
f <- function(x, y) x^2 + y^2
print(calculer_gradient(f, 1, 2))  
print(calculer_hessien(f, 1, 2))   


# 6. Inversion d'une matrice

# Fonction pour inverser une matrice avec vérification
inverser_matrice <- function(m) {
  # Vérifier si la matrice est carrée
  if (nrow(m) != ncol(m)) {
    stop("La matrice doit être carrée pour être inversée")
  }
  
  # Vérifier si la matrice est inversible
  if (det(m) == 0) {
    stop("La matrice n'est pas inversible (déterminant nul)")
  }
  
  # Retourner l'inverse
  return(solve(m))
}

# Exemple d'utilisation
m <- matrix(c(4, 7, 2, 6), nrow = 2)
print(inverser_matrice(m))



# 7. Étude de cas: Opérations primaires

# Fonction pour aider un enseignant du primaire avec les 4 opérations de base
operations_primaire <- function(a, b, operation) {
  operation <- tolower(operation)
  
  if (operation == "addition") {
    return(a + b)
  } else if (operation == "soustraction") {
    return(a - b)
  } else if (operation == "multiplication") {
    return(a * b)
  } else if (operation == "division") {
    if (b == 0) {
      return("Erreur: division par zéro")
    }
    return(a / b)
  } else {
    return("Opération non reconnue. Choisissez parmi: addition, soustraction, multiplication, division")
  }
}

# Exemple d'utilisation
print(operations_primaire(10, 5, "addition"))      
print(operations_primaire(10, 5, "division"))      
print(operations_primaire(10, 0, "division"))      