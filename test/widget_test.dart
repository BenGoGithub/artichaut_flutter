import 'package:artichaut_flutter/models/room.dart';
import 'package:artichaut_flutter/themes/app_theme.dart';
import 'package:artichaut_flutter/widgets/cards/room_card.dart';
import 'package:artichaut_flutter/widgets/images/image_room.dart';
import 'package:artichaut_flutter/widgets/layouts/price_with_rating.dart';
import 'package:artichaut_flutter/widgets/layouts/room_info.dart';
import 'package:artichaut_flutter/widgets/tags/rating_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Tests du modèle Room
  group('Room Model Tests', () {
    test('Room model should create correctly', () {
      // Création d'une instance de Room avec des données de test
      final room = Room(
        id: '1',
        title: 'Test Room',
        description: 'Test Description',
        imageUrl: 'test_image.jpg',
        price: 100.0,
        rating: 5,
        amenities: ['WiFi', 'TV'],
      );

      // Vérification que tous les champs sont correctement assignés
      expect(room.id, '1');
      expect(room.title, 'Test Room');
      expect(room.price, 100.0);
      expect(room.amenities.length, 2);
    });

    test('Sample rooms should be generated correctly', () {
      // Test de la méthode statique générant des données d'exemple
      final rooms = Room.getSampleRooms();

      expect(rooms.length, 3);
      expect(rooms.first.title, 'Chambre de Luxe');
      expect(rooms.first.price, 140);
      expect(rooms.first.rating, 0);
    });
  });

  /// Tests du widget RatingTag
  group('RatingTag Widget Tests', () {
    testWidgets('RatingTag should display rating correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RatingTag(rating: 4.5), // Test avec une note décimale
          ),
        ),
      );

      // Vérification de la présence de l'icône étoile
      expect(find.byIcon(Icons.star), findsOneWidget);
      // Vérification de l'affichage de la valeur de la note
      expect(find.text('4.5'), findsOneWidget);
    });

    testWidgets('RatingTag should handle integer ratings', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RatingTag(rating: 5), // Test avec un entier
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    /// Tests du widget ImageRoom - Composant gérant l'affichage des images avec overlay
    group('ImageRoom Widget Tests', () {
      late Room testRoom;

      setUp(() {
        // Création d'une chambre de test avec note positive pour tester le RatingTag
        testRoom = Room(
          id: '1',
          title: 'Test Room',
          description: 'Test Description',
          imageUrl: 'assets/images/room-deluxe.jpg',
          price: 100.0,
          rating: 4,
          amenities: ['WiFi'],
        );
      });

    testWidgets('RoomCard should contain all modular components', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: RoomCard(room: testRoom),
          ),
        ),
      );

      // Vérification de la présence de tous les composants modulaires
      expect(find.byType(ImageRoom), findsOneWidget);
      expect(find.byType(RoomInfo), findsOneWidget);
      expect(find.byType(PriceWithRating), findsOneWidget);
    });
  });
  });
}