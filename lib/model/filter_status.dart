enum FilterStatus { Upcoming, Schedule, Complete }

extension FilterStatusExtension on FilterStatus {
  String get name {
    switch (this) {
      case FilterStatus.Upcoming:
        return 'Sắp tới';
      case FilterStatus.Schedule:
        return 'Lịch hẹn';
      case FilterStatus.Complete:
        return 'Hoàn thành';
      default:
        return "";
    }
  }
}
