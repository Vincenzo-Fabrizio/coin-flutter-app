import 'package:flutter/material.dart';
import 'package:coin/app.dart';
import 'package:coin/models/numismatic_rarity.dart';
import 'package:coin/models/option_conservation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:coin/models/coin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CoinAdapter());
  Hive.registerAdapter(OptionConservationAdapter());
  Hive.registerAdapter(NumismaticRarityAdapter());
  await Hive.openBox<Coin>('coins');
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Merriweather',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 24),
          displayMedium: TextStyle(fontSize: 20),
          titleLarge: TextStyle(fontSize: 16),
          bodyLarge: TextStyle(fontSize: 14),
          bodyMedium: TextStyle(fontSize: 12),
        ),
      ),
      home: const App(),
    );
  }
}
