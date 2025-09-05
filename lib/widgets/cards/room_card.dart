import 'package:flutter/material.dart';
import '../../models/room.dart';
import '../images/image_room.dart';
import '../layouts/room_info.dart';

/// Widget principal représentant une carte de chambre d'hôtel
/// Utilise un StatelessWidget car l'affichage ne dépend que des données passées en paramètres
/// et ne nécessite pas de gestion d'état local
class RoomCard extends StatelessWidget {
  final Room room; // Modèle de données contenant les informations de la chambre
  final VoidCallback? onTap; // Callback optionnel pour gérer le tap sur la carte
  final VoidCallback? onReserve;

  const RoomCard({
    super.key,
    required this.room,
    this.onTap,
    this.onReserve,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      // InkWell permet de créer un effet de ripple lors du tap
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        // Structure en colonne : image en haut, contenu texte en bas
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Widget réutilisable affichant l'image avec l'overlay et la note (rating)
            ImageRoom(room: room),
            // Contenu textuel avec padding uniforme
            Padding(
              padding: const EdgeInsets.all(20),
              // Widget réutilisable gérant l'affichage des informations textuelles
              child: RoomInfo(room: room, onReserve: onReserve,
              ),
            ),
          ],
        ),
      ),
    );
  }
}