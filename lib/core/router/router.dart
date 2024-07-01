import 'package:go_router/go_router.dart';
import 'package:top_up_ticket/features/home/view/home_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
