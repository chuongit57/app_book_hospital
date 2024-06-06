enum ScheduleUserStatus { SIGN_UP, HISTORY }

extension ScheduleUserStatusExtension on ScheduleUserStatus {
  String get name {
    switch (this) {
      case ScheduleUserStatus.SIGN_UP:
        return 'Đăng ký khám';
      case ScheduleUserStatus.HISTORY:
        return 'Lịch sử';
      default:
        return "";
    }
  }
}
