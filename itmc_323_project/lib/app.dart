import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'weather/view/search_screen.dart';
import 'theme/themes.dart'; // Import the custom themes

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void toggleTheme() async {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? CustomThemes.darkTheme : CustomThemes.lightTheme,
      home: SearchScreen(toggleTheme: toggleTheme),
    );
  }
}
