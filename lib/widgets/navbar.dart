import 'package:flutter/material.dart';

class MyNavbar extends StatelessWidget {
  final int? index;
  final Function(int)? onTap;

  const MyNavbar({super.key, this.index, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: index ?? 0,
      onTap: onTap,
      backgroundColor: const Color(0xFFB08D57),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(label: 'HOME', icon: Icon(Icons.home)),
        BottomNavigationBarItem(
          label: 'COLLEZIONE',
          icon: Icon(Icons.inventory),
        ),
        BottomNavigationBarItem(
          label: 'SCANSIONA',
          icon: Icon(Icons.document_scanner),
        ),
        BottomNavigationBarItem(label: 'INFO', icon: Icon(Icons.info)),
      ],
    );
  }
}
