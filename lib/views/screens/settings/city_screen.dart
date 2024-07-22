import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_app/controllers/settings/city_controller.dart';
import 'package:payment_app/models/settings/city_model.dart';
import 'package:payment_app/utils/responsive_util.dart';
import 'package:payment_app/views/screens/widgets/button.dart';
import 'package:payment_app/views/screens/widgets/gridView_container.dart';
import 'package:provider/provider.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CityController>(context);
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select City',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(fontSize: 22),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_home_work_outlined),
            iconSize: screenWidth / 12,
            onPressed: () {
              _showAddCityDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12)
                        .copyWith(top: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.cities.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveUtil.isDesktop(context)
                        ? 4
                        : ResponsiveUtil.isTablet(context)
                            ? 3
                            : 2,
                    childAspectRatio: ResponsiveUtil.isDesktop(context)
                        ? 1.5
                        : ResponsiveUtil.isTablet(context)
                            ? 1.2
                            : 1,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    return GridViewContainer(
                      iconData: Icons.location_on,
                      text: controller.cities[index].name,
                      ontap: () {
                        _showCityDetails(context, controller.cities[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddCityDialog(BuildContext context) {
    final controller = Provider.of<CityController>(context, listen: false);
    final nameController = TextEditingController();

    String status = 'Active';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New City'),
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
                controller.addCity(
                  City(
                    name: nameController.text,
                    status: status,
                  ),
                );
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.add_task_outlined),
            ),
          ],
        );
      },
    );
  }

  void _showCityDetails(BuildContext context, City city) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('City Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${city.name}'),
                const SizedBox(height: 8),
                Text('Status: ${city.status}'),
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
