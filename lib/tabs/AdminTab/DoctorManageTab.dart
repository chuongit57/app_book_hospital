import 'package:flutter/material.dart';

class DTODoctor {
  final int doctorId;
  final String name;
  final int year_Of_Birth;
  final String degree;
  final String email;
  final String phoneNumber;
  final String adress;
  final String department;
  final String gender;
  final String examination_hours;
  final double number_of_start;

  DTODoctor({
    required this.doctorId,
    required this.name,
    required this.year_Of_Birth,
    required this.degree,
    required this.email,
    required this.phoneNumber,
    required this.adress,
    required this.department,
    required this.gender,
    required this.examination_hours,
    required this.number_of_start,
  });
}

class AdminDoctorScreen extends StatefulWidget {
  @override
  _AdminDoctorScreenState createState() => _AdminDoctorScreenState();
}

class _AdminDoctorScreenState extends State<AdminDoctorScreen> {
  List<DTODoctor> doctors = [];
  List<DTODoctor> filteredDoctors = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _examinationHoursController = TextEditingController();
  final TextEditingController _numberOfStart = TextEditingController();
  final TextEditingController _yearOfBirthController = TextEditingController();

  String? _selectedDegree;
  String? _selectedDepartment;
  String? _selectedGender;
  int? _editingDoctorId;

  List<Appointment> appointments = []; // Giả sử đây là danh sách các ca bệnh

  @override
  void initState() {
    super.initState();
    filteredDoctors = doctors;
    _searchController.addListener(_filterDoctors);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _adressController.dispose();
    _examinationHoursController.dispose();
    _numberOfStart.dispose();
    _yearOfBirthController.dispose();
    super.dispose();
  }

  void _filterDoctors() {
    setState(() {
      if (_searchController.text.isEmpty) {
        filteredDoctors = doctors;
      } else {
        filteredDoctors = doctors.where((doctor) => doctor.name.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
      }
    });
  }

  int _countAppointments(int doctorId, DateTimeRange range) {
    return appointments
        .where((appointment) =>
    appointment.doctorId == doctorId &&
        appointment.date.isAfter(range.start) &&
        appointment.date.isBefore(range.end))
        .length;
  }

  void _showReport(int doctorId) {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime startOfWeek = startOfDay.subtract(Duration(days: now.weekday - 1));
    DateTime startOfMonth = DateTime(now.year, now.month, 1);

    int dayCount = _countAppointments(doctorId, DateTimeRange(start: startOfDay, end: now));
    int weekCount = _countAppointments(doctorId, DateTimeRange(start: startOfWeek, end: now));
    int monthCount = _countAppointments(doctorId, DateTimeRange(start: startOfMonth, end: now));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Báo cáo số ca bệnh'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Số ca bệnh trong ngày: $dayCount'),
              Text('Số ca bệnh trong tuần: $weekCount'),
              Text('Số ca bệnh trong tháng: $monthCount'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý bác sĩ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Tìm kiếm bác sĩ theo tên',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = filteredDoctors[index];
                  return Card(
                    child: ListTile(
                      title: Text(doctor.name),
                      subtitle: Text('${doctor.degree} - ${doctor.department}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editDoctor(doctor);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _confirmDeleteDoctor(doctor.doctorId);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.bar_chart),
                            onPressed: () {
                              _showReport(doctor.doctorId);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _showDoctorForm,
              child: Text('Thêm bác sĩ'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDoctorForm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_editingDoctorId == null ? 'Thêm bác sĩ' : 'Chỉnh sửa bác sĩ'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTextFormField(_nameController, 'Tên bác sĩ'),
                  _buildTextFormField(_yearOfBirthController, 'Năm sinh'),
                  _buildDropdownFormField(
                    value: _selectedDegree,
                    items: ['Bác sĩ', 'Thạc sĩ/Bác sĩ', 'Bác sĩ chuyên khoa 1', 'Bác sĩ chuyên khoa 2'],
                    label: 'Bằng cấp/Chứng chỉ',
                    onChanged: (value) {
                      setState(() {
                        _selectedDegree = value;
                      });
                    },
                  ),
                  _buildTextFormField(_emailController, 'Email'),
                  _buildTextFormField(_phoneNumberController, 'Số điện thoại'),
                  _buildTextFormField(_adressController, 'Địa chỉ'),
                  _buildDropdownFormField(
                    value: _selectedDepartment,
                    items: ['Khoa nhi', 'Khoa thần kinh', 'Khoa gây mê hồi sức', 'Khoa răng hàm mặt', 'Khoa dinh dưỡng', 'Khoa da liễu', 'Khoa cấp cứu'],
                    label: 'Khoa',
                    onChanged: (value) {
                      setState(() {
                        _selectedDepartment = value;
                      });
                    },
                  ),
                  _buildDropdownFormField(
                    value: _selectedGender,
                    items: ['Nam', 'Nữ', 'Khác'],
                    label: 'Giới tính',
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  _buildTextFormField(_numberOfStart, 'Đánh giá'),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _clearForm();
              },
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: _saveDoctor,
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          labelStyle: TextStyle(color: Colors.grey),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Vui lòng nhập $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownFormField({
    required String? value,
    required List<String> items,
    required String label,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          labelStyle: TextStyle(color: Colors.grey),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Vui lòng chọn $label';
          }
          return null;
        },
      ),
    );
  }

  void _saveDoctor() {
    if (_formKey.currentState!.validate()) {
      if (_editingDoctorId == null) {
        // Thêm bác sĩ mới
        final newDoctor = DTODoctor(
          doctorId: DateTime.now().millisecondsSinceEpoch, // Tạo ID bằng timestamp
          name: _nameController.text,
          year_Of_Birth: int.parse(_yearOfBirthController.text),
          degree: _selectedDegree!,
          email: _emailController.text,
          phoneNumber: _phoneNumberController.text,
          adress: _adressController.text,
          department: _selectedDepartment!,
          gender: _selectedGender!,
          examination_hours: _examinationHoursController.text,
          number_of_start: double.parse(_numberOfStart.text),
        );
        setState(() {
          doctors.add(newDoctor);
          _filterDoctors(); // Cập nhật danh sách tìm kiếm
        });
      } else {
        // Cập nhật thông tin bác sĩ
        final doctorIndex = doctors.indexWhere((doctor) => doctor.doctorId == _editingDoctorId);
        if (doctorIndex != -1) {
          setState(() {
            doctors[doctorIndex] = DTODoctor(
              doctorId: _editingDoctorId!,
              name: _nameController.text,
              year_Of_Birth: int.parse(_yearOfBirthController.text),
              degree: _selectedDegree!,
              email: _emailController.text,
              phoneNumber: _phoneNumberController.text,
              adress: _adressController.text,
              department: _selectedDepartment!,
              gender: _selectedGender!,
              examination_hours: _examinationHoursController.text,
              number_of_start: double.parse(_numberOfStart.text),
            );
            _filterDoctors(); // Cập nhật danh sách tìm kiếm
          });
        }
      }

      Navigator.of(context).pop();
      _clearForm();
    }
  }

  void _editDoctor(DTODoctor doctor) {
    setState(() {
      _editingDoctorId = doctor.doctorId;
      _nameController.text = doctor.name;
      _yearOfBirthController.text = doctor.year_Of_Birth.toString(); // Chuyển đổi sang String
      _selectedDegree = doctor.degree;
      _emailController.text = doctor.email;
      _phoneNumberController.text = doctor.phoneNumber;
      _adressController.text = doctor.adress;
      _selectedDepartment = doctor.department;
      _selectedGender = doctor.gender;
      _examinationHoursController.text = doctor.examination_hours;
      _numberOfStart.text = doctor.number_of_start.toString(); // Chuyển đổi sang String
    });
    _showDoctorForm();
  }

  void _confirmDeleteDoctor(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Xác nhận xóa'),
          content: Text('Bạn có chắc chắn muốn xóa bác sĩ này không?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteDoctor(id);
                Navigator.of(context).pop();
              },
              child: Text('Xóa'),
            ),
          ],
        );
      },
    );
  }

  void _deleteDoctor(int id) {
    setState(() {
      doctors.removeWhere((doctor) => doctor.doctorId == id);
      _filterDoctors(); // Cập nhật danh sách tìm kiếm
    });
  }

  void _clearForm() {
    _editingDoctorId = null;
    _nameController.clear();
    _yearOfBirthController.clear();
    _selectedDegree = null;
    _emailController.clear();
    _phoneNumberController.clear();
    _adressController.clear();
    _selectedDepartment = null;
    _selectedGender = null;
    _examinationHoursController.clear();
    _numberOfStart.clear();
  }
}

class Appointment {
  final int doctorId;
  final DateTime date;

  Appointment({
    required this.doctorId,
    required this.date,
  });
}
