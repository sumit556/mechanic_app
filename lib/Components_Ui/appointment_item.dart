import 'package:flutter/material.dart';
import 'package:medi_connect/models/appointment.dart';
import 'package:medi_connect/models/mechanic.dart';
import 'package:medi_connect/services/auth_services.dart';
import 'package:provider/provider.dart';

class AppointmentItem extends StatefulWidget {
  final Mechanic mechanic;
  const AppointmentItem({
    super.key,
    required this.mechanic,
  });

  @override
  State<AppointmentItem> createState() => _AppointmentItemState();
}

class StatefulWidget {
}

class _AppointmentItemState extends State<AppointmentItem> {
  // Remove appointment method
  Future<void> removeAppointment() async {
    try {
      // Call AuthServices to delete the appointment
      await AuthServices.deleteAppointment(widget.mechanic);
      
      // Use context.read instead of Provider.of to access the appointment provider
      context.read<Appointment>().removeAppointment(widget.mechanic);

      // Optionally, show a success message or handle any UI changes
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Appointment removed successfully')),
      );
    } catch (error) {
      // Handle errors and provide feedback to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove appointment')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: widget.mechanic.imagePath != null ? Image.asset(widget.mechanic.imagePath) : null,
        title: Text(widget.mechanic.name ?? 'No Name'),
        subtitle: Text(widget.mechanic.specialization ?? 'No Specialization'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: removeAppointment,
        ),
      ),
    );
  }
}
