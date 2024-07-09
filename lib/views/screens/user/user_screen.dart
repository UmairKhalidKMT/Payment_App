import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_app/controllers/user/user_controller.dart';
import 'package:payment_app/models/user/user_model.dart';
import 'package:payment_app/utils/app_colors.dart';
import 'package:payment_app/views/screens/widgets/button.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserController(),
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
            'User Management',
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
                    onPressed: () => _showAddUserDialog(context),
                  ),
                );
              },
            ),
          ],
        ),
        body: Consumer<UserController>(
          builder: (context, controller, child) {
            return ListView.builder(
              itemCount: controller.users.length,
              itemBuilder: (context, index) {
                final user = controller.users[index];
                final isInactive = user.status == 'Inactive';
                return Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: AppColors.lightBlackColor,
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: TextStyle(
                        color: isInactive
                            ? AppColors.redColor
                            : AppColors.whiteColor,
                      ),
                    ),
                    subtitle: Text(user.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            //controller.deleteUser(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.update_rounded),
                          onPressed: () {
                            _showUpdateUserDialog(context, index, user);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {
                            _showUserDetails(context, user);
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

  void _showAddUserDialog(BuildContext context) {
    final controller = Provider.of<UserController>(context, listen: false);
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
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
                    controller: firstNameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
                  ),
                  TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    keyboardType: TextInputType.phone,
                  ),
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                    keyboardType: TextInputType.streetAddress,
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
                // controller.addUser(UserModel(
                //   firstName: firstNameController.text,
                //   lastName: lastNameController.text,
                //   email: emailController.text,
                //   password: passwordController.text,
                //   phone: phoneController.text,
                //   address: addressController.text,
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

  void _showUpdateUserDialog(BuildContext context, int index, UserModel user) {
    final controller = Provider.of<UserController>(context, listen: false);
    final firstNameController = TextEditingController(text: user.firstName);
    final lastNameController = TextEditingController(text: user.lastName);
    final emailController = TextEditingController(text: user.email);
    final passwordController = TextEditingController(text: user.password);
    final phoneController = TextEditingController(text: user.phone);
    final addressController = TextEditingController(text: user.address);
    String status = user.status;

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
                    controller: firstNameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
                  ),
                  TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    keyboardType: TextInputType.phone,
                  ),
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                    keyboardType: TextInputType.streetAddress,
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
                // controller.updateUser(
                //     index,
                //     UserModel(
                //       firstName: firstNameController.text,
                //       lastName: lastNameController.text,
                //       email: emailController.text,
                //       password: passwordController.text,
                //       phone: phoneController.text,
                //       address: addressController.text,
                //       status: status,
                //     ));
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.update),
            ),
          ],
        );
      },
    );
  }

  void _showUserDetails(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('First Name: ${user.firstName}'),
                const SizedBox(height: 8),
                Text('Last Name: ${user.lastName}'),
                const SizedBox(height: 8),
                Text('Email: ${user.email}'),
                const SizedBox(height: 8),
                Text('Phone: ${user.phone}'),
                const SizedBox(height: 8),
                Text('Address: ${user.address}'),
                const SizedBox(height: 8),
                Text('Status: ${user.status}'),
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
