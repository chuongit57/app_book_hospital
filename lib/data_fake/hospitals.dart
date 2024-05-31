class Hospital {
  final String name;
  final String address;

  Hospital({required this.name, required this.address});
}

final List<Hospital> hospitals = [
  Hospital(name: 'Bệnh viện Đại học Y', address: 'Số 1 Đại Cồ Việt, Hà Nội'),
  Hospital(name: 'Bệnh viện Bạch Mai', address: '78 Giải Phóng, Hà Nội'),
  Hospital(name: 'Bệnh viện Chợ Rẫy', address: '201B Nguyễn Chí Thanh, TP.HCM'),
  // Thêm các bệnh viện khác vào đây
];
