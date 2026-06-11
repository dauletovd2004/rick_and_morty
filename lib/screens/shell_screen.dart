import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellScreen extends StatelessWidget {
  final Widget child;
  const ShellScreen({super.key, required this.child});

  int _tabIndex(String location) {
    if (location.startsWith('/locations')) return 1;
    if (location.startsWith('/episodes')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex(location),
        selectedItemColor: Colors.green,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/characters');
              break;
            case 1:
              context.go('/locations');
              break;
            case 2:
              context.go('/episodes');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            activeIcon: Icon(Icons.location_on),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv_outlined),
            activeIcon: Icon(Icons.tv),
            label: 'Episodes',
          ),
        ],
      ),
    );
  }
}
