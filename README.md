# lpmi_manage

Application de gestion d'offres développée avec Flutter. Ce projet intègre une base de données locale SQLite, un système d'authentification sécurisé et une architecture séparant les responsabilités.

## Fonctionnalités

- **Authentification des utilisateurs :**
  - Inscription, connexion, déconnexion.
  - Processus de réinitialisation de mot de passe.

- **Sécurité :**
  - Stockage des mots de passe avec hachage (SHA-256) et salage.
  - Politique de mot de passe (longueur, majuscule, minuscule, chiffre, caractère spécial).

- **Gestion des offres (CRUD) :**
  - Création, lecture, mise à jour et suppression des offres.
  - Liste des offres et écran de détail.

- **Base de données :**
  - Persistance des données (utilisateurs, offres) via `sqflite`.
  - Mécanisme de migration pour les mises à jour du schéma de la base de données.

- **Architecture :**
  - Séparation des couches : UI (`screens`), logique métier (`controllers`), accès aux données (`repositories`) et modèles (`models`).
  - Gestion d'état centralisée avec le package `provider`.

## Démarrage rapide

Pour lancer le projet en local :

1.  **Prérequis :** Le [SDK Flutter](https://docs.flutter.dev/get-started/install) doit être installé.

2.  **Cloner le dépôt :**
    ```sh
    git clone https://github.com/Anne-J11/lpmi_manage_2026
    cd lpmi_manage
    ```

3.  **Installer les dépendances :**
    ```sh
    flutter pub get
    ```

4.  **Lancer l'application :**
    ```sh
    flutter run
    ```

## Structure du projet

L'organisation des fichiers est conçue pour séparer les responsabilités.

```
lib/
├── component/     # Widgets réutilisables
├── controller/    # Logique métier
├── database/      # Gestionnaire de la base de données
├── model/         # Modèles de données (User, Offer)
├── repository/    # Accès aux données
├── screen/        # Écrans de l'application
└── main.dart      # Point d'entrée et configuration des Providers
```

## Dépendances principales

- `provider` : Gestion d'état.
- `sqflite` : Base de données locale SQLite.
- `crypto` : Fonctions de hachage.
- `path` : Manipulation des chemins de fichiers.
