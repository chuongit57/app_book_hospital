import 'package:app_medicine/model/nhomMau.dart';
import 'package:app_medicine/model/patients.dart';
import 'package:flutter/material.dart';
import '../styles/colors.dart';
import '../styles/styles.dart';

class SliverPatientDetail extends StatelessWidget {
  const SliverPatientDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final patient = Patients(
        patientId: 1,
        name: 'Võ quốc bảo',
        address: 'HCM',
        phoneNumber: '1111',
        gender: 'nam',
        height: '1m65',
        weight: '60kg',
        nhomMau: nhom_mau(id: '1', nhomMau: '0'),
        tienSuBenh: 'Tiểu đường',
        note: 'đau đầu');
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text('Thông tin bệnh nhân'),
            backgroundColor: Color(MyColors.primary),
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'lib/assets/hospital.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DetailBody(patient: patient),
          ),
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  final Patients patient;
  const DetailBody({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DetailDoctorCard(),
          SizedBox(height: 15),
          SizedBox(height: 20),
          Text(
            'Chi tiết bệnh nhân',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          SectionTitle(title: 'Lý do đi khám'),
          SizedBox(height: 5),
          SectionContent(title: patient.note),
          SizedBox(height: 15),
          SectionTitle(title: 'Chiều Cao'),
          SizedBox(height: 5),
          SectionContent(title: patient.height),
          SizedBox(height: 15),
          SectionTitle(title: 'Cân nặng'),
          SizedBox(height: 5),
          SectionContent(title: patient.weight),
          SizedBox(height: 15),
          SectionTitle(title: 'Nhóm máu'),
          SizedBox(height: 5),
          SectionContent(title: patient.nhomMau.nhomMau),
          SizedBox(height: 15),
          SectionTitle(title: 'Tiền sử bệnh'),
          SizedBox(height: 5),
          SectionContent(title: patient.tienSuBenh),
          SizedBox(height: 15),
          SectionTitle(title: 'Giờ khám bệnh'),
          SizedBox(height: 5),
          SectionContent(title: '8:00 AM - 9:00 AM \nNgày 31/05/2024'),
          SizedBox(height: 15),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Color(MyColors.primary),
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(vertical: 15),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: Text('Chuẩn đoán bệnh', style: TextStyle(fontSize: 16, color: Colors.white)),
            onPressed: () => {
              _showDiagnosisAndPrescriptionDialog(context, patient),
            },
          ),
          SizedBox(height: 15),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Color(MyColors.primary),
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(vertical: 15),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: Text('Lịch hẹn', style: TextStyle(fontSize: 16, color: Colors.white)),
            onPressed: () => {
              _completeAppointment(context),
            },
          ),
        ],
      ),
    );
  }

  void _showDiagnosisAndPrescriptionDialog(BuildContext context, Patients patient) {
    final TextEditingController _diagnosisController = TextEditingController();
    final TextEditingController _prescriptionController = TextEditingController();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dialogWidth = screenWidth * 0.8;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(patient.name, style: TextStyle(fontWeight: FontWeight.bold),),
          content: SizedBox(
            height: 400,
            width: dialogWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'Chuẩn đoán',
                  style: TextStyle(
                    color: Color(MyColors.purple01),
                    fontWeight: FontWeight.w900,
                    height: 1.5,
                  ),
                ),
                TextField(
                  controller: _diagnosisController,
                  maxLines: 3,
                  style: TextStyle(fontSize: 13), // Allows for multiple lines
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    hintText: 'Vui lòng nhập chuẩn đoán bệnh',
                    hintStyle: TextStyle(
                      color: Colors.grey, // Change hint text color
                      fontStyle: FontStyle.italic, // Change hint text style
                      fontWeight: FontWeight.w500, // Change hint text weight
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Kê đơn thuốc',
                  style: TextStyle(
                    color: Color(MyColors.purple01),
                    fontWeight: FontWeight.w900,
                    height: 1.5,
                  ),
                ),
                TextField(
                  controller: _prescriptionController,
                  maxLines: 3,
                  style: TextStyle(fontSize: 13), // Allows for multiple lines
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    hintText: 'Vui lòng nhập đơn thuốc',
                    hintStyle: TextStyle(
                      color: Colors.grey, // Change hint text color
                      fontStyle: FontStyle.italic, // Change hint text style
                      fontWeight: FontWeight.w500, // Change hint text weight
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Không'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Chuẩn đoán'),
              onPressed: () {
                // Chạy api cập nhật lịch hẹn với bệnh nhân thêm field chuẩn đoán và kê đơn thuốc
              },
            ),
          ],
        );
      },
    );
  }

  void _completeAppointment(BuildContext context) {
    // Chạy api để chuyển ca khám sang trạng thái lịch hẹn
    // Chuyển sang tab "Hoàn thành"
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: kTitleStyle,
    );
  }
}

class SectionContent extends StatelessWidget {
  final String title;
  const SectionContent({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Color(MyColors.purple01),
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
    );
  }
}

class NumberCard extends StatelessWidget {
  final String label;
  final String value;

  const NumberCard({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(MyColors.bg03),
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Color(MyColors.grey02),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                color: Color(MyColors.header01),
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailDoctorCard extends StatelessWidget {
  const DetailDoctorCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Võ Quốc Bảo',
                    style: TextStyle(
                      color: Color(MyColors.header01),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Bệnh nhân',
                    style: TextStyle(
                      color: Color(MyColors.grey02),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'lib/assets/doctor2.png',
                width: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
