import 'dart:convert';
import 'package:http/http.dart' as http;

class GoldPrice {
  final String currency;
  final double priceGram24k;
  final double priceGram22k;

  GoldPrice({
    required this.currency,
    required this.priceGram24k,
    required this.priceGram22k,
  });
}

class GoldPriceService {
  Future<GoldPrice> fetchGoldPrice(String currency) async {
    final url = Uri.parse(
      'https://data-asg.goldprice.org/dbXRates/${currency.toUpperCase()}',
    );

    final response = await http.get(
      url,
      headers: {'User-Agent': 'Mozilla/5.0'},
    );

    if (response.statusCode != 200) {
      throw Exception('Errore HTTP: ${response.statusCode}');
    }

    final json = jsonDecode(response.body);

    final double pricePerOunce = double.parse(
      json['items'][0]['xauPrice'].toString(),
    );
    final double priceGram24k = pricePerOunce / 31.1035;
    final double priceGram22k = priceGram24k * 0.917;

    return GoldPrice(
      currency: currency.toUpperCase(),
      priceGram24k: priceGram24k,
      priceGram22k: priceGram22k,
    );
  }
}
