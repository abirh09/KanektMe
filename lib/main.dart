import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kanektme/screens/homepage.dart';
import 'package:kanektme/screens/login_screen.dart';
import 'package:kanektme/services/auth_service.dart';
import 'package:kanektme/services/event_service.dart';
import 'package:kanektme/utils/colors.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => EventService()), // Provide LocationService
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: CustomColors.primary,
        scaffoldBackgroundColor: CustomColors.backgroundColor,),
      home: Consumer<AuthService>(
        builder: (context, authService, _) {
          if (authService.user != null) {
            return const Homepage();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
