import 'package:flutter/material.dart';
import 'package:coin/models/coin.dart';

class CoinDetails extends StatelessWidget {
  final Coin coin;

  const CoinDetails({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            const Text('ID  '),
            Text(
              coin.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text('ANNO: ${coin.year}'),
        Text('MATERIALE: ${coin.material}'),
        Text('PESO: ${coin.weight} g'),
        Text('DIAMETRO: ${coin.diameter} mm'),
        Text('ALTEZZA: ${coin.height} mm'),
        Text('PREZZO: €${coin.price.toStringAsFixed(2)}'),
        Text('CONSERVAZIONE FRONTE: ${coin.conservationObverse.wording}'),
        Text('CONSERVAZIONE RETRO: ${coin.conservationReverse.wording}'),
        Text('GRADO NUMISMATICO: ${coin.degree.wording}'),
      ],
    );
  }
}
