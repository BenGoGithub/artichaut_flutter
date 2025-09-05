import 'package:artichaut_flutter/screens/room_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:artichaut_flutter/models/room.dart';
import 'package:artichaut_flutter/widgets/cards/room_card.dart';
import '../themes/app_theme.dart';
import '../services/reservation_service.dart';

/// Écran principal affichant la liste des chambres disponibles
/// StatelessWidget car la liste des chambres ne change pas dynamiquement
class RoomListScreen extends StatelessWidget {
  const RoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupération des données d'exemple des chambres
    final rooms = Room.getSampleRooms();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Nos Chambres'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Style du titre
        titleTextStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: AppTheme.textPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return RoomCard(
            room: room,
            // Callback pour naviguer vers les détails de la chambre
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomDetailScreen(room: room),
                ),
              );
            },
            // Callback centralisé pour gérer la réservation
            onReserve: () => ReservationService.showReservationDialog(context, room),
          );
        },
      ),
    );
  }
}
