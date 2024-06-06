import 'package:app_medicine/model/appointment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeSlot {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final bool isRegister;
  final bool isFree;

  TimeSlot({
    required this.startTime,
    required this.endTime,
    required this.isRegister,
    required this.isFree,
  });
}

class TimeSlotTags extends StatelessWidget {
  final List<Appointment> appointments;
  final Function(Appointment) onTimeSlotSelected;

  const TimeSlotTags({
    Key? key,
    required this.appointments,
    required this.onTimeSlotSelected,
  }) : super(key: key);

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
    Key? key,
    required this.appointment,
    required this.onPressed,
  }) : super(key: key);

  @override
  _TimeSlotChipState createState() => _TimeSlotChipState();
}

class _TimeSlotChipState extends State<TimeSlotChip> {
  bool isSelected = false; // Track the selection state

  String _formatTime(String time) {
    final DateTime dateTime = DateFormat('HH:mm:ss').parse(time);
    return DateFormat('HH:mm').format(dateTime);
  }

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
          '${_formatTime(widget.appointment.startTime)} - ${_formatTime(widget.appointment.endTime)}',
          style: const TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}
