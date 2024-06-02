// lib/data_fake/filter_status.dart
enum FilterStatus { Upcoming, Complete, Cancel }

extension FilterStatusExtension on FilterStatus {
  String get name {
    switch (this) {
      case FilterStatus.Upcoming:
        return 'Sắp tới';
      case FilterStatus.Complete:
        return 'Lịch hẹn';
      case FilterStatus.Cancel:
        return 'Hoàn thành';
      default:
        return "";
    }
  }
}
