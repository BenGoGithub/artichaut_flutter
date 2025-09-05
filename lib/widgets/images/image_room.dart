import 'package:flutter/material.dart';
import '../../models/room.dart';
import '../../themes/app_theme.dart';
import '../tags/rating_tag.dart';

/// Widget StatelessWidget réutilisable pour afficher l'image d'une chambre
/// avec un effet de dégradé et un tag de note si applicable
/// Responsabilité : gestion de l'affichage visuel de l'image et de ses overlays
class ImageRoom extends StatelessWidget {
  final Room room; // Modèle contenant les données de la chambre

  const ImageRoom({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Hauteur fixe pour uniformiser l'affichage
      width: double.infinity, // Prend toute la largeur disponible
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        // Dégradé de fond au cas où l'image ne se charge pas
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.accentColor,
            AppTheme.secondaryColor,
          ],
        ),
      ),
      // Stack permet de superposer plusieurs widgets (image, overlay, tag)
      child: Stack(
        children: [
          // Container pour l'image de fond
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              image: const DecorationImage(
                image: NetworkImage('https://ilot4.le-campus.eu/assets/images/room-deluxe.jpg'),
                fit: BoxFit.cover, // L'image couvre tout le container en gardant ses proportions
              ),
            ),
          ),
          // Overlay dégradé semi-transparent pour améliorer la lisibilité du texte éventuel
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.03), // Utilisation correcte de withValues
                ],
              ),
            ),
          ),
          // Tag de note positionné en haut à droite, affiché seulement si rating > 0
          if (room.rating > 0)
            Positioned(
              top: 12,
              right: 12,
              // Utilisation du widget réutilisable RatingTag
              child: RatingTag(rating: room.rating),
            ),
        ],
      ),
    );
  }
}