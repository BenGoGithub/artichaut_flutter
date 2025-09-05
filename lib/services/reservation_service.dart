// lib/services/reservation_service.dart
import 'package:flutter/material.dart';
import '../models/room.dart';
import '../themes/app_theme.dart';

/// Service centralisé pour gérer toute la logique de réservation
/// Suit le principe Single Responsibility : ne gère que les réservations
class ReservationService {

  /// Méthode statique pour afficher le dialog de confirmation
  /// Statique car ne nécessite pas d'instance de classe
  static void showReservationDialog(BuildContext context, Room room) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation de réservation'),
          content: Text(
            'Voulez-vous réserver la chambre "${room.title}" pour ${room.price.toInt()}€ ?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _processReservation(context, room);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
              ),
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  /// Méthode privée pour traiter la réservation
  /// to do : ceci appellerait une API
  static void _processReservation(BuildContext context, Room room) {
    // Feedback immédiat
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Réservation en cours pour "${room.title}"...'),
        backgroundColor: AppTheme.primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );

    // Simulation du succès après 2 secondes
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Réservation confirmée pour "${room.title}" !'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Voir mes réservations',
              textColor: Colors.white,
              onPressed: () {
                // Navigation vers l'écran des réservations
                Navigator.pushNamed(context, '/my-reservations');
              },
            ),
          ),
        );
      }
    });
  }

  static void reserveDirectly(BuildContext context, Room room) {
    _processReservation(context, room);
  }
}
