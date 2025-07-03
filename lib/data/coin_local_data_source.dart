import 'package:hive/hive.dart';
import '../models/coin.dart';

class CoinLocalDataSource {
  static const _boxName = 'coins';

  Future<void> init() async {
    await Hive.openBox<Coin>(_boxName);
  }

  Box<Coin> get _box => Hive.box<Coin>(_boxName);

  Future<List<Coin>> getAll() async {
    final coins = _box.values.whereType<Coin>().toList();
    coins.sort((a, b) => b.price.compareTo(a.price));
    return coins;
  }

  Future<void> saveAll(List<Coin> coins) async {
    final map = {for (var c in coins) c.id: c};
    await _box.putAll(map);
  }

  Future<void> delete(String id) => _box.delete(id);

  Future<void> addCoin(Coin coin) async {
    await _box.put(coin.id, coin);
  }
}
