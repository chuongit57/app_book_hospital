import 'package:app_medicine/widgets/edit_item.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class EditSettingTab extends StatefulWidget {
  const EditSettingTab({super.key});

  @override
  State<EditSettingTab> createState() => _EditSettingTabState();
}

class _EditSettingTabState extends State<EditSettingTab> {
  String? gender = "nam";
  String? bloodType;
  String? mediaHistory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        title: const Text(
          'Chỉnh sửa hồ sơ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                print("Button lưu thông tin bệnh nhân vào database");
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: const Size(60, 50),
                elevation: 3,
              ),
              icon: const Icon(Ionicons.checkmark, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: const Text(
                  "Hồ sơ bệnh",
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const EditItem(
                title: "Tên",
                widget: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập tên của bạn',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              EditItem(
                title: "Giới tính",
                widget: DropdownButtonFormField<String>(
                  value: gender,
                  hint: const Text('Chọn giới tính'),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'nam',
                      child: Text('Nam'),
                    ),
                    DropdownMenuItem(
                      value: 'nữ',
                      child: Text('Nữ'),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      gender = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              const EditItem(
                title: "Năm sinh",
                widget: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập năm sinh của bạn',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const EditItem(
                title: "Số điện thoại",
                widget: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập số điện thoại của bạn',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const EditItem(
                title: "Địa chỉ",
                widget: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập địa chỉ của bạn',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const EditItem(
                title: "Chiều cao",
                widget: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập chiều cao của bạn',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const EditItem(
                title: "Cân nặng",
                widget: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập cân nặng của bạn',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              EditItem(
                title: "Nhóm máu",
                widget: DropdownButtonFormField<String>(
                  value: bloodType,
                  hint: const Text('Chọn nhóm máu'),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'A',
                      child: Text('A'),
                    ),
                    DropdownMenuItem(
                      value: 'B',
                      child: Text('B'),
                    ),
                    DropdownMenuItem(
                      value: 'AB',
                      child: Text('AB'),
                    ),
                    DropdownMenuItem(
                      value: 'O',
                      child: Text('O'),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      bloodType = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              const EditItem(
                title: "Tiền sử bệnh",
                widget: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập tiền sử bệnh của bạn',
                  ),
                ),
              ),
              // const SizedBox(height: 20),
              // EditItem(
              //   title: "Tiền sử bệnh",
              //   widget: DropdownButtonFormField<String>(
              //     value: mediaHistory,
              //     hint: const Text('Tiền sử bệnh'),
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //     ),
              //     items: const [
              //       DropdownMenuItem(
              //         value: 'khong',
              //         child: Text('Không'),
              //       ),
              //       DropdownMenuItem(
              //         value: 'diung',
              //         child: Text('Dị ứng'),
              //       ),
              //       DropdownMenuItem(
              //         value: 'caohuyetap',
              //         child: Text('Cao huyết áp'),
              //       ),
              //       DropdownMenuItem(
              //         value: 'timmach',
              //         child: Text('Tim mạch'),
              //       ),
              //       DropdownMenuItem(
              //         value: 'gan',
              //         child: Text('Gan'),
              //       ),
              //     ],
              //     onChanged: (String? newValue) {
              //       setState(() {
              //         mediaHistory = newValue;
              //       });
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
