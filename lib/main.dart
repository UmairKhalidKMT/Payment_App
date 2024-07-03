import 'package:flutter/material.dart';
import 'package:payment_app/utils/app_colors.dart';
import 'package:payment_app/views/screens/home/home_screen.dart';
import 'package:payment_app/views/screens/merchant/merchant_screen.dart';

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

        // '/reports-home': (context) => ReportsHomeScreen(),
        // '/enter-amount': (context) => EnterAmountScreen(),
        // '/tap-insert': (context) => EnterAmountScreen(),
      },
      home: const HomeScreen(),
    );
  }
}
