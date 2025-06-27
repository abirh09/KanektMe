import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/textstyle.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String label;

  const CustomButton({super.key, required this.onTap,required this.label});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return TextButton(
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(color: CustomColors.secondary, borderRadius: BorderRadius.circular(10)),
        width: screenSize.width,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15
          ,
        ),
        child: Center(
            child: Text(
              label,
              style: CustomTextStyle.generalText.copyWith(color: CustomColors.textWhite),
            )),
      ),
    );
  }
}