import 'package:intl/intl.dart';

mixin DateFormatterMixin {
  String formatDateToString(final DateTime date) =>
      DateFormat('yyyy-MM-dd').format(date);
}
