import 'package:flutter/material.dart';
import 'package:payment_app/views/screens/widgets/button.dart';
import 'package:payment_app/views/screens/widgets/textfield.dart';

class MerchantScreen extends StatefulWidget {
  const MerchantScreen({super.key});

  @override
  State<MerchantScreen> createState() => _MerchantScreenState();
}

class _MerchantScreenState extends State<MerchantScreen> {
  List<Map<String, String>> merchants = [];

  void _addNewUser() {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController businessNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New User'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Textfield(
                    label: 'Name',
                    textInputType: TextInputType.name,
                    controller: nameController),
                Textfield(
                    label: 'Phone',
                    textInputType: TextInputType.phone,
                    controller: phoneController),
                Textfield(
                    label: 'Email',
                    textInputType: TextInputType.emailAddress,
                    controller: emailController),
                Textfield(
                    label: 'Address',
                    textInputType: TextInputType.emailAddress,
                    controller: addressController),
                Textfield(
                    label: 'Business',
                    textInputType: TextInputType.name,
                    controller: businessNameController),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ButtonWidget(
              btnName: 'Add',
              voidCallback: () {
                setState(() {
                  merchants.add({
                    'name': nameController.text,
                    'phone': phoneController.text,
                    'email': emailController.text,
                    'address': addressController.text,
                    'businessName': businessNameController.text,
                  });
                });
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _viewUserDetails(Map<String, String> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${user['name']}'),
                const SizedBox(height: 8),
                Text('Phone: ${user['phone']}'),
                const SizedBox(height: 8),
                Text('Email: ${user['email']}'),
                const SizedBox(height: 8),
                Text('Address: ${user['address']}'),
                const SizedBox(height: 8),
                Text('Business Name: ${user['businessName']}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Merchants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: _addNewUser,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: merchants.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(merchants[index]['name'] ?? ''),
            subtitle: Text(merchants[index]['businessName'] ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      merchants.removeAt(index);
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.update),
                  onPressed: () {
                    // Add update functionality here
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: () {
                    _viewUserDetails(merchants[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
