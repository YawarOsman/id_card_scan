
import 'package:intl/intl.dart' as intl;


extension CustomFormat on String? {
  // this method will format date time to this format 2021-09-09 12:12 am/pm
  String get customFormat {
    if (this == null) return '';
    final locale = intl.Intl.getCurrentLocale();

    final date = DateTime.parse(this!).toLocal();
    final formattedDate =
        intl.DateFormat('yyyy-MM-dd hh:mm:ss aa', locale).format(date);

    return formattedDate;
  }

  String get customDateFormat {
    if (this == null || this == '') return '';
    final locale = intl.Intl.getCurrentLocale();

    final date = DateTime.parse(this!).toLocal();
    final formattedDate = intl.DateFormat('yyyy-MM-dd', locale).format(date);
    return formattedDate;
  }

}