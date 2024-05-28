enum Role {
  USER,
  ADMIN,
  DOCTOR,
  // Add other roles if necessary
}

extension RoleExtension on Role {
  String get name => this.toString().split('.').last;

  static Role fromString(String roleString) {
    return Role.values.firstWhere((e) => e.name == roleString, orElse: () => throw ArgumentError('Invalid role: $roleString'));
  }
}