import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_app/controllers/devices/devices_controller.dart';
import 'package:payment_app/controllers/merchant/merchant_form_controller.dart';
import 'package:payment_app/models/devices/devices_model.dart';
import 'package:provider/provider.dart';
import 'package:payment_app/utils/app_colors.dart';
import 'package:payment_app/views/screens/widgets/button.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({super.key});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  DevicesController controller=DevicesController();
  MerchantController merchantController=MerchantController();
 bool isloading=true;
  String? selectedmerchant;
  String? selectedstatus;



  @override
  void initState() {
    super.initState();
    controller.fetchingdevices();
    merchantController.fetchingmerchant();

    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        isloading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Devices',
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
                  onPressed: () => _showAddDeviceDialog(context),
                ),
              );
            },
          ),
        ],
      ),
      body: isloading? Center(child: CircularProgressIndicator()) :ListView.builder(
        itemCount: controller.devices.length,
        itemBuilder: (context, index) {
          final device = controller.devices[index];
          final isInactive = device.status == 'Inactive';
          return Card(
            elevation: 5.0,
            margin: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ListTile(
              tileColor: AppColors.lightBlackColor,
              selectedColor: AppColors.lightWhiteColor,
              title: Text(
                device.terminalSn.toString(),
                style: TextStyle(
                  color: isInactive
                      ? AppColors.redColor
                      : AppColors.whiteColor,
                ),
              ),
              subtitle: Text(device.productKey.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                     // controller.deleteDevice(index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.update_rounded),
                    onPressed: () {
                     // _showUpdateDeviceDialog(context, index, device);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {
                     _showDeviceDetails(context,
                         device.terminalSn.toString(),
                         device.productKey.toString(),
                         device.location.toString(),
                         device.merchantId.toString(),
                         device.status.toString()
                     );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }



  void _showAddDeviceDialog(BuildContext context) {

    final deviceSnController = TextEditingController();
    final productKeyController = TextEditingController();
    final locationController = TextEditingController();
    final merchantIdController = TextEditingController();
    String status = 'Active';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Device'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: deviceSnController,
                    decoration: const InputDecoration(labelText: 'Device SN'),
                    keyboardType: TextInputType.name,
                  ),
                  TextField(
                    controller: productKeyController,
                    decoration: const InputDecoration(labelText: 'Product Key'),
                    keyboardType: TextInputType.name,
                  ),
                  TextField(
                    controller: locationController,
                    decoration: const InputDecoration(labelText: 'Location'),
                    keyboardType: TextInputType.text,
                  ),
                  TextField(
                    controller: merchantIdController,
                    decoration: const InputDecoration(labelText: 'Merchant ID'),
                    keyboardType: TextInputType.text,
                  ),
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
              voidCallback: () {
                // controller.addDevice(Devices(
                //   deviceSn: deviceSnController.text,
                //   productKey: productKeyController.text,
                //   location: locationController.text,
                //   merchantId: merchantIdController.text,
                //   status: status,
                // ));
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.add_task_outlined),
            ),
          ],
        );
      },
    );
  }

  // void _showUpdateDeviceDialog(
  //     BuildContext context, int index, Devices device) {
  //    final controller = Provider.of<DevicesController>(context, listen: false);
  //   final deviceSnController = TextEditingController(text: device.deviceSn);
  //   final productKeyController = TextEditingController(text: device.productKey);
  //   final locationController = TextEditingController(text: device.location);
  //   final merchantIdController = TextEditingController(text: device.merchantId);
  //   // String status = device.status;
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Update Device'),
  //         content: SizedBox(
  //           width: MediaQuery.of(context).size.width * 0.8,
  //           child: SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 TextField(
  //                   controller: deviceSnController,
  //                   decoration: const InputDecoration(labelText: 'Device SN'),
  //                   keyboardType: TextInputType.name,
  //                 ),
  //                 TextField(
  //                   controller: productKeyController,
  //                   decoration: const InputDecoration(labelText: 'Product Key'),
  //                   keyboardType: TextInputType.name,
  //                 ),
  //                 TextField(
  //                   controller: locationController,
  //                   decoration: const InputDecoration(labelText: 'Location'),
  //                   keyboardType: TextInputType.text,
  //                 ),
  //                 TextField(
  //                   controller: merchantIdController,
  //                   decoration: const InputDecoration(labelText: 'Merchant ID'),
  //                   keyboardType: TextInputType.text,
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(vertical: 10),
  //                   child: DropdownButtonFormField<String>(
  //                     value: status,
  //                     decoration: const InputDecoration(
  //                       labelText: 'Status',
  //                       border: OutlineInputBorder(),
  //                     ),
  //                     items: ['Active', 'Inactive'].map((String value) {
  //                       return DropdownMenuItem<String>(
  //                         value: value,
  //                         child: Text(value),
  //                       );
  //                     }).toList(),
  //                     onChanged: (newValue) {
  //                       status = newValue!;
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             child: const Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           ButtonWidget(
  //             btnName: 'Update',
  //             voidCallback: () {
  //               // controller.updateDevice(
  //               //     index,
  //               //     Devices(
  //               //       deviceSn: deviceSnController.text,
  //               //       productKey: productKeyController.text,
  //               //       location: locationController.text,
  //               //       merchantId: merchantIdController.text,
  //               //       status: status,
  //               //     ));
  //               Navigator.of(context).pop();
  //             },
  //             icon: const Icon(Icons.update),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showDeviceDetails(BuildContext context,
      String devicesn,
      String productkey,
      String Location,
      String merchantid,
      String status
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Device Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Device SN: ${devicesn.toString()}'),
                const SizedBox(height: 8),
                Text('Product Key: ${productkey.toString()}'),
                const SizedBox(height: 8),
                Text('Location: ${Location.toString()}'),
                const SizedBox(height: 8),
                Text('Merchant ID: ${merchantid.toString()}'),
                const SizedBox(height: 8),
                Text('Status: ${status.toString()}'),
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
