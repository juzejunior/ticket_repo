import 'package:money_formatter/money_formatter.dart' as v;

extension MoneyFormatter on double {
  String formatAsMoney() {
    final formatter = v.MoneyFormatter(
      amount: this,
      settings: v.MoneyFormatterSettings(
        symbol: 'AED',
        fractionDigits: 2,
      ),
    );
    return formatter.output.symbolOnLeft;
  }
}
