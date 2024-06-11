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

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  Future<void> _submit() async {
    setState(() {
      _isLoading = true; // Hiển thị popup loading
    });
    Appointment appointment = widget.appointment;
    DoctorAppointment doctorAppointment = widget.doctorAppointment;
    // Giả lập việc gọi API bằng cách đợi 2 giây
    try {
      await _userBookService.book(appointment.id, {
        'phone': _phoneController.text,
        'age': int.parse(_ageController.text),
        'weight': int.parse(_weightController.text)
        }
      );
      widget.onSuccess(appointment.id);
      if (!mounted) return;
      Navigator.of(context).pop();

      String titleSuccess = 'Ba Đăng ký thành công';
      String msg = 'Bạn đã đặt lịch khám thành công với bác sĩ :' + doctorAppointment.name;
      String msg2 = ' vào lúc :' + DateUtil.formatDateVN(appointment.date) + ' ' + DateUtil.formatTimeRange(appointment.startTime, appointment.endTime);
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
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Loading();
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Điều chỉnh bo góc
      ),
      backgroundColor: Colors.transparent, // Đặt màu nền trong suốt
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Popup ban đầu
          // Hiển thị popup ban đầu nếu không có loading
          Container(
              decoration: BoxDecoration(
                color: Color(MyColors.primary),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: const Text(
                      'Đăng ký khám bệnh',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          // Phần body với màu trắng
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Tên'),
                  keyboardType: TextInputType.name,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Số điện thoại'),
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  controller: _weightController,
                  decoration: InputDecoration(labelText: 'Tuổi'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          // Phần footer với nút Hủy và Đăng ký
          Container(
            padding: EdgeInsets.all(10),
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
                    side: BorderSide(color: Colors.black), // Đặt màu viền
                  ),
                  child: Text(
                    'Hủy',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 10),
                OutlinedButton(
                  onPressed: _isLoading ? null : () {
                    _submit();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blueAccent), // Đặt màu viền
                  ),
                  child: Text(
                    'Đăng ký',
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
