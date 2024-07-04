import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_app/controllers/merchant_form_controller.dart';
import 'package:payment_app/models/merchant/merchant_form_model.dart';
import 'package:provider/provider.dart';
import 'package:payment_app/utils/app_colors.dart';
import 'package:payment_app/views/screens/widgets/button.dart';

class MerchantScreen extends StatelessWidget {
  const MerchantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MerchantController(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
          ),
          elevation: 1.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Merchants',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(fontSize: 22),
            ),
          ),
          actions: [
            Builder(
              builder: (context) {
                double screenWidth = MediaQuery.of(context).size.width;
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    icon: const Icon(Icons.person_add_rounded),
                    iconSize: screenWidth / 13,
                    onPressed: () => _showAddMerchantDialog(context),
                  ),
                );
              },
            ),
          ],
        ),
        body: Consumer<MerchantController>(
          builder: (context, controller, child) {
            return ListView.builder(
              itemCount: controller.merchants.length,
              itemBuilder: (context, index) {
                final merchant = controller.merchants[index];
                final isInactive = merchant.status == 'Inactive';
                return Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: ListTile(
                    tileColor: AppColors.lightBlackColor,
                    selectedColor: AppColors.lightWhiteColor,
                    title: Text(
                      merchant.name,
                      style: TextStyle(
                        color: isInactive
                            ? AppColors.redColor
                            : AppColors.whiteColor,
                      ),
                    ),
                    subtitle: Text(merchant.businessName),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            controller.deleteMerchant(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.update_rounded),
                          onPressed: () {
                            _showUpdateMerchantDialog(context, index, merchant);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {
                            _showMerchantDetails(context, merchant);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showAddMerchantDialog(BuildContext context) {
    final controller = Provider.of<MerchantController>(context, listen: false);
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final addressController = TextEditingController();
    final businessNameController = TextEditingController();
    String status = 'Active';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New User'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    keyboardType: TextInputType.name,
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    keyboardType: TextInputType.phone,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                    keyboardType: TextInputType.streetAddress,
                  ),
                  TextField(
                    controller: businessNameController,
                    decoration:
                        const InputDecoration(labelText: 'Business Name'),
                    keyboardType: TextInputType.name,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DropdownButtonFormField<String>(
                      value: status,
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Active', 'Inactive'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        status = newValue!;
                      },
                    ),
                  ),
                ],
              ),
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
                controller.addMerchant(Merchant(
                  name: nameController.text,
                  phone: phoneController.text,
                  email: emailController.text,
                  address: addressController.text,
                  businessName: businessNameController.text,
                  status: status,
                ));
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.add_task_outlined),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateMerchantDialog(
      BuildContext context, int index, Merchant merchant) {
    final controller = Provider.of<MerchantController>(context, listen: false);
    final nameController = TextEditingController(text: merchant.name);
    final phoneController = TextEditingController(text: merchant.phone);
    final emailController = TextEditingController(text: merchant.email);
    final addressController = TextEditingController(text: merchant.address);
    final businessNameController =
        TextEditingController(text: merchant.businessName);
    String status = merchant.status;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update User'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    keyboardType: TextInputType.name,
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    keyboardType: TextInputType.phone,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                    keyboardType: TextInputType.streetAddress,
                  ),
                  TextField(
                    controller: businessNameController,
                    decoration:
                        const InputDecoration(labelText: 'Business Name'),
                    keyboardType: TextInputType.name,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DropdownButtonFormField<String>(
                      value: status,
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Active', 'Inactive'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        status = newValue!;
                      },
                    ),
                  ),
                ],
              ),
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
              btnName: 'Update',
              voidCallback: () {
                controller.updateMerchant(
                    index,
                    Merchant(
                      name: nameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      address: addressController.text,
                      businessName: businessNameController.text,
                      status: status,
                    ));
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.update),
            ),
          ],
        );
      },
    );
  }

  void _showMerchantDetails(BuildContext context, Merchant merchant) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${merchant.name}'),
                const SizedBox(height: 8),
                Text('Phone: ${merchant.phone}'),
                const SizedBox(height: 8),
                Text('Email: ${merchant.email}'),
                const SizedBox(height: 8),
                Text('Address: ${merchant.address}'),
                const SizedBox(height: 8),
                Text('Business Name: ${merchant.businessName}'),
                const SizedBox(height: 8),
                Text('Status: ${merchant.status}'),
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
}
