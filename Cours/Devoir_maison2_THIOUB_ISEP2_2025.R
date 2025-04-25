# ----------------------------- #
# TP R - Toolbox intelligente
# ----------------------------- #

# 1. Structure de contrôle : Le robot logique
robot_logique <- function(x) {
  message(" Analyse du nombre : ", x)
  
  if (x %% 2 == 0) {
    print("C'est un nombre pair.")
  } else {
    print("C'est un nombre impair.")
  }

  cat("➡Résultat logique :", ifelse(x > 0, "positif", "négatif ou nul"), "\n")
  
  cat(" Boucle for (compte de 1 à x):\n")
  for (i in 1:x) cat(i, " ")
  cat("\n")
  
  cat(" Boucle while (descente de x à 1):\n")
  while (x > 0) {
    cat(x, " ")
    x <- x - 1
  }
  cat("\n")
  
  vec <- c(2, 4, 6, 8, 10, 15, 20)
  cat(" Indices où valeur > 10:", which(vec > 10), "\n")
}

# 2. Détecteur de nombres premiers
radar_prime <- function(n) {
  if (n <= 1) return(FALSE)
  if (n == 2) return(TRUE)
  for (i in 2:sqrt(n)) {
    if (n %% i == 0) return(FALSE)
  }
  return(TRUE)
}

prime_upto <- function(n) {
  return(Filter(radar_prime, 2:n))
}

# 3. Résolveur d’équation du style ax + b = c
mini_solver <- function(a, b, c) {
  if (a == 0) return("❌as de solution unique")
  return((c - b) / a)
}

# 4. Système linéaire : Résolveur 2x2
systeme2x2 <- function() {
  A <- matrix(c(1, 2, 3, 4), 2, 2)
  b <- c(5, 11)
  if (det(A) == 0) return("Pas de solution unique")
  return(solve(A, b))
}

# 5. Optimisation légère : f(x) = x^2 - 4x + 4
optim_flash <- function() {
  f <- function(x) x^2 - 4*x + 4
  gradient <- function(x) 2*x - 4
  hessien <- function(x) 2
  return(list(
    minimum = optimize(f, c(-10, 10))$minimum,
    gradient_au_min = gradient(2),
    hessien_au_min = hessien(2)
  ))
}

# 6. Inverser une matrice magique
inverse_matrice_magique <- function(M) {
  if (nrow(M) != ncol(M) || det(M) == 0) {
    return(" Impossible d'inverser la matrice.")
  }
  return(solve(M))
}

# 7. Calculatrice pour l'école primaire 
primaire_calculatrice <- function(a, b) {
  list(
    addition = a + b,
    soustraction = a - b,
    multiplication = a * b,
    division = if (b == 0) " Division par zéro" else a / b
  )
}

# ------------------ #
# 🔍 Exemples d’usage
# ------------------ #

# robot_logique(5)
# prime_upto(30)
# mini_solver(2, 3, 7)
# systeme2x2()
# optim_flash()
# inverse_matrice_magique(matrix(c(1, 2, 3, 4), 2))
# primaire_calculatrice(10, 2)
