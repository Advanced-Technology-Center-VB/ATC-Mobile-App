import 'package:atc_mobile_app/destinations/destination_home.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: navIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: "Home"),
          NavigationDestination(icon: Icon(Icons.home_outlined), label: "Programs"),
          NavigationDestination(icon: Icon(Icons.home_outlined), label: "Updates"),
        ],
        onDestinationSelected: (value) => {
          setState(() {
            navIndex = value;
          })
        }
      ),
      body: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(8, 52, 8, 8),
          child: DestinationHome()
        ),
        const Center(),
        const Center()
      ][navIndex]
    );
  }
}