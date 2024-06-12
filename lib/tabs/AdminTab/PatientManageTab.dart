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
    _initializeFakePatients(); // Initialize fake patients here
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

  void _initializeFakePatients() {
    patients = [
      Patient(
        code: 1,
        name: 'Nguyễn Tuấn An',
        yearOfBirth: 1980,
        email: 'nguyenvana@gmail.com',
        phone: '0123456789',
        address: '123 Đường A, Thành phố Hồ Chí Minh',
        gender: 'Nam',
        height: '170 cm',
        weight: '65 kg',
        healthcardnumber: 'Không có',
        anamnesis: 'Không',
        bloodgroup: Bloodgroup(id: 3, code: "M03", name: "Nhóm máu B"),
        note: '',
      ),
      Patient(
        code: 2,
        name: 'Trần Thị Bé Nhi',
        yearOfBirth: 1990,
        email: 'tranthib@gmail.com',
        phone: '0987654321',
        address: '456 Đường B, Thành phố Củ Chi',
        gender: 'Nữ',
        height: '160 cm',
        weight: '55 kg',
        healthcardnumber: '987654321',
        anamnesis: 'Tiểu đường',
        bloodgroup: Bloodgroup(id: 3, code: "M03", name: "Nhóm máu B"),
        note: '',
      ),
      // Add 8 more patients
      Patient(
        code: 3,
        name: 'Lê Anh Cường',
        yearOfBirth: 1975,
        email: 'levanc@gmail.com',
        phone: '0167890123',
        address: '789 Đường C, Thành phố Dĩ An',
        gender: 'Nam',
        height: '165 cm',
        weight: '70 kg',
        healthcardnumber: 'Không có',
        anamnesis: 'Cao huyết áp',
        bloodgroup: Bloodgroup(id: 3, code: "M03", name: "Nhóm máu B"),
        note: '',
      ),
      Patient(
        code: 4,
        name: 'Phạm Thị Dung',
        yearOfBirth: 1985,
        email: 'phamthid@gmail.com',
        phone: '0178901234',
        address: '101 Đường D, Thành phố Cần Thơ',
        gender: 'Nữ',
        height: '158 cm',
        weight: '52 kg',
        healthcardnumber: '5566778899',
        anamnesis: 'Viêm khớp',
        bloodgroup: Bloodgroup(id: 3, code: "M03", name: "Nhóm máu B"),
        note: '',
      ),
      Patient(
        code: 5,
        name: 'Hoàng Đinh Tuấn Phú',
        yearOfBirth: 2000,
        email: 'hoangvane@gmail.com',
        phone: '0189012345',
        address: '202 Đường E, Thành phố Cần Thơ',
        gender: 'Nam',
        height: '172 cm',
        weight: '68 kg',
        healthcardnumber: '9988776655',
        anamnesis: 'Hen suyễn',
        bloodgroup: Bloodgroup(id: 3, code: "M03", name: "Nhóm máu B"),
        note: '',
      ),
      Patient(
        code: 6,
        name: 'Vũ Thị Như Phương',
        yearOfBirth: 1995,
        email: 'vuthif@gmail.com',
        phone: '0190123456',
        address: '303 Đường F, Thành phố Gia Lai',
        gender: 'Nữ',
        height: '162 cm',
        weight: '54 kg',
        healthcardnumber: '4455667788',
        anamnesis: 'Không',
        bloodgroup: Bloodgroup(id: 3, code: "M03", name: "Nhóm máu B"),
        note: '',
      ),
      Patient(
        code: 7,
        name: 'Đặng Văn Giang',
        yearOfBirth: 1988,
        email: 'dangvang@gmail.com',
        phone: '0201234567',
        address: '404 Đường G, Thành phố Hồ Chí Minh',
        gender: 'Nam',
        height: '175 cm',
        weight: '75 kg',
        healthcardnumber: 'Không có',
        anamnesis: 'Đau dạ dày',
        bloodgroup: Bloodgroup(id: 1, code: "M01", name: "Chưa rõ"),
        note: '',
      ),
      Patient(
        code: 8,
        name: 'Phan Thị Hồng',
        yearOfBirth: 1992,
        email: 'phanthih@gmail.com',
        phone: '0212345678',
        address: '505 Đường H, Thành phố Lai Châu',
        gender: 'Nữ',
        height: '168 cm',
        weight: '60 kg',
        healthcardnumber: '6655443322',
        anamnesis: 'Tiền sử ung thư',
        bloodgroup: Bloodgroup(id: 2, code: "M02", name: "Nhóm máu A"),
        note: '',
      ),
      Patient(
        code: 9,
        name: 'Ngô Anh Tú',
        yearOfBirth: 1983,
        email: 'ngovani@gmail.com',
        phone: '0223456789',
        address: '606 Đường I, Thành phố Đà Nẵng',
        gender: 'Nam',
        height: '178 cm',
        weight: '80 kg',
        healthcardnumber: '7744112233',
        anamnesis: 'Không',
        bloodgroup: Bloodgroup(id: 1, code: "M01", name: "Chưa rõ"),
        note: '',
      ),
      Patient(
        code: 10,
        name: 'Đinh Hồng Anh',
        yearOfBirth: 1998,
        email: 'dinhthik@gmail.com',
        phone: '0234567890',
        address: '707 Đường K, Thành phố Khánh Hòa',
        gender: 'Nữ',
        height: '164 cm',
        weight: '58 kg',
        healthcardnumber: '2211334477',
        anamnesis: 'Tiền sử bệnh tim',
        bloodgroup: Bloodgroup(id: 1, code: "M01", name: "Chưa rõ"),
        note: '',
      ),
    ];
  }

  void _showPatientDetails(Patient patient) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Chi tiết bệnh nhân'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tên: ${patient.name}'),
                Text('Năm sinh: ${patient.yearOfBirth}'),
                Text('Giới tính: ${patient.gender}'),
                Text('Email: ${patient.email}'),
                Text('Số điện thoại: ${patient.phone}'),
                Text('Địa chỉ: ${patient.address}'),
                Text('Chiều cao: ${patient.height}'),
                Text('Cân nặng: ${patient.weight}'),
                Text('Số thẻ bảo hiểm: ${patient.healthcardnumber}'),
                Text('Tiền sử bệnh: ${patient.anamnesis}'),
                Text('Nhóm máu: ${patient.bloodgroup.name}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
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
        title: Text('Danh sách bệnh nhân'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Tìm kiếm bệnh nhân',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPatients.length,
              itemBuilder: (context, index) {
                final patient = filteredPatients[index];
                return ListTile(
                  title: Text(patient.name),
                  subtitle: Text('Năm sinh: ${patient.yearOfBirth}'),
                  onTap: () => _showPatientDetails(patient),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () {
                          // Implement lock account functionality here
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Implement delete functionality here
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
