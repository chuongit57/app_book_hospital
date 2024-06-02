import 'package:app_medicine/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportDoctor extends StatefulWidget {
  ReportDoctor({
    Key? key,
  }) : super(key: key);

  @override
  State<ReportDoctor> createState() => _ReportDoctorState();
}

class _ReportDoctorState extends State<ReportDoctor> {
  DateTime? startDateTime;
  DateTime? endDateTime;
  final DateFormat formatDate = DateFormat('dd/MM/yyyy');
  int cases = 0;
  String displayText = '';

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        startDateTime = picked.start;
        endDateTime = picked.end;
        _updateStatistics();
      });
    }
  }

  void _updateStatistics() {
    final difference = endDateTime!.difference(startDateTime!).inDays;
    if (difference < 1) {
      cases = _getDayCases();
      displayText = 'Số ca bệnh trong 1 ngày: $cases';
    } else if (difference >= 1 && difference < 7) {
      cases = _getWeekCases();
      displayText = 'Số ca bệnh trong 1 tuần: $cases';
    } else {
      cases = _getLifetimeCases();
      displayText = 'Số ca bệnh trọn đời: $cases';
    }
  }

  int _getDayCases() {
    // Logic để tính số ca bệnh trong 1 ngày
    return 5; // Giá trị giả định
  }

  int _getWeekCases() {
    // Logic để tính số ca bệnh trong 1 tuần
    return 20; // Giá trị giả định
  }

  int _getLifetimeCases() {
    // Logic để tính số ca bệnh trong trọn đời
    return 1000; // Giá trị giả định
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _selectDateRange(context),
              child: Text('Vui lòng chọn thời gian mong muốn'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                'Selected range: ${startDateTime != null ? formatDate.format(startDateTime!.toLocal()) : ''} - ${endDateTime != null ? formatDate.format(endDateTime!.toLocal()) : ''}',
                style: TextStyle(
                  color: Color(MyColors.header01),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                displayText,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(MyColors.header01),
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
