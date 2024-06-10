enum ScheduleUserStatus { SIGN_UP, DONE, HISTORY }

extension ScheduleUserStatusExtension on ScheduleUserStatus {
  String get name {
    switch (this) {
      case ScheduleUserStatus.SIGN_UP:
        return 'Đăng ký';
      case ScheduleUserStatus.DONE:
        return 'Hoành thành';
      case ScheduleUserStatus.HISTORY:
        return 'Lịch sử';
      default:
        return "";
    }
  }
}

enum ScheduleDoctorStatus { COMING, DONE, CANCLE }
extension ScheduleDoctorStatusExtension on ScheduleDoctorStatus {
  String get name {
    switch (this) {
      case ScheduleDoctorStatus.COMING:
        return 'Lịch hẹn';
      case ScheduleDoctorStatus.DONE:
        return 'Hoành thành';
      case ScheduleDoctorStatus.CANCLE:
        return 'Hủy lịch';
      default:
        return "";
    }
  }
}
