import 'package:artichaut_flutter/models/room.dart';
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
  });
}