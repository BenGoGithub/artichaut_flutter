import 'package:flutter/material.dart';
import '../../models/room.dart';
import '../buttons/icon_text_buton.dart';
import 'price_with_rating.dart';

/// Widget StatelessWidget responsable de l'affichage des informations textuelles d'une chambre
/// Structure : titre, description, ligne avec prix et bouton de réservation
/// Responsabilité : organisation du contenu textuel et des actions utilisateur
class RoomInfo extends StatelessWidget {
  final Room room; // Modèle contenant les données de la chambre
  final VoidCallback? onReserve;

  const RoomInfo({super.key, required this.room, this.onReserve,});

  @override
  Widget build(BuildContext context) {
    // Column pour organiser verticalement les éléments
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche
      children: [
        // Titre de la chambre utilisant le thème de l'application
        Text(
          room.title,
          style: Theme.of(context).textTheme.titleLarge, // Style cohérent avec le thème global
        ),
        const SizedBox(height: 12), // Espacement vertical

        // Description avec limitation du nombre de lignes pour éviter les débordements
        Text(
          room.description,
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 4, // Limitation à 4 lignes maximum
          overflow: TextOverflow.ellipsis, // Points de suspension si le texte dépasse
        ),
        const SizedBox(height: 16), // Espacement avant la ligne prix/bouton

        // Row pour aligner horizontalement le prix et le bouton de réservation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Répartit l'espace entre les extrémités
          children: [
            // Widget réutilisable pour afficher prix et rating conditionnel
            PriceWithRating(room: room),

            // Widget bouton réutilisable avec icône et texte
            // Utilisation d'un callback pour gérer l'action de réservation
            IconTextButton(
            onPressed: onReserve ?? () {
            // Action par défaut si aucun callback n'est fourni
                print('Réservation pour la chambre: ${room.title}');
              },
              label: 'Réserver',
              icon: Icons.hotel, // Icône cohérente avec le contexte hôtelier
            ),
          ],
        ),
      ],
    );
  }
}