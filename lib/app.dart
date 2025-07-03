import 'package:flutter/material.dart';
import 'package:coin/screens/collezione/add_coin_page.dart'; // importa la pagina
import 'package:coin/data/coin_local_data_source.dart';
import 'package:coin/data/coin_repository.dart';
import 'package:coin/screens/collezione/list_coin_page.dart';
import 'package:coin/screens/collezione/search_coin_page.dart';
import 'package:coin/screens/home/view_page.dart';
import 'package:coin/screens/info/search_coin_info.dart';
import 'package:coin/screens/scansiona/identify_coin.dart';
import 'package:coin/widgets/appbar.dart';
import 'package:coin/widgets/navbar.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  int _pageIndex = 0;

  final _icons = [
    [null, null],
    [Icons.search, Icons.add],
    [null, null],
    [null, null],
  ];

  final _pageController = PageController(initialPage: 0);

  final List<String> _titles = [
    'CHRONOCOIN',
    'COLLEZIONE',
    'SCANSIONA MONETA',
    'INFO MONETE',
  ];

  void _onAddCoinPressed() async {
    final result = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => AddCoin(repository: repository)));

    if (result == true) {
      listCoinsKey.currentState?.loadCoins();
    }
  }

  void _onSearchCoinPage() async {
    final allCoins = await repository.getAllCoins();
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SearchCoinPage(allCoins: allCoins)),
    );
  }

  late final List<Widget> _screens;

  late final CoinRepository repository;

  final GlobalKey<ListCoinsState> listCoinsKey = GlobalKey<ListCoinsState>();

  @override
  void initState() {
    super.initState();
    repository = CoinRepository(localDs: CoinLocalDataSource());
    _screens = [
      ViewPage(),
      ListCoins(key: listCoinsKey, repository: repository),
      IdentifyCoinPage(),
      SearchCoinInfoPage(),
    ];
  }

  _onPageChanged(int index) {
    setState(() => _pageIndex = index);
  }

  _onTap(int index) {
    setState(() => _pageIndex = index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: _titles[_pageIndex],
        left: _icons[_pageIndex][0],
        right: _icons[_pageIndex][1],
        onLeftPressed: () {
          if (_pageIndex == 1) {
            _onSearchCoinPage();
          }
        },
        onRightPressed: () {
          if (_icons[_pageIndex][1] == Icons.add) {
            _onAddCoinPressed();
          }
        },
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _screens,
      ),
      bottomNavigationBar: MyNavbar(index: _pageIndex, onTap: _onTap),
    );
  }
}
