import 'package:intl/intl.dart';

class Formatter {
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  static String formatDecimal(double number) {
    final formatter = NumberFormat.decimalPattern('en_US');
    return formatter.format(number);
  }
}
