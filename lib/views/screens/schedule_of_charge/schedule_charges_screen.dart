import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_app/controllers/schedule_of_charges/schedule_charges_controller.dart';
import 'package:payment_app/models/schedule_of_charges/schedule_charges.dart';
import 'package:provider/provider.dart';
import 'package:payment_app/utils/app_colors.dart';
import 'package:payment_app/views/screens/widgets/button.dart';

class ScheduleCharges extends StatelessWidget {
  const ScheduleCharges({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScheduleChargesController(),
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
            'Schedule of Charges',
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
                    onPressed: () => _showAddChargeDialog(context),
                  ),
                );
              },
            ),
          ],
        ),
        body: Consumer<ScheduleChargesController>(
          builder: (context, controller, child) {
            return ListView.builder(
              itemCount: controller.scheduleCharges.length,
              itemBuilder: (context, index) {
                final charges = controller.scheduleCharges[index];
                final isInactive = charges.status == 'Inactive';
                return Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: ListTile(
                    tileColor: AppColors.lightBlackColor,
                    selectedColor: AppColors.lightWhiteColor,
                    title: Text(
                      charges.name,
                      style: TextStyle(
                        color: isInactive
                            ? AppColors.redColor
                            : AppColors.whiteColor,
                      ),
                    ),
                    subtitle: Text(charges.range),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            controller.deleteCharge(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.update_rounded),
                          onPressed: () {
                            _showUpdateChargeDialog(context, index, charges);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {
                            _showChargeDetails(context, charges);
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

  void _showAddChargeDialog(BuildContext context) {
    final controller =
        Provider.of<ScheduleChargesController>(context, listen: false);
    final nameController = TextEditingController();
    final rangeController = TextEditingController();
    final percentageController = TextEditingController();
    final fixedChargesController = TextEditingController();
    final merchantIdController = TextEditingController();
    String status = 'Active';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Charge'),
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
                    controller: rangeController,
                    decoration: const InputDecoration(labelText: 'Range'),
                    keyboardType: TextInputType.text,
                  ),
                  TextField(
                    controller: percentageController,
                    decoration: const InputDecoration(labelText: 'Percentage'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: fixedChargesController,
                    decoration:
                        const InputDecoration(labelText: 'Fixed Charges'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: merchantIdController,
                    decoration: const InputDecoration(labelText: 'Merchant ID'),
                    keyboardType: TextInputType.text,
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
                controller.addCharge(ScheduleChargesModel(
                  name: nameController.text,
                  range: rangeController.text,
                  percentage: percentageController.text,
                  fixedCharges: fixedChargesController.text,
                  merchantId: merchantIdController.text,
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

  void _showUpdateChargeDialog(
      BuildContext context, int index, ScheduleChargesModel charges) {
    final controller =
        Provider.of<ScheduleChargesController>(context, listen: false);
    final nameController = TextEditingController(text: charges.name);
    final rangeController = TextEditingController(text: charges.range);
    final percentageController =
        TextEditingController(text: charges.percentage);
    final fixedChargesController =
        TextEditingController(text: charges.fixedCharges);
    final merchantIdController =
        TextEditingController(text: charges.merchantId);
    String status = charges.status;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Charge'),
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
                    controller: rangeController,
                    decoration: const InputDecoration(labelText: 'Range'),
                    keyboardType: TextInputType.text,
                  ),
                  TextField(
                    controller: percentageController,
                    decoration: const InputDecoration(labelText: 'Percentage'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: fixedChargesController,
                    decoration:
                        const InputDecoration(labelText: 'Fixed Charges'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: merchantIdController,
                    decoration: const InputDecoration(labelText: 'Merchant ID'),
                    keyboardType: TextInputType.text,
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
                controller.updateCharge(
                    index,
                    ScheduleChargesModel(
                      name: nameController.text,
                      range: rangeController.text,
                      percentage: percentageController.text,
                      fixedCharges: fixedChargesController.text,
                      merchantId: merchantIdController.text,
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

  void _showChargeDetails(BuildContext context, ScheduleChargesModel charges) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Charge Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${charges.name}'),
                const SizedBox(height: 8),
                Text('Range: ${charges.range}'),
                const SizedBox(height: 8),
                Text('Percentage: ${charges.percentage}'),
                const SizedBox(height: 8),
                Text('Fixed Charges: ${charges.fixedCharges}'),
                const SizedBox(height: 8),
                Text('Merchant ID: ${charges.merchantId}'),
                const SizedBox(height: 8),
                Text('Status: ${charges.status}'),
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
