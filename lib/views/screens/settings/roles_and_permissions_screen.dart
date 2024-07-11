import 'package:flutter/material.dart';

class RolesAndPermissionsScreen extends StatefulWidget {
  const RolesAndPermissionsScreen({super.key});

  @override
  State<RolesAndPermissionsScreen> createState() =>
      _RolesAndPermissionsScreenState();
}

class _RolesAndPermissionsScreenState extends State<RolesAndPermissionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roles and Permissions'),
      ),
    );
  }
}
