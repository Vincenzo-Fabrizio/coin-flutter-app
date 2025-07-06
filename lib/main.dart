import 'package:flutter/material.dart';
import 'package:coin/app.dart';
import 'package:coin/models/numismatic_rarity.dart';
import 'package:coin/models/option_conservation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:coin/models/coin.dart'; // importa il modello Coin

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CoinAdapter());
  Hive.registerAdapter(OptionConservationAdapter()); // registra l'adapter
  Hive.registerAdapter(NumismaticRarityAdapter()); // registra l'adapter
  await Hive.openBox<Coin>('coins'); // apri la box PRIMA di runApp
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        fontFamily: 'Merriweather',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32),
          displayMedium: TextStyle(fontSize: 28),
          titleLarge: TextStyle(fontSize: 20),
          bodyLarge: TextStyle(fontSize: 13),
          bodyMedium: TextStyle(fontSize: 13),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Merriweather'),
      ),
      home: const App(),
    );
  }
}
