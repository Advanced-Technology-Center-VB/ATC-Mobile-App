import 'package:atc_mobile_app/models/event_model.dart';
import 'package:flutter/material.dart';



class RouteHeadline extends StatelessWidget {
  final EventModel model;
  final Image cachedImage;
  final void Function() addAlert;
  

  const RouteHeadline({super.key, required this.model, required this.cachedImage, required this.addAlert});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(model.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_alert_outlined),
              onPressed: () => addAlert.call(),
            )
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed([
              cachedImage,
              Text(model.summary ?? "")
            ])
          ),
        )
      ],
    );
  }
  
}