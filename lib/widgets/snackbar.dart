import 'package:flutter/material.dart';
import 'package:kanektme/utils/colors.dart';
import 'package:kanektme/utils/textstyle.dart';

void showSnackBar({
  required BuildContext context,
  required String title,
  String? message,
  required bool failureMessage,
  int? durationInSeconds,
  double? height,
}) {
  final size = MediaQuery.of(context).size;
  var snackBar = SnackBar(
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: CustomTextStyle.tittleText.copyWith(color: Colors.white)),
        // Text(message, style: CustomTextStyle.generalText.copyWith(color: Colors.white), textAlign: TextAlign.center),
      ],
    ),
    backgroundColor: failureMessage ? CustomColors.red : CustomColors.green,
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
    margin: EdgeInsets.only(bottom: size.height - (height ?? 200), left: 50, right: 50),
    elevation: 2,
    duration: Duration(seconds: durationInSeconds ?? 3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    clipBehavior: Clip.hardEdge,
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
