import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_app/controllers/schedule_of_charges/schedule_charges_controller.dart';
import 'package:payment_app/models/schedule_of_charges/schedule_charges.dart';
import 'package:payment_app/views/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:payment_app/utils/app_colors.dart';
import 'package:payment_app/views/screens/widgets/button.dart';

import '../../../controllers/merchant/merchant_form_controller.dart';

class ScheduleChargesScreen extends StatefulWidget {
  const ScheduleChargesScreen({super.key});

  @override
  State<ScheduleChargesScreen> createState() => _ScheduleChargesScreenState();
}

class _ScheduleChargesScreenState extends State<ScheduleChargesScreen> {
  ScheduleChargesController controller = ScheduleChargesController();
  MerchantController merchantController=MerchantController();
  bool isloading=true;
  String? selectedmerchant;
  String? selectedstatus;
  String? updatestatus;
  String? updatemerchant;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchingChrges();
    merchantController.fetchingmerchant();
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        isloading = false;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScheduleChargesController(),
      child: isloading? Center(child: CircularProgressIndicator())  :Scaffold(
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
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
        body: ListView.builder(
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
                  charges.name.toString(),
                  style: TextStyle(
                    color: isInactive
                        ? AppColors.redColor
                        : AppColors.whiteColor,
                  ),
                ),
                subtitle: Text(charges.rangeamount.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async{
                        // controller.deleteCharge(index);
                        await controller.deletecharges(charges.chargesId.toString());
                        setState(() {
                        isloading = true;
                        });
                        await controller.fetchingChrges();
                        setState(() {
                        isloading = false;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.update_rounded),
                      onPressed: () {
                       // ; _showUpdateChargeDialog(context, index, charges)

                        _showUpdateChargeDialog(context,
                            index,
                            charges.name.toString(),
                            charges.rangeamount.toString(),
                            charges.percentage.toString(),
                            charges.fixedamount.toString(),
                            charges.merchantId.toString(),
                            charges.status.toString(),
                            charges.chargesId.toString()
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                        // _showChargeDetails(context, charges);
                        _showChargeDetails(context,
                            charges.name.toString(),
                            charges.rangeamount.toString(),
                            charges.percentage.toString(),
                            charges.fixedamount.toString(),
                            charges.merchantId.toString(),
                            charges.status.toString(),
                            charges.chargesId.toString()
                        );
                      },
                    ),
                  ],
                ),
              ),
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
                  // TextField(
                  //   controller: merchantIdController,
                  //   decoration: const InputDecoration(labelText: 'Merchant ID'),
                  //   keyboardType: TextInputType.text,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DropdownButtonFormField<String>(
                      value: selectedstatus,
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem<String>(
                          value: '1',
                          child: Text('Active'),
                        ),
                        DropdownMenuItem<String>(
                          value: '0',
                          child: Text('Inactive'),
                        ),
                      ],
                      onChanged: (newValue) {
                        selectedstatus = newValue!;
                        print(selectedstatus);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DropdownButtonFormField<String>(
                      value: selectedmerchant,
                      decoration: const InputDecoration(
                        labelText: 'select merchant',
                        border: OutlineInputBorder(),
                      ),
                      items: merchantController.getmerchant?.data?.map((e) => DropdownMenuItem(
                        value: e.merchantId.toString(),
                        child: Text(e.name.toString()),
                      )).toList() ??
                          [],
                      onChanged: (newValue) {
                        setState(() {
                          selectedmerchant = newValue;
                          print(selectedmerchant);
                        });
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
              voidCallback: ()async {
              await  controller.createSchedulOfCharges(
                    nameController.text,
                    rangeController.text,
                    percentageController.text,
                    fixedChargesController.text,
                    selectedstatus.toString(),
                    selectedmerchant.toString()
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduleChargesScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add_task_outlined),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateChargeDialog(
      BuildContext context, int index,
      String name,
      String range,
      String percentage,
      String ficedCharges,
      String merchantid,
      String status,
      String charges_id
      ) {

    final nameController = TextEditingController(text: name);
    final rangeController = TextEditingController(text: range);
    final percentageController =
        TextEditingController(text: percentage);
    final fixedChargesController =
        TextEditingController(text: ficedCharges);
    final merchantIdController =
        TextEditingController(text: merchantid);
    // String status = status;
    List<String?> merchantIds = merchantController.getmerchant?.data?.map((e) => e.merchantId.toString()).toList() ?? [];
    if (!merchantIds.contains(merchantid)) {
      merchantid = (merchantIds.isNotEmpty ? merchantIds.first : null)!;
    }
    updatemerchant = merchantid;

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
                  // TextField(
                  //   controller: merchantIdController,
                  //   decoration: const InputDecoration(labelText: 'Merchant ID'),
                  //   keyboardType: TextInputType.text,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DropdownButtonFormField<String>(
                      value: updatestatus,
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem<String>(
                          value: '1',
                          child: Text('Active'),
                        ),
                        DropdownMenuItem<String>(
                          value: '0',
                          child: Text('Inactive'),
                        ),
                      ],
                      onChanged: (newValue) {
                        updatestatus = newValue!;
                        print(updatestatus);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DropdownButtonFormField<String>(
                      value: updatemerchant,
                      decoration: const InputDecoration(
                        labelText: 'select merchant',
                        border: OutlineInputBorder(),
                      ),
                      items: merchantController.getmerchant?.data?.map((e) => DropdownMenuItem(
                        value: e.merchantId.toString(),
                        child: Text(e.name.toString()),
                      )).toList() ??
                          [],
                      onChanged: (newValue) {
                        setState(() {
                          updatemerchant = newValue;
                          print(updatemerchant);
                        });
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
              voidCallback: ()async {
             await  controller.updateSchedulOfCharges(
                   nameController.text,
                   rangeController.text,
                   percentageController.text,
                   fixedChargesController.text,
                   updatestatus.toString(),
                   updatemerchant.toString(),
                   charges_id
               );
               Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(
                   builder: (context) => ScheduleChargesScreen(),
                 ),
               );
              },
              icon: const Icon(Icons.update),
            ),
          ],
        );
      },
    );
  }

  void _showChargeDetails(BuildContext context,
      String name,
      String range,
      String percentage,
      String ficedCharges,
      String merchantid,
      String status,
      String charges_id
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Charge Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${name}'),
                const SizedBox(height: 8),
                Text('Range: ${range}'),
                const SizedBox(height: 8),
                Text('Percentage: ${percentage}'),
                const SizedBox(height: 8),
                Text('Fixed Charges: ${ficedCharges}'),
                const SizedBox(height: 8),
                Text('Merchant ID: ${merchantid}'),
                const SizedBox(height: 8),
                Text('Status: ${status}'),
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
