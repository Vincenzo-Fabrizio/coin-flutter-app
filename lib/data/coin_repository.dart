import 'coin_local_data_source.dart';
import '../models/coin.dart';

class CoinRepository {
  final CoinLocalDataSource localDs;

  CoinRepository({required this.localDs});

  Future<List<Coin>> getAllCoins() async {
    return await localDs.getAll();
  }

  Future<void> addCoin(Coin coin) async {
    final localList = await localDs.getAll();
    await localDs.saveAll([...localList, coin]);
  }

  Future<void> deleteCoin(String id) async {
    await localDs.delete(id);
  }
}
