import 'package:flutter/material.dart';

class TotalRevenueScreen extends StatelessWidget {
  const TotalRevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revenue'),
      ),
      body: const Center(
        child: Text('Total Revenue'),
      ),
    );
  }
}
