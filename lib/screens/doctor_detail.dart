import 'package:app_medicine/model/DTODoctor.dart';
import 'package:app_medicine/screens/AppointmentBookingScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import '../styles/colors.dart';
import '../styles/styles.dart';

class SliverDoctorDetail extends StatelessWidget {
  const SliverDoctorDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DTODoctorDetail data = ModalRoute.of(context)?.settings.arguments as DTODoctorDetail;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text('Thông tin bác sĩ'),
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
            child: DetailBody(
              data: data, // Pass the data to DetailBody
            ),
          ),
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  final DTODoctorDetail data; // Add a data parameter to accept the doctor details

  const DetailBody({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DetailDoctorCard(data: data),
          SizedBox(height: 15),
          DoctorInfo(data: data),
          SizedBox(height: 30),
          SectionTitle(title: 'Thông tin liên hệ'),
          SizedBox(height: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Số điện thoại: ',
                    style: TextStyle(
                      color: Color(MyColors.purple01),
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    data.doctor?.phoneNumber ?? 'Không có thông tin',
                    style: TextStyle(
                      color: Color(MyColors.purple01),
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0), // khoảng cách giữa số điện thoại và email
              Row(
                children: [
                  Text(
                    'Email: ',
                    style: TextStyle(
                      color: Color(MyColors.purple01),
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    data.doctor?.email ?? 'Không có thông tin',
                    style: TextStyle(
                      color: Color(MyColors.purple01),
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 25),
          SectionTitle(title: 'Chuyên khoa'),
          SizedBox(height: 10),
          Text(
            data.doctor?.department ?? 'Không có thông tin',
            style: TextStyle(
              color: Color(MyColors.purple01),
              fontWeight: FontWeight.w900,
              height: 1.5,
            ),
          ),
          SizedBox(height: 25),
          SectionTitle(title: 'Giờ khám bệnh'),
          SizedBox(height: 10),
          Text(
            data.doctor?.examination_hours ?? '08:00 - 17:00',
            style: TextStyle(
              color: Color(MyColors.purple01),
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          SizedBox(height: 25),
          DoctorLocation(),
          SizedBox(height: 25),
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
            child: Text('Đặt lịch hẹn', style: TextStyle(fontSize: 16)),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentBookingScreen(),
                ),
              ),
            },
          ),
        ],
      ),
    );
  }
}

class DoctorLocation extends StatelessWidget {
  const DoctorLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 200,
        color: Colors.grey[300],
        // Replace with a Map widget or Image if necessary
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  final DTODoctorDetail data; // Add a data parameter to accept the doctor details

  const DoctorInfo({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NumberCard(label: 'Người bệnh', value: data.doctor?.patientCount ?? 'Không có thông tin'),
        SizedBox(width: 15),
        NumberCard(label: 'Kinh nghiệm', value: data.doctor?.experience ?? 'Không có thông tin'),
        SizedBox(width: 15),
        NumberCard(label: 'Đánh giá', value: data.doctor?.rating ?? 'Không có thông tin'),
      ],
    );
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
  final DTODoctorDetail data; // Add a data parameter to accept the doctor details

  const DetailDoctorCard({Key? key, required this.data}) : super(key: key);

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
                    data.doctor?.name ?? 'Không có tên',
                    style: TextStyle(
                      color: Color(MyColors.header01),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    data.doctor?.degree ?? 'Không có chức danh',
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
                data.doctor?.gender == "Nam"
                    ? 'lib/assets/doctor2.png'
                    : 'lib/assets/doctor_woman.jpg',
                width: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
