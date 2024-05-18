import 'package:authentication/controller/details_provider/details_provider.dart';
import 'package:authentication/controller/item_provider/item_provider.dart';
import 'package:authentication/controller/authentication/auth_controller.dart';
import 'package:authentication/controller/bottom_provider/bottom_prov.dart';
import 'package:authentication/controller/chat_provider/chat_provider.dart';
import 'package:authentication/controller/favourites_provider/favourites_controller.dart';
import 'package:authentication/controller/notification_controller/notification_controller.dart';
import 'package:authentication/firebase_options.dart';
import 'package:authentication/view/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Razorpay razorpay = Razorpay();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ItemProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavouritesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatController(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}
