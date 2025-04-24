# Création du DataFrame
homework_df <- data.frame(
  id = 1:3,
  nom = c("Michel", "Marie", "Trésor"),
  sexe = c("Homme", "Femme", "Homme"),
  age = c(21, 19, 18),
  sit_mat = c("Célibataire", "Marié", "Marié"),
  entrainement = c("Oui", "Non", "Oui"),
  enfants = c(2, 3, 1),
  disponibilite = c("Non", "Non", NA),  # Valeur manquante (NA)
  part_revenu_cons_pourcent = c(80, 90, 75),
  salarie = c("Non", NA, "Non")  # Valeur manquante (NA)
)

# Afficher un aperçu du DataFrame
print(homework_df)

# 1. Vérifier la structure des données
str(homework_df)  # Vérifie les types de variables

# 2. Vérifier les valeurs manquantes
colSums(is.na(homework_df))  # Compte les NA dans chaque colonne

# 3. Filtrer les personnes ayant un revenu consommé supérieur à 80%
revenu_eleve <- subset(homework_df, part_revenu_cons_pourcent > 80)
print(revenu_eleve)

# 4. Ajouter une colonne indiquant si la personne est mineure ou majeure
homework_df$statut_age <- ifelse(homework_df$age >= 18, "Majeur", "Mineur")
print(homework_df)

# 5. Remplacer les valeurs manquantes dans la colonne 'salarie' par "Inconnu"
homework_df$salarie[is.na(homework_df$salarie)] <- "Inconnu"

# 6. Calculer la moyenne d'âge
moyenne_age <- mean(homework_df$age)
print(paste("Moyenne d'âge:", moyenne_age))

# 7. Grouper les individus par sexe et calculer l'âge moyen
library(dplyr)
age_par_sexe <- homework_df %>%
  group_by(sexe) %>%
  summarise(age_moyen = mean(age))
print(age_par_sexe)

# 8. Trier les individus par âge décroissant
homework_df <- homework_df[order(-homework_df$age), ]
print(homework_df)

# 9. Supprimer la colonne 'id' (inutile dans certaines analyses)
homework_df <- subset(homework_df, select = -id)

# 10. Afficher le DataFrame final
print(homework_df)
