import 'package:flutter/material.dart';

class ConfirmedAppointmentPage extends StatelessWidget {
  final String appointmentType;
  final String appointmentDay;
  final String appointmentTime;

  ConfirmedAppointmentPage({
    required this.appointmentType,
    required this.appointmentDay,
    required this.appointmentTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appointment Confirmation'), backgroundColor: Color(0xFF660033), foregroundColor: Colors.white,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.check_circle, size: 100, color: Color(0xFF660033)),
          SizedBox(height: 20),
          Text('Appointment Confirmed!', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Text('Type: ${_formatAppointmentType(appointmentType)}', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
          Text('Day: $appointmentDay', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
          Text('Time: $appointmentTime', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
          SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF660033)),
            onPressed: () => Navigator.pushNamed(context, '/profile_page'),
            child: Text('View Appointments', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
  String _formatAppointmentType(String type) {
    switch (type) {
      case 'annual': return 'Annual Check Up';
      case 'lab': return 'Lab Appointment';
      case 'followUp': return 'Follow Up';
      case 'special': return 'Special Appointment';
      default: return type;
    }
  }
}
