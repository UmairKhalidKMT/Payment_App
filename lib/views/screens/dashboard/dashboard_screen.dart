import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_app/utils/app_colors.dart';
import 'package:payment_app/utils/responsive_util.dart';
import 'package:payment_app/views/screens/dashboard/total_devices_screen.dart';
import 'package:payment_app/views/screens/dashboard/total_merchants_screen.dart';
import 'package:payment_app/views/screens/dashboard/total_revenue_screen.dart';
import 'package:payment_app/views/screens/widgets/gridView_container.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dashboardItemList = [
      {
        'iconName': Icons.person_search_outlined,
        'title': 'Total Merchants\n20',
        'navigator': () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TotalMerchantScreen()),
          );
        },
      },
      {
        'iconName': Icons.devices_other_outlined,
        'title': 'Total Devices \n20',
        'navigator': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TotalDevicesScreen()),
          );
        },
      },
      {
        'iconName': Icons.money_rounded,
        'title': 'Total Revenue \n200k',
        'navigator': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TotalRevenueScreen()),
          );
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Dashboard',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 32,
            ),
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
                  itemCount: dashboardItemList.length,
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
                      iconData: dashboardItemList[index]['iconName'],
                      text: dashboardItemList[index]['title'],
                      ontap: dashboardItemList[index]['navigator'],
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
