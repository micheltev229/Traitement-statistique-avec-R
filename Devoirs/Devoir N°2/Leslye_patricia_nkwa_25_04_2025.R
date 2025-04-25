# Exemple : Vérifie si un nombre est pair ou impair
check_parity <- function(n) {
  if (n %% 2 == 0) {
    return("Pair")
  } else {
    return("Impair")
  }
}

# Boucle for : somme des nombres de 1 à 10
somme_for <- function() {
  s <- 0
  for (i in 1:10) {
    s <- s + i
  }
  return(s)
}

# Boucle while : même somme
somme_while <- function() {
  s <- 0
  i <- 1
  while (i <= 10) {
    s <- s + i
    i <- i + 1
  }
  return(s)
}

# ifelse : note automatique
note_etudiant <- function(score) {
  return(ifelse(score >= 10, "Admis", "Ajourné"))
}

# which : position des valeurs supérieures à 5
valeurs_pos <- function(v) {
  return(which(v > 5))
}



# Nombre premier 

est_premier <- function(n) {
  if (n <= 1) return(FALSE)
  for (i in 2:floor(sqrt(n))) {
    if (n %% i == 0) {
      return(FALSE)
    }
  }
  return(TRUE)
}



# Résolution de l'équation ax + b = c 

resoudre_equation <- function(a, b, c) {
  if (a == 0) {
    if (b == c) return("Infinité de solutions")
    else return("Pas de solution")
  } else {
    return((c - b) / a)
  }
}

# Résolution système d'équation AX = b 

resoudre_systeme <- function(A, b) {
  if (det(A) == 0) {
    return("Système sans solution unique")
  } else {
    return(solve(A, b))
  }
}



# Optimisation gradient et hessienne 

optimisation_exemple <- function() {
  library(numDeriv)
  
  f <- function(x) x[1]^2 + x[2]^2 + 3*x[1] + 4*x[2]
  
  # Gradient
  grad <- grad(f, c(0, 0))
  
  # Hessienne
  hess <- hessian(f, c(0, 0))
  
  list(gradient = grad, hessienne = hess)
}


# Inverse d'une matrice 

inverse_matrice <- function(M) {
  if (det(M) == 0) {
    return("Matrice non inversible")
  } else {
    return(solve(M))
  }
}


# Opérations 

resoudre_operations <- function(a, b) {
  list(
    addition = a + b,
    soustraction = a - b,
    multiplication = a * b,
    division = ifelse(b != 0, a / b, NA)
  )
}
