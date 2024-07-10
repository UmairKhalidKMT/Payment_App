import 'package:flutter/material.dart';
import 'package:payment_app/controllers/settings/city/city_controller.dart';
import 'package:payment_app/utils/app_colors.dart';
import 'package:payment_app/views/screens/dashboard/dashboard_screen.dart';
import 'package:payment_app/views/screens/dashboard/total_devices_screen.dart';
import 'package:payment_app/views/screens/dashboard/total_merchants_screen.dart';
import 'package:payment_app/views/screens/dashboard/total_revenue_screen.dart';
import 'package:payment_app/views/screens/devices/device_screen.dart';
import 'package:payment_app/views/screens/home/home_screen.dart';
import 'package:payment_app/views/screens/merchant/merchant_screen.dart';
import 'package:payment_app/views/screens/schedule_of_charge/schedule_charges_screen.dart';
import 'package:payment_app/views/screens/settings/city_screen.dart';
import 'package:payment_app/views/screens/settings/country_screen.dart';
import 'package:payment_app/views/screens/settings/group_screen.dart';
import 'package:payment_app/views/screens/settings/industry_screen.dart';
import 'package:payment_app/views/screens/settings/region_screen.dart';
import 'package:payment_app/views/screens/settings/roles_and_permissions_screen.dart';
import 'package:payment_app/views/screens/settings/settings_screen.dart';
import 'package:payment_app/views/screens/user/user_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CityController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.primaryColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primaryColor,
          )),
      routes: {
<<<<<<< HEAD
        '/dashboard': (context) => const DashboardScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/merchant': (context) => const MerchantScreen(),
=======
        // '/login': (context) => LoginScreen(),
         '/merchant': (context) =>  MerchantScreen(),

>>>>>>> 7a964fa22001037a0262d1b77ddbe3e9a47cf55e
        '/devices': (context) => const DeviceScreen(),
        '/charges': (context) => const ScheduleChargesScreen(),
        '/user': (context) => const UserScreen(),
        '/totaldevices': (context) => const TotalDevicesScreen(),
        '/totalrevenue': (context) => const TotalRevenueScreen(),
        '/totalmerchants': (context) => const TotalMerchantScreen(),
        '/city': (context) => const CityScreen(),
        '/country': (context) => const CountryScreen(),
        '/group': (context) => const GroupScreen(),
        '/industry': (context) => const IndustryScreen(),
        '/region': (context) => const RegionScreen(),
        '/role': (context) => const RolesAndPermissionsScreen(),
      },
      home: const HomeScreen(),
    );
  }
}
