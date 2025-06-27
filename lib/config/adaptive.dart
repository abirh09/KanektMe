import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kanektme/config/responsive.dart';

class AdaptiveApp extends StatelessWidget {
  const AdaptiveApp({super.key, required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    final iOS = Theme.of(context).platform == TargetPlatform.iOS;
    return iOS
        ? CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: Responsive(child: home),
            theme: const CupertinoThemeData(),
            color: Colors.redAccent,
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Responsive(child: home,),
            theme: ThemeData.light(useMaterial3: true),
            color: Colors.redAccent,
          );
  }
}
