import 'package:go_router/go_router.dart';
import '../screens/shell_screen.dart';
import '../screens/characters_screen.dart';
import '../screens/locations_screen.dart';
import '../screens/episodes_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/characters',
  routes: [
    ShellRoute(
      builder: (context, state, child) => ShellScreen(child: child),
      routes: [
        GoRoute(
          path: '/characters',
          builder: (context, state) => const CharactersScreen(),
        ),
        GoRoute(
          path: '/locations',
          builder: (context, state) => const LocationsScreen(),
        ),
        GoRoute(
          path: '/episodes',
          builder: (context, state) => const EpisodesScreen(),
        ),
      ],
    ),
  ],
);
