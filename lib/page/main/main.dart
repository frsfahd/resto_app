import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/page/home/home.dart';
import 'package:resto_app/page/search/search.dart';
import 'package:resto_app/provider/main/index_nav_provider.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        onTap: (index) {
          context.read<IndexNavProvider>().setIndexBottomNavBar = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_mini_rounded),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: "Search",
            tooltip: "Search",
          ),
        ],
      ),

      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => Home(),
            1 => Search(),
            _ => SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
