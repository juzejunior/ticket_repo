import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:top_up_ticket/core/extensions/double_money_formatter.dart';
import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';

class TopUpResumeScreen extends StatelessWidget {
  const TopUpResumeScreen({
    super.key,
    required this.beneficiary,
    required this.topUpValue,
  });

  final Beneficiary beneficiary;
  final int topUpValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top up resume'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'You are top-upping',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '${topUpValue.toDouble().formatAsMoney()} to ${beneficiary.nickName}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 40),
                _InfoItem(
                  label: 'Phone Number',
                  value: beneficiary.phoneNumber,
                ),
                const SizedBox(height: 16),
                // padding only date format for now without hours
                _InfoItem(
                  label: 'Top-up date',
                  value: formatDate(DateTime.now(), [mm, '/', dd, '/', yyyy]),
                ),
                Text(
                  'A charge of AED 1 will be applied to your top-up',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: false
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator.adaptive())
                    : const Text('Confirm Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Divider(),
      ],
    );
  }
}
