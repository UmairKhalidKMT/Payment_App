import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/app_colors.dart';

class GridViewContainer extends StatelessWidget {
  final IconData iconData;
  final VoidCallback ontap;
  final String text;

  const GridViewContainer({
    Key? key,
    required this.iconData,
    required this.text,required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.lightBlackColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              iconData,
              color: AppColors.whiteColor,
              size: 48,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                textStyle: TextStyle(color: AppColors.whiteColor, fontSize: 18,fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
    ),
);
}
}
