import 'package:app_medicine/model/appointment.dart';
import 'package:app_medicine/model/doctor_appointment.dart';
import 'package:app_medicine/service/user_book_service.dart';
import 'package:app_medicine/styles/colors.dart';
import 'package:app_medicine/utils/date_utils.dart';
import 'package:app_medicine/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:app_medicine/utils/toast_utils.dart';

class UserBookSubmitDialog extends StatefulWidget {
  final Appointment appointment;
  final DoctorAppointment doctorAppointment;
  final Function(int) onSuccess;

  const UserBookSubmitDialog({super.key, required this.appointment, required this.onSuccess, required this.doctorAppointment});

  @override
  State<UserBookSubmitDialog> createState() => _UserBookSubmitDialogState();
}

class _UserBookSubmitDialogState extends State<UserBookSubmitDialog> {
  bool _isLoading = false;

  final UserBookService _userBookService = UserBookService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void setInitialValues() {
    _nameController.text = "John Doe";
    _phoneController.text = "123456789";
    _ageController.text = "30";
    _heightController.text = "175";
    _weightController.text = "70";
    _descriptionController.text = "This is a description.";
  }

  String _selectedGender = 'Nam';  // Default value

  Future<void> _submit() async {
    setState(() {
      _isLoading = true; // Hiển thị popup loading
    });
    Appointment appointment = widget.appointment;
    DoctorAppointment doctorAppointment = widget.doctorAppointment;
    // Giả lập việc gọi API bằng cách đợi 2 giây
    try {
      await _userBookService.book(appointment.id, {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'age': int.parse(_ageController.text),
        'height': int.parse(_heightController.text),
        'weight': int.parse(_weightController.text),
        'description': _descriptionController.text,
        'gender': _selectedGender
        }
      );
      widget.onSuccess(appointment.id);
      if (!mounted) return;
      Navigator.of(context).pop();

      String titleSuccess = 'Ba Đăng ký thành công';
      String msg = 'Bạn đã đặt lịch khám thành công với bác sĩ :${doctorAppointment.name}';
      String msg2 = ' vào lúc :${DateUtil.formatDateVN(appointment.date)} ${DateUtil.formatTimeRange(appointment.startTime, appointment.endTime)}';
      ToastUtil.toastSuccess(context: context, title: titleSuccess, message: msg+msg2);
    } catch (e) {
      // Hiển thị thông báo lỗi nếu có lỗi xảy ra
      ToastUtil.toastError(context: context, title: 'Đăng ký Thất bại!',message: e.toString().replaceAll('Exception: Error:', ''));
    } finally {
      setState(() {
        _isLoading = false; // Ẩn popup loading
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setInitialValues();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Appointment appointment = widget.appointment;
    DoctorAppointment doctorAppointment = widget.doctorAppointment;

    String dateFormat = DateUtil.formatDateVN(appointment.date);
    String timeFormat = DateUtil.formatTimeRange(appointment.startTime, appointment.endTime);

    if (_isLoading) {
      return const Loading();
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Rounded corners
      ),
      contentPadding: const EdgeInsets.all(0),
      // backgroundColor: Colors.transparent, // Transparent background
      content: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Set width to 80% of the screen width
        decoration: BoxDecoration(
          color: Colors.white, // Set background color to white
          borderRadius: BorderRadius.circular(15.0), // Rounded corners
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Initial popup
            // Display initial popup if not loading
            Container(
              decoration: BoxDecoration(
                color: Color(MyColors.primary),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Đăng ký khám bệnh',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
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
                  const SizedBox(height: 10),
                ],
              ),
            ),
            // Body part with white color
            Container(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.black12,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('lib/assets/doctor2.png'),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctorAppointment.name,
                              style: TextStyle(
                                color: Color(MyColors.header01),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              doctorAppointment.degree,
                              style: TextStyle(
                                color: Color(MyColors.grey02),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 245, // Adjust this value based on your needs
                child: ListView(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Họ và tên:'),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        decoration: const InputDecoration(labelText: 'Số điện thoại:'),
                      ),
                      DropdownButtonFormField<String>(
                        value: _selectedGender,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedGender = newValue!;
                          });
                        },
                        items: <String>['Nam', 'Nữ', 'Khác']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Giới tính',
                        ),
                      ),
                      TextField(
                        controller: _ageController,
                        decoration: InputDecoration(
                          labelText: 'Tuổi',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: _heightController,
                        decoration: InputDecoration(
                          labelText: 'Chiều cao',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: _weightController,
                        decoration: InputDecoration(
                          labelText: 'Cân nặng',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Mô tả',
                        ),
                        maxLines: 3,
                      ),
                    ]
                ),
              ),
            ),
            // Footer part with Cancel and Register buttons
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black), // Border color
                    ),
                    child: const Text(
                      'Hủy',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: _isLoading ? null : () {
                      _submit();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blueAccent), // Border color
                    ),
                    child: const Text(
                      'Đăng ký',
                      style: TextStyle(color: Colors.indigo),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
