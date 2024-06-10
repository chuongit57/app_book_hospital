import 'package:app_medicine/model/bloodgroup.dart';
import 'package:app_medicine/model/patient.dart';
import 'package:flutter/material.dart';

import '../../service/bloodgroup_service.dart';

class AdminPatientScreen extends StatefulWidget {
  @override
  _AdminPatientScreenState createState() => _AdminPatientScreenState();
}

class _AdminPatientScreenState extends State<AdminPatientScreen> {
  List<Patient> patients = [];
  List<Patient> filteredPatients = [];
  List<Bloodgroup> bloodgroup = [];
  final bloodGroupService = BloodGroupService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _yearOfBirthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _healthcardnumberController = TextEditingController();
  final TextEditingController _anamnesisController = TextEditingController();




  Future<void> getBloodGroup() async {
    bloodgroup = await bloodGroupService.getBloodGroup();
    // return listDoctor;
  }

  String? _selectedGender;
  Bloodgroup? _selectedBloodGroup;
  int? _editingPatientId;

  @override
  void initState() {
    super.initState();
    getBloodGroup();
    filteredPatients = patients;
    _searchController.addListener(_filterPatients);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _yearOfBirthController.dispose();
    super.dispose();
  }

  void _filterPatients() {
    setState(() {
      if (_searchController.text.isEmpty) {
        filteredPatients = patients;
      } else {
        filteredPatients = patients.where((patient) => patient.name.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý bệnh nhân'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Tìm kiếm bệnh nhân theo tên',
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
                itemCount: filteredPatients.length,
                itemBuilder: (context, index) {
                  final patient = filteredPatients[index];
                  return Card(
                    child: ListTile(
                      title: Text(patient.name),
                      subtitle: Text('Email: ${patient.email} - SĐT: ${patient.phone}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // _editPatient(patient);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _confirmDeletePatient(patient.code);
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
              onPressed: _showPatientForm,
              child: Text('Tìm kiếm bệnh nhân'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPatientForm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_editingPatientId == null ? 'Thêm bệnh nhân' : 'Chỉnh sửa bệnh nhân'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTextFormField(_nameController, 'Tên bệnh nhân'),
                  _buildTextFormField(_yearOfBirthController, 'Năm sinh'),
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
                  _buildTextFormField(_emailController, 'Email'),
                  _buildTextFormField(_phoneNumberController, 'Số điện thoại'),
                  _buildTextFormField(_addressController, 'Địa chỉ'),
                  _buildTextFormField(_heightController, 'Chiều cao'),
                  _buildTextFormField(_weightController, 'Cân nặng'),
                  _buildTextFormField(_healthcardnumberController, 'Mã số BHYT'),
                  _buildDropdownBloodGroupFormField(
                    value: _selectedBloodGroup,
                    items: bloodgroup,
                    label: 'Nhóm máu',
                    onChanged: (value) {
                      setState(() {
                        _selectedBloodGroup = value;
                      });
                    },
                  ),
                  _buildTextFormField(_anamnesisController, 'Tiền sử bệnh'),
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
              onPressed: _savePatient,
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

  Widget _buildDropdownBloodGroupFormField({
    required Bloodgroup? value,
    required List<Bloodgroup> items,
    required String label,
    required ValueChanged<Bloodgroup?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<Bloodgroup>(
        value: value,
        items: items.map((e) {
          return DropdownMenuItem<Bloodgroup>(
            value: e,
            child: Text(e.name),
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
          if (value == null) {
            return 'Vui lòng chọn $label';
          }
          return null;
        },
      ),
    );
  }

  void _savePatient() {
    if (_formKey.currentState!.validate()) {
      if (_editingPatientId == null) {
        // Thêm bệnh nhân mới
        final newPatient = Patient(
          code: DateTime.now().millisecondsSinceEpoch,
          name: _nameController.text,
          yearOfBirth: int.parse(_yearOfBirthController.text),
          email: _emailController.text,
          phone: _phoneNumberController.text,
          address: _addressController.text,
          gender: _selectedGender!,
          height: _heightController.text,
          weight: _weightController.text,
          healthcardnumber: _healthcardnumberController.text,
          anamnesis: _anamnesisController.text,
          bloodgroup: _selectedBloodGroup!,
          note: "",

        );
        setState(() {
          patients.add(newPatient);
          _filterPatients();
        });
      } else {
        // Cập nhật thông tin bệnh nhân
        final patientIndex = patients.indexWhere((patient) => patient.code == _editingPatientId);
        if (patientIndex != -1) {
          setState(() {
            patients[patientIndex] = Patient(
              code: _editingPatientId!,
              name: _nameController.text,
              yearOfBirth: int.parse(_yearOfBirthController.text),
              email: _emailController.text,
              phone: _phoneNumberController.text,
              address: _addressController.text,
              gender: _selectedGender!,
              height: _heightController.text,
              weight: _weightController.text,
              healthcardnumber: _healthcardnumberController.text,
              anamnesis: _anamnesisController.text,
              bloodgroup: _selectedBloodGroup!,
              note: "",
            );
            _filterPatients();
          });
        }
      }

      Navigator.of(context).pop();
      _clearForm();
    }
  }

  // void _editPatient(DTOPatient patient) {
  //   setState(() {
  //     _editingPatientId = patient.patientId;
  //     _nameController.text = patient.name;
  //     _yearOfBirthController.text = patient.yearOfBirth.toString();
  //     _emailController.text = patient.email;
  //     _phoneNumberController.text = patient.phoneNumber;
  //     _addressController.text = patient.address;
  //     _selectedGender = patient.gender;
  //
  //   });
  //   _showPatientForm();
  // }

  void _confirmDeletePatient(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Xác nhận xóa'),
          content: Text('Bạn có chắc chắn muốn xóa bệnh nhân này không?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                _deletePatient(id);
                Navigator.of(context).pop();
              },
              child: Text('Xóa'),
            ),
          ],
        );
      },
    );
  }

  void _deletePatient(int id) {
    setState(() {
      patients.removeWhere((patient) => patient.code == id);
      _filterPatients();
    });
  }

  void _clearForm() {
    _editingPatientId = null;
    _nameController.clear();
    _yearOfBirthController.clear();
    _emailController.clear();
    _phoneNumberController.clear();
    _addressController.clear();
    _selectedGender = null;
  }
}
