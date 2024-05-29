import 'dart:ui';
import 'package:app_medicine/data_fake/data_doctor.dart';
import 'package:flutter/material.dart';
import '../model/doctors.dart';
import '../styles/colors.dart';
import '../styles/styles.dart';

List<Map> doctors = [
  {'img': 'lib/assets/doctor2.png', 'doctorName': 'Mai Thanh Nam', 'doctorTitle': 'Bác sĩ tim mạch'},
  {'img': 'lib/assets/doctor2.png', 'doctorName': 'Nguyễn Lê Lâm', 'doctorTitle': 'Bác sĩ thần kinh'},
  {'img': 'lib/assets/doctor2.png', 'doctorName': 'Thạch Xuân Hoàng', 'doctorTitle': 'Bác sĩ nha khoa'},
  {'img': 'lib/assets/doctor2.png', 'doctorName': 'Hồ Huy', 'doctorTitle': 'Bác sĩ da liễu'}
];

List<Map> categories = [
  {'icon': Icons.chat, 'text': 'Tư vấn'},
  {'icon': Icons.local_pharmacy, 'text': 'Đơn thuốc'},
  {'icon': Icons.car_rental, 'text': 'Gọi xe'},
  {'icon': Icons.local_hospital, 'text': 'Bệnh viện'},
];

class HomeTab extends StatefulWidget {
  final void Function() onPressedScheduleCard;

  HomeTab({
    Key? key,
    required this.onPressedScheduleCard,
  }) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Doctors> docters = [];

  Future<List<Doctors>> getBacsihangdau() async {
    await Future.delayed(Duration(seconds: 5));
    docters = generateDoctorList();
    return docters;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            SearchInput(),
            SizedBox(
              height: 20,
            ),
            CategoryIcons(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lịch hẹn hôm nay',
                  style: kTitleStyle,
                ),
                TextButton(
                  child: Text(
                    'Xem tất cả',
                    style: TextStyle(
                      color: Color(MyColors.yellow01),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => {widget.onPressedScheduleCard()},
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            AppointmentCard(
              onTap: widget.onPressedScheduleCard,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bác sĩ hàng đầu',
                  style: kTitleStyle,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<Doctors>>(
              future: getBacsihangdau(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the data is loading, display a loading indicator
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // If there's an error while fetching data, display an error message
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // If no data is returned, display a message
                  return Center(child: Text('No data found'));
                } else {
                  // If the data is loaded successfully, display the list of doctors
                  List<Doctors> doctorss = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: doctorss.length,
                    itemBuilder: (context, index) {
                      var doctor = doctorss[index];
                      return TopDoctorCard(
                        img: 'lib/assets/doctor2.png', // Replace with actual image path
                        doctorName: doctor.name,
                        doctorKhoa: doctor.khoa.name,
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TopDoctorCard extends StatelessWidget {
  final String img;
  final String doctorName;
  final String doctorKhoa;

  TopDoctorCard({
    required this.img,
    required this.doctorName,
    required this.doctorKhoa,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(MyColors.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(bottom: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/detail', arguments: {
              'img': img,
              'doctorName': doctorName,
              'doctorTitle': doctorKhoa,
              'reservedDate': 'Thứ 3, 14 tháng 5',
              'reservedTime': '08:00 - 11:00',
              'status': "Hoàn thành"
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(img),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorName,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          doctorKhoa,
                          style: TextStyle(color: Color(MyColors.text01)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Color(MyColors.yellow02),
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '4.0 - 50 đánh giá',
                      style: TextStyle(color: Color(MyColors.grey02)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final void Function() onTap;

  const AppointmentCard({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(MyColors.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('lib/assets/doctor2.png'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nguyễn Lê Lâm', style: TextStyle(color: Colors.white)),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Bác sĩ thần kinh',
                              style: TextStyle(color: Color(MyColors.text01)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ScheduleCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg02),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg03),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryIcons extends StatelessWidget {
  const CategoryIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var category in categories)
          CategoryIcon(
            icon: category['icon'],
            text: category['text'],
          ),
      ],
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg01),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 10,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Thứ 2, 13/05',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              '11:00 ~ 12:10',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  IconData icon;
  String text;

  CategoryIcon({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Color(MyColors.bg01),
      onTap: () => {
        print(text),
        if (text == 'Đơn thuốc')
          {Navigator.pushNamed(context, '/prescription')}
        else if(text == 'Tư vấn')
          {Navigator.pushNamed(context, '/advide')}
        else if (text == 'Gọi xe')
            {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Gọi ngay cho chúng tôi nếu bạn cần', textAlign: TextAlign.center),
                  content: const Text('0901379115', textAlign: TextAlign.center),
                  contentTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink, fontSize: 22),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            }
          else
            {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  // title: const Text('Tính năng đang phát triển'),
                  content: const Text('Tính năng đang phát triển', textAlign: TextAlign.center),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            }
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(MyColors.bg),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                color: Color(MyColors.primary),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color: Color(MyColors.primary),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(MyColors.bg),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Icon(
              Icons.search,
              color: Color(MyColors.purple02),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Nhập tên bác sĩ bạn muốn tìm kiếm',
                hintStyle: TextStyle(fontSize: 13, color: Color(MyColors.purple01), fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
