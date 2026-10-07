import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/about_screen.dart';

void main() {
  runApp(const AstrovaApp());
}

class AstrovaApp extends StatelessWidget {
  const AstrovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astrova',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090A15),
        primaryColor: const Color(0xFF7B8CDE),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7B8CDE),
          secondary: Color(0xFFC084FC),
          surface: Color(0xFF10142B),
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  String? _selectedCategoryFromHome;

  void _navigateToExplore(String? category) {
    setState(() {
      _selectedCategoryFromHome = category;
      _currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(onNavigateToExplore: _navigateToExplore),
      ExploreScreen(
        key: ValueKey(_selectedCategoryFromHome),
        initialCategory: _selectedCategoryFromHome,
      ),
      const AboutScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF090A15),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0B0E1B),
          border: Border(
            top: BorderSide(
              color: Color(0xFF1E2548),
              width: 1,
            ),
          ),
        ),
        // Requisito: Navegação com BottomNavigationBar
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            // Requisito: Gerenciamento de estado nativo com setState
            setState(() {
              if (index != 1) {
                _selectedCategoryFromHome = null;
              }
              _currentIndex = index;
            });
          },
          backgroundColor: const Color(0xFF0B0E1B),
          selectedItemColor: const Color(0xFF7B8CDE),
          unselectedItemColor: const Color(0xFF6B7280),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: 'Explorar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              activeIcon: Icon(Icons.info),
              label: 'Sobre',
            ),
          ],
        ),
      ),
    );
  }
}
