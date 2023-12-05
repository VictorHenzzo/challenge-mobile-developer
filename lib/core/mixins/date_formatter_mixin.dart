import 'package:intl/intl.dart';

mixin DateFormatterMixin {
  String dateToYYYYMMDD(final DateTime date) =>
      DateFormat('yyyy-MM-dd').format(date);

  String dateToDDMMYYYY(final DateTime date) =>
      DateFormat('dd-MM-yyyy').format(date);
}
