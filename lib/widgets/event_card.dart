import 'package:atc_mobile_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final EventModel model;
  final BuildContext context;
  final VoidCallback onAlertAdd;

  const EventCard({required this.model, required this.context, required this.onAlertAdd, super.key});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
        child: Row(
          children: [
            Expanded(
              child:ListTile(
                leading: Wrap(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      model.startTimestamp.day.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                        height: 0.5,
                        color: Colors.black
                      ),
                    ),
                    Text(
                      DateFormat.MMM().format(model.startTimestamp).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12
                      )
                    ),
                  ],
                ),
                title: Text(model.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, height: 2)),
                subtitle: Wrap(
                  spacing: 6,  
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(Icons.schedule, size: 16),
                    Text(TimeOfDay.fromDateTime(model.startTimestamp).format(context)),
                    const Text("•"),
                    const Icon(Icons.location_on_outlined, size: 16),
                    Text(model.location)
                  ],
                ),
              ), 
            ),
            IconButton(
                onPressed: onAlertAdd, 
                icon: const Icon(Icons.add_alert_outlined)
            )
          ],
      )
    );
  } 
}