## Homework


# recherche de nombre premier
est_premier <- function(n)
{
  if (n <= 1) 
    {
    return(FALSE)
    }
  for (i in 2:sqrt(n)) 
    {
    if (n %% i == 0) 
      {
      return(FALSE)
      }
    }
  return(TRUE)
}
# test
est_premier(877)

# resoudre une equation simple
resoudre_equation <- function(a, b) 
{
  if (a == 0) 
    {
    if (b == 0) 
      {
      return("Infinité de solutions")
      } 
    else 
      {
      return("Pas de solution")
      }
    }
  return(-b / a)
}
# test : ax + b = 0
resoudre_equation(2,4)

# resoudre un systeme d'equation
resoudre_systeme <- function(A, B)
{
  if (det(A) == 0) 
    {
    return("Système sans solution unique")
    }
  return(solve(A, B))
}
# test : AX = B
resoudre_systeme(matrix(c(1,2,-2,3), nrow=2), c(5,11))


# resoudre le probleme d'optimisation //calcul du hessien, du 
library(numDeriv)
optimiser_fonction <- function(f, x_init) 
{
  grad <- grad(f, x_init)
  hess <- hessian(f, x_init)
  return(list("Gradient" = grad, "Hessien" = hess))
}

# test : 
optimiser_fonction(function(x) x[1]^2 + x[2]^2, c(1,1))


# inverser une matrice
inverser_matrice <- function(M) 
{
  if (det(M) == 0) 
    {
    return("Matrice non inversible")
    }
  return(solve(M))
}
# test : 
m <- matrix(c(1,3,4,9), nrow=2)
inverser_matrice(m)

#etude de cas : au primaire : aider l'enseignant a resoudre les 4 operations
calcul_prim <- function(a, b, operateur) 
{
  ifelse(operateur == "+", return(a + b),
         ifelse(operateur == "-", return(a - b),
                ifelse(operateur == "*", return(a * b),
                       ifelse(operateur == "/", 
                              if (b != 0) return(a / b) else return("Division par zéro"),
                              return("Opérateur inconnu")
                       )
                )
         )
  )
}
# test 
calcul_prim(1,3,"+")

