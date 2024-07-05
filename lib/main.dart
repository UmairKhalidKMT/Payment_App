import 'package:flutter/material.dart';
import 'package:payment_app/utils/app_colors.dart';
import 'package:payment_app/views/screens/devices/device_screen.dart';
import 'package:payment_app/views/screens/home/home_screen.dart';
import 'package:payment_app/views/screens/merchant/merchant_screen.dart';
import 'package:payment_app/views/screens/schedule_of_charge/schedule_charges_screen.dart';
import 'package:payment_app/views/screens/user/user_screen.dart';

void main() {
  runApp(const MyApp());
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
        // '/login': (context) => LoginScreen(),
        '/merchant': (context) => const MerchantScreen(),

        '/devices': (context) => const DeviceScreen(),
        '/charges': (context) => const ScheduleCharges(),
        '/user': (context) => const UserScreen(),
      },
      home: const HomeScreen(),
    );
  }
}
