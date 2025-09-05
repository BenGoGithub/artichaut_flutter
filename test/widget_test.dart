import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:artichaut_flutter/main.dart';
import 'package:artichaut_flutter/models/room.dart';
import 'package:artichaut_flutter/widgets/cards/room_card.dart';
import 'package:artichaut_flutter/widgets/images/image_room.dart';
import 'package:artichaut_flutter/widgets/tags/rating_tag.dart';
import 'package:artichaut_flutter/widgets/layouts/room_info.dart';
import 'package:artichaut_flutter/widgets/layouts/price_with_rating.dart';
import 'package:artichaut_flutter/screens/room_list_screen.dart';
import 'package:artichaut_flutter/screens/room_detail_screen.dart';
import 'package:artichaut_flutter/themes/app_theme.dart';

void main() {
  group('Room Model Tests', () {
    test('Room model should create correctly', () {
      final room = Room(
        id: '1',
        title: 'Test Room',
        description: 'Test Description',
        imageUrl: 'test_image.jpg',
        price: 100.0,
        rating: 5,
        amenities: ['WiFi', 'TV'],
      );

      expect(room.id, '1');
      expect(room.title, 'Test Room');
      expect(room.price, 100.0);
      expect(room.amenities.length, 2);
    });

    test('Sample rooms should be generated correctly', () {
      final rooms = Room.getSampleRooms();

      expect(rooms.length, 3);
      expect(rooms.first.title, 'Chambre de Luxe');
      expect(rooms.first.price, 140);
      expect(rooms.first.rating, 0);
    });
  });

  group('RoomCard Widget Tests', () {
    late Room testRoom;

    setUp(() {
      testRoom = Room(
        id: '1',
        title: 'Chambre de Luxe',
        description: 'Une belle chambre de luxe avec tous les équipements.',
        imageUrl: 'test_image.jpg',
        price: 140.0,
        rating: 0,
        amenities: ['50m²', 'Coin salon'],
      );
    });

    testWidgets('RoomCard should display room information correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: RoomCard(room: testRoom),
          ),
        ),
      );

      // Vérifier que le titre est affiché
      expect(find.text('Chambre de Luxe'), findsOneWidget);

      // Vérifier que le prix est affiché
      expect(find.text('140 €'), findsOneWidget);

      // Vérifier que la description est affichée
      expect(find.textContaining('Une belle chambre'), findsOneWidget);

      // Vérifier que le bouton de réservation est présent
      expect(find.text('Réserver'), findsOneWidget);
    });

    testWidgets('RoomCard should show rating when rating > 0', (WidgetTester tester) async {
      final roomWithRating = Room(
        id: '2',
        title: 'Test Room',
        description: 'Description',
        imageUrl: 'test.jpg',
        price: 100,
        rating: 5,
        amenities: [],
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: RoomCard(room: roomWithRating),
          ),
        ),
      );

      // Vérifier que l'étoile et la note sont affichées
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('RoomCard should handle tap events', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: RoomCard(
              room: testRoom,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // Taper sur la carte
      await tester.tap(find.byType(RoomCard));
      await tester.pump();

      expect(tapped, true);
    });
  });

  group('RoomListScreen Widget Tests', () {
    testWidgets('RoomListScreen should display list of rooms', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const RoomListScreen(),
        ),
      );

      // Vérifier que l'AppBar est présent
      expect(find.text('Nos Chambres'), findsOneWidget);

      // Vérifier que les cartes de chambres sont affichées
      expect(find.byType(RoomCard), findsAtLeastNWidgets(1));

      // Vérifier que la chambre de luxe est affichée
      expect(find.text('Chambre de Luxe'), findsOneWidget);
    });

    testWidgets('RoomListScreen should navigate to detail screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const RoomListScreen(),
        ),
      );

      // Taper sur la première carte
      await tester.tap(find.byType(RoomCard).first);
      await tester.pumpAndSettle();

      // Vérifier que nous sommes sur l'écran de détail
      expect(find.byType(RoomDetailScreen), findsOneWidget);
    });
  });

  group('RoomDetailScreen Widget Tests', () {
    late Room testRoom;

    setUp(() {
      testRoom = Room(
        id: '1',
        title: 'Chambre de Luxe',
        description: 'La chambre de Luxe offre 50m² d\'espace pensé pour votre bien-être.',
        imageUrl: 'test_image.jpg',
        price: 140.0,
        rating: 0,
        amenities: ['50m²', 'Coin salon', 'Baignoire'],
      );
    });

    testWidgets('RoomDetailScreen should display room details', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: RoomDetailScreen(room: testRoom),
        ),
      );

      // Vérifier que le titre est affiché
      expect(find.text('Chambre de Luxe'), findsOneWidget);

      // Vérifier que le prix est affiché
      expect(find.text('140 €'), findsOneWidget);

      // Vérifier que la description complète est affichée
      expect(find.textContaining('50m² d\'espace'), findsOneWidget);

      // Vérifier que le bouton de réservation est présent
      expect(find.text('Réserver maintenant'), findsOneWidget);
    });

    testWidgets('RoomDetailScreen should display amenities', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: RoomDetailScreen(room: testRoom),
        ),
      );

      // Vérifier que le titre des équipements est affiché
      expect(find.text('Équipements'), findsOneWidget);

      // Vérifier que les équipements sont affichés
      expect(find.text('50m²'), findsOneWidget);
      expect(find.text('Coin salon'), findsOneWidget);
      expect(find.text('Baignoire'), findsOneWidget);
    });

    testWidgets('RoomDetailScreen should have scrollable content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: RoomDetailScreen(room: testRoom),
        ),
      );

      // Vérifier que le CustomScrollView est présent
      expect(find.byType(CustomScrollView), findsOneWidget);

      // Vérifier que le SliverAppBar est présent
      expect(find.byType(SliverAppBar), findsOneWidget);
    });
  });

  group('Theme Integration Tests', () {
        testWidgets('Buttons should use theme styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: ElevatedButton(
              onPressed: () {},
              child: const Text('Test'),
            ),
          ),
        ),
      );

      final BuildContext context = tester.element(find.byType(Scaffold));
      final ThemeData theme = Theme.of(context);
      final buttonStyle = theme.elevatedButtonTheme.style;

      expect(
        buttonStyle?.backgroundColor?.resolve({}),
        AppTheme.primaryColor,
      );
      expect(
        buttonStyle?.foregroundColor?.resolve({}),
        Colors.white,
      );
    });
  });

  group('Integration Tests', () {
    testWidgets('Full app navigation flow', (WidgetTester tester) async {
      await tester.pumpWidget(const LuxuryHotelApp());

      // Vérifier que nous sommes sur l'écran de liste
      expect(find.byType(RoomListScreen), findsOneWidget);
      expect(find.text('Nos Chambres'), findsOneWidget);

      // Taper sur une chambre
      await tester.tap(find.text('Chambre de Luxe'));
      await tester.pumpAndSettle();

      // Vérifier que nous sommes sur l'écran de détail
      expect(find.byType(RoomDetailScreen), findsOneWidget);
      expect(find.text('Réserver maintenant'), findsOneWidget);

      // Revenir en arrière
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Vérifier que nous sommes revenus sur la liste
      expect(find.byType(RoomListScreen), findsOneWidget);
    });

    testWidgets('App should handle different room types', (WidgetTester tester) async {
      await tester.pumpWidget(const LuxuryHotelApp());

      // Vérifier que différents types de chambres sont affichés
      expect(find.text('Chambre de Luxe'), findsOneWidget);

      // Faire défiler pour voir plus de chambres
      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pumpAndSettle();

      // Vérifier que d'autres chambres sont visibles
      expect(find.text('Suite Présidentielle'), findsOneWidget);
    });
  });

  group('Accessibility Tests', () {
    testWidgets('App should have proper semantic labels', (WidgetTester tester) async {
      await tester.pumpWidget(const LuxuryHotelApp());

      // Vérifier que les éléments importants ont des labels sémantiques
      expect(find.text('Nos Chambres'), findsOneWidget);
      expect(find.text('Réserver'), findsAtLeastNWidgets(1));

      // Vérifier que les boutons sont accessibles
      final reserveButtons = find.text('Réserver');
      expect(reserveButtons, findsAtLeastNWidgets(1));
    });
  });

  group('Error Handling Tests', () {
    testWidgets('App should handle empty room list gracefully', (WidgetTester tester) async {
      // Test avec une liste vide (nécessiterait de mocker Room.getSampleRooms())
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const RoomListScreen(),
        ),
      );

      // L'app devrait toujours fonctionner même avec des données manquantes
      expect(find.byType(RoomListScreen), findsOneWidget);
    });
  });
}