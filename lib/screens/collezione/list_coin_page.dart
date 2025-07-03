import 'package:flutter/material.dart';
import 'package:coin/data/coin_repository.dart';
import 'package:coin/models/coin.dart';
import 'package:coin/screens/collezione/widgets/coin_details.dart';

class ListCoins extends StatefulWidget {
  final CoinRepository repository;
  const ListCoins({super.key, required this.repository});

  @override
  State<ListCoins> createState() => ListCoinsState();
}

class ListCoinsState extends State<ListCoins> {
  late Future<List<Coin>> _futureCoins;

  @override
  void initState() {
    super.initState();
    loadCoins();
  }

  void loadCoins() {
    _futureCoins = widget.repository.getAllCoins();
    setState(() {});
  }

  Future<void> _deleteCoin(Coin coin) async {
    await widget.repository.deleteCoin(coin.id);
    if (!mounted) return;
    loadCoins();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('MONETA "${coin.name}" ELIMINATA.')));
  }

  @override
  Widget build(BuildContext context) {
    const double cardHeight = 280;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3ED),
      body: FutureBuilder<List<Coin>>(
        future: _futureCoins,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("ERRORE: ${snapshot.error}"));
          }
          final coins = snapshot.data ?? [];
          if (coins.isEmpty) {
            return const Center(
              child: Text(
                "NESSUNA MONETA TROVATA",
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            itemCount: coins.length,
            itemBuilder: (_, index) {
              final c = coins[index];
              return Dismissible(
                key: ValueKey(c.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.delete,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (_) => _deleteCoin(c),
                child: SizedBox(
                  height: cardHeight,
                  width: double.infinity,
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: const Color(0xFFFFF8E1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 100,
                    shadowColor: Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CoinDetails(coin: c)],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
