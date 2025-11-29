import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:the_flow/database/database_provider.dart';
import 'package:the_flow/pages/home_page.dart';
import 'package:the_flow/theme/theme_provider.dart';
import 'package:permission_handler/permission_handler.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings =
  InitializationSettings(android: initSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initSettings);
}

Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.status;

  if (!status.isGranted) {
    await Permission.notification.request();
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Database
  await Database.initialize();
  await Database().saveFirstLaunchDate();

  // Initialize Notification
  await initNotifications();

  await requestNotificationPermission();

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Database()),
          ChangeNotifierProvider(create: (context) =>  ThemeProvider())
        ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
