import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_app/utils/responsive_util.dart';
import 'package:payment_app/views/screens/widgets/gridView_container.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> settingCards = [
      {
        'iconName': Icons.location_on,
        'title': 'Cities',
        'navigator': () {
          Navigator.pushNamed(context, '/city');
        },
      },
      {
        'iconName': Icons.factory_outlined,
        'title': 'Industry',
        'navigator': () {
          Navigator.pushNamed(context, '/industry');
        },
      },
      {
        'iconName': Icons.location_city,
        'title': 'Region',
        'navigator': () {
          Navigator.pushNamed(context, '/region');
        },
      },
      {
        'iconName': Icons.location_searching,
        'title': 'Country',
        'navigator': () {
          Navigator.pushNamed(context, '/country');
        },
      },
      {
        'iconName': Icons.group,
        'title': 'Group',
        'navigator': () {
          Navigator.pushNamed(context, '/group');
        },
      },
      {
        'iconName': Icons.fact_check_outlined,
        'title': 'Roles & Permissions',
        'navigator': () {
          Navigator.pushNamed(context, '/role');
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(fontSize: 22),
          ),
        ),
        centerTitle: true,
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
                  itemCount: settingCards.length,
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
                      iconData: settingCards[index]['iconName'],
                      text: settingCards[index]['title'],
                      ontap: settingCards[index]['navigator'],
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
}
