import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/favourites_page.dart';
import 'package:book_collector/views/history_page.dart';
import 'package:book_collector/views/home_page/home_page.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  final List _pages = [
    const HomePage(),
    const FavouritesPage(),
    const HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() => _selectedIndex = value),
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        items: const [
          //--- Home ---//
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: "Home",
            tooltip: "Home",
          ),

          //--- Favourites ---//
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outline_rounded),
            activeIcon: Icon(Icons.star_rounded),
            label: "Favorit",
            tooltip: "Favorit",
          ),

          //--- History ---//
          BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            activeIcon: Icon(Icons.history_rounded),
            label: "Riwayat",
            tooltip: "Riwayat",
          ),
        ],
      ),
    );
  }
}
