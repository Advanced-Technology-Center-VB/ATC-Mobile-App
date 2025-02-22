import 'package:atc_mobile_app/destinations/destination_app_hub.dart';
import 'package:atc_mobile_app/destinations/destination_home.dart';
import 'package:atc_mobile_app/destinations/destination_programs.dart';
import 'package:atc_mobile_app/route/route_test.dart';
import 'package:flutter/material.dart';

/// This route describes the main functionality of the app.
/// 
/// The navigation system is the only thing that must be housed in here
/// as this serves as an entry point for all other screens.
class RouteMain extends StatefulWidget {
  const RouteMain({super.key});

  @override
  State<StatefulWidget> createState() => _RouteMainState();
}

class _RouteMainState extends State<RouteMain> {
  int navIndex = 0;

  var controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: navIndex,
        destinations: const [
          NavigationDestination(selectedIcon: Icon(Icons.home_filled), icon: Icon(Icons.home_outlined), label: "Home"),
          NavigationDestination(selectedIcon: Icon(Icons.school), icon: Icon(Icons.school_outlined), label: "Programs"),
          NavigationDestination(selectedIcon: Icon(Icons.edit_note), icon: Icon(Icons.edit_note_outlined), label: "Apply"),
        ],
        onDestinationSelected: (value) => {
          setState(() {
            navIndex = value;
            controller.animateToPage(value, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);
          })
        }
      ),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        itemBuilder: (context, index) => const <Widget>[ //This is where pages are defined.
          DestinationHome(),
          DestinationPrograms(),
          DestinationAppHub()
        ][index]
      )
    );
  }
}