import 'package:flutter/material.dart';

class BeneficiaryCard extends StatelessWidget {
  const BeneficiaryCard({
    super.key,
    required this.name,
    required this.phoneNumber,
    this.onTap,
  });

  final String name;
  final String phoneNumber;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).splashColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 5.0),
          Text(
            '+${phoneNumber.replaceAll(' ', '')}',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30.0),
          SizedBox(
            height: 35.0,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  'Recharge now',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
