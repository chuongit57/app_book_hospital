import 'package:app_medicine/model/prescription.dart';
import 'package:app_medicine/model/prescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;
import '../styles/colors.dart';
import '../styles/styles.dart';

final List<Prescription> defaultPrescription = [
  Prescription(prescriptionId: '1', name: "Bệnh cảm", prescription: "A, B"),
  Prescription(prescriptionId: "2", name: "Bện sốt", prescription: 'c, d'),
  Prescription(prescriptionId: "3", name: "Dị ứng", prescription: 't,y'),
];



class PrescriptionItem extends StatelessWidget {
  final Prescription prescription;

  const PrescriptionItem({
    Key? key,
    required this.prescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: 50,
    //   child: Center(child: TextButton(prescription.name)),
    // );
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}


class PrescriptionDetail extends StatelessWidget {
  PrescriptionDetail({Key? key}) : super(key: key);
  TextEditingController _searchController = TextEditingController();

  void _submitSearch() {
    String searchQuery = _searchController.text;
    // Đây là nơi để thực hiện tìm kiếm với từ khóa searchQuery
    print('Searching for: $searchQuery');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm kiếm đơn thuốc'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Nhập tên bệnh',
                    ),
                    onSubmitted: (_) => _submitSearch(),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý sự kiện khi nút được nhấn
                      print('Button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Màu sắc nút
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Hình dạng nút
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0), // Kích thước nút
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search), // Biểu tượng tìm kiếm
                        SizedBox(width: 0.0), // Khoảng cách giữa biểu tượng và văn bản
                        Text('Tìm kiếm'), // Văn bản của nút
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(flex:1,
              child:  ListView(
              padding: const EdgeInsets.all(8),
              children: defaultPrescription.map((e) => PrescriptionItem(prescription: e)).toList()
            ),)
          ],
        ),
      ),
    );
  }
}
