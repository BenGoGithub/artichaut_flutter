Artichaut Flutter Hôtel
Application Flutter de gestion de chambres d’hôtel (exemple pédagogique, architecture scalable).

Arborescence du projet
text
.
├── main.dart                           # Point d’entrée de l’application
├── models/                             # Définition des modèles de données
│   └── room.dart                       # Modèle d'une chambre (Room)
├── screens/                            # Pages principales de l’application
│   ├── my_home_page.dart               # Accueil
│   ├── room_detail_screen.dart         # Détail d’une chambre
│   └── room_list_screen.dart           # Liste des chambres
├── services/                           # Logique métier et accès aux ressources
│   └── reservation_service.dart        # Service centralisé pour les réservations
├── themes/                             # Définition des couleurs, textes, etc.
│   └── app_theme.dart                  # Thème applicatif global
└── widgets/                            # Widgets réutilisables et UI emballée
├── buttons/
│   └── icon_text_buton.dart        # Bouton personnalisé (icône + texte)
├── cards/
│   └── room_card.dart              # Carte affichant une chambre
├── images/
│   └── image_room.dart             # Widget image de chambre avec overlay
├── layouts/
│   ├── price_with_rating.dart      # Section prix + note
│   └── room_info.dart              # Bloc de détails d’une chambre
└── tags/
└── rating_tag.dart             # Badge d’évaluation (rating)
Explication rapide des dossiers
models/
Contient les définitions des objets métier.
Ex : Room représente une chambre, ses attributs et méthodes de manipulation de données.

services/
Contient la logique technique (ex. appels API, dialogues, traitement complexe).
Exemple : reservation_service.dart centralise la gestion et les effets de la réservation pour toute l’app.

screens/
Toutes les pages majeures de l’application.
Chaque page organise et compose les widgets pour afficher la vue principale.

widgets/
Composants UI réutilisables, regroupés par type (boutons, cartes, images...).
Permet de découper et structurer le code selon le principe "single responsibility".

themes/
Couleurs, fonds, tailles de textes et styles globaux.
Garde la cohérence visuelle de l’application.

Installation & Lancement
Installer les dépendances :

text
flutter pub get
Lancer l’application sur émulateur ou appareil :

text
flutter run
Bonnes pratiques utilisées
Architecture modulaire, KISS et Clean Code

Séparation des responsabilités : data, logique, affichage

Réutilisabilité des widgets grâce à leur découpage

State management possible (Riverpod ou Provider recommandé pour grande échelle)

Styles centralisés pour une cohérence visuelle

Contribution
Ajouter vos propres modèles dans models/

Votre logique métier dans services/

Vos écrans dans screens/

Vos widgets UI réutilisables dans widgets/

Garder les styles centralisés !