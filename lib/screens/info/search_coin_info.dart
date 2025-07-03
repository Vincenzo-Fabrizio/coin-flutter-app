import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchCoinInfoPage extends StatefulWidget {
  const SearchCoinInfoPage({super.key});

  @override
  State<SearchCoinInfoPage> createState() => _SearchCoinInfoPageState();
}

class _SearchCoinInfoPageState extends State<SearchCoinInfoPage> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse('https://en.numista.com/catalogue/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3ED),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
