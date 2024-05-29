import 'package:flutter/material.dart';
import 'dart:collection';

class Prescription {
  final String name;
  final String description;
  final String dosage;

  Prescription({
    required this.name,
    required this.description,
    required this.dosage,
  });
}

class Disease {
  final String name;
  final List<Prescription> prescriptions;

  Disease({
    required this.name,
    required this.prescriptions,
  });
}

class PrescriptionSearchTab extends StatefulWidget {
  @override
  _PrescriptionSearchTabState createState() => _PrescriptionSearchTabState();
}

class _PrescriptionSearchTabState extends State<PrescriptionSearchTab> {
  final TextEditingController _searchController = TextEditingController();
  List<Disease> _searchResults = [];

  final List<Disease> allDiseases = [
    Disease(
      name: 'Cảm cúm',
      prescriptions: [
        Prescription(
          name: 'Paracetamol',
          description: 'Thuốc giảm đau và hạ sốt.',
          dosage: '500mg, uống mỗi 4-6 giờ.',
        ),
        Prescription(
          name: 'Ibuprofen',
          description: 'Thuốc chống viêm không steroid (NSAID).',
          dosage: '200-400mg, uống mỗi 4-6 giờ.',
        ),
      ],
    ),
    Disease(
      name: 'Nhiễm trùng',
      prescriptions: [
        Prescription(
          name: 'Amoxicillin',
          description: 'Kháng sinh thuộc nhóm penicillin.',
          dosage: '500mg, uống mỗi 8 giờ.',
        ),
      ],
    ),
    Disease(
      name: 'Tiểu đường',
      prescriptions: [
        Prescription(
          name: 'Metformin',
          description: 'Thuốc điều trị tiểu đường loại 2.',
          dosage: '500mg, uống hai lần mỗi ngày.',
        ),
      ],
    ),
    Disease(
      name: 'Cholesterol cao',
      prescriptions: [
        Prescription(
          name: 'Atorvastatin',
          description: 'Thuốc hạ cholesterol.',
          dosage: '10-20mg, uống một lần mỗi ngày.',
        ),
      ],
    ),
    Disease(
      name: 'Cảm lạnh',
      prescriptions: [
        Prescription(
          name: 'Paracetamol',
          description: 'Thuốc giảm đau và hạ sốt.',
          dosage: '500mg, uống mỗi 4-6 giờ.',
        ),
      ],
    ),
    Disease(
      name: 'Ho',
      prescriptions: [
        Prescription(
          name: 'Azithromycin',
          description: 'Thuốc điều trị ho.',
          dosage: '500mg, uống mỗi 4-6 giờ.',
        ),
      ],
    ),
    Disease(
      name: 'Cảm lạnh',
      prescriptions: [
        Prescription(
          name: 'Ibuprofen',
          description: 'Thuốc chống viêm không steroid (NSAID).',
          dosage: '200-400mg, uống mỗi 4-6 giờ.',
        ),
      ],
    ),
    Disease(
      name: 'Viêm họng',
      prescriptions: [
        Prescription(
          name: 'Amoxicillin',
          description: 'Kháng sinh thuộc nhóm penicillin.',
          dosage: '500mg, uống mỗi 8 giờ.',
        ),
      ],
    ),
    Disease(
      name: 'Viêm phế quản',
      prescriptions: [
        Prescription(
          name: 'Azithromycin',
          description: 'Kháng sinh thuộc nhóm macrolid.',
          dosage: '250mg, uống mỗi ngày một lần trong 5 ngày.',
        ),
      ],
    ),
    Disease(
      name: 'Viêm phế quản',
      prescriptions: [
        Prescription(
          name: 'Prednisone',
          description: 'Thuốc chống viêm corticosteroid.',
          dosage: '20mg, uống mỗi ngày một lần trong 5-7 ngày.',
        ),
      ],
    ),
    Disease(
      name: 'Viêm xoang',
      prescriptions: [
        Prescription(
          name: 'Augmentin (Amoxicillin/Clavulanate)',
          description: 'Kháng sinh kết hợp.',
          dosage: '875/125mg, uống mỗi 12 giờ.',
        ),
      ],
    ),
    Disease(
      name: 'Viêm phế quản',
      prescriptions: [
        Prescription(
          name: 'Pseudoephedrine',
          description: 'Thuốc thông mũi.',
          dosage: '60mg, uống mỗi 4-6 giờ.',
        ),
      ],
    ),
    Disease(
      name: 'Táo bón',
      prescriptions: [
        Prescription(
          name: 'Lactulose',
          description: 'Thuốc nhuận tràng.',
          dosage: '10-20g, uống mỗi ngày.',
        ),
      ],
    ),
    Disease(
      name: 'Táo bón',
      prescriptions: [
        Prescription(
          name: 'Bisacodyl',
          description: 'Thuốc nhuận tràng kích thích.',
          dosage: '5mg, uống mỗi ngày trước khi đi ngủ.',
        ),
      ],
    ),
    Disease(
      name: 'Đau nữa đầu',
      prescriptions: [
        Prescription(
          name: 'Sumatriptan',
          description: 'Thuốc điều trị đau nửa đầu.',
          dosage: '50-100mg, uống khi bắt đầu triệu chứng.',
        ),
      ],
    ),
    Disease(
      name: 'Cao huyết áp',
      prescriptions: [
        Prescription(
          name: 'Lisinopril',
          description: 'Thuốc ức chế men chuyển.',
          dosage: '10-20mg, uống mỗi ngày.',
        ),
      ],
    ),
    Disease(
      name: 'Mất ngủ',
      prescriptions: [
        Prescription(
          name: 'Zolpidem',
          description: 'Thuốc an thần.',
          dosage: '5-10mg, uống trước khi đi ngủ.',
        ),
      ],
    ),
    Disease(
      name: 'Hen phế quản',
      prescriptions: [
        Prescription(
          name: 'Albuterol',
          description: 'Thuốc giãn phế quản beta2-agonist.',
          dosage: '90mcg, hít khi cần.',
        ),
      ],
    ),
    Disease(
      name: 'Viêm da dị ứng',
      prescriptions: [
        Prescription(
          name: 'Hydrocortisone',
          description: 'Thuốc corticosteroid bôi ngoài da.',
          dosage: 'bôi lên vùng da bị viêm mỗi ngày.',
        ),
      ],
    ),
    Disease(
      name: 'Mụn trứng cá',
      prescriptions: [
        Prescription(
          name: 'Clindamycin',
          description: 'Thuốc kháng sinh bôi ngoài da.',
          dosage: 'bôi lên vùng da bị mụn mỗi ngày.',
        ),
      ],
    ),
    Disease(
      name: 'Gút',
      prescriptions: [
        Prescription(
          name: 'Allopurinol',
          description: 'Thuốc giảm acid uric.',
          dosage: '100-300mg, uống mỗi ngày.',
        ),
      ],
    ),
    Disease(
      name: 'Gút',
      prescriptions: [
        Prescription(
          name: 'Colchicine',
          description: 'Thuốc chống viêm.',
          dosage: '0.6mg, uống mỗi 12 giờ khi có triệu chứng.',
        ),
      ],
    ),
  ];

  void _performSearch() {
    setState(() {
      _searchResults = allDiseases
          .where((disease) => disease.name.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm kiếm đơn thuốc'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Nhập tên bệnh',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _performSearch,
                ),
              ),
              onSubmitted: (value) => _performSearch(),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _searchResults.isEmpty
                  ? Center(
                      child: Text('Không tìm thấy kết quả'),
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        Disease disease = _searchResults[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  disease.name,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                SizedBox(height: 10),
                                ...disease.prescriptions.map((prescription) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tên thuốc:',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        Text(
                                          prescription.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Mô tả:',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        Text(
                                          prescription.description,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Liều dùng:',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        Text(
                                          prescription.dosage,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
