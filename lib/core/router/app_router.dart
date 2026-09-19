import 'package:click_yt/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: NavigationScreen.name,
      builder: (context, state) => const NavigationScreen(),
    ),
  ],
);
