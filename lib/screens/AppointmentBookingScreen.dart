import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this dependency in pubspec.yaml

class AppointmentBookingScreen extends StatefulWidget {
  @override
  _AppointmentBookingScreenState createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _selectedTime;

  final List<String> _time = [
    '08:00 - 09:00',
    '09:00 - 10:00',
    '10:00 - 11:00',
    '13:00 - 14:00',
    '14:00 - 15:00',
    '15:00 - 16:00',
    '16:00 - 17:00',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đặt lịch hẹn'),
        backgroundColor: Colors.pink, // Set the background color of the AppBar
      ),
      body: SingleChildScrollView(
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
              SizedBox(height: 15), // Add space between form fields
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
              SizedBox(height: 15), // Add space between form fields
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Chiều cao',
                  border: OutlineInputBorder(), // Add border to text fields
                ),
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Vui lòng nhập chiều cao của bạn';
                  // }
                  return null;
                },
              ),
              SizedBox(height: 15), // Add space between form fields
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Cân nặng',
                  border: OutlineInputBorder(), // Add border to text fields
                ),
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Vui lòng nhập cân nặng của bạn';
                  // }
                  return null;
                },
              ),
              SizedBox(height: 15), // Add space between form fields
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nhóm máu',
                  border: OutlineInputBorder(), // Add border to text fields
                ),
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Vui lòng nhập nhóm máu của bạn';
                  // }
                  return null;
                },
              ),
              SizedBox(height: 15), // Add space between form fields
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
              SizedBox(height: 15), // Add space between form fields
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        _selectedDate == null ? 'Chọn ngày' : '${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                      ),
                      trailing: Icon(Icons.calendar_today),
                      onTap: _pickDate,
                    ),
                  ),
                  SizedBox(width: 10), // Add space between ListTile and DropdownButton
                  Expanded(
                    child: DropdownButton<String>(
                      value: _selectedTime,
                      hint: Text('Chọn giờ khám'),
                      isExpanded: true,
                      items: _time.map((String date) {
                        return DropdownMenuItem<String>(
                          value: date,
                          child: Text(date),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTime = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(height: 15), // Add space before the button
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
    List<TimeOfDay> timeSlots = [];
    TimeOfDay initialTime = TimeOfDay(hour: 0, minute: 0);

    // Generate time slots with 1-hour intervals
    for (int i = 0; i < 24; i++) {
      timeSlots.add(initialTime);
      initialTime = initialTime.replacing(hour: initialTime.hour + 1);
    }

    // Show time slots in a dialog
    TimeOfDay? pickedTime = await showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Chọn các khung giờ'),
          children: timeSlots
              .map((time) => SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, time);
            },
            child: Text(time.format(context)),
          ))
              .toList(),
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = "";
      });
    }
  }
}
