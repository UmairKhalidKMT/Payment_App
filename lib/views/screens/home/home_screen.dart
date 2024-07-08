import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_app/utils/app_colors.dart';
import 'package:payment_app/views/screens/merchant/merchant_screen.dart';
import 'package:payment_app/views/screens/widgets/gridView_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> paymentMethodsList = [
      {
        'iconName': Icons.business_center_outlined,
        'title': 'Merchants',
        'navigator': () {
          Navigator.pushNamed(context, '/merchant');
        },
      },
      {
        'iconName': Icons.devices,
        'title': 'Devices',
        'navigator': () {
          Navigator.pushNamed(context, '/devices');
        },
      },
      {
        'iconName': Icons.receipt_long_outlined,
        'title': 'Schedule of Charges',
        'navigator': () {
          Navigator.pushNamed(context, '/charges');
        },
      },
      {
        'iconName': Icons.person_2_outlined,
        'title': 'Users',
        'navigator': () {
          Navigator.pushNamed(context, '/user');
        },
      },
      {
        'iconName': Icons.insert_chart,
        'title': 'Reports',
        'navigator': () {
          Navigator.pushNamed(context, '/reports-home');
        },
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/images/logo.png')),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Payments',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: AppColors.whiteColor, fontSize: 32),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12)
                        .copyWith(top: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: paymentMethodsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    return GridViewContainer(
                      iconData: paymentMethodsList[index]['iconName'],
                      text: paymentMethodsList[index]['title'],
                      ontap: paymentMethodsList[index]['navigator'],

                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
