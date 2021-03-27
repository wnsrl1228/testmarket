import 'package:intl/intl.dart';

class DataUtils {
  static final oCcy = new NumberFormat("#,###", "ko_KR");
  static String calcStringToMon(String priceString) {
    if (priceString == "무료나눔") return priceString;
    return "${oCcy.format(int.parse(priceString))}원";
  }
}
