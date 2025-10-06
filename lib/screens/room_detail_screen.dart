import 'package:flutter/material.dart';
import '../models/room.dart';
import '../themes/app_theme.dart';
import '../widgets/buttons/icon_text_buton.dart';
import '../widgets/images/image_room.dart'; // Import du widget ImageRoom
import '../services/reservation_service.dart';

/// Widget StatelessWidget pour l'écran de détail d'une chambre
/// StatelessWidget est approprié car cette page affiche uniquement des informations
/// statiques basées sur l'objet Room passé en paramètre - aucun état local n'est géré
class RoomDetailScreen extends StatelessWidget {
  // Propriété finale contenant les données de la chambre à afficher
  // 'final' garantit l'immutabilité et 'required' assure qu'une chambre soit toujours fournie
  final Room room;

  /// Constructeur avec clé optionnelle pour l'optimisation des performances
  /// La clé permet à Flutter d'identifier et réutiliser ce widget dans l'arbre des widgets
  const RoomDetailScreen({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    /// Scaffold : Structure de base de l'écran avec support pour AppBar, body, etc.
    /// Fournit le squelette architectural standard d'une page Flutter
    return Scaffold(
      // Couleur de fond appliquée à toute la page via le thème centralisé
      backgroundColor: AppTheme.backgroundColor,

      /// CustomScrollView : Container de défilement avancé permettant d'utiliser des Slivers
      /// Les Slivers sont des portions scrollables qui peuvent avoir des comportements spéciaux
      /// (expansion, contraction, épinglage) pendant le défilement
      body: CustomScrollView(
        slivers: [
          /// SliverAppBar : AppBar qui peut s'étendre et se contracter lors du défilement
          /// Crée un effet visuel immersif avec une image de fond qui se réduit progressivement
          SliverAppBar(
            expandedHeight: 300, // Hauteur maximale quand l'AppBar est étendue
            pinned: true, // L'AppBar reste visible (épinglée) même en défilant vers le bas

            /// FlexibleSpaceBar : Espace flexible dans le SliverAppBar qui s'adapte au défilement
            /// Permet d'afficher du contenu (image, titre) qui se transforme pendant le scroll
            flexibleSpace: FlexibleSpaceBar(
              /// Remplacement du Container avec dégradé par le widget ImageRoom
              /// ImageRoom est un composant réutilisable qui gère l'affichage de l'image
              /// avec overlay, dégradé de secours et tag de notation
              background: ClipRRect(
                /// ClipRRect applique un BorderRadius au widget enfant
                /// Nécessaire car ImageRoom a ses propres coins arrondis
                /// mais dans le contexte du SliverAppBar, on veut des coins droits
                borderRadius: BorderRadius.zero,
                child: Container(
                  /// Container wrapper pour adapter ImageRoom au contexte du SliverAppBar
                  /// Supprime la hauteur fixe d'ImageRoom et utilise tout l'espace disponible
                  height: double.infinity,
                  width: double.infinity,
                  child: ImageRoom(
                    room: room, // Passage des données de la chambre au widget réutilisable
                  ),
                ),
              ),
            ),
          ),

          /// SliverToBoxAdapter : Convertit un widget normal en Sliver
          /// Permet d'intégrer du contenu standard dans un CustomScrollView
          SliverToBoxAdapter(
            child: Container(
              // Décoration avec coins arrondis pour un effet de "carte" moderne
              decoration: const BoxDecoration(
                color: AppTheme.backgroundColor,
                // Coins arrondis uniquement en haut pour créer un effet de superposition
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),

              /// Padding : Ajoute un espacement interne uniforme autour du contenu
              /// 24 pixels sur tous les côtés pour une présentation aérée
              child: Padding(
                padding: const EdgeInsets.all(24),

                /// Column : Layout vertical pour organiser les éléments les uns sous les autres
                /// CrossAxisAlignment.start aligne tout le contenu à gauche
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Section titre et prix - Layout horizontal avec Row
                    Row(
                      // Espace le titre et le prix aux extrémités de la ligne
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // Aligne verticalement le titre et prix en haut
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Expanded : Permet au titre de prendre tout l'espace disponible
                        /// Évite le débordement si le titre est long
                        Expanded(
                          child: Text(
                            room.title, // Accès direct aux données du modèle Room
                            // Style de texte récupéré depuis le thème global de l'application
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),

                        /// Affichage du prix avec style personnalisé
                        Text(
                          '${room.price.toInt()} €', // Conversion en entier et formatage
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppTheme.primaryColor,      // Couleur d'accent du thème
                            fontWeight: FontWeight.w600,       // Police semi-grasse pour l'emphase
                          ),
                        ),
                      ],
                    ),
                    /// SizedBox : Widget d'espacement vertical fixe
                    /// Alternative plus claire que Padding pour les espacements simples
                    const SizedBox(height: 20),

                    /// Section description - Texte simple avec style du thème
                    Text(
                      room.description, // Propriété description du modèle Room
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),

                    /// Section équipements - Titre de section
                    Text(
                      'Équipements',
                      // Style de titre de section, moins important que le titre principal
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),

                    /// Wrap : Layout qui passe automatiquement à la ligne suivante
                    /// Idéal pour afficher une collection d'éléments de taille variable (tags, chips)
                    Wrap(
                      spacing: 8,     // Espacement horizontal entre les éléments
                      runSpacing: 8,  // Espacement vertical entre les lignes

                      /// Transformation de la liste d'équipements en widgets visuels
                      /// .map() transforme chaque string en Container stylisé
                      /// .toList() convertit l'Iterable en List<Widget> attendue par Wrap
                      children: room.amenities.map((amenity) {
                        return Container(
                          // Espacement interne pour chaque "chip" d'équipement
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.accentColor,         // Couleur de fond du chip
                            borderRadius: BorderRadius.circular(20), // Coins très arrondis (pilule)
                          ),
                          child: Text(
                            amenity, // Nom de l'équipement
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textPrimaryColor, // Couleur du texte contrastante
                            ),
                          ),
                        );
                      }).toList(), // Conversion obligatoire en List<Widget>
                    ),
                    const SizedBox(height: 32), // Espacement plus large avant le bouton

                    /// Section bouton de réservation
                    /// SizedBox avec width: double.infinity force le bouton à occuper toute la largeur
                    SizedBox(
                      width: double.infinity, // Largeur maximale disponible

                      /// IconTextButton : Widget personnalisé (probablement défini dans l'application)
                      /// Combine icône et texte dans un bouton réutilisable
                      child: IconTextButton(
                        /// Callback de pression du bouton - délègue à un service
                        /// Cette approche sépare la logique métier (réservation) de la présentation
                        onPressed: () => ReservationService.showReservationDialog(context, room),
                        label: 'Réserver maintenant', // Texte du bouton
                        icon: Icons.hotel,             // Icône Material Design
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}