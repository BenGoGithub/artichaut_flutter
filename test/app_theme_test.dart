import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:artichaut_flutter/themes/app_theme.dart';

void main() {
  group('Tests du thème personnalisé', () {
    testWidgets('Vérifie la couleur primaire du thème clair (AppBar)', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Test AppBar'),
            ),
            body: const SizedBox.shrink(),
          ),
        ),
      );

      // Récupérer la couleur d'arrière plan de l'AppBar via le contexte
      final BuildContext context = tester.element(find.byType(AppBar));
      final Color? appBarBackgroundColor = AppBarTheme.of(context).backgroundColor ??
          AppTheme.lightTheme.colorScheme.primary;

      expect(appBarBackgroundColor, equals(AppTheme.primaryColor));
    });

    testWidgets('Le texte applique la bonne taille du thème', (WidgetTester tester) async {
      const testText = 'Un texte de test';

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return Text(
                  testText,
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              },
            ),
          ),
        ),
      );

      final Text textWidget = tester.widget(find.text(testText));
      expect(textWidget.style?.fontSize, equals(32));
      // fontFamily est sur ThemeData, pas dans TextStyle directement ici, on skip
    });
  });
}