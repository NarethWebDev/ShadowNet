// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shadownet_group/main.dart';

void main() {
  testWidgets('AgentProfileScreen muestra el título correctamente',
      (WidgetTester tester) async {
    // Construye la app
    await tester.pumpWidget(const ShadowNetApp());

    // Verifica que el AppBar tiene el título esperado
    expect(find.text('SHADOWNET // PERFIL DE AGENTE'), findsOneWidget);
  });

  testWidgets('Muestra mensaje inicial cuando no hay facción seleccionada',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ShadowNetApp());

    expect(
      find.text('> Selecciona tu facción para continuar_'),
      findsOneWidget,
    );
  });

  testWidgets('Seleccionar Hacker muestra su nombre en pantalla',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ShadowNetApp());

    // Toca el botón de Hacker
    await tester.tap(find.text('HACKER'));
    await tester.pump();

    expect(find.text('HACKER'), findsWidgets);
  });
}