import 'package:flutter/material.dart';
import 'package:medi_connect/Components_Ui/mechanic_tile.dart';
import 'package:medi_connect/models/appointment.dart';
import 'package:medi_connect/models/mechanic.dart';
import 'package:provider/provider.dart';

class MechanicPage extends StatefulWidget {
  const MechanicPage({super.key});

  @override
  State<MechanicPage> createState() => _MechanicPageState();
}

class _MechanicPageState extends State<MechanicPage> {
  void addMechanicAppointment(Mechanic mechanic) {
    Provider.of<Appointment>(context, listen: false).addAppointment(mechanic);

    // alert user, appointment added
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Appointment Sucessfully added!'),
        content: Text('Check your Appointment'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Appointment>(
      builder: (context, value, child) => Column(
        children: [
          // search bar
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 25.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search',
                  style: TextStyle(
                    color: Color.fromARGB(255, 103, 103, 103),
                  ),
                ),
                Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 103, 103, 103),
                ),
              ],
            ),
          ),

          // message
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'Book your appointment with the mechanics',
              style: TextStyle(color: Colors.black),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Mechanics',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'See all',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Mechanic mechanic = value.getMechanicList()[index];

                return MechanicTile(
                  mechanic: mechanic,
                  onTap: () => addMechanicAppointment(mechanic),
                );
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(top: 25.0, left: 25, right: 25),
            child: Divider(
              color: Color.fromARGB(255, 85, 175, 174),
            ),
          )
        ],
      ),
    );
  }
}
