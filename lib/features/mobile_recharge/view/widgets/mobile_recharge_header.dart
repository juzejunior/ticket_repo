import 'package:flutter/material.dart';

class MobileRechargeHeader extends StatelessWidget {
  const MobileRechargeHeader({
    super.key,
    required this.userName,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome, $userName 👋🏽'),
      ],
    );
  }
}
