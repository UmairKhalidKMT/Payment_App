import 'package:flutter/material.dart';

class MerchantScreen extends StatefulWidget {
  const MerchantScreen({super.key});

  @override
  State<MerchantScreen> createState() => _MerchantScreen();
}

class _MerchantScreen extends State<MerchantScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            snap: false,
            elevation: 10,  
            backgroundColor: Colors.deepPurple,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Merhcant Screen',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
