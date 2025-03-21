import 'package:basic_test/controllers/auth_controller.dart';
import 'package:basic_test/screens/google_map.dart';
import 'package:basic_test/screens/login.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final List<Widget> _screens = [
    HomeScreen(),
    TrafficMapScreen(),
    SettingsScreen(),
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  void _checkToken() async {
    String? token = await AuthController().getToken();
    print("====================> $token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          _currentIndex = index;
          setState(() {});
        },
        selectedIndex: _currentIndex,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.map), label: "Map"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () => _onClickLogOutButton(context),
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Center(child: Text("Home page")),
    );
  }

  void _onClickLogOutButton(context) {
    AuthController().logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (_) => false,
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Settings page")));
  }
}
