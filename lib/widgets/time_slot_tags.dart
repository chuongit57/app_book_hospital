import 'package:app_medicine/model/appointment.dart';
import 'package:app_medicine/utils/date_utils.dart';
import 'package:flutter/material.dart';

class TimeSlotTags extends StatelessWidget {
  final List<Appointment> appointments;
  final Function(Appointment) onTimeSlotSelected;

  const TimeSlotTags({
    super.key,
    required this.appointments,
    required this.onTimeSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 4.0,
      childAspectRatio: 4,
      children: appointments.map((appointment) {
        return TimeSlotChip(
          appointment: appointment,
          onPressed: () {
            onTimeSlotSelected(appointment);
          },
        );
      }).toList(),
    );
  }
}

class TimeSlotChip extends StatefulWidget {
  final Appointment appointment;
  final VoidCallback onPressed;

  const TimeSlotChip({
    super.key,
    required this.appointment,
    required this.onPressed,
  });

  @override
  State<TimeSlotChip>createState() => _TimeSlotChipState();
}

class _TimeSlotChipState extends State<TimeSlotChip> {
  bool isSelected = false; // Track the selection state

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    if (widget.appointment.status == DoctorAppointmentStatus.BOOKED) {
      backgroundColor = Colors.red;
    } else {
      backgroundColor = Colors.green;
    }

    // if (widget.appointment.status == DoctorAppointmentStatus.BOOKED) {
    //   backgroundColor = Colors.blue;
    // }

    return InkWell(
      splashColor: Colors.transparent,
      child: MaterialButton(
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: backgroundColor,
        hoverColor: Colors.blue[50],
        highlightColor: Colors.blue[100],
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onPressed: widget.onPressed,
        child: Text(
          DateUtil.formatTimeRange(widget.appointment.startTime, widget.appointment.endTime),
          style: const TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}
