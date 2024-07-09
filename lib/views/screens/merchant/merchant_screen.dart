import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_app/controllers/merchant/merchant_form_controller.dart';
import 'package:payment_app/controllers/subgroup_controller.dart';
import 'package:payment_app/models/merchant/merchant_details.dart';
import 'package:provider/provider.dart';
import 'package:payment_app/utils/app_colors.dart';
import 'package:payment_app/views/screens/widgets/button.dart';

import '../home/home_screen.dart';

class MerchantScreen extends StatefulWidget {
  const MerchantScreen({super.key});

  @override
  State<MerchantScreen> createState() => _MerchantScreenState();
}

class _MerchantScreenState extends State<MerchantScreen> {
  MerchantController controller = MerchantController();
  SubgroupController subgroupController = SubgroupController();
  String? selectedsubgroup;
  String? selectedstatus;
  String? updatestatus;
  String? updatesubgroup;
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    controller.fetchingmerchant();
    subgroupController.fetchingsubgroup();
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MerchantController(),
      child: isloading
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
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
        body:   ListView.builder(
          itemCount: controller.getmerchant?.data?.length ?? 1,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5.0,
              margin: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: ListTile(
                tileColor: AppColors.lightBlackColor,
                selectedColor: AppColors.lightWhiteColor,
                title: Text(
                  controller.getmerchant?.data?[index].name.toString() ?? "no data is avalible",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                  ),
                ),
                subtitle: Text(
                  controller.getmerchant?.data?[index].name.toString() ??"Please check your internet connection and try again",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await controller.deletemerhant(controller
                            .getmerchant!.data![index].merchantId
                            .toString());
                        setState(() {
                          isloading = true;
                        });
                        await controller.fetchingmerchant();
                        setState(() {
                          isloading = false;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.update_rounded),
                      onPressed: () {
                        _showUpdateMerchantDialog(
                          context,
                          controller.getmerchant!.data![index].name
                              .toString(),
                          controller.getmerchant!.data![index].phone
                              .toString(),
                          controller.getmerchant!.data![index].email
                              .toString(),
                          controller.getmerchant!.data![index].address
                              .toString(),
                          controller.getmerchant!.data![index]
                              .businessName
                              .toString(),
                          controller.getmerchant!.data![index].status
                              .toString(),
                          controller.getmerchant!.data![index].subgroup!
                              .subgroupName
                              .toString(),
                          controller.getmerchant!.data![index].merchantId
                              .toString(),

                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                       _showMerchantDetails(context,
                           controller.getmerchant!.data![index].name.toString(),
                           controller.getmerchant!.data![index].phone.toString(),
                           controller.getmerchant!.data![index].email.toString(),
                           controller.getmerchant!.data![index].address.toString(),
                           controller.getmerchant!.data![index].businessName.toString(),
                         controller.getmerchant!.data![index].status.toString(),
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
                    decoration: const InputDecoration(labelText: 'Business Name'),
                    keyboardType: TextInputType.name,
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
                      value: selectedsubgroup,
                      decoration: const InputDecoration(
                        labelText: 'subgroup',
                        border: OutlineInputBorder(),
                      ),
                      items: subgroupController.getsubgroup_list?.data?.map((e) => DropdownMenuItem(
                        value: e.subgroupId.toString(),
                        child: Text(e.subgroupName.toString()),
                      )).toList() ??
                          [],
                      onChanged: (newValue) {
                        setState(() {
                          selectedsubgroup = newValue;
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
              voidCallback: () async {
                await controller.createmerchat(
                  nameController.text,
                  phoneController.text,
                  emailController.text,
                  businessNameController.text,
                  selectedstatus.toString(),
                  addressController.text,
                  selectedsubgroup.toString(),
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MerchantScreen(),
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

  void _showUpdateMerchantDialog(
      BuildContext context,
      String name,
      String phone,
      String email,
      String address,
      String businessName,
      String status,
      String subgroup,
      String merchantid
      ) {
    final controller = Provider.of<MerchantController>(context, listen: false);
    final nameController = TextEditingController(text: name);
    final phoneController = TextEditingController(text: phone);
    final emailController = TextEditingController(text: email);
    final addressController = TextEditingController(text: address);
    final businessNameController = TextEditingController(text: businessName);

    List<String?> subgroupIds = subgroupController.getsubgroup_list?.data?.map((e) => e.subgroupId.toString()).toList() ?? [];
    if (!subgroupIds.contains(subgroup)) {
      subgroup = (subgroupIds.isNotEmpty ? subgroupIds.first : null)!;
    }

    updatesubgroup = subgroup;

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
                    decoration: const InputDecoration(labelText: 'Business Name'),
                    keyboardType: TextInputType.name,
                  ),
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
                      value: updatesubgroup,
                      decoration: const InputDecoration(
                        labelText: 'subgroup',
                        border: OutlineInputBorder(),
                      ),
                      items: subgroupController.getsubgroup_list?.data?.map((e) => DropdownMenuItem(
                        value: e.subgroupId.toString(),
                        child: Text(e.subgroupName.toString()),
                      )).toList() ??
                          [],
                      onChanged: (newValue) {
                        setState(() {
                          updatesubgroup = newValue;
                          print(updatesubgroup);
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
              voidCallback: () {
                controller.updatemerchant(
                    nameController.text,
                    phoneController.text,
                    emailController.text,
                    businessNameController.text,
                    updatestatus.toString(),
                    addressController.text,
                    updatesubgroup.toString(),
                    merchantid
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MerchantScreen(),
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

  void _showMerchantDetails(BuildContext context,
      String name,
      String phone,
      String email,
      String adress,
      String businessname ,
      String status
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${name.toString()}'),
                const SizedBox(height: 8),
                Text('Phone: ${phone}'),
                const SizedBox(height: 8),
                Text('Email: ${email}'),
                const SizedBox(height: 8),
                Text('Address: ${adress}'),
                const SizedBox(height: 8),
                Text('Business Name: ${businessname}'),
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
