import 'package:go_router/go_router.dart';
import 'package:top_up_ticket/core/router/screen_name.dart';
import 'package:top_up_ticket/features/mobile_recharge/view/screens/mobile_recharge_screen.dart';
import 'package:top_up_ticket/features/top_up/view/screens/top_up_resume_screen.dart';
import 'package:top_up_ticket/features/top_up/view/screens/top_up_screen.dart';
import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RechargeScreen(),
      routes: [
        GoRoute(
            name: ScreenNames.topup,
            path: 'topup',
            builder: (context, state) {
              final args = state.extra as TopUpScreenExtraArgs;
              return TopUpScreen(beneficiary: args.beneficiary);
            },
            routes: [
              GoRoute(
                name: ScreenNames.topupResume,
                path: 'resume',
                builder: (context, state) {
                  final args = state.extra as TopUpScreenExtraArgs;
                  return TopUpResumeScreen(
                    beneficiary: args.beneficiary,
                    topUpValue: args.topUpValue ?? 0,
                  );
                },
              ),
            ]),
      ],
    ),
  ],
);

class TopUpScreenExtraArgs {
  final Beneficiary beneficiary;
  final int? topUpValue;

  TopUpScreenExtraArgs({
    required this.beneficiary,
    this.topUpValue,
  });
}
