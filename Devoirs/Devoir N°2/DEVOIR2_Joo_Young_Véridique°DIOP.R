## Homework

# creer des functions en utilisant les ## Structure if, ifelse, for, foreach, which; while ;;

# Fonction pour vérifier si un nombre est pair ou impair
simulate_double_six <- function() {
  count <- 0
  repeat {
    d1 <- sample(1:6, 1)
    d2 <- sample(1:6, 1)
    count <- count + 1
    if (d1 == 6 && d2 == 6) break
  }
  return(count)
}
simulate_double_six()
# Utilisation de ifelse pour une évaluation vectorielle
classify <- function(vec) {
  ifelse(vec > 0, "Positif", "non positif")
}
x<- c(2,4,2,-5,3,0)
classify(x)
# Boucle for
sum_of_double_1_to_n <- function(n) {
  s <- 0
  for (i in 1:n) {
    s <- s + 2*i
  }
  return(s)
}
sum_of_double_1_to_n(2)
# Boucle while
collatz_sequence <- function(n) {
  if (n <= 0) stop("Le nombre doit être strictement positif.")
  seq <- c(n)
  u=0
  while (n != 1) {
    if (n %% 2 == 0) {
      n <- n / 2
    } else {
      n <- 3 * n + 1
    }
    seq <- c(seq, n)
    u<- u + 1
  }
  return(u)
}


collatz_sequence(19)

# which
local_peaks <- function(vec) {
  n <- length(vec)
  if (n < 3) return(integer(0))  # Il faut au moins 3 éléments
  
  indices <- which(vec[2:(n - 1)] > vec[1:(n - 2)] & vec[2:(n - 1)] > vec[3:n])
  
  # On décale de 1 car on a travaillé sur vec[2:(n-1)]
  return(indices + 1)
}
x<- c(sample(1:15, 8))
local_peaks(x)


## Recherche de nombre premier,
is_prime <- function(n) {
  if (n <= 1) return(FALSE)
  for (i in 2:sqrt(n)) {
    if (n %% i == 0) return(FALSE)
  }
  return(TRUE)
}

is_prime(18)
## Resoudre une equation simple;
# Résolution manuelle
solve_equation <- function(a,b,c) {
  if (a == 0) return ("a doit être non nul")
  x <- (c - b) / a
  return(x)
}
solve_equation(8,7,8)
## Resoudre un system d'equations
# Système : 2x + y = 5 ; x - y = 1
solve_system <- function() {
  A <- matrix(c(2, 1, 1, -1), nrow = 2, byrow = TRUE)
  b <- c(5, 1)
  sol <- solve(A, b)
  return(sol)
}

## Resoudre le problem d'optimisation // calcul du Hessioen, gradient ;;;
# Génération de données
set.seed(123) # Pour la reproductibilité
n <- 50  # Nombre d'observations
p <- 1   # Une seule variable explicative

X <- matrix(rnorm(n * p), n, p)  # Génération des X
print(X) 

X <- cbind(1, X)  # Ajout de la constante (intercept)
print(X)
beta_vrai <- c(2, 3)  # Coefficients réels (intercept = 2, pente = 3)
y <- X %*% beta_vrai + rnorm(n, sd=0.5)  # Génération de y avec un bruit

# Calcul de la solution analytique des MCO
beta_MCO <- solve(t(X) %*% X) %*% t(X) %*% y

# Affichage des coefficients estimés
print(beta_MCO)

# Tracé de la fonction de coût J(beta) en 2D
beta_range <- seq(-1, 5, length.out = 100)
cost_values <- sapply(beta_range, function(b) sum((y - X[,2] * b)^2))

plot(beta_range, cost_values, type = "l", col = "blue", lwd = 2,
     xlab = "Valeur de beta", ylab = "J(beta)",
     main = "Fonction de coût J(beta)")
abline(v = beta_MCO[2], col = "red", lty = 2) # Minimum trouvé
legend("topright", legend = c("J(beta)", "Minimum trouvé"),
       col = c("blue", "red"), lty = c(1, 2), lwd = 2)


## Inverserune matrice ...
invert_matrix <- function(M) {
  if (det(M) == 0) {
    return("Non inversible")
  } else {
    return(solve(M))
  }
}

## Etude de cas: au primaire; aider l'enseignant a resoudre les quatres operations !
help_teacher <- function(a, b) {
  list(
    addition = a + b,
    soustraction = a - b,
    multiplication = a * b,
    division = if (b != 0) a / b else "Division par zéro"
  )
}
