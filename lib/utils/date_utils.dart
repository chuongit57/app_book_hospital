import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtil {
  static String formatDateVN(DateTime date) {
    try {
      final DateFormat formatter = DateFormat('EEEE, dd/MM');
      String formattedDate = formatter.format(date);

      // Convert the day name to Vietnamese
      switch (formattedDate.split(',')[0]) {
        case 'Monday':
          formattedDate = formattedDate.replaceFirst('Monday', 'Thứ 2');
          break;
        case 'Tuesday':
          formattedDate = formattedDate.replaceFirst('Tuesday', 'Thứ 3');
          break;
        case 'Wednesday':
          formattedDate = formattedDate.replaceFirst('Wednesday', 'Thứ 4');
          break;
        case 'Thursday':
          formattedDate = formattedDate.replaceFirst('Thursday', 'Thứ 5');
          break;
        case 'Friday':
          formattedDate = formattedDate.replaceFirst('Friday', 'Thứ 6');
          break;
        case 'Saturday':
          formattedDate = formattedDate.replaceFirst('Saturday', 'Thứ 7');
          break;
        case 'Sunday':
          formattedDate = formattedDate.replaceFirst('Sunday', 'Chủ Nhật');
          break;
      }
      return formattedDate;
    } catch (e) {
      print(e);
      return '';
    }
  }

  static String formatTimeRange(TimeOfDay start, TimeOfDay end) {
    final now = DateTime.now();
    final startDateTime = DateTime(now.year, now.month, now.day, start.hour, start.minute);
    final endDateTime = DateTime(now.year, now.month, now.day, end.hour, end.minute);

    final startFormatted = DateFormat('HH:mm').format(startDateTime);
    final endFormatted = DateFormat('HH:mm').format(endDateTime);

    return '$startFormatted ~ $endFormatted';
  }
}