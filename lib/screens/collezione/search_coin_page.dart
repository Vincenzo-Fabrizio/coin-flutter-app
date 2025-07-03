import 'package:flutter/material.dart';
import 'package:coin/screens/collezione/widgets/coin_details.dart';
import '../../models/coin.dart';

class SearchCoinPage extends StatefulWidget {
  final List<Coin> allCoins;

  const SearchCoinPage({super.key, required this.allCoins});

  @override
  State<SearchCoinPage> createState() => _SearchCoinPageState();
}

class _SearchCoinPageState extends State<SearchCoinPage> {
  final _nameCtrl = TextEditingController();
  final _yearCtrl = TextEditingController();
  final _materialCtrl = TextEditingController();

  List<Coin> _filtered = [];
  bool _hasSearched = false;

  void _filter() {
    final name = _nameCtrl.text.toLowerCase();
    final year = _yearCtrl.text;
    final material = _materialCtrl.text.toLowerCase();

    setState(() {
      _filtered =
          widget.allCoins.where((coin) {
            final m1 = name.isEmpty || coin.name.toLowerCase().contains(name);
            final m2 = year.isEmpty || coin.year.toString().contains(year);
            final m3 =
                material.isEmpty ||
                coin.material.toLowerCase().contains(material);
            return m1 && m2 && m3;
          }).toList();
      _hasSearched = true;
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _yearCtrl.dispose();
    _materialCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('RICERCA MONETE'),
        backgroundColor: const Color(0xFFB08D57),
      ),
      backgroundColor: const Color(0xFFF5F3ED),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildField('NOME', _nameCtrl),
            _buildField('ANNO', _yearCtrl, numeric: true),
            _buildField('MATERIALE', _materialCtrl),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.search),
              label: const Text('RICERCA MONETA'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB08D57),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: _filter,
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  !_hasSearched
                      ? const Center(child: Text('INSERISCI I PARAMETRI'))
                      : _filtered.isEmpty
                      ? const Center(child: Text('NESSUNA MONETA TROVATA'))
                      : ListView.builder(
                        itemCount: _filtered.length,
                        itemBuilder: (_, i) => _buildDetailedCard(_filtered[i]),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController ctrl, {
    bool numeric = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: ctrl,
        keyboardType: numeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailedCard(Coin coin) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E1),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFFB08D57), width: 2),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(25, 0, 0, 0),
              offset: const Offset(0, 3),
              blurRadius: 5,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [CoinDetails(coin: coin)],
        ),
      ),
    );
  }
}
