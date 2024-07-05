import 'package:flutter/material.dart';
import 'package:payment_app/utils/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final String btnName;
  final Icon? icon;
  final VoidCallback? voidCallback;
  const ButtonWidget(
      {super.key, required this.btnName, required this.voidCallback, this.icon});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: voidCallback,
      
      child: Container(
        height: 50,
        width: screenWidth / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.lightWhiteColor,
        ),
        child: Center(
          child: Text(
            btnName,
            style: const TextStyle(
                fontSize: 18,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        
      ),
      
    );
  }
}
