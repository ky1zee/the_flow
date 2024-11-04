import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_flow/database/database_provider.dart';
import 'package:the_flow/pages/home_page.dart';
import 'package:the_flow/theme/theme_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize database
  await Database.initialize();


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

