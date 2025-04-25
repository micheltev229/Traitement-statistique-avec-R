# **Devoirs R : Script Unifié**
# *Structures de contrôle, équations, optimisation, matrices et aide aux enseignants*

# ----------------------------
# **1. Structures de contrôle**
# ----------------------------

## **1.1 Fonction avec if/while - Test de nombre premier**
est_premier <- function(n) {
  if (n <= 1) return(FALSE)
  if (n == 2) return(TRUE)
  if (n %% 2 == 0) return(FALSE)
  
  i <- 3
  while (i <= sqrt(n)) {
    if (n %% i == 0) return(FALSE)
    i <- i + 2
  }
  return(TRUE)
}

## **1.2 Fonction avec for/ifelse - Liste de nombres premiers**
generer_premiers <- function(n) {
  primes <- c()
  num <- 2
  while (length(primes) < n) {
    if (est_premier(num)) primes <- c(primes, num)
    num <- num + 1
  }
  return(primes)
}

## **1.3 Fonction avec which - Filtrage**
filtre_pairs <- function(vec) {
  return(vec[which(vec %% 2 == 0)])
}

# ----------------------
# **2. Résolution maths**
# ----------------------

## **2.1 Équation linéaire (ax + b = 0)**
resoudre_eq <- function(a, b) {
  if (a == 0) {
    if (b == 0) return("Infinité de solutions")
    else return("Pas de solution")
  }
  return(-b/a)
}

## **2.2 Système d'équations (matrices)**
resoudre_systeme <- function(A, B) {
  if (det(A) == 0) stop("Matrice singulière")
  return(solve(A, B))
}

# --------------------------
# **3. Optimisation numérique**
# --------------------------

## **3.1 Gradient et Hessien**
fonction_test <- function(x) x^2 + 3*x + 2
gradient <- function(x) 2*x + 3
hessien <- function(x) 2

## **3.2 Minimisation**
optimiser <- function() {
  resultat <- optim(0, fonction_test, gr = gradient, method = "BFGS")
  return(resultat$par)
}

# -------------------
# **4. Opérations matricielles**
# -------------------

## **4.1 Inversion de matrice**
inverser <- function(M) {
  if (det(M) == 0) stop("Matrice non inversible")
  return(solve(M))
}

# --------------------------
# **5. Aide aux enseignants (Primaire)**
# --------------------------

## **5.1 Addition vectorisée**
addition <- function(a, b) a + b

## **5.2 Soustraction avec contrôle**
soustraction <- function(a, b) {
  if (b > a) warning("Résultat négatif")
  return(a - b)
}

## **5.3 Multiplication avec for**
multiplication <- function(a, b) {
  res <- 0
  for (i in 1:b) res <- res + a
  return(res)
}

## **5.4 Division avec vérification**
division <- function(a, b) {
  if (b == 0) stop("Division par zéro")
  return(a / b)
}

# --------------------------
# **TESTS**
# --------------------------

cat("Test nombres premiers (7):", est_premier(7), "\n")
cat("5 premiers nombres premiers:", generer_premiers(5), "\n\n")

cat("Résolution 2x - 4 = 0:", resoudre_eq(2, -4), "\n")

A <- matrix(c(1,2,3,4), nrow=2)
B <- c(5,6)
cat("Solution système Ax=B:", resoudre_systeme(A, B), "\n\n")

cat("Minimum de x²+3x+2:", optimiser(), "\n")

M <- matrix(c(1,2,3,4), nrow=2)
cat("Inverse de M:\n")
print(inverser(M))

cat("\nOpérations primaires:")
cat("\n5 + 3 =", addition(5, 3))
cat("\n5 - 3 =", soustraction(5, 3))
cat("\n5 * 3 =", multiplication(5, 3))
cat("\n6 / 3 =", division(6, 3))


