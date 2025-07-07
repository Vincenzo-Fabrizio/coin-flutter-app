import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GoldApiService {
  static const String _apiKey = 'goldapi-1jlsbk17mct8ertw-io';
  static const String _baseUrl = 'https://www.goldapi.io/api';

  /// Ottiene il prezzo dell'oro per una data specifica (formato yyyy-mm-dd)
  /// Usa endpoint https://www.goldapi.io/api/XAU/EUR/{date}
  Future<GoldApiPrice> fetchGoldPriceOnDate(String date) async {
    final url = Uri.parse('$_baseUrl/XAU/EUR/$date');
    final response = await http.get(
      url,
      headers: {'x-access-token': _apiKey, 'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return GoldApiPrice.fromJson(data);
    } else {
      throw Exception('Errore API GoldAPI.io: ${response.statusCode}');
    }
  }

  /// Restituisce lo storico degli ultimi 7 giorni, aggiornando solo se necessario
  Future<List<GoldApiPrice>> getGoldHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final todayStr =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    final savedHistory = prefs.getString('gold_history');
    final savedDate = prefs.getString('gold_history_last_date');

    List<GoldApiPrice> history = [];
    if (savedHistory != null && savedDate == todayStr) {
      // Usa storico salvato se aggiornato a oggi
      final List<dynamic> decoded = jsonDecode(savedHistory);
      history = decoded.map((e) => GoldApiPrice.fromJson(e)).toList();
    } else {
      history = [];
      for (int i = 6; i >= 0; i--) {
        final date = now.subtract(Duration(days: i));
        final dateStr =
            "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
        try {
          final price = await fetchGoldPriceOnDate(dateStr);
          history.add(price);
        } catch (e) {
          // Se errore aggiungo prezzi a 0 per non bloccare lo storico
          history.add(GoldApiPrice(priceGram24k: 0, priceGram22k: 0));
        }
      }
      // Salva storico e data
      prefs.setString(
        'gold_history',
        jsonEncode(history.map((e) => e.toJson()).toList()),
      );
      prefs.setString('gold_history_last_date', todayStr);
    }
    return history;
  }
}

class GoldApiPrice {
  final double priceGram24k;
  final double priceGram22k;

  GoldApiPrice({required this.priceGram24k, required this.priceGram22k});

  factory GoldApiPrice.fromJson(Map<String, dynamic> json) {
    double? price24k = (json['price_gram_24k'] as num?)?.toDouble();
    double? price22k = (json['price_gram_22k'] as num?)?.toDouble();

    if (price24k == null || price24k == 0) {
      double? prevClose = (json['prev_close_price'] as num?)?.toDouble();
      if (prevClose != null && prevClose > 0) {
        price24k = prevClose / 31.1035; // Conversione da oncia a grammo
      } else {
        price24k = 0;
      }
    }

    if (price22k == null || price22k == 0) {
      price22k = price24k * (22 / 24); // Stima approssimata prezzo 22k
    }

    return GoldApiPrice(priceGram24k: price24k, priceGram22k: price22k);
  }

  Map<String, dynamic> toJson() => {
    'price_gram_24k': priceGram24k,
    'price_gram_22k': priceGram22k,
  };
}
