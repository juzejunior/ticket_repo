import 'package:flutter/material.dart';
import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({
    super.key,
    required this.beneficiary,
  });

  final Beneficiary beneficiary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top up'),
      ),
      body: const Center(
        child: Text('Top up screen'),
      ),
    );
  }
}
