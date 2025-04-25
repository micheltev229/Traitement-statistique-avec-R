# ======================================================================
# Homework
# ======================================================================
#Fonction nombre premier
est_premier <- function(n) {
  if (n <= 1) {
    return(FALSE)
  }
  for (i in 2:(n - 1)) {
    if (n %% i == 0) {
      return(FALSE)
    }
  }
  return(TRUE)
}


#Fonction equation premier degre
resoudre_equation <- function() {
  a <- as.numeric(readline("Entrez le coefficient a: "))
  b <- as.numeric(readline("Entrez le coefficient b: "))
  
  if (a == 0) {
    if (b == 0) {
      cat("Tous les nombres sont solutions.\n")
    } else {
      cat("Aucune solution.\n")
    }
  } else {
    solution <- -b / a
    cat("La solution est:", solution, "\n")
  }
}



#Fonction aide scolaire
aide_scolaire <- function() {
  cat("Choisissez une opération:\n")
  cat("1: Addition\n")
  cat("2: Soustraction\n")
  cat("3: Multiplication\n")
  cat("4: Division\n")
  op <- as.numeric(readline("Entrez le numéro de l'opération: "))
  
  nb1 <- sample(1:20, 1)
  nb2 <- sample(1:20, 1)
  
  if (op == 4) {
    nb2 <- sample(1:10, 1)  # éviter division par zéro
  }
  
  if (op == 1) {
    cat(nb1, "+", nb2, "= ?\n")
    reponse <- nb1 + nb2
  } else if (op == 2) {
    cat(nb1, "-", nb2, "= ?\n")
    reponse <- nb1 - nb2
  } else if (op == 3) {
    cat(nb1, "*", nb2, "= ?\n")
    reponse <- nb1 * nb2
  } else if (op == 4) {
    cat(nb1, "/", nb2, "= ? (arrondi à 2 décimales)\n")
    reponse <- round(nb1 / nb2, 2)
  } else {
    cat("Choix non valide.\n")
    return()
  }
  
  essai <- as.numeric(readline("Votre réponse: "))
  if (abs(essai - reponse) < 0.01) {
    cat("Bravo, c'est correct!\n")
  } else {
    cat("Dommage, la bonne réponse était:", reponse, "\n")
  }
}



#Fonction équation à deux inconnues
resoudre_systeme <- function() {
  cat("Résolution d'un système de 2 équations à 2 inconnues\n")
  cat("Format attendu : ax + by = c\n")
  
  # Fonction pour lire une équation
  lire_equation <- function(numero) {
    repeat {
      cat("Entrez les coefficients de l'équation", numero, "(a b c) :\n")
      saisie <- readline()
      valeurs <- as.numeric(strsplit(saisie, " ")[[1]])
      if (length(valeurs) == 3 && all(!is.na(valeurs))) {
        return(valeurs)
      } else {
        cat("Veuillez entrer exactement 3 nombres séparés par un espace.\n")
      }
    }
  }
  
  # Lecture des deux équations
  eq1 <- lire_equation(1)
  eq2 <- lire_equation(2)
  
  # Matrice des coefficients (2x2) et vecteur des constantes
  A <- matrix(c(eq1[1], eq1[2], eq2[1], eq2[2]), nrow = 2, byrow = TRUE)
  B <- c(eq1[3], eq2[3])
  
  # Résolution du système
  if (det(A) == 0) {
    cat("Le système n'a pas de solution unique (matrice singulière).\n")
  } else {
    solution <- solve(A, B)
    cat("La solution est :\n")
    cat("x =", solution[1], "\n")
    cat("y =", solution[2], "\n")
  }
}


est_premier(23)         # Vrai
resoudre_equation()     # Interactif
aide_scolaire()         # Jeu de calcul


