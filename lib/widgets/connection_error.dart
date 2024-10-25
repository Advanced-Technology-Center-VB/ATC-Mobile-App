import 'package:flutter/material.dart';

class ConnectionError extends StatelessWidget {
  const ConnectionError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.signal_wifi_connected_no_internet_4_outlined, 
            size: 72
          ),
          Text(
            "Cannot connect. Check your network connection.",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
            ),
          )
        ],
      ),
    
      );
  }
  
}