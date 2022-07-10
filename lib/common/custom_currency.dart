import 'package:intl/intl.dart';

class CustomCurrency{
  static String convertIdr(String number){
    NumberFormat formatIdr = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0
    );
    return formatIdr.format(num.parse(number));
  }
}