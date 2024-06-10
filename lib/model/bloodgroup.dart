class Bloodgroup {
  final int id;
  final String code;
  final String name;

  Bloodgroup({
    required this.id,
    required this.code,
    required this.name,
  });

  factory Bloodgroup.fromJson(Map<String, dynamic> json) {
    return Bloodgroup(
      id: json['id'],
      code: json['code'],
      name: json['name'],
    );
  }

}