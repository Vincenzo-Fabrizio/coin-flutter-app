import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:coin/services/gold_price_service.dart'; // Quotazione attuale
import 'package:coin/services/gold_price_historian_service.dart'; // Storico grafico

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  List<FlSpot> data24k = [];
  List<FlSpot> data22k = [];
  double? prezzoAttuale24k;
  double? prezzoAttuale22k;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    setState(() => _loading = true);

    // 1. Prendi la quotazione attuale
    try {
      final attuale = await GoldPriceService().fetchGoldPrice('eur');
      prezzoAttuale24k = attuale.priceGram24k;
      prezzoAttuale22k = attuale.priceGram22k;
    } catch (e) {
      prezzoAttuale24k = null;
      prezzoAttuale22k = null;
    }

    // 2. Prendi lo storico (ad esempio ultimi 7 giorni)
    try {
      final storico = await GoldApiService().getGoldHistory();
      data24k = List.generate(
        storico.length,
        (i) => FlSpot(i.toDouble(), storico[i].priceGram24k),
      );
      data22k = List.generate(
        storico.length,
        (i) => FlSpot(i.toDouble(), storico[i].priceGram22k),
      );
    } catch (e) {
      data24k = [];
      data22k = [];
    }

    setState(() => _loading = false);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3ED),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📌 Sezione informazioni iniziali
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 5.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'QUOTAZIONE ORO IN TEMPO REALE',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    prezzoAttuale24k != null
                        ? '💰24K: ${prezzoAttuale24k!.toStringAsFixed(2)} €/g'
                        : '💰24K: -- €/g',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    prezzoAttuale22k != null
                        ? '💰22K: ${prezzoAttuale22k!.toStringAsFixed(2)} €/g'
                        : '💰22K: -- €/g',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10), // 🔺 Spazio tra intestazione e grafico
            // 📊 Grafico che occupa tutto lo spazio rimanente
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  15,
                  0,
                  15,
                  24,
                ), // 🔽 padding inferiore dalla navbar
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(146, 201, 201, 201),
                  ),
                  padding: const EdgeInsets.all(12),
                  child:
                      _loading
                          ? const Center(child: CircularProgressIndicator())
                          : Column(
                            children: [
                              Expanded(
                                child: LineChart(
                                  LineChartData(
                                    minX: 0,
                                    maxX:
                                        data24k.isNotEmpty
                                            ? data24k.length - 1
                                            : 6,
                                    minY:
                                        [
                                          ...data24k.map((e) => e.y),
                                          ...data22k.map((e) => e.y),
                                        ].fold<double>(
                                          double.infinity,
                                          (prev, el) => el < prev ? el : prev,
                                        ) -
                                        5,
                                    maxY:
                                        [
                                          ...data24k.map((e) => e.y),
                                          ...data22k.map((e) => e.y),
                                        ].fold<double>(
                                          -double.infinity,
                                          (prev, el) => el > prev ? el : prev,
                                        ) +
                                        5,

                                    // ✅ Rende gli assi leggibili
                                    titlesData: FlTitlesData(
                                      show: true,
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 30,
                                          interval: 1,
                                          getTitlesWidget: (value, meta) {
                                            return Text(
                                              value.toStringAsFixed(0),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 40,
                                          interval: 10,
                                          getTitlesWidget: (value, meta) {
                                            return Text(
                                              value.toStringAsFixed(0),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      rightTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                    ),
                                    borderData: FlBorderData(show: false),
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: data24k,
                                        isCurved: true,
                                        barWidth: 3,
                                        color: Colors.blue,
                                      ),
                                      LineChartBarData(
                                        spots: data22k,
                                        isCurved: true,
                                        barWidth: 3,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '📊 Legenda Grafico:\n'
                                  '- Linea blu: quotazione oro 24K\n'
                                  '- Linea grigia: quotazione oro 22K',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
