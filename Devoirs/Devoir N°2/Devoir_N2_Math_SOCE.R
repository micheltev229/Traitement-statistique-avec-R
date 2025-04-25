# ======================================================================
# Homework
# ======================================================================

# Fonction qui vérifie si un nombre est premier
est_premier <- function(n) {
  if (n <= 1) {
    return(FALSE)  # return() : retourne une valeur (ici FALSE)
  }
  for (i in 2:(n - 1)) {
    if (n %% i == 0) {  # %% : opérateur modulo, vérifie si n est divisible par i
      return(FALSE)
    }
  }
  return(TRUE)
}

# Fonction qui résout une équation du premier degré de la forme ax + b = 0
resoudre_equation <- function() {
  # readline() : permet de lire une entrée utilisateur depuis la console
  # as.numeric() : convertit une chaîne saisie en nombre
  a <- as.numeric(readline("Entrez le coefficient a: "))
  b <- as.numeric(readline("Entrez le coefficient b: "))
  
  if (a == 0) {
    if (b == 0) {
      cat("Tous les nombres sont solutions.\n")  # cat() : affiche du texte dans la console
    } else {
      cat("Aucune solution.\n")
    }
  } else {
    solution <- -b / a
    cat("La solution est:", solution, "\n")
  }
}

# Fonction de jeu éducatif : aide scolaire pour s'entraîner aux opérations de base
aide_scolaire <- function() {
  cat("Choisissez une opération:\n")
  cat("1: Addition\n")
  cat("2: Soustraction\n")
  cat("3: Multiplication\n")
  cat("4: Division\n")
  
  op <- as.numeric(readline("Entrez le numéro de l'opération: "))
  
  # sample() : tire aléatoirement un nombre dans un vecteur donné
  nb1 <- sample(1:20, 1)
  nb2 <- sample(1:20, 1)
  
  if (op == 4) {
    nb2 <- sample(1:10, 1)  # Évite la division par zéro
  }
  
  # Selon l'opération choisie, on effectue le bon calcul
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
    reponse <- round(nb1 / nb2, 2)  # round() : arrondit à 2 décimales
  } else {
    cat("Choix non valide.\n")
    return()
  }
  
  essai <- as.numeric(readline("Votre réponse: "))
  
  if (abs(essai - reponse) < 0.01) {  # abs() : valeur absolue
    cat("Bravo, c'est correct!\n")
  } else {
    cat("Dommage, la bonne réponse était:", reponse, "\n")
  }
}

# Fonction qui résout un système de deux équations à deux inconnues
resoudre_systeme <- function() {
  cat("Résolution d'un système de 2 équations à 2 inconnues\n")
  cat("Format attendu : ax + by = c\n")
  
  # Sous-fonction pour lire une équation saisie sous forme "a b c"
  lire_equation <- function(numero) {
    repeat {  # repeat : boucle infinie jusqu’à ce qu’on fasse return()
      cat("Entrez les coefficients de l'équation", numero, "(a b c) :\n")
      saisie <- readline()  # Lire la ligne
      # strsplit() : divise une chaîne de caractères en morceaux
      # [[1]] : extrait la première (et unique) liste produite
      # as.numeric() : convertit en numérique
      valeurs <- as.numeric(strsplit(saisie, " ")[[1]])
      if (length(valeurs) == 3 && all(!is.na(valeurs))) {  # all() : vérifie que toutes les valeurs sont valides
        return(valeurs)
      } else {
        cat("Veuillez entrer exactement 3 nombres séparés par un espace.\n")
      }
    }
  }
  
  # Lecture des deux équations
  eq1 <- lire_equation(1)
  eq2 <- lire_equation(2)
  
  # matrix() : crée une matrice avec les coefficients des équations
  A <- matrix(c(eq1[1], eq1[2], eq2[1], eq2[2]), nrow = 2, byrow = TRUE)
  B <- c(eq1[3], eq2[3])  # Vecteur des constantes
  
  # det() : calcule le déterminant de la matrice
  if (det(A) == 0) {
    cat("Le système n'a pas de solution unique (matrice singulière).\n")
  } else {
    solution <- solve(A, B)  # solve() : résout un système linéaire Ax = B
    cat("La solution est :\n")
    cat("x =", solution[1], "\n")
    cat("y =", solution[2], "\n")
  }
}

# ======================================================================
# Exemples d’utilisation
# ======================================================================
est_premier(23)         # Teste si 23 est un nombre premier
resoudre_equation()     # Lance la résolution d'une équation ax + b = 0
aide_scolaire()         # Lance un jeu d'entraînement aux calculs de base
resoudre_systeme()      # Résout un système de 2 équations à 2 inconnues
