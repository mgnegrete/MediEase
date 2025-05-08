import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mediease/confirmed_appointment_page.dart';

enum AppointmentType { annual, lab, followUp, special }

class BookAppointmentPage extends StatefulWidget {
  @override
  _BookAppointmentPageState createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  AppointmentType _selectedType = AppointmentType.annual;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTime;

  final List<String> _timeSlots = [
    '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM',
    '11:00 AM', '11:30 AM', '12:00 PM', '12:30 PM',
    '1:00 PM', '1:30 PM', '2:00 PM', '2:30 PM',
    '3:00 PM', '3:30 PM', '4:00 PM', '4:30 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book an Appointment'),
        backgroundColor: const Color(0xFF660033),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select appointment type', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            _buildTypeSelector(),
            SizedBox(height: 24),
            _buildCalendar(),
            SizedBox(height: 24),
            Text('Select time slot', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            _buildTimeSlots(),
            SizedBox(height: 24),
            Center(child: _buildConfirmButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Wrap(
      spacing: 12,
      children: AppointmentType.values.map((type) {
        final isSelected = _selectedType == type;
        String label;
        switch (type) {
          case AppointmentType.annual:
            label = 'Annual Check Up'; break;
          case AppointmentType.lab:
            label = 'Lab Appointment'; break;
          case AppointmentType.followUp:
            label = 'Follow Up'; break;
          case AppointmentType.special:
            label = 'Special Appointment'; break;
        }
        return ChoiceChip(
          label: Text(label),
          selected: isSelected,
          selectedColor: const Color(0xFF660033),
          onSelected: (_) => setState(() => _selectedType = type),
          backgroundColor: Colors.white,
          side: BorderSide(color: const Color(0xFF660033)),
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF660033),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendar() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selected, focused) {
            setState(() {
              _selectedDay = selected;
              _focusedDay = focused;
            });
          },
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(color: const Color(0xFF660033), fontSize: 20, fontWeight: FontWeight.bold),
            leftChevronIcon: Icon(Icons.chevron_left, color: const Color(0xFF660033)),
            rightChevronIcon: Icon(Icons.chevron_right, color: const Color(0xFF660033)),
          ),
          calendarStyle: CalendarStyle(
            // Ensure all decorations are rectangles to avoid shape-animation errors
            defaultDecoration:    BoxDecoration(shape: BoxShape.rectangle),
            todayDecoration:      BoxDecoration(
                                   color: const Color(0xFF660033).withOpacity(0.3),
                                   shape: BoxShape.rectangle,
                                   borderRadius: BorderRadius.circular(4),
                                 ),
            selectedDecoration:   BoxDecoration(
                                   color: const Color(0xFF660033),
                                   shape: BoxShape.rectangle,
                                   borderRadius: BorderRadius.circular(4),
                                 ),
            weekendDecoration:    BoxDecoration(shape: BoxShape.rectangle),
            outsideDecoration:    BoxDecoration(shape: BoxShape.rectangle),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSlots() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _timeSlots.map((time) {
        final isSelected = _selectedTime == time;
        return GestureDetector(
          onTap: () => setState(() => _selectedTime = time),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF660033) : Colors.transparent,
              border: Border.all(
                color: const Color(0xFF660033),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              time,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF660033),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildConfirmButton() {
    final isEnabled = _selectedDay != null && _selectedTime != null;
    return ElevatedButton(
      onPressed: isEnabled
          ? () {
              final formattedDate = "${_selectedDay!.month.toString().padLeft(2, '0')}-${_selectedDay!.day.toString().padLeft(2, '0')}-${_selectedDay!.year}";
              Navigator.pushNamed(
                context,
                '/confirmed_appointment',
                arguments: {
                  'appointmentType': _selectedType.name,
                  'appointmentDay': formattedDate,
                  'appointmentTime': _selectedTime.toString(),
                },
              );
            }
          : null,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Text(
          'Confirm Appointment', 
          style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF660033),
        disabledBackgroundColor: const Color.fromARGB(255, 158, 158, 158),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
