import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_flow/database/database_provider.dart';
import 'package:the_flow/models/habit.dart';
import 'package:the_flow/theme/theme_provider.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Dark Mode",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              SizedBox(height: 8.0),
              CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context).isDarkMode,
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 82.0,
        height: 82.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 6, // Blur radius
              offset: Offset(0, 3), // Changes the position of the shadow
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {},
          shape: CircleBorder(),
          elevation: 0, // Remove the default elevation
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inversePrimary,
            size: 37,
          ),
        ),
      ),
    );
  }
}