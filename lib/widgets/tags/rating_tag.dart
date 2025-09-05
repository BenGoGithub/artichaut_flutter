import 'package:flutter/material.dart';

/// Widget StatelessWidget réutilisable pour afficher un tag de note
/// Composition : icône étoile + valeur numérique dans un container arrondi
/// Responsabilité : affichage d'un indicateur de qualité/rating
class RatingTag extends StatelessWidget {
  final num rating; // Valeur de la note à afficher

  const RatingTag({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Padding interne pour espacer le contenu des bords
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white, // Fond blanc pour contraster avec l'image
        borderRadius: BorderRadius.circular(12), // Coins arrondis
      ),
      // Row pour aligner horizontalement l'icône et le texte
      child: Row(
        mainAxisSize: MainAxisSize.min, // Prend seulement l'espace nécessaire
        children: [
          Icon(
            Icons.star,
            size: 16,
            color: Colors.amber[600], // Couleur dorée typique des étoiles de notation
          ),
          const SizedBox(width: 4), // Espacement entre l'icône et le texte
          Text(
            rating.toString(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600, // Texte semi-gras pour la lisibilité
            ),
          ),
        ],
      ),
    );
  }
}