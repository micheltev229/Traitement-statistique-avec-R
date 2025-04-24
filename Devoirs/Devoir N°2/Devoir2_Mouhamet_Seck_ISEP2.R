### 1. Recherche de nombres premiers


# Fonction pour vérifier si un nombre est premier

est_premier <- function(n) {
  if (n <= 1) return(FALSE)
  if (n == 2) return(TRUE)
  if (n %% 2 == 0) return(FALSE)
  
  for (i in 3:sqrt(n)) {
    if (n %% i == 0) return(FALSE)
  }
  return(TRUE)
}

# Trouver tous les nombres premiers jusqu'à une limite
nombres_premiers <- function(limite) {
  premiers <- c()
  for (i in 2:limite) {
    if (est_premier(i)) {
      premiers <- c(premiers, i)
    }
  }
  return(premiers)
}

# Exemple d'utilisation
nombres_premiers(30) 








### 2. Résolution d'une équation simple
# Résolution d'une équation linéaire ax + b = 0
resoudre_equation <- function(a, b) {
  if (a == 0) {
    if (b == 0) {
      return("Tous les réels sont solutions")
    } else {
      return("Pas de solution")
    }
  } else {
    return(-b/a)
  }
}

# Exemple d'utilisation
resoudre_equation(2, -4) 








### 3. Résolution d'un système d'équations linéaires
# Résolution d'un système 2x2
resoudre_systeme <- function(a1, b1, c1, a2, b2, c2) {
  # Matrice des coefficients
  A <- matrix(c(a1, b1, a2, b2), nrow = 2, byrow = TRUE)
  # Vecteur des constantes
  B <- c(c1, c2)
  
  # Vérifier si le système a une solution unique
  if (det(A) != 0) {
    solution <- solve(A, B)
    return(solution)
  } else {
    # Vérifier si le système a une infinité de solutions ou aucune solution
    if (a1/a2 == b1/b2 && b1/b2 == c1/c2) {
      return("Infinité de solutions")
    } else {
      return("Pas de solution")
    }
  }
}

# Exemple d'utilisation
resoudre_systeme(1, 1, 3, 2, -1, 0) 







### 5. Inversion d'une matrice
# Fonction pour inverser une matrice (version simplifiée)
inverser_matrice <- function(m) {
  # Vérifier si la matrice est carrée
  if (nrow(m) != ncol(m)) {
    stop("La matrice doit être carrée")
  }
  
  # Vérifier si la matrice est inversible
  if (det(m) == 0) {
    stop("La matrice n'est pas inversible")
  }
  
  # Utiliser la fonction solve() de R
  return(solve(m))
}

# Exemple d'utilisation
m <- matrix(c(4, 7, 2, 6), nrow = 2)
inverser_matrice(m)




#6. Assistant pour les opérations primaires
# Assistant pour les 4 opérations de base
assistant_primaire <- function() {
  cat("Assistant pour les opérations de base\n")
  cat("1. Addition\n2. Soustraction\n3. Multiplication\n4. Division\n")
  
  choix <- as.integer(readline("Choisissez une opération (1-4): "))
  a <- as.numeric(readline("Premier nombre: "))
  b <- as.numeric(readline("Deuxième nombre: "))
  
  resultat <- switch(choix,
                     "1" = a + b,
                     "2" = a - b,
                     "3" = a * b,
                     "4" = {
                       if (b == 0) "Division par zéro impossible" else a / b
                     },
                     "Choix invalide")
  
  cat("Résultat: ", resultat, "\n")
}

# Exemple d'utilisation
assistant_primaire()


# Classifier les nombres comme pairs ou impairs
classifier_nombres <- function(nombres) {
  ifelse(nombres %% 2 == 0, "Pair", "Impair")
}

classifier_nombres(1:10)











