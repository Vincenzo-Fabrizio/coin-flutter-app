import 'coin_local_data_source.dart';
import '../models/coin.dart';

class CoinRepository {
  final CoinLocalDataSource localDs;

  CoinRepository({required this.localDs});

  /// Ottiene tutte le monete solo dal locale
  Future<List<Coin>> getAllCoins() async {
    return await localDs.getAll();
  }

  /// Aggiunge una nuova moneta solo in locale.
  Future<void> addCoin(Coin coin) async {
    final localList = await localDs.getAll();
    await localDs.saveAll([...localList, coin]);
  }

  /// Elimina la moneta specificata solo in locale.
  Future<void> deleteCoin(String id) async {
    await localDs.delete(id);
  }
}
