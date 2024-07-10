import 'package:flutter/material.dart';

class TotalDevicesScreen extends StatelessWidget {
  const TotalDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices'),
      ),
      body: const Center(
        child: Text(' Total Devices'),
      ),
    );
  }
}
