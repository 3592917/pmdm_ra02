import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pmdm_ra02/my_app.dart';

void main() {
  testWidgets('MyHomePage UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the title is displayed.
    expect(find.text('Flutter básico - HTTP y Serialización'), findsOneWidget);

    // Verify that all buttons are displayed.
    expect(
      find.widgetWithText(ElevatedButton, 'Obtener usuario'),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(ElevatedButton, 'Obtener todos los usuarios'),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(ElevatedButton, 'Crear un nuevo usuario'),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(ElevatedButton, 'Modificar usuario'),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(ElevatedButton, 'Borrar usuario'),
      findsOneWidget,
    );
  });
}
