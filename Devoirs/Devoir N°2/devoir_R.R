
# 1. Fonctions avec structures de contrôle

filtrer_positifs <- function(vec) {
  res <- c()
  for (v in vec) {
    if (v > 0) {
      res <- c(res, v)
    }
  }
  return(res)
}

compter_jusqua <- function(n) {
  i <- 1
  while (i <= n) {
    print(i)
    i <- i + 1
  }
}

indices_pairs <- function(vec) {
  return(which(vec %% 2 == 0))
}

# 2. Recherche de nombre premier

est_premier <- function(n) {
  if (n <= 1) return(FALSE)
  for (i in 2:sqrt(n)) {
    if (n %% i == 0) return(FALSE)
  }
  return(TRUE)
}

# 3. Résolution d'une équation simple (ax + b = c)

resoudre_eq_simple <- function(a, b, c) {
  return((c - b) / a)
}

# 4. Résolution d'un système d'équations

A <- matrix(c(2, 3, 1, -1), nrow = 2, byrow = TRUE)
B <- c(5, 1)
solution <- solve(A, B)

# 5. Problème d'optimisation

f <- function(x) {
  return(x[1]^2 + x[2]^2)
}
optim(c(1, 1), f)

# Gradient et Hessienne
library(numDeriv)
grad_f <- grad(f, c(1, 1))
hess_f <- hessian(f, c(1, 1))

# 6. Inversion de matrice

A <- matrix(c(1, 2, 3, 4), nrow = 2)
A_inv <- solve(A)

# 7. Étude de cas - Les 4 opérations

calculatrice <- function(a, b) {
  cat("Addition :", a + b, "\n")
  cat("Soustraction :", a - b, "\n")
  cat("Multiplication :", a * b, "\n")
  cat("Division :", a / b, "\n")
}


# Fonction utilisant ifelse : déterminer si les éléments sont pairs ou impairs

pair_ou_impair <- function(vec) {
  return(ifelse(vec %% 2 == 0, "pair", "impair"))
}


# Utilisation de foreach (sans parallélisme)
library(foreach)

carres_foreach <- function(vec) {
  result <- foreach(x = vec, .combine = c) %do% {
    x^2
  }
  return(result)
}
