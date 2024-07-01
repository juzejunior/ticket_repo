import 'package:go_router/go_router.dart';
import 'package:top_up_ticket/features/mobile_recharge/view/screens/mobile_recharge_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RechargeScreen(),
    ),
  ],
);
