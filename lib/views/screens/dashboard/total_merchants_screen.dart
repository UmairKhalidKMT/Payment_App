import 'package:flutter/material.dart';

class TotalMerchantScreen extends StatelessWidget {
  const TotalMerchantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Merchants'),
      ),
      body: const Center(
        child: Text('List of Merchants'),
      ),
    );
  }
}
