import 'package:flutter/material.dart';
import '../../models/room.dart';
import '../../themes/app_theme.dart';

/// Widget StatelessWidget spécialisé dans l'affichage du prix et du rating conditionnel
/// Logique métier : affiche la note seulement si elle vaut 0
/// Responsabilité : gestion de l'affichage cohérent du prix avec styling thématique
class PriceWithRating extends StatelessWidget {
  final Room room; // Modèle contenant les données de prix et rating

  const PriceWithRating({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    // Row pour aligner horizontalement le prix et la note éventuelle
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end, // Alignement sur la ligne de base
      children: [
        // Affichage du prix avec styling thématique fort
        Text(
          '${room.price.toInt()} €', // Conversion en entier pour éviter les décimales inutiles
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.primaryColor, // Couleur primaire pour attirer l'attention
            fontWeight: FontWeight.w600, // Poids semi-gras pour l'importance
          ),
        ),

        // Affichage conditionnel de la note si elle vaut 0
        // Note : cette logique semble particulière, généralement on afficherait si rating > 0
        if (room.rating == 0)
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 2), // Léger décalage pour l'alignement
            child: Text(
              room.rating.toString(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondaryColor, // Couleur secondaire moins proéminente
              ),
            ),
          ),
      ],
    );
  }
}