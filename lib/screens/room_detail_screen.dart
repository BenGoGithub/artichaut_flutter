import 'package:flutter/material.dart';
import '../models/room.dart';
import '../themes/app_theme.dart';
import '../widgets/buttons/icon_text_buton.dart';
import '../services/reservation_service.dart';

class RoomDetailScreen extends StatelessWidget {
  final Room room;

  const RoomDetailScreen({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // App bar avec image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.accentColor,
                      AppTheme.secondaryColor,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Contenu
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppTheme.backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre et prix
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            room.title,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        Text(
                          '${room.price.toInt()} €',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Description
                    Text(
                      room.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),

                    // Équipements
                    Text(
                      'Équipements',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: room.amenities.map((amenity) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.accentColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            amenity,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textPrimaryColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),

                    // Bouton de réservation
                    SizedBox(
                      width: double.infinity,
                      child: IconTextButton(
                        onPressed: () => ReservationService.showReservationDialog(context, room),
                        label: 'Réserver maintenant',
                        icon: Icons.hotel,
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