
import 'package:flutter/material.dart';

import '../utils/date_utils.dart';

class AppointmentTimeCard extends StatelessWidget {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final DateTime date;

  const AppointmentTimeCard({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    String dateFormat = DateUtil.formatDateVN(date);
    String timeFormat = DateUtil.formatTimeRange(startTime, endTime);

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF4A4A58), // Assuming MyColors.bg01 is a hex value
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 10,
          ),
          const SizedBox(width: 5),
          Text(
            dateFormat,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 10),
          const Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 17,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              timeFormat,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}