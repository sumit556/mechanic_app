import 'package:flutter/material.dart';
import 'package:medi_connect/Components_Ui/appointment_item.dart';
import 'package:medi_connect/models/appointment.dart';
import 'package:medi_connect/models/mechanic.dart';
import 'package:medi_connect/services/auth_services.dart';
import 'package:provider/provider.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Appointment>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // heading
            const Text(
              'My Appointment',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: value.getUserAppointment().length,
                itemBuilder: (context, index) {
                  Mechanic individualMechanic =
                      value.getUserAppointment()[index];

                  return AppointmentItem(mechanic: individualMechanic);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
