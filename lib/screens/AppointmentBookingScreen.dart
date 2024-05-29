import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this dependency in pubspec.yaml

class AppointmentBookingScreen extends StatefulWidget {
  @override
  _AppointmentBookingScreenState createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đặt lịch hẹn'),
        backgroundColor: Colors.pink, // Set the background color of the AppBar
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Tên của bạn',
                  border: OutlineInputBorder(), // Add border to text fields
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên của bạn';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Add space between form fields
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Số điện thoại',
                  border: OutlineInputBorder(), // Add border to text fields
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Add space between form fields
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Lí do đi khám',
                  border: OutlineInputBorder(), // Add border to text fields
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tình trạng sức khỏe của bạn';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Add space between form fields
              ListTile(
                title: Text(
                  _selectedDate == null ? 'Chọn ngày' : 'Ngày: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              ListTile(
                title: Text(
                  _selectedTime == null ? 'Chọn giờ' : 'Giờ: ${_selectedTime!.format(context)}',
                ),
                trailing: Icon(Icons.access_time),
                onTap: _pickTime,
              ),
              SizedBox(height: 20), // Add space before the button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle booking logic here
                    Navigator.pop(context);
                  }
                },
                child: Text('Xác nhận'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.pink), // Set button color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }
}
