import 'package:coin/models/numismatic_rarity.dart';
import 'package:coin/models/option_conservation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coin/models/coin.dart';
import 'package:coin/screens/collezione/widgets/coin_details.dart';

void main() {
  testWidgets('CoinDetails shows coin data correctly', (
    WidgetTester tester,
  ) async {
    // Arrange: crea una moneta di test
    final coin = Coin(
      id: '1',
      name: 'Test Coin',
      year: 2024,
      material: 'Gold',
      weight: 10.0,
      diameter: 20.0,
      height: 2.0,
      price: 1000.0,
      conservationObverse: OptionConservation.qFDC,
      conservationReverse: OptionConservation.SPL,
      degree: NumismaticRarity.R,
    );

    // Act: monta il widget
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: CoinDetails(coin: coin))),
    );

    // Assert: verifica che i dati siano visibili
    expect(find.textContaining('Test Coin'), findsOneWidget);
    expect(find.textContaining('2024'), findsOneWidget);
    expect(find.textContaining('Gold'), findsOneWidget);
    expect(find.textContaining('10'), findsWidgets); // peso
    expect(find.textContaining('20'), findsWidgets); // diametro
    expect(find.textContaining('2'), findsWidgets); // altezza
    expect(find.textContaining('1000'), findsWidgets); // prezzo
  });
}
