## Fonction nombre premier

est_premier <- function(n) {
  if(n <= 1) return(FALSE)
  i <- 2
  while(i <= sqrt(n)) {
    if(n %% i == 0) return(FALSE)
    i <- i + 1
  }
  return(TRUE)
}

## foction résolution equation ax+b =0

solve_eq <- function(a, b) {
  if(a == 0) stop("Pas de solution unique")
  return(-b/a)
}

## fonction Optimisation

optim_quad <- function() {
  f <- function(x) x^2 + 2*x + 1
  grad <- function(x) 2*x + 2
  hess <- function(x) 2
  optim(0, f, gr = grad, method = "BFGS", hessian = TRUE)
}



## foction inversion matrix
inverse_matrice <- function(m) {
  if(det(m) == 0) stop("Matrice non inversible")
  solve(m)
}


## quatre opérations

calcul <- function(a, b, op) {
  switch(op,
         "+" = a + b,
         "-" = a - b,
         "*" = a * b,
         "/" = if(b == 0) stop("Division par zéro") else a/b,
         stop("Opération invalide"))
}


## Utilisation 


est_premier(7) 
solve_eq(2, -4) 
optim_quad()$par # Minimum à x = -1
inverse_matrice(matrix(c(4,3,3,2), 2)) # [[-2, 3],[3, -4]]
calcul(10, 5, "/") 
