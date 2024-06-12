import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  final List<DateTime> dates;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateChanged;

  const DatePicker({
    Key? key,
    required this.dates,
    required this.selectedDate,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<DateTime>(
      value: selectedDate,
      hint: const Text('Chọn ngày'),
      isExpanded: true,
      items: dates.map((DateTime date) {
        return DropdownMenuItem<DateTime>(
          value: date,
          child: Text(DateFormat('dd/MM/yyyy').format(date)),
        );
      }).toList(),
      onChanged: onDateChanged,
    );
  }
}